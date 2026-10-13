import 'package:agentfolio/core/network/api_client.dart';
import 'package:agentfolio/core/network/json.dart';
import 'package:agentfolio/core/network/json_fields.dart';
import 'package:agentfolio/features/ai/domain/entities/ai.dart';

/// `/api/ai/*`, mirroring `AgentfolioUI/src/api/ai.ts`. The server builds the
/// portfolio snapshot itself and forwards it, with the key, to OpenRouter.
/// It does not keep the key.
class AiRemoteDataSource {
  AiRemoteDataSource(this._api);

  final ApiClient _api;

  Future<String> insights(AiCredentials credentials) => _api.post(
    '/api/ai/insights',
    body: _credentials(credentials),
    decode: (json) => jsonString(asJsonMap(json)['insight']),
    timeout: ApiTimeouts.ai,
  );

  Future<String> ask(String question, AiCredentials credentials) => _api.post(
    '/api/ai/ask',
    body: {..._credentials(credentials), 'question': question},
    decode: (json) => jsonString(asJsonMap(json)['answer']),
    timeout: ApiTimeouts.ai,
  );

  static Map<String, Object?> _credentials(AiCredentials c) => {
    'api_key': c.apiKey,
    'model': c.model,
  };
}
