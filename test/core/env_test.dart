import 'package:agentfolio/core/config/env.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Flavor resolve(String? native, String? configured) =>
      Env.resolveFlavor(native: native, configured: configured);

  test('matching native flavor and config agree', () {
    expect(resolve('dev', 'dev'), Flavor.dev);
    expect(resolve('prod', 'prod'), Flavor.prod);
  });

  test('either one alone decides', () {
    expect(resolve('dev', null), Flavor.dev);
    expect(resolve(null, 'dev'), Flavor.dev);
  });

  test('with neither, the build is prod', () {
    expect(resolve(null, null), Flavor.prod);
  });

  test('a dev app with the prod config refuses to start', () {
    expect(() => resolve('dev', 'prod'), throwsStateError);
    expect(() => resolve('prod', 'dev'), throwsStateError);
  });

  test('an unknown flavor name is rejected, not treated as prod', () {
    expect(() => resolve('staging', null), throwsStateError);
    expect(() => resolve(null, 'Dev'), throwsStateError);
  });
}
