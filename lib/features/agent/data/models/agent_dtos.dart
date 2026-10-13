import 'package:agentfolio/core/network/json_fields.dart';
import 'package:agentfolio/core/utils/time.dart';
import 'package:agentfolio/features/agent/domain/agent_logic.dart';
import 'package:agentfolio/features/agent/domain/entities/agent.dart';
import 'package:json_annotation/json_annotation.dart';

part 'agent_dtos.g.dart';

AgentType _agentType(Object? v) =>
    AgentType.values.where((t) => t.wire == v).firstOrNull ?? AgentType.finance;

/// One entry of `GET /api/agent/threads`, and the `thread` of create/rename.
@JsonSerializable(fieldRename: FieldRename.snake)
class ChatThreadDto {
  const ChatThreadDto({
    required this.id,
    required this.agentType,
    required this.title,
    this.createdAt,
    this.updatedAt,
  });

  factory ChatThreadDto.fromJson(Map<String, dynamic> json) => _$ChatThreadDtoFromJson(json);

  @JsonKey(fromJson: jsonInt)
  final int id;
  @JsonKey(fromJson: _agentType)
  final AgentType agentType;
  @JsonKey(fromJson: jsonString)
  final String title;
  @JsonKey(fromJson: jsonStringOrNull)
  final String? createdAt;
  @JsonKey(fromJson: jsonStringOrNull)
  final String? updatedAt;

  ChatThread toEntity() => ChatThread(
    id: id,
    agentType: agentType,
    title: title.trim().isEmpty ? defaultThreadTitle : title.trim(),
    createdAt: Times.parseServer(createdAt),
    updatedAt: Times.parseServer(updatedAt),
  );
}

@JsonSerializable()
class ThreadListDto {
  const ThreadListDto({required this.premium, required this.threads});

  factory ThreadListDto.fromJson(Map<String, dynamic> json) => _$ThreadListDtoFromJson(json);

  @JsonKey(defaultValue: false)
  final bool premium;
  @JsonKey(defaultValue: <ChatThreadDto>[])
  final List<ChatThreadDto> threads;

  ThreadList toEntity() =>
      ThreadList(premium: premium, threads: [for (final t in threads) t.toEntity()]);
}

/// One `{role, text}` of `GET /api/agent/threads/{id}/messages`.
@JsonSerializable()
class ChatMessageDto {
  const ChatMessageDto({required this.role, required this.text});

  factory ChatMessageDto.fromJson(Map<String, dynamic> json) => _$ChatMessageDtoFromJson(json);

  @JsonKey(fromJson: jsonString)
  final String role;
  @JsonKey(fromJson: jsonString)
  final String text;

  ChatMessage toEntity(String id) => ChatMessage(
    id: id,
    role: role == 'user' ? ChatRole.user : ChatRole.assistant,
    text: historyText(text),
  );
}

/// `POST /api/agent/chat`.
@JsonSerializable(fieldRename: FieldRename.snake)
class ChatReplyDto {
  const ChatReplyDto({required this.reply, this.approvalResult, this.threadId});

  factory ChatReplyDto.fromJson(Map<String, dynamic> json) => _$ChatReplyDtoFromJson(json);

  @JsonKey(fromJson: jsonString)
  final String reply;
  @JsonKey(fromJson: jsonStringOrNull)
  final String? approvalResult;
  @JsonKey(fromJson: _intOrNull)
  final int? threadId;

  ChatReply toEntity() =>
      ChatReply(reply: reply.trim(), approvalResult: approvalResult, threadId: threadId);
}

int? _intOrNull(Object? v) => v == null ? null : jsonInt(v);
