import 'package:agentfolio/core/broker/brokers/angel_one.dart';
import 'package:agentfolio/core/cache/request_cache.dart';
import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/session/session_epoch.dart';
import 'package:agentfolio/core/session/session_expiry_signal.dart';
import 'package:agentfolio/core/telemetry/telemetry.dart';
import 'package:agentfolio/core/telemetry/telemetry_event.dart';
import 'package:agentfolio/features/auth/domain/usecases/link_account.dart';
import 'package:agentfolio/features/auth/domain/usecases/login.dart';
import 'package:agentfolio/features/auth/presentation/providers/session_provider.dart';
import 'package:agentfolio/features/auth/presentation/view_models/link_account_view_model.dart';
import 'package:agentfolio/features/auth/presentation/view_models/login_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/fake_auth_repository.dart';
import '../../helpers/recording_sink.dart';

class _MockSession extends Mock implements SessionProvider;

const _credentials = {
  'api_key': 'key',
  'client_id': 'ab1234',
  'password': '1234',
  'totp_secret': 'JBSWY3DP',
};

void main() {
  late FakeAuthRepository repo;
  late _MockSession session;
  late Telemetry telemetry;
  late RecordingSink sink;

  setUp(() async {
    repo = FakeAuthRepository();
    session = _MockSession();
    when(() => session.signedInNow()).thenAnswer((_) async => true);
    (telemetry, sink) = await recordingTelemetry();
  });

  group('LoginViewModel', () {
    late DateTime now;
    late LoginViewModel vm;

    setUp(() async {
      now = DateTime(2026, 10, 11, 12);
      vm = LoginViewModel(
        repository: repo,
        login: Login(repo),
        session: session,
        telemetry: telemetry,
        clock: () => now,
      );
      await vm.loadConfig();
    });

    tearDown(() => vm.dispose());

    test("defaults to the server's dial code", () {
      expect(vm.country?.dialCode, '91');
    });

    test('success re-reads the session and reports the action', () async {
      expect(await vm.submit(national: '98765 43210', appPassword: 'secret'), isTrue);
      expect(repo.logins.single.phone.dialCode, '91');
      verify(() => session.signedInNow()).called(1);
      expect(sink.named(EventName.actionSucceeded).single.properties['action'], 'login');
    });

    test('a wrong password is a form-level message', () async {
      repo.loginResult = failWith(
        const UnauthorizedFailure("That WhatsApp number and password don't match."),
      );
      expect(await vm.submit(national: '9876543210', appPassword: 'nope'), isFalse);
      expect(vm.problem, isA<LoginFormProblem>());
      verifyNever(() => session.signedInNow());
    });

    test('a bad number marks the phone field', () async {
      repo.loginResult = failWith(const ValidationFailure('Bad number', field: 'whatsapp_number'));
      await vm.submit(national: '123', appPassword: 'pw');
      final problem = vm.problem;
      expect(problem, isA<LoginFieldProblem>());
      expect((problem! as LoginFieldProblem).field, 'whatsapp_number');
    });

    test('blank fields are caught before any request, and clear once edited', () async {
      await vm.submit(national: '  ', appPassword: 'pw');
      expect(repo.logins, isEmpty);
      expect(vm.problem, isA<LoginFieldProblem>());

      vm.edited('whatsapp_number');
      expect(vm.problem, isNull);
    });

    test('throttling blocks submit until Retry-After has passed', () async {
      repo.loginResult = failWith(
        const RateLimitedFailure('Too many attempts', retryAfter: Duration(seconds: 42)),
      );
      await vm.submit(national: '9876543210', appPassword: 'pw');
      expect(vm.canSubmit, isFalse);
      expect(vm.retryIn, const Duration(seconds: 42));

      now = now.add(const Duration(seconds: 43));
      expect(vm.retryIn, isNull);
      expect(vm.canSubmit, isTrue);
    });

    test('the broker rejecting stored credentials offers re-linking', () async {
      repo.loginResult = failWith(const BrokerFailure('Angel One rejected…', statusCode: 502));
      await vm.submit(national: '9876543210', appPassword: 'pw');
      expect(vm.problem, isA<LoginBrokerRejected>());
    });

    test('a dropped connection asks the server instead of reporting failure', () async {
      repo.loginResult = failWith(const UnknownOutcomeFailure());
      expect(await vm.submit(national: '9876543210', appPassword: 'pw'), isTrue);
      verify(() => session.signedInNow()).called(1);
    });
  });

  group('LinkAccountViewModel', () {
    late LinkAccountViewModel vm;

    LinkAccountViewModel build({bool consentRequired = false}) => LinkAccountViewModel(
      broker: angelOne,
      repository: repo,
      linkAccount: LinkAccount(repo),
      session: session,
      consentRequired: consentRequired,
      telemetry: telemetry,
    );

    Future<bool> submit() => vm.submit(
      credentials: _credentials,
      national: '9876543210',
      appPassword: 'longenough',
      appPasswordConfirm: 'longenough',
    );

    setUp(() async {
      vm = build();
      await vm.loadConfig();
    });

    tearDown(() => vm.dispose());

    test('step one needs every credential before moving on', () {
      expect(vm.continueToSignIn({..._credentials, 'totp_secret': ''}), isFalse);
      expect(vm.step, LinkStep.brokerCredentials);
      expect(vm.fieldErrors.keys, ['totp_secret']);

      expect(vm.continueToSignIn(_credentials), isTrue);
      expect(vm.step, LinkStep.signIn);
    });

    test('back from step two returns to step one, then lets the screen close', () {
      vm.continueToSignIn(_credentials);
      expect(vm.back(), isTrue);
      expect(vm.step, LinkStep.brokerCredentials);
      expect(vm.back(), isFalse);
    });

    test('success links and signs in', () async {
      vm.continueToSignIn(_credentials);
      expect(await submit(), isTrue);
      expect(repo.links.single.normalizedCredentials['client_id'], 'AB1234');
    });

    test('the broker rejecting the credentials goes back to step one with the message', () async {
      vm.continueToSignIn(_credentials);
      repo.linkResult = failWith(
        const ValidationFailure('Angel One rejected these credentials: Invalid totp'),
      );
      expect(await submit(), isFalse);
      expect(vm.step, LinkStep.brokerCredentials);
      expect(vm.formError, contains('rejected'));
    });

    test('a number owned by another account stays on step two, on the phone field', () async {
      vm.continueToSignIn(_credentials);
      repo.linkResult = failWith(
        const ValidationFailure('That WhatsApp number is already in use', field: 'whatsapp_number'),
      );
      await submit();
      expect(vm.step, LinkStep.signIn);
      expect(vm.fieldErrors['whatsapp_number'], contains('already in use'));
    });

    test('an offline failure keeps the user on the step they are on', () async {
      vm.continueToSignIn(_credentials);
      repo.linkResult = failWith(const NetworkFailure());
      await submit();
      expect(vm.step, LinkStep.signIn);
      expect(vm.formError, isNotNull);
    });

    test('a dropped connection asks the server whether it went through', () async {
      vm.continueToSignIn(_credentials);
      repo.linkResult = failWith(const UnknownOutcomeFailure());
      expect(await submit(), isTrue);
      verify(() => session.signedInNow()).called(1);
    });

    test('when legal pages exist, consent is required before anything is sent', () async {
      vm = build(consentRequired: true);
      await vm.loadConfig();
      vm.continueToSignIn(_credentials);

      expect(await submit(), isFalse);
      expect(vm.consentMissing, isTrue);
      expect(repo.links, isEmpty);

      vm.setConsent(value: true);
      expect(await submit(), isTrue);
    });
  });

  group('SessionProvider.signOut', () {
    test('ends the server session, then signs the device out and reports it', () async {
      final provider = SessionProvider(
        repository: repo,
        cache: RequestCache(),
        epoch: SessionEpoch(),
        telemetry: telemetry,
        expirySignal: SessionExpirySignal(),
      );
      await provider.signOut();
      expect(repo.logouts, 1);
      expect(provider.status, SessionStatus.signedOut);
      expect(sink.named(EventName.loggedOut), hasLength(1));
    });
  });
}
