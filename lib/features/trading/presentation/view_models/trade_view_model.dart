import 'dart:async';

import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/core/presentation/base_view_model.dart';
import 'package:agentfolio/core/presentation/loadable.dart';
import 'package:agentfolio/features/trading/domain/entities/trading.dart';
import 'package:agentfolio/features/trading/domain/repositories/trading_repository.dart';
import 'package:agentfolio/features/trading/domain/trading_logic.dart';

/// The Trade tab: proposals awaiting a decision, the risk profile they are
/// checked against, and the daily WhatsApp brief.
///
/// Proposals are polled while the tab is on screen and the app is in the
/// foreground: the agent creates them mid-conversation and they expire in
/// minutes. Nowhere else.
class TradeViewModel extends BaseViewModel {
  TradeViewModel({
    required this._trading,
    required super.telemetry,
    Duration? pollEvery,
    Duration? logsSettle,
  }) : _pollEvery = pollEvery ?? const Duration(seconds: 8),
       _logsSettle = logsSettle ?? const Duration(seconds: 35);

  final TradingRepository _trading;
  final Duration _pollEvery;
  final Duration _logsSettle;

  late final proposals = Loadable<List<TradeProposal>>(
    fetch: ({required force}) async => switch (await _trading.proposals(force: force)) {
      Success(:final value) => Success(sortProposals(value)),
      Err(:final failure) => Err(failure),
    },
    peek: () => _trading.cachedProposals().let(sortProposals),
    onChanged: notifyListeners,
  );
  late final profile = Loadable<RiskProfile?>(
    fetch: _trading.riskProfile,
    onChanged: notifyListeners,
  );
  late final schedule = Loadable<BriefingSchedule?>(
    fetch: _trading.briefingSchedule,
    onChanged: notifyListeners,
  );
  late final logs = Loadable<List<BriefingLog>>(
    fetch: _trading.briefingLogs,
    onChanged: notifyListeners,
  );

  Timer? _poll;
  Timer? _logsTimer;
  bool _visible = false;
  bool _foreground = true;

  final Set<String> _approving = {};
  final Set<String> _rejecting = {};
  final Map<String, ApprovalOutcome> _outcomes = {};

  bool isApproving(String id) => _approving.contains(id);
  bool isRejecting(String id) => _rejecting.contains(id);

  /// What happened to an approval made on this screen, if one was.
  ApprovalOutcome? outcomeFor(String id) => _outcomes[id];

  int get pendingCount => proposals.data?.where((p) => p.isPending).length ?? 0;

  Future<void> load() async {
    await Future.wait([proposals.load(), profile.load(), schedule.load(), logs.load()]);
  }

  Future<void> refresh() async {
    await Future.wait([
      proposals.load(force: true),
      profile.load(force: true),
      schedule.load(force: true),
      logs.load(force: true),
    ]);
  }

  // ── Polling ────────────────────────────────────────────────────────────

  void setVisible({required bool visible}) {
    if (_visible == visible) return;
    _visible = visible;
    _updatePolling(immediately: visible);
  }

  void setForeground({required bool foreground}) {
    if (_foreground == foreground) return;
    _foreground = foreground;
    _updatePolling(immediately: foreground);
  }

  bool get polling => _poll != null;

  void _updatePolling({required bool immediately}) {
    final should = _visible && _foreground && !isDisposed;
    if (!should) {
      _poll?.cancel();
      _poll = null;
      return;
    }
    if (_poll != null) return;
    if (immediately) unawaited(proposals.load(force: true));
    _poll = Timer.periodic(_pollEvery, (_) {
      // Never stack polls behind an approval that is still in flight.
      if (_approving.isEmpty) unawaited(proposals.load(force: true));
    });
  }

  // ── Decisions ──────────────────────────────────────────────────────────

  /// Approves after the user has confirmed it, and says what happened. The
  /// request is sent once; if its answer is lost, the proposal's status is
  /// read back instead of trying again.
  Future<ApprovalOutcome?> approve(String id) async {
    if (_approving.contains(id) || _rejecting.contains(id)) return null;
    _approving.add(id);
    _outcomes.remove(id);
    notifyListeners();

    final result = await runAction('approve_proposal', () => _trading.approve(id));
    final ApprovalOutcome outcome;
    switch (result) {
      case Success(:final value):
        outcome = outcomeOf(value);
      case Err(failure: NetworkFailure()):
        // Never connected: the server did not see it.
        outcome = await _reconcile(id, fallback: const ApprovalNotReceived());
      case Err():
        // Lost answer, gateway error, or "already approved": the server's
        // record of the proposal says what really happened.
        outcome = await _reconcile(id);
    }

    _approving.remove(id);
    _outcomes[id] = outcome;
    unawaited(proposals.load(force: true));
    notifyListeners();
    return outcome;
  }

  Future<ApprovalOutcome> _reconcile(String id, {ApprovalOutcome? fallback}) async {
    final result = await _trading.proposals(force: true);
    final list = result.valueOrNull;
    if (list == null) return fallback ?? const OutcomeUnconfirmed();
    return reconcileApproval(list.where((p) => p.id == id).firstOrNull);
  }

  Future<Result<void>> reject(String id) async {
    if (_approving.contains(id) || _rejecting.contains(id)) {
      return const Err(ValidationFailure('Already being decided.'));
    }
    _rejecting.add(id);
    notifyListeners();
    final result = await runAction('reject_proposal', () => _trading.reject(id));
    _rejecting.remove(id);
    await proposals.load(force: true);
    return result;
  }

  // ── Daily brief ────────────────────────────────────────────────────────

  bool _briefingBusy = false;
  bool get briefingBusy => _briefingBusy;

  Future<Result<BriefingSchedule>> saveSchedule({
    required int hour,
    required int minute,
    required bool enabled,
  }) => _briefing(
    'briefing_save',
    () => _trading.saveBriefingSchedule(timeIst: istHhMm(hour, minute), enabled: enabled),
    after: () => schedule.load(),
  );

  Future<Result<void>> disableSchedule() => _briefing(
    'briefing_disable',
    _trading.disableBriefing,
    after: () => schedule.load(force: true),
  );

  /// The send runs in the background on the server; its log row lands about
  /// half a minute later, so the log is read again then.
  Future<Result<String>> sendBriefingNow() => _briefing(
    'briefing_send_now',
    _trading.sendBriefingNow,
    after: () async {
      _logsTimer?.cancel();
      _logsTimer = Timer(_logsSettle, () => unawaited(logs.load(force: true)));
    },
  );

  Future<Result<T>> _briefing<T>(
    String name,
    Future<Result<T>> Function() action, {
    required Future<void> Function() after,
  }) async {
    if (_briefingBusy) return const Err(ValidationFailure('Please wait for the last change.'));
    _briefingBusy = true;
    notifyListeners();
    final result = await runAction(name, action);
    _briefingBusy = false;
    if (result is Success) await after();
    notifyListeners();
    return result;
  }

  @override
  void dispose() {
    _poll?.cancel();
    _logsTimer?.cancel();
    super.dispose();
  }
}

extension<T> on T? {
  R? let<R>(R Function(T value) f) {
    final self = this;
    return self == null ? null : f(self);
  }
}
