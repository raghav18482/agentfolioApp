import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Keychain (iOS) / Keystore-encrypted storage (Android) for anything that
/// grants access: the session cookie and the OpenRouter key.
///
/// iOS items are `first_unlock_this_device`, so they never sync to iCloud or
/// restore onto another phone. Android resets on a decrypt error, which is
/// what happens when Auto Backup restores data whose Keystore key did not come
/// with it. The user is then simply asked to sign in again.
class SecureStore {
  SecureStore([FlutterSecureStorage? storage])
    : _storage =
          storage ??
          const FlutterSecureStorage(
            iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock_this_device),
          );

  final FlutterSecureStorage _storage;

  Future<String?> read(String key) => _storage.read(key: key);

  Future<void> write(String key, String value) => _storage.write(key: key, value: value);

  Future<void> delete(String key) => _storage.delete(key: key);

  Future<Map<String, String>> readAll() => _storage.readAll();

  Future<void> deleteAll() => _storage.deleteAll();
}
