import 'package:freezed_annotation/freezed_annotation.dart';

part 'agent.freezed.dart';

/// The two agents the server runs. Both read the portfolio; only the trading
/// one proposes orders, and none is placed until the user approves it.
enum AgentType {
  finance,
  trading;

  String get wire => name;
}

/// A saved conversation. Saved conversations are a Premium feature; everyone
/// else talks in one unsaved conversation per agent.
@freezed
abstract class ChatThread with _$ChatThread {
  const factory ChatThread({
    required int id,
    required AgentType agentType,
    required String title,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ChatThread;
}

@freezed
abstract class ThreadList with _$ThreadList {
  const factory ThreadList({
    /// False when the server keeps no history for this user.
    required bool premium,
    required List<ChatThread> threads,
  }) = _ThreadList;
}

enum ChatRole { user, assistant }

/// Where a message the user sent stands.
enum Delivery {
  /// Answered, or loaded from history.
  delivered,

  /// On its way, or the agent is still working on it.
  sending,

  /// Known not to have been answered: safe to send again.
  failed,

  /// The connection dropped after it left. The agent may have it, and may
  /// have acted on it. Never resent automatically.
  unknown,
}

@freezed
abstract class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    /// Local only: stable across rebuilds, for keys and retries.
    required String id,
    required ChatRole role,
    required String text,
    @Default(Delivery.delivered) Delivery delivery,

    /// Why a send failed, in the server's words.
    String? failure,

    /// The server's account of an APPROVE / REJECT it carried out.
    String? approvalResult,
  }) = _ChatMessage;
}

@freezed
abstract class ChatReply with _$ChatReply {
  const factory ChatReply({required String reply, String? approvalResult, int? threadId}) =
      _ChatReply;
}
