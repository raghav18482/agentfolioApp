import 'package:agentfolio/core/network/api_client.dart';
import 'package:agentfolio/core/network/json.dart';
import 'package:agentfolio/core/network/json_fields.dart';
import 'package:agentfolio/features/trading/data/models/trading_dtos.dart';
import 'package:agentfolio/features/trading/domain/entities/trading.dart';

/// `/api/trading/*`, `/api/briefing/*` and `/api/premium/register`,
/// mirroring `AgentfolioUI/src/api/trading.ts` and `premium.ts`.
class TradingRemoteDataSource {
  TradingRemoteDataSource(this._api);

  final ApiClient _api;

  Future<RiskProfile?> riskProfile() =>
      _api.get('/api/trading/profile', decode: (json) => riskProfileFromJson(asJsonMap(json)));

  Future<RiskProfile> saveRiskProfile(RiskProfile profile) => _api.post(
    '/api/trading/profile',
    body: riskProfileToJson(profile),
    decode: (json) => riskProfileFromMap(asJsonMap(asJsonMap(json)['profile'])),
  );

  Future<List<TradeProposal>> proposals() => _api.get(
    '/api/trading/proposals',
    decode: (json) => asJsonList(asJsonMap(json)['proposals'], proposalFromJson),
  );

  /// Executes against the broker, which can take a while after a restart.
  Future<ExecutionResult> approve(String id) => _api.post(
    '/api/trading/proposals/${Uri.encodeComponent(id)}/approve',
    decode: (json) => executionResultFromJson(asJsonMap(json)),
    timeout: ApiTimeouts.slow,
  );

  Future<void> reject(String id) =>
      _api.post('/api/trading/proposals/${Uri.encodeComponent(id)}/reject', decode: ignoreBody);

  Future<BriefingSchedule?> briefingSchedule() => _api.get(
    '/api/briefing/schedule',
    decode: (json) => briefingScheduleFromJson(asJsonMap(json)),
  );

  Future<BriefingSchedule> saveBriefingSchedule(String timeIst, {required bool enabled}) =>
      _api.post(
        '/api/briefing/schedule',
        body: {'time_ist': timeIst, 'enabled': enabled},
        decode: (json) => briefingScheduleFromMap(asJsonMap(asJsonMap(json)['schedule'])),
      );

  Future<void> disableBriefing() => _api.delete('/api/briefing/schedule', decode: ignoreBody);

  Future<String> sendBriefingNow() =>
      _api.post('/api/briefing/send-now', decode: (json) => jsonString(asJsonMap(json)['message']));

  Future<List<BriefingLog>> briefingLogs() => _api.get(
    '/api/briefing/logs',
    decode: (json) => asJsonList(asJsonMap(json)['logs'], briefingLogFromJson),
  );

  Future<void> activatePremium(String dialCode, String number) => _api.post(
    '/api/premium/register',
    body: {'country_code': dialCode, 'whatsapp_number': number},
    decode: ignoreBody,
  );
}
