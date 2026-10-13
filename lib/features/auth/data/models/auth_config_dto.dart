import 'package:agentfolio/features/auth/domain/entities/auth_config.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_config_dto.g.dart';

/// `GET /api/auth/config`:
/// `{countries: [{iso, dial, name, label}], default_dial_code, min_password_chars}`.
@JsonSerializable()
class AuthConfigDto {
  const AuthConfigDto({
    required this.countries,
    required this.defaultDialCode,
    required this.minPasswordChars,
  });

  factory AuthConfigDto.fromJson(Map<String, dynamic> json) => _$AuthConfigDtoFromJson(json);

  final List<CountryDto> countries;
  final String defaultDialCode;
  final int minPasswordChars;

  AuthConfig toEntity() => AuthConfig(
    countries: [for (final c in countries) Country(iso: c.iso, dialCode: c.dial, name: c.name)],
    defaultDialCode: defaultDialCode,
    minPasswordChars: minPasswordChars,
  );
}

@JsonSerializable()
class CountryDto {
  const CountryDto({required this.iso, required this.dial, required this.name});

  factory CountryDto.fromJson(Map<String, dynamic> json) => _$CountryDtoFromJson(json);

  final String iso;
  final String dial;
  final String name;
}
