import 'dart:async';

import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/core/presentation/base_view_model.dart';
import 'package:agentfolio/core/presentation/loadable.dart';
import 'package:agentfolio/core/presentation/view_state.dart';
import 'package:agentfolio/core/storage/prefs.dart';
import 'package:agentfolio/core/telemetry/user_hash.dart';
import 'package:agentfolio/features/agent/domain/agent_logic.dart';
import 'package:agentfolio/features/agent/domain/entities/agent.dart';
import 'package:agentfolio/features/agent/domain/repositories/agent_repository.dart';

/// One agent's conversations: the finance agent or the trading agent.
///
/// Premium users get saved threads. The latest is resumed on arrival, and a
/// new thread is created on the first message rather than on "New chat", so
/// the history never fills with empty entries. Everyone else gets the
/// server's unsaved conversation.
///
/// Sending is careful about outcomes, because a message can make the agent
/// act (a trade proposal, an approval):
/// * nothing is ever resent automatically;
/// * a dropped connection is reconciled against the saved thread: if the
///   agent has the message, the app waits for its answer instead of
///   offering to send it twice.
class AgentChatViewModel extends BaseViewModel {
  AgentChatViewModel({
    required this.type,
    required this._agent,
    required this._prefs,
    required String? userId,
    required super.telemetry,
    DateTime Function()? clock,
  }) : _draftKey = userId == null ? null : '${hashUserId(userId)}.${type.wire}',
       _now = clock ?? DateTime.now {
    _draft = _draftKey == null ? '' : (_prefs.agentDraft(_draftKey) ?? '');
  }

  final AgentType type;
  final AgentRepository _agent;
  final Prefs _prefs;
  final String? _draftKey;
  final DateTime Function() _now;

  late final threads = Loadable<ThreadList>(
    fetch: ({required force}) => _agent.threads(type, force: force),
    peek: () => _agent.cachedThreads(type),
    onChanged: _onThreadsChanged,
  );

  /// Messages per conversation; `null` is the one not saved (yet).
  final Map<int?, List<ChatMessage>> _conversations = {null: []};
  final Map<int, ViewState<void>> _history = {};

  /// Until the user picks a thread or starts a new one, the latest is shown.
  bool _followLatest = true;
  int? _selected;

  /// The conversation a reply is on its way to, while one is.
  bool _busy = false;
  int? _busyThreadId;
  DateTime? _busySince;

  int _nextId = 0;
  String _draft = '';
  int _draftVersion = 0;
  Timer? _draftSave;

  // ── State ──────────────────────────────────────────────────────────────

  /// Saved conversations are kept for this user.
  bool get premium => threads.data?.premium ?? false;

  /// The thread list has answered (or failed, in which case chat still works,
  /// unsaved). Sending before then could start an unsaved conversation for a
  /// user whose conversations should be saved.
  bool get ready => switch (threads.state) {
    ViewData() || ViewError() => true,
    _ => false,
  };

  int? get activeThreadId =>
      _followLatest ? (premium ? threads.data?.threads.firstOrNull?.id : null) : _selected;

  ChatThread? get activeThread {
    final id = activeThreadId;
    return id == null ? null : threads.data?.threads.where((t) => t.id == id).firstOrNull;
  }

  List<ChatMessage> get messages => List.unmodifiable(_conversations[activeThreadId] ?? const []);

  /// The saved history of the conversation on screen.
  ViewState<void> get history {
    final id = activeThreadId;
    if (id == null) return const ViewData(null);
    return _history[id] ?? const ViewIdle();
  }

  bool get busy => _busy;

  /// A reply is on its way to the conversation on screen.
  bool get answeringHere => _busy && _busyThreadId == activeThreadId;
  DateTime? get busySince => _busySince;

  String get draft => _draft;

  /// Bumped when the draft is set from outside the composer (a prefill), so
  /// the composer knows to replace its text.
  int get draftVersion => _draftVersion;

  // ── Loading ────────────────────────────────────────────────────────────

  Future<void> load() => threads.load();

  Future<void> refresh() async {
    await threads.load(force: true);
    final id = activeThreadId;
    if (id != null) await loadHistory(id);
  }

  void _onThreadsChanged() {
    final id = activeThreadId;
    if (id != null && !_conversations.containsKey(id) && _history[id] == null) {
      unawaited(loadHistory(id));
    }
    notifyListeners();
  }

  Future<void> loadHistory(int threadId) async {
    if (_busyThreadId == threadId && _busy) return; // a reply is landing here
    final had = _conversations.containsKey(threadId);
    _history[threadId] = had ? const ViewData(null, refreshing: true) : const ViewLoading();
    notifyListeners();

    final result = await _agent.messages(threadId);
    if (_busy && _busyThreadId == threadId) return;
    switch (result) {
      case Success(:final value):
        _conversations[threadId] = value;
        _history[threadId] = const ViewData(null);
      case Err(:final failure):
        _history[threadId] = had ? ViewData(null, refreshFailure: failure) : ViewError(failure);
    }
    notifyListeners();
  }

  // ── Conversations ──────────────────────────────────────────────────────

  void openThread(int threadId) {
    if (activeThreadId == threadId) return;
    _followLatest = false;
    _selected = threadId;
    notifyListeners();
    if (!_conversations.containsKey(threadId)) unawaited(loadHistory(threadId));
  }

  /// A blank conversation. For a premium user it is saved on its first
  /// message; otherwise the server is told to forget the unsaved one.
  Future<void> newConversation() async {
    if (_busy) return;
    _followLatest = false;
    _selected = null;
    _conversations[null] = [];
    notifyListeners();
    if (!premium) {
      // If this fails, the next message simply continues the old context.
      await runAction('agent_reset', () => _agent.resetUnsaved(type));
    }
  }

  Future<Result<ChatThread>> rename(int threadId, String title) async {
    final clean = title.split(RegExp(r'\s+')).where((w) => w.isNotEmpty).join(' ');
    final result = await runAction('agent_thread_rename', () => _agent.rename(threadId, clean));
    if (result is Success) await threads.load();
    return result;
  }

  Future<Result<void>> delete(int threadId) async {
    final result = await runAction('agent_thread_delete', () => _agent.delete(threadId));
    if (result is Success) {
      final wasActive = activeThreadId == threadId;
      _conversations.remove(threadId);
      _history.remove(threadId);
      if (wasActive) {
        _followLatest = false;
        _selected = null;
        _conversations[null] = [];
      }
      await threads.load();
    }
    return result;
  }

  // ── Sending ────────────────────────────────────────────────────────────

  /// Sends one message. An `APPROVE <id>` must be confirmed by the user
  /// before this is called: the server places the order on receipt.
  Future<void> send(String raw) async {
    final text = raw.trim();
    if (text.isEmpty || text.length > maxMessageLength || _busy || !ready) return;

    _busy = true;
    _busySince = _now();
    final local = ChatMessage(
      id: 'l${_nextId++}',
      role: ChatRole.user,
      text: text,
      delivery: Delivery.sending,
    );
    var threadId = activeThreadId;
    _busyThreadId = threadId;
    _append(threadId, local);

    if (premium && threadId == null) {
      final created = await runAction('agent_thread_create', () => _agent.createThread(type));
      switch (created) {
        case Success(:final value):
          threadId = value.id;
          _conversations[threadId] = _conversations.remove(null) ?? [];
          _conversations[null] = [];
          _history[threadId] = const ViewData(null);
          _followLatest = false;
          _selected = threadId;
          _busyThreadId = threadId;
          unawaited(threads.load());
        case Err(:final failure):
          _mark(null, local.id, Delivery.failed, failure: failure.message);
          _finish();
          return;
      }
    }

    final result = await runAction(
      type == AgentType.trading ? 'agent_trading_send' : 'agent_send',
      () => _agent.send(text, type, threadId: threadId),
    );
    switch (result) {
      case Success(:final value):
        _mark(threadId, local.id, Delivery.delivered);
        _append(
          threadId,
          ChatMessage(
            id: 'l${_nextId++}',
            role: ChatRole.assistant,
            text: value.reply,
            approvalResult: value.approvalResult,
          ),
        );
        if (threadId != null) unawaited(threads.load());
        _finish();
      case Err(failure: CancelledFailure()):
        _finish();
      case Err(:final failure) when failure is UnknownOutcomeFailure || threadId != null:
        // A gateway error can arrive after the server has saved the message
        // and while the agent is still working on it. A saved thread can say.
        _finish(notify: false);
        await _reconcile(threadId, local, failure);
      case Err(:final failure):
        _mark(threadId, local.id, Delivery.failed, failure: failure.message);
        _finish();
    }
  }

  /// The send failed or the connection dropped after the message left. For
  /// a saved thread the server can say what happened: the agent has the message (wait for its
  /// answer) or it never arrived (safe to send again).
  Future<void> _reconcile(int? threadId, ChatMessage local, Failure failure) async {
    if (threadId == null) {
      _mark(null, local.id, Delivery.unknown);
      notifyListeners();
      return;
    }
    final result = await _agent.messages(threadId);
    final server = result.valueOrNull;
    if (server == null) {
      _mark(threadId, local.id, Delivery.unknown);
    } else {
      final at = server.lastIndexWhere((m) => m.role == ChatRole.user && m.text == local.text);
      final answered = at >= 0 && server.skip(at + 1).any((m) => m.role == ChatRole.assistant);
      if (answered) {
        _conversations[threadId] = server; // the reply arrived after all
      } else if (at >= 0) {
        _mark(threadId, local.id, Delivery.unknown); // received, still working
      } else {
        _mark(threadId, local.id, Delivery.failed, failure: failure.message);
      }
    }
    notifyListeners();
  }

  /// Takes a failed message out of the conversation and returns its text,
  /// to go back through the same path as a new message (confirmation
  /// included). Messages that may have been received are not offered.
  String? takeForResend(String messageId) {
    final list = _conversations[activeThreadId];
    final message = list?.where((m) => m.id == messageId).firstOrNull;
    if (list == null || message == null || _busy) return null;
    final resendable =
        message.delivery == Delivery.failed ||
        (message.delivery == Delivery.unknown &&
            activeThreadId == null &&
            parseApprovalCommand(message.text) == null);
    if (!resendable) return null;
    list.remove(message);
    notifyListeners();
    return message.text;
  }

  void _append(int? threadId, ChatMessage message) {
    (_conversations[threadId] ??= []).add(message);
    notifyListeners();
  }

  void _mark(int? threadId, String id, Delivery delivery, {String? failure}) {
    final list = _conversations[threadId];
    if (list == null) return;
    final i = list.indexWhere((m) => m.id == id);
    if (i >= 0) list[i] = list[i].copyWith(delivery: delivery, failure: failure);
  }

  void _finish({bool notify = true}) {
    _busy = false;
    _busyThreadId = null;
    _busySince = null;
    if (notify) notifyListeners();
  }

  // ── Draft ──────────────────────────────────────────────────────────────

  /// Kept as the user types, and saved shortly after they pause, so it
  /// survives the app being closed.
  void setDraft(String text) {
    _draft = text;
    _draftSave?.cancel();
    final key = _draftKey;
    if (key == null) return;
    _draftSave = Timer(const Duration(milliseconds: 400), () {
      unawaited(_prefs.setAgentDraft(key, text));
    });
  }

  /// Opens a blank conversation with [text] ready to send, for "Ask the
  /// agent" elsewhere in the app. The user reviews it and sends.
  Future<void> prefill(String text) async {
    if (_busy) return;
    await newConversation();
    setDraft(text);
    _draftVersion++;
    notifyListeners();
  }

  @override
  void dispose() {
    // Not flushed here: on sign-out this runs after the user's data has been
    // wiped, and writing the draft back would leave it on the device.
    _draftSave?.cancel();
    super.dispose();
  }
}
