/// Where a user's OpenRouter key and model choice live on this device.
///
/// The key goes to the Keychain / Keystore, never to plain preferences.
/// Everything is per user, so two people sharing a phone never use each
/// other's key.
abstract interface class AiKeyRepository {
  Future<String?> readKey(String userId);
  Future<void> saveKey(String userId, String key);
  Future<void> deleteKey(String userId);

  String? model(String userId);
  Future<void> setModel(String userId, String model);

  /// Removes everything kept for [userId].
  Future<void> forget(String userId);
}
