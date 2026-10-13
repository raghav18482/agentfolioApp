import 'package:agentfolio/core/storage/prefs.dart';
import 'package:agentfolio/core/storage/secure_store.dart';
import 'package:agentfolio/core/telemetry/user_hash.dart';
import 'package:agentfolio/features/ai/domain/repositories/ai_key_repository.dart';

class AiKeyRepositoryImpl implements AiKeyRepository {
  AiKeyRepositoryImpl(this._secure, this._prefs);

  final SecureStore _secure;
  final Prefs _prefs;

  // Keyed by a hash of the user id, so the client code is not stored as a
  // readable key name either.
  static String _scope(String userId) => hashUserId(userId);
  static String _keyName(String userId) => 'openrouter_key.${_scope(userId)}';

  @override
  Future<String?> readKey(String userId) => _secure.read(_keyName(userId));

  @override
  Future<void> saveKey(String userId, String key) => _secure.write(_keyName(userId), key.trim());

  @override
  Future<void> deleteKey(String userId) => _secure.delete(_keyName(userId));

  @override
  String? model(String userId) => _prefs.aiModel(_scope(userId));

  @override
  Future<void> setModel(String userId, String model) =>
      _prefs.setAiModel(_scope(userId), model.trim());

  @override
  Future<void> forget(String userId) async {
    await deleteKey(userId);
    await _prefs.clearUser(_scope(userId));
  }
}
