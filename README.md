# Agentfolio (Flutter)

Mobile and tablet app for Agentfolio — portfolio analytics, research and an AI trading
assistant on top of your broker account. Talks to the FastAPI backend at
`https://agentfolio.in`.

- Architecture, how to add a feature / broker / telemetry sink: [docs/architecture.md](docs/architecture.md)
- Multi-broker design: [docs/adr/0002-multi-broker.md](docs/adr/0002-multi-broker.md)

```
flutter pub get
dart run build_runner build
flutter run --flavor dev --dart-define-from-file=config/dev.json
```
