import 'package:shared_preferences/shared_preferences.dart';

/// Non-sensitive preferences: onboarding seen, hide balances, analytics
/// consent, AI model choice. Anything that grants access goes in `SecureStore`.
class Prefs {
  Prefs(this._prefs);

  final SharedPreferencesWithCache _prefs;

  static const _installMarker = 'install_marker_v1';
  static const _onboardingSeen = 'onboarding_seen';
  static const _analyticsEnabled = 'analytics_enabled';
  static const _hideBalances = 'hide_balances';
  static const _appLock = 'app_lock_enabled';

  // Per user, keyed by a hash of the user id: two people sharing a phone each
  // keep their own, and signing out removes only one person's.
  static const _aiModelPrefix = 'ai_model.';
  static const _agentDraftPrefix = 'agent_draft.';
  static const _riskAckPrefix = 'risk_disclosure_v1.';

  static Future<Prefs> create() async => Prefs(
    await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(),
    ),
  );

  bool get hasInstallMarker => _prefs.getBool(_installMarker) ?? false;
  Future<void> setInstallMarker() => _prefs.setBool(_installMarker, true);

  bool get onboardingSeen => _prefs.getBool(_onboardingSeen) ?? false;
  Future<void> setOnboardingSeen() => _prefs.setBool(_onboardingSeen, true);

  bool get analyticsEnabled => _prefs.getBool(_analyticsEnabled) ?? true;
  Future<void> setAnalyticsEnabled({required bool enabled}) =>
      _prefs.setBool(_analyticsEnabled, enabled);

  /// Face ID / passcode to open the app. Off unless the user turns it on.
  bool get appLockEnabled => _prefs.getBool(_appLock) ?? false;
  Future<void> setAppLockEnabled({required bool enabled}) => _prefs.setBool(_appLock, enabled);

  bool get hideBalances => _prefs.getBool(_hideBalances) ?? false;
  Future<void> setHideBalances({required bool hide}) => _prefs.setBool(_hideBalances, hide);

  /// The OpenRouter model id this user chose, if any.
  String? aiModel(String userScope) => _prefs.getString('$_aiModelPrefix$userScope');
  Future<void> setAiModel(String userScope, String model) =>
      _prefs.setString('$_aiModelPrefix$userScope', model);

  /// An unsent chat message, kept so it survives the app being closed.
  /// [draftKey] names the user and the conversation.
  String? agentDraft(String draftKey) => _prefs.getString('$_agentDraftPrefix$draftKey');
  Future<void> setAgentDraft(String draftKey, String text) => text.trim().isEmpty
      ? _prefs.remove('$_agentDraftPrefix$draftKey')
      : _prefs.setString('$_agentDraftPrefix$draftKey', text);

  /// Whether this user has read and accepted the trading risk disclosure.
  /// Versioned: a changed disclosure is a new key, asked again.
  bool riskDisclosureAccepted(String userScope) =>
      _prefs.getBool('$_riskAckPrefix$userScope') ?? false;
  Future<void> setRiskDisclosureAccepted(String userScope) =>
      _prefs.setBool('$_riskAckPrefix$userScope', true);

  /// Removes everything kept for one user: on sign-out.
  Future<void> clearUser(String userScope) async {
    await _prefs.remove('$_aiModelPrefix$userScope');
    await _prefs.remove('$_riskAckPrefix$userScope');
    for (final key in _prefs.keys.toList()) {
      if (key.startsWith('$_agentDraftPrefix$userScope')) await _prefs.remove(key);
    }
  }
}
