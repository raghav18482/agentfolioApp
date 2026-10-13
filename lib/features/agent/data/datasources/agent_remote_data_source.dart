import 'package:agentfolio/core/network/api_client.dart';
import 'package:agentfolio/core/network/json.dart';
import 'package:agentfolio/features/agent/data/models/agent_dtos.dart';
import 'package:agentfolio/features/agent/domain/entities/agent.dart';

/// `/api/agent/*`, mirroring `AgentfolioUI/src/api/agent.ts`.
class AgentRemoteDataSource {
  AgentRemoteDataSource(this._api);

  final ApiClient _api;

  Future<ThreadListDto> threads(AgentType type) => _api.get(
    '/api/agent/threads',
    query: {'agent_type': type.wire},
    decode: (json) => ThreadListDto.fromJson(asJsonMap(json)),
  );

  Future<List<ChatMessageDto>> messages(int threadId) => _api.get(
    '/api/agent/threads/$threadId/messages',
    decode: (json) => asJsonList(asJsonMap(json)['messages'], ChatMessageDto.fromJson),
  );

  Future<ChatThreadDto> createThread(AgentType type) => _api.post(
    '/api/agent/threads',
    body: {'agent_type': type.wire},
    decode: (json) => ChatThreadDto.fromJson(asJsonMap(asJsonMap(json)['thread'])),
  );

  Future<ChatThreadDto> rename(int threadId, String title) => _api.patch(
    '/api/agent/threads/$threadId',
    body: {'title': title},
    decode: (json) => ChatThreadDto.fromJson(asJsonMap(asJsonMap(json)['thread'])),
  );

  Future<void> delete(int threadId) =>
      _api.delete('/api/agent/threads/$threadId', decode: ignoreBody);

  Future<ChatReplyDto> chat(String message, AgentType type, int? threadId) => _api.post(
    '/api/agent/chat',
    body: {'message': message, 'agent_type': type.wire, 'thread_id': ?threadId},
    decode: (json) => ChatReplyDto.fromJson(asJsonMap(json)),
    timeout: ApiTimeouts.agent,
  );

  Future<void> resetUnsaved(AgentType type) =>
      _api.post('/api/agent/new-chat', body: {'agent_type': type.wire}, decode: ignoreBody);
}
