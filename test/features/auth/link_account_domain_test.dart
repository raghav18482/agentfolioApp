import 'package:agentfolio/core/broker/brokers/angel_one.dart';
import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/features/auth/domain/entities/auth_config.dart';
import 'package:agentfolio/features/auth/domain/entities/link_account_request.dart';
import 'package:agentfolio/features/auth/domain/usecases/link_account.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const phone = PhoneNumber(dialCode: '91', national: '98765 43210');

  group('credential normalisation', () {
    test('identifiers and keys are trimmed, client ids upper-cased, PINs untouched', () {
      final request = LinkAccountRequest(
        broker: angelOne,
        brokerCredentials: const {
          'api_key': '  abc 123\n',
          'client_id': ' ab1234 ',
          'password': ' 12 34 ',
          'totp_secret': 'JBSW Y3DP ',
        },
        phone: phone,
        appPassword: 'x',
        appPasswordConfirm: 'x',
      );
      expect(request.normalizedCredentials, {
        'api_key': 'abc123',
        'client_id': 'AB1234',
        'password': ' 12 34 ',
        'totp_secret': 'JBSWY3DP',
      });
    });
  });

  group('validation', () {
    test('names the first missing broker credential', () {
      final failure = validateBrokerCredentials(angelOne, const {
        'api_key': 'k',
        'client_id': '   ',
        'password': 'p',
        'totp_secret': 't',
      });
      expect(failure?.field, 'client_id');
    });

    test('all credentials present passes', () {
      expect(
        validateBrokerCredentials(angelOne, const {
          'api_key': 'k',
          'client_id': 'c',
          'password': 'p',
          'totp_secret': 't',
        }),
        isNull,
      );
    });

    ValidationFailure? signIn({
      String national = '9876543210',
      String pw = 'longenough',
      String? confirm,
    }) => validateSignIn(
      phone: PhoneNumber(dialCode: '91', national: national),
      appPassword: pw,
      appPasswordConfirm: confirm ?? pw,
      minPasswordChars: 8,
    );

    test('missing number', () => expect(signIn(national: ' ')?.field, 'whatsapp_number'));
    test('short password', () => expect(signIn(pw: 'short')?.field, 'app_password'));
    test('mismatch', () => expect(signIn(confirm: 'different1')?.field, 'app_password_confirm'));
    test('valid', () => expect(signIn(), isNull));
  });

  test('server fields map to the step that owns them', () {
    expect(linkAccountFieldFor('whatsapp_number'), LinkAccountField.phone);
    expect(linkAccountFieldFor('app_password'), LinkAccountField.appPassword);
    expect(linkAccountFieldFor('app_password_confirm'), LinkAccountField.appPasswordConfirm);
    expect(linkAccountFieldFor('totp_secret'), LinkAccountField.brokerCredentials);
    expect(linkAccountFieldFor(null), isNull);
  });

  test('country flags come from the ISO code', () {
    expect(const Country(iso: 'IN', dialCode: '91', name: 'India').flag, '🇮🇳');
    expect(const Country(iso: 'us', dialCode: '1', name: 'United States').flag, '🇺🇸');
  });
}
