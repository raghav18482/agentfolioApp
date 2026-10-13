import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/features/agent/domain/entities/agent.dart';

/// Conversations with the server's finance and trading agents. They run on
/// the server's own model key: nothing for the user to set up.
abstract interface class AgentRepository {
  Future<Result<ThreadList>> threads(AgentType type, {bool force = false});

  /// The last thread list fetched, for an instant paint.
  ThreadList? cachedThreads(AgentType type);

  Future<Result<List<ChatMessage>>> messages(int threadId);

  Future<Result<ChatThread>> createThread(AgentType type);
  Future<Result<ChatThread>> rename(int threadId, String title);
  Future<Result<void>> delete(int threadId);

  /// One turn. Not idempotent: never retried, and a dropped connection comes
  /// back as an unknown outcome to reconcile, not a failure to resend.
  Future<Result<ChatReply>> send(String message, AgentType type, {int? threadId});

  /// Forgets the unsaved conversation, so the next message starts afresh.
  Future<Result<void>> resetUnsaved(AgentType type);
}
