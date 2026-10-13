import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/platform/link_opener.dart';
import 'package:agentfolio/core/presentation/privacy/privacy_provider.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/telemetry/telemetry.dart';
import 'package:agentfolio/features/ai/presentation/providers/ai_key_provider.dart';
import 'package:agentfolio/features/ai/presentation/screens/ai_settings_screen.dart';
import 'package:agentfolio/features/ai/presentation/view_models/ai_insights_view_model.dart';
import 'package:agentfolio/features/ai/presentation/view_models/ask_view_model.dart';
import 'package:agentfolio/features/ai/presentation/widgets/ai_insights_card.dart';
import 'package:agentfolio/features/ai/presentation/widgets/ask_ai_card.dart';
import 'package:agentfolio/features/ai/presentation/widgets/ask_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../helpers/a11y.dart';
import '../../helpers/fake_ai.dart';
import '../../helpers/recording_sink.dart';

const _key = 'sk-or-v1-0123456789abcdef0123';

void main() {
  late Telemetry telemetry;
  late FakeAiKeyRepository keys;
  late FakeAiRepository ai;
  late AiKeyProvider aiKey;

  setUp(() async {
    (telemetry, _) = await recordingTelemetry();
    keys = FakeAiKeyRepository();
    ai = FakeAiRepository();
  });

  Future<void> pumpApp(WidgetTester tester, Widget home) async {
    tester.view
      ..physicalSize = const Size(390, 844) * 3
      ..devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    final (session, _) = await signedInSession(telemetry);
    aiKey = AiKeyProvider(repository: keys, session: session, telemetry: telemetry);
    final prefs = await memoryPrefs();
    final router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (context, state) => home),
        GoRoute(path: '/account/ai', builder: (context, state) => const AiSettingsScreen()),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<Telemetry>.value(value: telemetry),
          Provider<LinkOpener>.value(value: LinkOpener(telemetry)),
          ChangeNotifierProvider(create: (_) => PrivacyProvider(prefs)),
          ChangeNotifierProvider<AiKeyProvider>.value(value: aiKey),
        ],
        child: MaterialApp.router(
          theme: AppTheme.dark(),
          routerConfig: router,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Widget homeCards() => MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => AiInsightsViewModel(ai: ai, aiKey: aiKey, telemetry: telemetry),
      ),
      Provider<AskViewModelFactory>.value(
        value: () => AskViewModel(ai: ai, aiKey: aiKey, telemetry: telemetry),
      ),
    ],
    child: Scaffold(body: ListView(children: const [AiInsightsCard(), AskAiCard()])),
  );

  group('AI settings', () {
    testWidgets('checks a key before saving it, then shows it saved', (tester) async {
      await pumpApp(tester, const AiSettingsScreen());
      expect(find.text('Not set'), findsOneWidget);

      await tester.enterText(find.byType(TextField).first, 'sk-or-v1 has spaces in it');
      await tester.pump();
      await tester.tap(find.text('Save key'));
      await tester.pump();
      expect(find.textContaining('no spaces'), findsOneWidget);
      expect(keys.keys, isEmpty);

      await tester.enterText(find.byType(TextField).first, 'sk-proj-0123456789abcdef');
      await tester.pump();
      expect(find.textContaining('usually start with sk-or-'), findsOneWidget);

      await tester.enterText(find.byType(TextField).first, '$_key\n');
      await tester.pump();
      await tester.tap(find.text('Save key'));
      await tester.pumpAndSettle();
      expect(keys.keys['A123'], _key);
      expect(find.text('Saved'), findsOneWidget);
      expect(find.text('Replace key'), findsOneWidget);
      // The field is emptied: the key is never shown again.
      expect(tester.widget<TextField>(find.byType(TextField).first).controller!.text, isEmpty);
    });

    testWidgets('removing a key asks first', (tester) async {
      keys.keys['A123'] = _key;
      await pumpApp(tester, const AiSettingsScreen());
      await tester.tap(find.text('Remove'));
      await tester.pumpAndSettle();
      expect(find.text('Remove your key?'), findsOneWidget);
      await tester.tap(find.text('Remove').last);
      await tester.pumpAndSettle();
      expect(keys.keys, isEmpty);
      expect(find.text('Not set'), findsOneWidget);
    });

    testWidgets('a preset or a valid custom model can be chosen', (tester) async {
      await pumpApp(tester, const AiSettingsScreen());
      await tester.tap(find.text('openai/gpt-4o'));
      await tester.pumpAndSettle();
      expect(keys.models['A123'], 'openai/gpt-4o');

      await tester.ensureVisible(find.text('Another model'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Another model'));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('Use this model'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).last, 'not a model');
      await tester.tap(find.text('Use this model'));
      await tester.pumpAndSettle();
      expect(find.textContaining('provider/model-name'), findsOneWidget);
      expect(keys.models['A123'], 'openai/gpt-4o');

      await tester.ensureVisible(find.text('Use this model'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).last, 'meta-llama/llama-3.1-8b-instruct:free');
      await tester.tap(find.text('Use this model'));
      await tester.pumpAndSettle();
      expect(keys.models['A123'], 'meta-llama/llama-3.1-8b-instruct:free');
    });
  });

  group('Home cards', () {
    testWidgets('without a key, both cards lead to AI settings', (tester) async {
      await pumpApp(tester, homeCards());
      expect(find.text('Set up AI'), findsNWidgets(2));
      await tester.tap(find.text('Set up AI').first);
      await tester.pumpAndSettle();
      expect(find.text('AI settings'), findsOneWidget);
    });

    testWidgets('insights are written only when asked, then kept', (tester) async {
      keys.keys['A123'] = _key;
      await pumpApp(tester, homeCards());
      expect(ai.calls, isEmpty);
      expect(find.textContaining('Uses your OpenRouter credit'), findsOneWidget);

      await tester.tap(find.text('Write insights'));
      await tester.pumpAndSettle();
      expect(find.textContaining('Rs. 3,600', findRichText: true), findsOneWidget);
      expect(find.textContaining('openai/gpt-4o-mini · just now'), findsOneWidget);
      expect(ai.calls, ['insights:openai/gpt-4o-mini']);
    });

    testWidgets('a refused key offers Check key instead of Retry', (tester) async {
      keys.keys['A123'] = _key;
      ai.insightsResult = const Err(
        ValidationFailure('Invalid OpenRouter API key. Please check and try again.'),
      );
      await pumpApp(tester, homeCards());
      await tester.tap(find.text('Write insights'));
      await tester.pumpAndSettle();
      expect(find.text('Check key'), findsOneWidget);
      expect(find.text('Retry'), findsNothing);
    });

    testWidgets('a starter opens Ask with the answer, and follow-ups can be asked', (tester) async {
      keys.keys['A123'] = _key;
      await pumpApp(tester, homeCards());
      await tester.scrollUntilVisible(
        find.text('What is my risk exposure?'),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(find.text('What is my risk exposure?'));
      await tester.pumpAndSettle();
      expect(find.textContaining('IT is 83%', findRichText: true), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'And sector-wise?');
      await tester.pump();
      await tester.tap(find.byTooltip('Send'));
      await tester.pumpAndSettle();
      expect(ai.calls, ['ask:What is my risk exposure?', 'ask:And sector-wise?']);
      expect(find.textContaining('IT is 83%', findRichText: true), findsNWidgets(2));
    });
  });

  testWidgets('accessible: AI settings at 2× text', (tester) async {
    useLargeText(tester);
    await pumpApp(tester, const AiSettingsScreen());
    await expectAccessibleTapTargets(tester);
    await scrollThrough(tester);
  });
}
