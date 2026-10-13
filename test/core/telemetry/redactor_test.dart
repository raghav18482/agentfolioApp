import 'package:agentfolio/core/telemetry/redactor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const redactor = Redactor();

  group('keys that must never leave the app', () {
    for (final key in [
      'password',
      'app_password',
      'appPassword',
      'API-Key',
      'api_key',
      'totp_secret',
      'session_token',
      'Cookie',
      'authorization',
      'whatsapp_number',
      'phone',
      'email',
      'client_id',
      'clientCode',
      'pin',
      'message',
      'question',
      'prompt',
      'amount',
      'ltp',
      'pnl',
      'qty',
    ]) {
      test(key, () {
        expect(redactor.properties({key: 'x'})[key], Redactor.redacted);
      });
    }
  });

  test('ordinary analytics properties pass through', () {
    final out = redactor.properties({
      'track_id': 'login_submit',
      'selection': 'holdings',
      'path': '/api/portfolio/analytics',
      'status': 200,
      'duration_ms': 123,
      'signed_in': true,
    });
    expect(out, {
      'track_id': 'login_submit',
      'selection': 'holdings',
      'path': '/api/portfolio/analytics',
      'status': 200,
      'duration_ms': 123,
      'signed_in': true,
    });
  });

  test('phone numbers and emails inside free text are masked', () {
    final text = redactor.text('Login failed for +91 98765 43210 / someone@example.com');
    expect(text, isNot(contains('98765')));
    expect(text, isNot(contains('example.com')));
    expect(text, contains(Redactor.redacted));
  });

  test('nested maps are redacted and nulls dropped', () {
    final out = redactor.properties({
      'outer': {'api_key': 'sk-123', 'screen': 'home'},
      'nothing': null,
    });
    expect(out['outer'], {'api_key': Redactor.redacted, 'screen': 'home'});
    expect(out.containsKey('nothing'), isFalse);
  });

  test('long strings and lists are truncated', () {
    final out = redactor.properties({'note': 'a' * 500, 'items': List.generate(50, (i) => i)});
    expect((out['note']! as String).length, lessThanOrEqualTo(121));
    expect((out['items']! as List).length, 20);
  });
}
