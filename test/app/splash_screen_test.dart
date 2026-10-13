import 'package:agentfolio/app/splash/app_startup.dart';
import 'package:agentfolio/app/splash/splash_screen.dart';
import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/telemetry/telemetry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../helpers/recording_sink.dart';

class _MockStartup extends Mock implements AppStartup;

void main() {
  late _MockStartup startup;
  late Telemetry telemetry;

  setUp(() async {
    startup = _MockStartup();
    when(() => startup.phase).thenReturn(StartupPhase.running);
    (telemetry, _) = await recordingTelemetry();
  });

  Widget harness({bool reduceMotion = false}) => MultiProvider(
    providers: [
      Provider<Telemetry>.value(value: telemetry),
      ChangeNotifierProvider<AppStartup>.value(value: startup),
    ],
    child: MaterialApp(
      theme: AppTheme.dark(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MediaQuery(
        data: MediaQueryData(disableAnimations: reduceMotion),
        child: const SplashScreen(),
      ),
    ),
  );

  testWidgets('tells startup the intro finished once the animation has played', (tester) async {
    await tester.pumpWidget(harness());
    verifyNever(() => startup.introFinished());

    await tester.pump(const Duration(milliseconds: 1000));
    verifyNever(() => startup.introFinished());

    await tester.pump(const Duration(milliseconds: 500));
    verify(() => startup.introFinished()).called(1);
    expect(find.text('Agentfolio'), findsOneWidget);
  });

  testWidgets('with reduce-motion, finishes at once', (tester) async {
    await tester.pumpWidget(harness(reduceMotion: true));
    await tester.pump();
    verify(() => startup.introFinished()).called(1);
  });

  testWidgets('offers Retry when the server cannot be reached', (tester) async {
    when(() => startup.phase).thenReturn(StartupPhase.offline);
    when(() => startup.retry()).thenAnswer((_) async {});
    await tester.pumpWidget(harness(reduceMotion: true));
    await tester.pump();

    await tester.tap(find.text('Retry'));
    verify(() => startup.retry()).called(1);
  });
}
