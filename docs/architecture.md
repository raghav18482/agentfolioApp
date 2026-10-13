# Agentfolio app — architecture

Flutter (iOS + Android, phone and tablet) client for the Agentfolio FastAPI backend.
Clean Architecture, feature-first, Provider for UI state, get_it for the object graph.

## Layers

```
lib/
  app/        bootstrap, DI, router, adaptive shell, splash
  core/       cross-feature infrastructure (no feature imports)
  features/<name>/
    data/          remote data sources (one method per endpoint), DTOs, repository impls
    domain/        entities, abstract repositories, use cases — pure Dart
    presentation/  view models / providers, screens, widgets
```

Rules:

- **domain** imports nothing from Flutter, Dio or JSON.
- **data** is the only layer that sees `ApiClient`. Repositories return `Result<T>`,
  never throw: wrap calls in `guardApi`.
- **presentation** depends on domain only. View models extend `BaseViewModel`
  and expose `ViewState<T>`; screens render it with `AsyncView`.
- Features talk to each other only through their **domain** layer.

## Networking

`core/network/api_client.dart` is the single HTTP client. Interceptors, in order:
cookies (Keychain/Keystore-backed) → telemetry → retry (GET only) → session expiry.
`RequestCache` gives TTL caching, in-flight de-duplication and account scoping;
TTLs mirror the web app's react-query `staleTime`s.

Writes are **never** retried. A write that loses its connection mid-flight returns
`UnknownOutcomeFailure`: reconcile from the server, never resubmit.

"No data for this" is `UnavailableFailure`, shown as a calm note without Retry
(`SectionState`, `ErrorView`). The server says it three ways, all mapped to it:
a 404, a 200 with `{error: "..."}` (decode with `asDataMap`), and, for the AI
summary, a 400.

## Loading on demand

Each screen section is a `Loadable<T>` (stale-while-revalidate, newest result
wins). Load only what is on screen: Stock Detail opens with the technicals (one
request serves the chart, every range, and the Technicals tab), the prediction
loads when its card scrolls into view, fundamentals and the AI summary when their
tab is first shown. Pull-to-refresh reloads what was asked for, never a paid AI
answer that succeeded.

## Charts

`core/presentation/charts/`: `TimeSeriesChart` draws lines, candles, histograms,
bands, reference lines and an aligned volume pane in one painter, with
drag-to-scrub (crosshair repaints alone, haptic tick per day). Its geometry
(`chart_scale.dart`: slots, nice ticks, padded domains) is pure and unit-tested.
`fl_chart` is used for the simpler pie and bar charts; `Treemap` and `RingGauge`
are custom painters.

## Telemetry

Everything goes through `Telemetry` (`core/telemetry/telemetry.dart`), which redacts
once and fans out to the sinks listed in `telemetry_setup.dart`.

Captured automatically: screens (route observer + tab bar), taps and changes (every
design-system widget takes a `trackId`), API calls (method, path template, status,
latency), view-model actions (`runAction`), uncaught errors, and every
`package:logging` record at INFO or above.

### Adding Amplitude (or any destination)

1. Write `core/telemetry/sinks/amplitude_sink.dart`: `class AmplitudeSink extends TelemetrySink`,
   with `isAnalytics => true`, mapping `track` / `screen` / `identify` / `reset` to the SDK.
2. Add one line to `buildTelemetrySinks` in `telemetry_setup.dart`.

Nothing else changes.

## Brokers

A broker is a `BrokerDescriptor` (`core/broker/`): display name, auth method,
credential form fields, capabilities, links. To add one, write
`core/broker/brokers/<name>.dart` and list it in `BrokerRegistry`. Screens read
capabilities, never broker names. See `docs/adr/0002-multi-broker.md`.

## Adding a feature

1. `features/<name>/data/datasources/<name>_remote_data_source.dart` — one method per endpoint.
2. DTOs with `json_serializable`; entities with `freezed`.
3. Abstract repository in `domain/`, implementation in `data/` using `guardApi` and `RequestCache`.
4. `features/<name>/<name>_module.dart` with `register<Name>Feature(GetIt sl)`, called from `app/di/injector.dart`.
5. Screen-scoped view model provided on its route; use tracked widgets for every control.

Markets (`features/markets`) keeps one `Loadable` per news period, so going
back to a period already read is instant, and runs FinBERT sentiment only when
asked: it is heavy on the server. The sentiment request echoes the portfolio
news back exactly as received, which is what the server expects.

Screens that compose other features' domains (Stock Detail reads `research` and
`portfolio`; Learn reads `research`) live in a presentation-only feature with
their own module.

## Running

```
flutter run --flavor dev --dart-define-from-file=config/dev.json    # in.agentfolio.app.dev, local backend, Crashlytics off
flutter run --flavor prod --dart-define-from-file=config/prod.json  # in.agentfolio.app, agentfolio.in
dart run build_runner build                                         # after changing DTOs/entities
flutter test && dart analyze
```

Pass both flags together. `--flavor` picks the native app (bundle ID, name, Firebase
app); the JSON file picks the Dart config. Without `--flavor` the build is prod.

## AI and the agent

- **Two kinds of AI.** Home insights and Ask use the user's own OpenRouter key
  (`features/ai`). The agent chat and stock summaries run on the server's key
  and need no setup.
- **The key** lives only in secure storage, per user (hashed id), and is read
  at the moment of a request. `AiKeyProvider` holds just its fingerprint;
  answers are cached under it so a new key never shows an old key's answer.
  An explicit sign-out wipes it via `SessionProvider.onSignOut`; a merely
  expired session does not.
- **Paid answers are on request.** Insights are written when the user taps,
  then kept until sign-out. Nothing AI-related retries automatically.
- **Agent sends are not idempotent.** A dropped connection becomes an
  unknown outcome. For a saved thread the view model asks the server what
  arrived (answer → show it; received → "Check again"; not received → safe to
  resend). Nothing is resent without the user, and an unsaved `APPROVE`
  with an unknown outcome is never offered for resending.
- **`APPROVE <id>` places an order on the server**, before the agent sees it.
  The composer recognises the server's exact pattern and asks for
  confirmation first (biometrics arrive with Trade).
- **Hide balances** also masks rupee amounts inside AI text (`AmountMask`).

## Trade

- **One way to approve an order**: `confirmTradeApproval` (risk disclosure
  once per user → a sheet with the order, the account and the expiry →
  `DeviceAuth`: Face ID, fingerprint or passcode; a device with no lock holds
  a button instead). The Approve button and `APPROVE <id>` typed in the
  trading chat both go through it. Swipe can only reject.
- **Approvals are sent once.** If the answer is lost (timeout, gateway 5xx,
  "already approved"), `TradeViewModel` re-reads the proposal and reports
  what the server says: placed, not placed, still with the broker (check
  Orders), never received (still pending), or unconfirmed (the proposal is
  gone: check Orders). The server refuses a second approval, so a re-read
  can never place a second order.
- **Countdowns use `ServerClock`**, learned from each response's `Date`
  header, so a phone with a wrong clock never offers an expired proposal.
- **Live prices**: `MarketStream` keeps one SSE connection for every watched
  symbol (ref-counted, most recent 12, debounced), replaces a silent one,
  backs off on errors, stops on 404/400, and pauses with the app.
  `SseParser` is the pure, tested frame parser.
- **Polling** (proposals, every 8 s) runs only while the Trade tab is
  visible (`VisibilityDetector`) and the app is in the foreground.

## Privacy and security

- **`AppShield`** (above every route, in `MaterialApp.builder`) covers the app
  with the brand while it is not in front, so the app switcher never shows a
  portfolio. Android 13+ also refuses the recents snapshot natively
  (`MainActivity.setRecentsScreenshotEnabled(false)`), which unlike
  `FLAG_SECURE` still lets the user take screenshots.
- **`AppLock`** (optional, off by default): locks a session restored at
  launch and after a minute in the background, never right after typing the
  password. Turning it on requires one successful device check. If the phone's
  screen lock is later removed, it turns itself off instead of locking the
  user out. Signing out turns it off.
- **Account deletion**: `SessionProvider.deleteAccount` re-checks the app
  password on the server, then wipes the device exactly as sign-out does
  (every `onSignOut` task). Login then says the account was deleted.
- **Accessibility**: every main screen is tested at 2× text and against
  Flutter's tap-target and label guidelines (`test/helpers/a11y.dart`).
- **Release**: `scripts/build_release.sh`, and see `docs/release.md`.
