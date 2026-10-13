import 'dart:async';

import 'package:agentfolio/core/telemetry/telemetry.dart';
import 'package:agentfolio/core/telemetry/telemetry_event.dart';
import 'package:agentfolio/features/ai/domain/entities/ai.dart';
import 'package:agentfolio/features/ai/domain/repositories/ai_key_repository.dart';
import 'package:agentfolio/features/auth/presentation/providers/session_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

/// The signed-in user's OpenRouter key and model, shared by every AI feature.
///
/// The key itself is never held here: only whether one is saved and its
/// [keyFingerprint]. [credentials] reads it from secure storage at the moment
/// a request needs it. Follows the session, so switching users switches keys,
/// and an explicit sign-out removes the key from the device.
class AiKeyProvider extends ChangeNotifier {
  AiKeyProvider({required this._repository, required this._session, required this._telemetry}) {
    _session
      ..addListener(_onSession)
      ..onSignOut(_repository.forget);
    _onSession();
  }

  final AiKeyRepository _repository;
  final SessionProvider _session;
  final Telemetry _telemetry;
  static final _log = Logger('AiKey');

  String? _userId;
  bool _ready = false;
  String? _fingerprint;
  String _model = AiModels.fallback;

  /// False until the saved key has been looked up for this user.
  bool get isReady => _ready;
  bool get hasKey => _fingerprint != null;

  /// Changes whenever the saved key does. Cached answers are keyed by it.
  String? get keyFingerprint => _fingerprint;
  String get model => _model;

  void _onSession() {
    final id = _session.signedIn?.user.id;
    if (id == _userId) return;
    _userId = id;
    _ready = false;
    _fingerprint = null;
    _model = AiModels.fallback;
    notifyListeners();
    if (id != null) unawaited(_load(id));
  }

  Future<void> _load(String userId) async {
    final key = await _readKey(userId);
    if (_userId != userId) return; // the user changed while reading
    _fingerprint = key == null ? null : AiKeyRules.fingerprint(key);
    _model = _repository.model(userId) ?? AiModels.fallback;
    _ready = true;
    notifyListeners();
  }

  /// The key and model for one request, or null when there is no key.
  Future<AiCredentials?> credentials() async {
    final userId = _userId;
    if (userId == null) return null;
    final key = await _readKey(userId);
    if (key == null || _userId != userId) return null;
    return AiCredentials(apiKey: key, model: _model);
  }

  Future<void> saveKey(String raw) async {
    final userId = _userId;
    if (userId == null) return;
    final key = raw.trim();
    await _repository.saveKey(userId, key);
    if (_userId != userId) return;
    _fingerprint = AiKeyRules.fingerprint(key);
    _track('ai_key_saved');
    notifyListeners();
  }

  Future<void> removeKey() async {
    final userId = _userId;
    if (userId == null) return;
    await _repository.deleteKey(userId);
    if (_userId != userId) return;
    _fingerprint = null;
    _track('ai_key_removed');
    notifyListeners();
  }

  Future<void> setModel(String model) async {
    final userId = _userId;
    final id = model.trim();
    if (userId == null || id == _model || !AiModels.isValidId(id)) return;
    _model = id;
    notifyListeners();
    await _repository.setModel(userId, id);
  }

  /// A Keychain that cannot be read (locked before first unlock, or an
  /// Android restore whose Keystore key is gone) means no usable key: the
  /// user is asked for it again rather than shown an error.
  Future<String?> _readKey(String userId) async {
    try {
      final key = await _repository.readKey(userId);
      return key == null || key.trim().isEmpty ? null : key;
    } on Object catch (e, s) {
      _log.warning('Could not read the saved OpenRouter key', e, s);
      return null;
    }
  }

  void _track(String action) =>
      _telemetry.track(TelemetryEvent(EventName.actionSucceeded, {'action': action}));

  @override
  void dispose() {
    _session.removeListener(_onSession);
    super.dispose();
  }
}
