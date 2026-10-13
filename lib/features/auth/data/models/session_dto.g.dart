// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionDto _$SessionDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SessionDto', json, ($checkedConvert) {
      final val = SessionDto(
        authenticated: $checkedConvert('authenticated', (v) => v as bool),
        clientId: $checkedConvert('client_id', (v) => v as String?),
        premium: $checkedConvert(
          'premium',
          (v) => v == null ? null : PremiumDto.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    }, fieldKeyMap: const {'clientId': 'client_id'});

PremiumDto _$PremiumDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PremiumDto', json, ($checkedConvert) {
      final val = PremiumDto(
        registered: $checkedConvert('registered', (v) => v as bool),
        whatsappNumber: $checkedConvert('whatsapp_number', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {'whatsappNumber': 'whatsapp_number'});
