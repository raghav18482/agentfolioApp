import 'package:agentfolio/core/broker/broker_descriptor.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'broker_account.freezed.dart';

enum AccountStatus {
  active,

  /// The broker's session or token expired and the user must sign in to the
  /// broker again (daily for OAuth brokers).
  needsReauth,
  disabled,
}

/// One linked brokerage account. A user can hold several, across brokers.
///
/// Today's backend links exactly one Angel One account per user and does not
/// name it, so [id] is the broker client code. When the backend gains an
/// accounts API, [id] becomes its own identifier and nothing else changes.
@freezed
abstract class BrokerAccount with _$BrokerAccount {
  const factory BrokerAccount({
    required String id,
    required BrokerId brokerId,
    required String clientCode,
    @Default(AccountStatus.active) AccountStatus status,
    String? label,
  }) = _BrokerAccount;
}
