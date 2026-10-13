import 'package:agentfolio/features/accounts/domain/entities/broker_account.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'session.freezed.dart';

@freezed
abstract class PremiumStatus with _$PremiumStatus {
  const factory PremiumStatus({required bool registered, String? whatsappNumber}) = _PremiumStatus;
}

/// The Agentfolio identity: who signs in with a WhatsApp number and app
/// password. Separate from the broker accounts they link.
@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({required String id, required PremiumStatus premium}) = _AppUser;
}

/// Who is using the app right now, as the server sees it.
@freezed
sealed class Session with _$Session {
  const factory Session.signedOut() = SignedOut;

  const factory Session.signedIn({
    required AppUser user,
    required List<BrokerAccount> accounts,
    required String activeAccountId,
  }) = SignedIn;
}

extension SignedInX on SignedIn {
  BrokerAccount get activeAccount =>
      accounts.firstWhere((a) => a.id == activeAccountId, orElse: () => accounts.first);
}
