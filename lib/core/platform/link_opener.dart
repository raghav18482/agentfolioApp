import 'package:agentfolio/core/telemetry/telemetry.dart';
import 'package:agentfolio/core/telemetry/telemetry_event.dart';
import 'package:logging/logging.dart';
import 'package:url_launcher/url_launcher.dart';

/// Opens web pages. Guides and legal pages open in an in-app browser
/// (SFSafariViewController / Custom Tabs), so the user stays in the app and
/// one swipe brings them back.
class LinkOpener {
  LinkOpener(this._telemetry);

  final Telemetry _telemetry;
  static final _log = Logger('LinkOpener');

  /// [id] names the link for analytics (`setup_guide`), never the URL, which
  /// may carry parameters.
  Future<bool> open(Uri uri, {required String id}) async {
    _telemetry.track(TelemetryEvent('link_opened', {'link': id}));
    try {
      if (await launchUrl(uri, mode: LaunchMode.inAppBrowserView)) return true;
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } on Object catch (e, s) {
      _log.warning('Could not open $id', e, s);
      return false;
    }
  }
}
