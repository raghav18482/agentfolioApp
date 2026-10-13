/// Compliance and informed-consent text, copied verbatim from the web app.
///
/// These are deliberately not in the translation files: they must read exactly
/// as written, and a change needs a deliberate decision, not a copy edit.
/// Widget tests assert each one appears unaltered.
abstract final class Disclaimers {
  // From frontend/templates/landing.html, "Responsible AI".
  static const responsibleAiEyebrow = 'Responsible AI';
  static const responsibleAiTitle = 'Built for clarity. Designed with humility.';
  static const responsibleAiBody =
      'We build AI systems designed to assist with decision-making under conditions of '
      'uncertainty. Our focus is on portfolio optimization, risk assessment, and informed '
      'capital allocation — not short-term market speculation.';
  static const responsibleAiPillarRiskTitle = 'Risk management over return maximization';
  static const responsibleAiPillarRiskBody =
      'Capital preservation comes first. We surface drawdowns, concentration, and tail risk '
      'before chasing upside.';
  static const responsibleAiPillarLongTermTitle = 'Long-term robustness over short-term moves';
  static const responsibleAiPillarLongTermBody =
      'We design for decade-long compounding, not the next tick. Patience is a strategy, and '
      'we encode it.';
  static const responsibleAiFineprint =
      'We do not develop or offer AI systems intended to predict individual stock prices or '
      'guarantee market outcomes. Any insights or outputs generated are meant to support '
      'analysis and decision-making — not to serve as definitive predictions or financial advice.';

  // From AgentfolioUI/src/features/auth/EnrollPage.tsx. The user's informed
  // consent to storing their credentials.
  static const linkAccountTradeOffLead = 'Read this before continuing:';
  static const linkAccountTradeOff =
      'saving your credentials is a real trade-off. Until now they lived only in server memory '
      'and vanished on logout. From here they are encrypted in the database, and your app '
      'password is what unlocks them — so it protects a live trading account. Choose a strong, '
      'unique one. Running this again later will overwrite your stored credentials and '
      'password, which is also how you reset a forgotten one.';

  // From AgentfolioUI/src/features/auth/LoginPage.tsx.
  static const securityNoticeLead = 'Security notice:';
  static String securityNotice(String broker) =>
      'Your $broker credentials are encrypted at rest and decrypted only in server memory, '
      'for the duration of your session. Your app password is stored as a one-way hash and '
      'cannot be read back by anyone, including us.';

  // From AgentfolioUI/src/features/analytics/PredictionCard.tsx: shown when
  // the server sends no caveat of its own for an uncalibrated confidence.
  static const predictionCalibration = 'Confidence shown is not a calibrated probability.';

  // From AgentfolioUI/src/features/research/ScoreCard.tsx.
  static const scoreLimits =
      'This only measures the numbers above. It knows nothing about management, competition, '
      'litigation or pledged shares — it is a reading aid, not a recommendation.';

  // Shown once before a user's first trade approval (store readiness §12.3).
  // DRAFT: written for this app, not copied from the web, and awaiting legal
  // review before release.
  static const tradingRiskTitle = 'Before you approve a trade';
  static const _tradingRiskReal =
      'Orders you approve are real. They go straight to your broker, and Agentfolio cannot '
      'cancel or reverse them.';
  static const _tradingRiskAi =
      'Trade ideas come from an AI agent. It can be wrong, and it does not know your full '
      'financial situation.';
  static const List<String> tradingRiskPoints = [
    _tradingRiskReal,
    _tradingRiskAi,
    'Trading can lose money. Intraday orders can lose it quickly.',
    'You decide. Approving means you have checked the order and accept its risk.',
  ];
  static const tradingRiskAccept = 'I understand the risks';
}
