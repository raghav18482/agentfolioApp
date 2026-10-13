import 'package:agentfolio/app/router/routes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String? redirect(
    String location, {
    bool ready = true,
    bool signedIn = false,
    bool onboardingSeen = true,
  }) => resolveRedirect(
    location: Uri.parse(location),
    startupReady: ready,
    signedIn: signedIn,
    onboardingSeen: onboardingSeen,
  );

  group('before launch work is done', () {
    test('stays on the splash', () {
      expect(redirect(Routes.splash, ready: false), isNull);
    });

    test('holds a deep link on the splash so it survives launch', () {
      expect(redirect('/portfolio', ready: false), '/splash?from=%2Fportfolio');
    });
  });

  group('leaving the splash', () {
    test('signed in → Home', () {
      expect(redirect(Routes.splash, signedIn: true), Routes.home);
    });

    test('signed in with a deep link → the deep link', () {
      expect(redirect('/splash?from=%2Fmarkets', signedIn: true), '/markets');
    });

    test('first launch, signed out → Onboarding', () {
      expect(redirect(Routes.splash, onboardingSeen: false), Routes.onboarding);
    });

    test('returning, signed out → Login', () {
      expect(redirect(Routes.splash), Routes.login);
    });

    test('signed out with a deep link → Login, remembering it', () {
      expect(redirect('/splash?from=%2Ftrade'), '/login?from=%2Ftrade');
    });
  });

  group('guards', () {
    test('a signed-out user cannot open a tab', () {
      expect(redirect('/portfolio'), '/login?from=%2Fportfolio');
    });

    test('a signed-in user is moved on from Login', () {
      expect(redirect(Routes.login, signedIn: true), Routes.home);
      expect(redirect('/login?from=%2Fagent', signedIn: true), '/agent');
    });

    test('setup is reachable signed out and nested under Login', () {
      expect(redirect(Routes.linkAccount), isNull);
      expect(redirect(Routes.linkAccount, signedIn: true), Routes.home);
    });

    test('a signed-in user can open tabs', () {
      expect(redirect('/markets', signedIn: true), isNull);
    });

    test('a session ending mid-visit sends the user to Login', () {
      expect(redirect('/trade'), startsWith(Routes.login));
    });
  });

  group('return destinations are only ever in-app paths', () {
    for (final from in [
      'https://evil.example/phish',
      '//evil.example',
      'javascript:alert(1)',
      '/splash',
      '/login',
    ]) {
      test(from, () {
        final encoded = Uri.encodeQueryComponent(from);
        expect(redirect('/splash?from=$encoded', signedIn: true), Routes.home);
      });
    }
  });
}
