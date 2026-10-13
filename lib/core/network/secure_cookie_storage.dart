import 'package:agentfolio/core/storage/secure_store.dart';
import 'package:cookie_jar/cookie_jar.dart';

/// Keeps the cookie jar in the Keychain/Keystore instead of plain files.
///
/// The backend's session cookie alone can place trades for seven days, so it
/// is a credential and is stored like one.
class SecureCookieStorage implements Storage {
  SecureCookieStorage(this._store);

  final SecureStore _store;
  static const _prefix = 'cookies.';

  @override
  Future<void> init(bool persistSession, bool ignoreExpires) async {}

  @override
  Future<String?> read(String key) => _store.read('$_prefix$key');

  @override
  Future<void> write(String key, String value) => _store.write('$_prefix$key', value);

  @override
  Future<void> delete(String key) => _store.delete('$_prefix$key');

  @override
  Future<void> deleteAll(List<String> keys) async {
    for (final key in keys) {
      await delete(key);
    }
  }
}
