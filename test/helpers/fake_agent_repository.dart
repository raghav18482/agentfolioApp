import 'dart:async';

import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/features/agent/domain/agent_logic.dart';
import 'package:agentfolio/features/agent/domain/entities/agent.dart';
import 'package:agentfolio/features/agent/domain/repositories/agent_repository.dart';

ChatThread thread(int id, String title, {DateTime? at}) => ChatThread(
  id: id,
  agentType: AgentType.finance,
  title: title,
  updatedAt: at ?? DateTime(2026, 10, 12, 10).subtract(Duration(hours: id)),
);

ChatMessage said(ChatRole role, String text, [String? id]) =>
    ChatMessage(id: id ?? 'h-$text', role: role, text: text);

/// A server with saved threads (when [premium]) whose answers each test sets.
/// Messages sent are "received" into the thread's history as the real
/// server does, before the reply is written.
class FakeAgentRepository implements AgentRepository {
  FakeAgentRepository({this.premium = true, List<ChatThread>? threads}) : threads_ = threads ?? [];

  bool premium;
  List<ChatThread> threads_;
  final history = <int, List<ChatMessage>>{};
  final calls = <String>[];
  int _nextId = 100;

  Result<ThreadList>? threadsFailure;
  Result<List<ChatMessage>>? messagesFailure;
  Result<ChatThread>? createFailure;

  /// What a send returns; by default a reply echoing the message.
  Result<ChatReply> Function(String message)? onSend;

  /// When false, a send is "lost" before the server receives it.
  bool receives = true;

  /// When set, sends wait for it.
  Completer<void>? gate;

  @override
  Future<Result<ThreadList>> threads(AgentType type, {bool force = false}) async {
    calls.add('threads');
    return threadsFailure ?? Success(ThreadList(premium: premium, threads: [...threads_]));
  }

  @override
  ThreadList? cachedThreads(AgentType type) => null;

  @override
  Future<Result<List<ChatMessage>>> messages(int threadId) async {
    calls.add('messages:$threadId');
    return messagesFailure ?? Success([...?history[threadId]]);
  }

  @override
  Future<Result<ChatThread>> createThread(AgentType type) async {
    calls.add('create');
    if (createFailure case final failure?) return failure;
    final t = ChatThread(
      id: _nextId++,
      agentType: type,
      title: defaultThreadTitle,
      updatedAt: DateTime(2026, 10, 12, 12),
    );
    threads_.insert(0, t);
    return Success(t);
  }

  @override
  Future<Result<ChatThread>> rename(int threadId, String title) async {
    calls.add('rename:$threadId:$title');
    final i = threads_.indexWhere((t) => t.id == threadId);
    threads_[i] = threads_[i].copyWith(title: title);
    return Success(threads_[i]);
  }

  @override
  Future<Result<void>> delete(int threadId) async {
    calls.add('delete:$threadId');
    threads_.removeWhere((t) => t.id == threadId);
    history.remove(threadId);
    return const Success(null);
  }

  @override
  Future<Result<ChatReply>> send(String message, AgentType type, {int? threadId}) async {
    calls.add('send:${threadId ?? '-'}:$message');
    if (receives && threadId != null) {
      (history[threadId] ??= []).add(said(ChatRole.user, message, 'h${_nextId++}'));
    }
    await gate?.future;
    final result =
        onSend?.call(message) ??
        Success(ChatReply(reply: 'Reply to: $message', threadId: threadId));
    if (result case Success(:final value) when threadId != null) {
      (history[threadId] ??= []).add(said(ChatRole.assistant, value.reply, 'h${_nextId++}'));
    }
    return result;
  }

  @override
  Future<Result<void>> resetUnsaved(AgentType type) async {
    calls.add('reset');
    return const Success(null);
  }
}

Result<ChatReply> lostConnection(String _) => const Err(UnknownOutcomeFailure());
