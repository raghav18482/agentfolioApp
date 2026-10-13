/// Every event name the app sends, in one place.
///
/// `object_action`, snake_case, past tense where it describes something that
/// happened. Analytics tools key dashboards on these strings, so renaming one
/// breaks history: add a new name instead.
abstract final class EventName {
  // App lifecycle
  static const appOpened = 'app_opened';
  static const appForegrounded = 'app_foregrounded';
  static const appBackgrounded = 'app_backgrounded';
  static const splashCompleted = 'splash_completed';

  // Navigation & interaction (captured automatically by the design system)
  static const screenViewed = 'screen_viewed';
  static const uiTapped = 'ui_tapped';
  static const uiChanged = 'ui_changed';

  // Network (captured automatically by the Dio interceptor)
  static const apiRequested = 'api_requested';

  // View-model actions (captured automatically by BaseViewModel.runAction)
  static const actionSucceeded = 'action_succeeded';
  static const actionFailed = 'action_failed';

  // Session
  static const sessionRestored = 'session_restored';
  static const sessionExpired = 'session_expired';
  static const loggedIn = 'logged_in';
  static const loggedOut = 'logged_out';
  static const accountDeleted = 'account_deleted';
}

/// One thing that happened, with properties safe to send anywhere.
///
/// Properties pass through the redactor before any sink sees them, but callers
/// should still never put credentials, phone numbers, chat text or amounts in.
class TelemetryEvent {
  const TelemetryEvent(this.name, [this.properties = const {}]);

  /// A tap on a tracked design-system widget.
  factory TelemetryEvent.tap(String trackId) =>
      TelemetryEvent(EventName.uiTapped, {'track_id': trackId});

  /// A selection change (segment, switch, chip). [selection] must be an
  /// identifier like `holdings`, never user-entered text.
  factory TelemetryEvent.change(String trackId, String selection) =>
      TelemetryEvent(EventName.uiChanged, {'track_id': trackId, 'selection': selection});

  final String name;
  final Map<String, Object?> properties;

  @override
  String toString() => properties.isEmpty ? name : '$name $properties';
}

/// Who is using the app, as analytics should know them: a stable hash, never
/// the broker client id or phone number itself.
class TelemetryUser {
  const TelemetryUser({required this.id, this.traits = const {}});

  final String id;
  final Map<String, Object?> traits;
}
