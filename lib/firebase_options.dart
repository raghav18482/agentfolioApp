// File generated to match the Firebase project "agentfolio-app".
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter/services.dart' show appFlavor;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'register a web app in the Firebase console and add its options here.',
      );
    }
    // Picked by the native flavor (`--flavor dev`), not the Dart config, because
    // the options must match the bundle ID the app was actually installed as.
    final isDev = appFlavor == 'dev';
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return isDev ? androidDev : android;
      case TargetPlatform.iOS:
        return isDev ? iosDev : ios;
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for '
          '$defaultTargetPlatform - only Android and iOS are registered.',
        );
      default:
        throw UnsupportedError('DefaultFirebaseOptions are not supported for this platform.');
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB2ZPKgsNnEWCQTAgCYJFxt3Gxtgsbn1zY',
    appId: '1:151342190258:android:f692758bdd8ec2460683ab',
    messagingSenderId: '151342190258',
    projectId: 'agentfolio-app',
    storageBucket: 'agentfolio-app.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAS8b-x_Zl2mQfPsg8pk-rgR6ZxIlsddsc',
    appId: '1:151342190258:ios:61a708db3487ba290683ab',
    messagingSenderId: '151342190258',
    projectId: 'agentfolio-app',
    storageBucket: 'agentfolio-app.firebasestorage.app',
    iosBundleId: 'in.agentfolio.app',
  );

  static const FirebaseOptions androidDev = FirebaseOptions(
    apiKey: 'AIzaSyB2ZPKgsNnEWCQTAgCYJFxt3Gxtgsbn1zY',
    appId: '1:151342190258:android:c61f9a4335c71f380683ab',
    messagingSenderId: '151342190258',
    projectId: 'agentfolio-app',
    storageBucket: 'agentfolio-app.firebasestorage.app',
  );

  static const FirebaseOptions iosDev = FirebaseOptions(
    apiKey: 'AIzaSyAS8b-x_Zl2mQfPsg8pk-rgR6ZxIlsddsc',
    appId: '1:151342190258:ios:c3ca3cac268aac930683ab',
    messagingSenderId: '151342190258',
    projectId: 'agentfolio-app',
    storageBucket: 'agentfolio-app.firebasestorage.app',
    iosBundleId: 'in.agentfolio.app.dev',
  );
}
