// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatThreadDto _$ChatThreadDtoFromJson(Map<String, dynamic> json) => $checkedCreate(
  'ChatThreadDto',
  json,
  ($checkedConvert) {
    final val = ChatThreadDto(
      id: $checkedConvert('id', (v) => jsonInt(v)),
      agentType: $checkedConvert('agent_type', (v) => _agentType(v)),
      title: $checkedConvert('title', (v) => jsonString(v)),
      createdAt: $checkedConvert('created_at', (v) => jsonStringOrNull(v)),
      updatedAt: $checkedConvert('updated_at', (v) => jsonStringOrNull(v)),
    );
    return val;
  },
  fieldKeyMap: const {
    'agentType': 'agent_type',
    'createdAt': 'created_at',
    'updatedAt': 'updated_at',
  },
);

ThreadListDto _$ThreadListDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ThreadListDto', json, ($checkedConvert) {
      final val = ThreadListDto(
        premium: $checkedConvert('premium', (v) => v as bool? ?? false),
        threads: $checkedConvert(
          'threads',
          (v) =>
              (v as List<dynamic>?)
                  ?.map((e) => ChatThreadDto.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [],
        ),
      );
      return val;
    });

ChatMessageDto _$ChatMessageDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ChatMessageDto', json, ($checkedConvert) {
      final val = ChatMessageDto(
        role: $checkedConvert('role', (v) => jsonString(v)),
        text: $checkedConvert('text', (v) => jsonString(v)),
      );
      return val;
    });

ChatReplyDto _$ChatReplyDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ChatReplyDto', json, ($checkedConvert) {
      final val = ChatReplyDto(
        reply: $checkedConvert('reply', (v) => jsonString(v)),
        approvalResult: $checkedConvert('approval_result', (v) => jsonStringOrNull(v)),
        threadId: $checkedConvert('thread_id', (v) => _intOrNull(v)),
      );
      return val;
    }, fieldKeyMap: const {'approvalResult': 'approval_result', 'threadId': 'thread_id'});
