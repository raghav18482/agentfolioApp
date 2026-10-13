import 'package:agentfolio/core/broker/broker_descriptor.dart';

/// Angel One (SmartAPI). Field keys match `POST /api/auth/enroll`.
final angelOne = BrokerDescriptor(
  id: const BrokerId('angel_one'),
  displayName: 'Angel One',
  authMethod: BrokerAuthMethod.credentials,
  credentialFields: const [
    CredentialField(
      key: 'api_key',
      label: 'API Key',
      kind: CredentialKind.apiKey,
      hint: 'Your Angel One API key',
      helpText: 'From your app on the SmartAPI developer portal.',
    ),
    CredentialField(
      key: 'client_id',
      label: 'Client ID',
      kind: CredentialKind.identifier,
      hint: 'e.g. AB1234',
      uppercase: true,
    ),
    CredentialField(
      key: 'password',
      label: 'PIN / Password',
      kind: CredentialKind.secret,
      hint: 'Your trading PIN',
    ),
    CredentialField(
      key: 'totp_secret',
      label: 'TOTP Secret',
      kind: CredentialKind.totpSecret,
      hint: 'Base32 TOTP secret from Angel One',
      helpText: 'Shown once when you enable TOTP for SmartAPI.',
    ),
  ],
  capabilities: const BrokerCapabilities(
    holdings: true,
    trading: true,
    liveStream: true,
    candles: true,
  ),
  accountOpeningUrl: Uri.parse('https://angel-one.onelink.me/Wjgr/bnic9p8w'),
  developerPortalUrl: Uri.parse('https://smartapi.angelbroking.com/'),
  credentialsGuidePath: '/setup',
);
