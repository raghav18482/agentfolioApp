// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_config_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthConfigDto _$AuthConfigDtoFromJson(Map<String, dynamic> json) => $checkedCreate(
  'AuthConfigDto',
  json,
  ($checkedConvert) {
    final val = AuthConfigDto(
      countries: $checkedConvert(
        'countries',
        (v) => (v as List<dynamic>)
            .map((e) => CountryDto.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      defaultDialCode: $checkedConvert('default_dial_code', (v) => v as String),
      minPasswordChars: $checkedConvert('min_password_chars', (v) => (v as num).toInt()),
    );
    return val;
  },
  fieldKeyMap: const {
    'defaultDialCode': 'default_dial_code',
    'minPasswordChars': 'min_password_chars',
  },
);

CountryDto _$CountryDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CountryDto', json, ($checkedConvert) {
      final val = CountryDto(
        iso: $checkedConvert('iso', (v) => v as String),
        dial: $checkedConvert('dial', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
      );
      return val;
    });
