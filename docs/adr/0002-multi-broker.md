# ADR 0002 — Multiple brokers and accounts

## Status
Accepted (app side). Backend contract pending.

## Context
Today one Agentfolio user links exactly one Angel One account. The backend scopes
everything by the session cookie and never names the broker. We expect to add more
brokers (OAuth-based ones such as Zerodha and Upstox) and to let one user link several
accounts.

## Decision
The app models it now so new brokers are additive:

- `AppUser` (Agentfolio identity) is separate from `BrokerAccount` (`id`, `brokerId`,
  `clientCode`, `status`). A session holds a list of accounts and an active one.
- Each broker is a `BrokerDescriptor`; the link-account form, copy and capability checks
  read from it.
- `RequestCache` is scoped by the active account id, so switching accounts can never show
  another account's data. Switching advances `SessionEpoch` so late responses are dropped.
- Telemetry identifies the user by a hash of the app-user id, and tags events with the
  active `broker_id`.

Today `AuthRepositoryImpl` maps the bootstrap response to one user with one Angel One
account whose id is the client code. Only that mapping changes when the backend does.

## Backend contract the app expects (future)
- `GET /api/accounts` → `[{id, broker_id, client_code, status, label}]`
- `POST /api/accounts/link` → credentials or OAuth result for a broker
- `DELETE /api/accounts/{id}`
- An `X-Account-Id` request header selecting the account; added in one Dio interceptor
  in `core/network/` once the backend supports it.
- OAuth brokers redirect to `agentfolio://broker/callback`.
