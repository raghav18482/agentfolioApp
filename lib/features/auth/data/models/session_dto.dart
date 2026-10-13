import 'package:json_annotation/json_annotation.dart';

part 'session_dto.g.dart';

/// `GET /api/session/bootstrap`:
/// `{authenticated: false}` or
/// `{authenticated: true, client_id, premium: {registered, whatsapp_number}}`.
@JsonSerializable()
class SessionDto {
  const SessionDto({required this.authenticated, this.clientId, this.premium});

  factory SessionDto.fromJson(Map<String, dynamic> json) => _$SessionDtoFromJson(json);

  final bool authenticated;
  final String? clientId;
  final PremiumDto? premium;
}

@JsonSerializable()
class PremiumDto {
  const PremiumDto({required this.registered, this.whatsappNumber});

  factory PremiumDto.fromJson(Map<String, dynamic> json) => _$PremiumDtoFromJson(json);

  final bool registered;
  final String? whatsappNumber;
}
