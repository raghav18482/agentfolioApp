import 'package:agentfolio/core/storage/prefs.dart';
import 'package:agentfolio/core/storage/secure_store.dart';
import 'package:logging/logging.dart';

/// Wipes secure storage on the first launch after an install.
///
/// The iOS Keychain outlives an uninstall, but app preferences do not. Without
/// this, deleting and reinstalling the app would quietly sign the previous
/// user back in with their old session cookie. The missing preference marker
/// is how we tell a fresh install from an ordinary launch.
class FirstLaunchGuard {
  FirstLaunchGuard(this._prefs, this._secureStore);

  final Prefs _prefs;
  final SecureStore _secureStore;
  static final _log = Logger('FirstLaunchGuard');

  Future<void> run() async {
    if (_prefs.hasInstallMarker) return;
    _log.info('Fresh install: clearing secure storage left by a previous install');
    await _secureStore.deleteAll();
    await _prefs.setInstallMarker();
  }
}
