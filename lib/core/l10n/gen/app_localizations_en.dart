// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Agentfolio';

  @override
  String get appTagline => 'Your portfolio, with an AI analyst on call';

  @override
  String get commonRetry => 'Retry';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonContinue => 'Continue';

  @override
  String get commonSomethingWrong => 'Something went wrong';

  @override
  String get splashConnecting => 'Connecting securely…';

  @override
  String get splashSlow => 'This is taking longer than usual. Check your connection.';

  @override
  String get splashOfflineTitle => 'Can\'t reach Agentfolio';

  @override
  String get splashOfflineBody => 'Check your internet connection and try again.';

  @override
  String get tabHome => 'Home';

  @override
  String get tabPortfolio => 'Portfolio';

  @override
  String get tabMarkets => 'Markets';

  @override
  String get tabTrade => 'Trade';

  @override
  String get tabAgent => 'Agent';

  @override
  String get accountTitle => 'Account';

  @override
  String comingSoonTitle(String screen) {
    return '$screen is on its way';
  }

  @override
  String get comingSoonBody => 'This screen arrives in an upcoming phase of the app.';

  @override
  String get commonPaste => 'Paste';

  @override
  String get commonShow => 'Show password';

  @override
  String get commonHide => 'Hide password';

  @override
  String get commonBack => 'Back';

  @override
  String get commonDiscard => 'Discard';

  @override
  String get commonKeepEditing => 'Keep editing';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingNext => 'Next';

  @override
  String get onboardingSlide1Title => 'Your whole portfolio, at a glance';

  @override
  String get onboardingSlide1Body =>
      'Holdings, P&L, sectors and cash from your broker, live — with charts that make the numbers obvious.';

  @override
  String get onboardingSlide2Title => 'An AI analyst that knows your holdings';

  @override
  String get onboardingSlide2Body =>
      'Ask questions in plain language, get research on any stock you own, and review trade ideas before anything is placed. You approve every order.';

  @override
  String get onboardingLogin => 'Log in';

  @override
  String get onboardingSetUp => 'Set up your account';

  @override
  String get loginTitle => 'Log in';

  @override
  String loginSubtitle(String broker) {
    return 'Your $broker credentials are already stored, encrypted. Just your number and app password.';
  }

  @override
  String get loginSubmit => 'Log in';

  @override
  String get loginNewHere => 'First time here, or registered before app passwords existed?';

  @override
  String get loginSetUpLink => 'Set up your account';

  @override
  String loginNoBrokerAccount(String broker) {
    return 'No $broker account yet?';
  }

  @override
  String get loginOpenDemat => 'Open a free Demat account';

  @override
  String loginRetryIn(String time) {
    return 'Try again in $time';
  }

  @override
  String get loginRelink => 'Re-link your account';

  @override
  String get loginSessionLoadFailed =>
      'You\'re signed in, but we couldn\'t load your account. Please try again.';

  @override
  String get fieldWhatsapp => 'WhatsApp number';

  @override
  String get fieldWhatsappHint => '98765 43210';

  @override
  String get fieldWhatsappHelp =>
      'Pick your country code, then the number without it. This is also where premium briefings are sent.';

  @override
  String get fieldAppPassword => 'App password';

  @override
  String get fieldAppPasswordLoginHint => 'The password you chose during setup';

  @override
  String fieldAppPasswordNewHint(int count) {
    return 'At least $count characters';
  }

  @override
  String get fieldAppPasswordNewHelp => 'Choose something new — not your trading PIN.';

  @override
  String get fieldAppPasswordConfirm => 'Confirm app password';

  @override
  String get countryPickerTitle => 'Country code';

  @override
  String get countryPickerSearch => 'Search countries';

  @override
  String countryPickerNoMatch(String query) {
    return 'No country matches “$query”';
  }

  @override
  String countryPickerButton(String code) {
    return 'Country code $code, change';
  }

  @override
  String get linkTitle => 'Set up your account';

  @override
  String linkStepOf(int step, int total) {
    return 'Step $step of $total';
  }

  @override
  String linkBrokerStepTitle(String broker) {
    return '$broker credentials';
  }

  @override
  String linkBrokerStepSubtitle(String broker) {
    return 'Enter them once. We verify them with $broker, encrypt them, and from then on you log in with just your WhatsApp number and an app password.';
  }

  @override
  String get linkWhereToFind => 'Not sure where to find these?';

  @override
  String get linkSetupGuide => 'Open the setup guide';

  @override
  String get linkSignInStepTitle => 'How you\'ll log in from now on';

  @override
  String get linkSignInStepSubtitle =>
      'Your WhatsApp number and a new app password. Your broker credentials stay encrypted behind it.';

  @override
  String get linkContinue => 'Continue';

  @override
  String get linkSubmit => 'Verify and finish';

  @override
  String linkVerifying(String broker) {
    return 'Verifying with $broker…';
  }

  @override
  String linkConsent(String terms, String privacy) {
    return 'I agree to the $terms and $privacy.';
  }

  @override
  String get linkConsentTerms => 'Terms';

  @override
  String get linkConsentPrivacy => 'Privacy Policy';

  @override
  String get linkConsentRequired => 'Please accept the Terms and Privacy Policy to continue.';

  @override
  String get linkAlreadySetUp => 'Already set up?';

  @override
  String get linkLogInInstead => 'Log in';

  @override
  String get linkDiscardTitle => 'Discard what you\'ve entered?';

  @override
  String get linkDiscardBody =>
      'Your credentials haven\'t been saved. Leaving now clears them from this screen.';

  @override
  String get accountLinkedBroker => 'Linked account';

  @override
  String get accountGuides => 'Guides';

  @override
  String get accountSetupGuide => 'Setup guide';

  @override
  String get accountSetupGuideHint => 'Where to find your broker credentials';

  @override
  String get accountConnectMcp => 'Connect an AI assistant';

  @override
  String get accountConnectMcpHint => 'Use Agentfolio from Claude, ChatGPT or Cursor';

  @override
  String get accountLogout => 'Log out';

  @override
  String get accountLogoutTitle => 'Log out of Agentfolio?';

  @override
  String get accountLogoutBody =>
      'You\'ll need your WhatsApp number and app password to log back in. Nothing is stored on this phone after you log out.';

  @override
  String accountVersion(String version) {
    return 'Version $version';
  }

  @override
  String get privacyHideBalances => 'Hide balances';

  @override
  String get privacyShowBalances => 'Show balances';

  @override
  String get homeCurrentValue => 'Current value';

  @override
  String get homeInvested => 'Invested';

  @override
  String get homeCash => 'Cash';

  @override
  String get homeOverallPnl => 'Overall P&L';

  @override
  String get homeDayPnl => 'Today';

  @override
  String homeUpdated(String time) {
    return 'Updated $time';
  }

  @override
  String homeStaleTitle(String time) {
    return 'Couldn\'t refresh · showing data from $time';
  }

  @override
  String get homeAvailableCash => 'Available cash';

  @override
  String get homeNetValue => 'Net value';

  @override
  String get homeNoHoldingsTitle => 'No holdings yet';

  @override
  String get homeNoHoldingsBody =>
      'Stocks you hold with your broker appear here, with their charts and P&L.';

  @override
  String get homeHeatmapTitle => 'P&L heatmap';

  @override
  String get homeHeatmapSubtitle => 'Size is value · colour is gain or loss';

  @override
  String homeHeatmapSemantics(int count) {
    return 'Heatmap of $count holdings sized by value and coloured by profit or loss';
  }

  @override
  String homeHeatmapOthers(int count) {
    return '+$count more';
  }

  @override
  String get homeMoversTitle => 'Top movers';

  @override
  String get homeMoversSubtitle => 'Biggest gains and losses in rupees';

  @override
  String get homeMoversGainers => 'Gainers';

  @override
  String get homeMoversLosers => 'Losers';

  @override
  String get homeMoversFlat => 'Nothing has moved yet.';

  @override
  String get homeSectorTitle => 'Sector allocation';

  @override
  String get homeCashTitle => 'Cash vs invested';

  @override
  String get homeTotalValue => 'Total value';

  @override
  String get homeTotalCapital => 'Total capital';

  @override
  String homeCashSemantics(String invested, String cash) {
    return 'Ring chart: $invested invested, $cash in cash';
  }

  @override
  String get holdingQuantity => 'Quantity';

  @override
  String get holdingAverage => 'Average price';

  @override
  String get holdingLastPrice => 'Last price';

  @override
  String get benchmarkTitle => 'Portfolio vs NIFTY 50';

  @override
  String benchmarkSubtitle(int days) {
    return 'Cumulative returns · last $days days';
  }

  @override
  String get benchmarkNotEnoughData => 'Not enough history yet to compare with the market.';

  @override
  String get benchmarkPortfolio => 'My portfolio';

  @override
  String get benchmarkNifty => 'NIFTY 50';

  @override
  String benchmarkSemantics(String portfolio, String nifty) {
    return 'Line chart: portfolio $portfolio, NIFTY 50 $nifty over the period';
  }

  @override
  String get benchmarkBeta => 'Beta';

  @override
  String get benchmarkAlpha => 'Alpha (daily)';

  @override
  String get benchmarkRSquared => 'R-squared';

  @override
  String get benchmarkDays => 'Days';

  @override
  String get benchmarkBandAggressive => 'High volatility';

  @override
  String get benchmarkBandMarket => 'Moves with market';

  @override
  String get benchmarkBandDefensive => 'Defensive';

  @override
  String get infoIdeal => 'Ideal values';

  @override
  String get infoTip => 'Pro tip';

  @override
  String get benchmarkBetaInfoTitle => 'Portfolio Beta (β)';

  @override
  String get benchmarkBetaInfoBody =>
      'Measures how sensitive your portfolio is to market (NIFTY 50) movements. A beta of 1.0 means your portfolio moves exactly with the market.';

  @override
  String get benchmarkBetaInfoIdeal =>
      'β < 0.8 = Defensive (less volatile)\nβ ≈ 1.0 = Moves with market\nβ > 1.2 = Aggressive (more volatile)';

  @override
  String get benchmarkBetaInfoTip =>
      'For long-term wealth building, β between 0.8–1.2 is considered balanced. Lower beta during uncertain markets helps protect capital.';

  @override
  String get benchmarkAlphaInfoTitle => 'Alpha (α)';

  @override
  String get benchmarkAlphaInfoBody =>
      'The excess daily return your portfolio generates beyond what the market movement explains. Positive alpha = you\'re beating the market after adjusting for risk.';

  @override
  String get benchmarkAlphaInfoIdeal =>
      'α > 0 = Outperforming the market\nα = 0 = Matching the market\nα < 0 = Underperforming';

  @override
  String get benchmarkAlphaInfoTip =>
      'Even a small positive daily alpha compounds significantly over time. Consistent α > 0.01% daily is excellent.';

  @override
  String get benchmarkR2InfoTitle => 'R-Squared (R²)';

  @override
  String get benchmarkR2InfoBody =>
      'Shows what percentage of your portfolio\'s movement is explained by the market. R² of 1.0 means your portfolio perfectly tracks NIFTY 50.';

  @override
  String get benchmarkR2InfoIdeal =>
      'R² > 0.7 = Closely tracks the market\nR² 0.4–0.7 = Moderate correlation\nR² < 0.4 = Largely independent of market';

  @override
  String get benchmarkR2InfoTip =>
      'High R² with low beta = diversified market tracker. Low R² = your returns come from stock-specific factors, not the broad market.';

  @override
  String get portfolioHoldings => 'Holdings';

  @override
  String get portfolioPositions => 'Positions';

  @override
  String get portfolioOrders => 'Orders';

  @override
  String get holdingsCount => 'Stocks';

  @override
  String get holdingsReturns => 'Returns';

  @override
  String get holdingsSearch => 'Search holdings';

  @override
  String get holdingsClearSearch => 'Clear search';

  @override
  String holdingsNoMatch(String query) {
    return 'No holding matches “$query”';
  }

  @override
  String get holdingsSortBy => 'Sort by';

  @override
  String get holdingsSortValue => 'Value';

  @override
  String get holdingsSortPnl => 'P&L';

  @override
  String get holdingsSortPnlPercent => 'P&L %';

  @override
  String get holdingsSortInvested => 'Invested';

  @override
  String get holdingsSortName => 'Name';

  @override
  String get positionsDayPnl => 'Day P&L';

  @override
  String positionsOpen(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count open positions',
      one: '1 open position',
    );
    return '$_temp0';
  }

  @override
  String get positionsEmptyTitle => 'No open positions today';

  @override
  String get positionsEmptyBody => 'Intraday and delivery positions you open today show up here.';

  @override
  String positionDetail(String qty, String buy, String sell) {
    return 'Net $qty · Buy $buy · Sell $sell';
  }

  @override
  String positionLtp(String price) {
    return 'LTP $price';
  }

  @override
  String get ordersOrders => 'Orders';

  @override
  String get ordersTrades => 'Trades';

  @override
  String get ordersEmpty => 'No orders today';

  @override
  String get tradesEmpty => 'No executed trades today';

  @override
  String get holdingsValue => 'Value';

  @override
  String get stockTabOverview => 'Overview';

  @override
  String get stockTabFundamentals => 'Fundamentals';

  @override
  String get stockTabTechnicals => 'Technicals';

  @override
  String get stockTabAi => 'AI';

  @override
  String get stockHeld => 'HELD';

  @override
  String get stockOneDay => '1D';

  @override
  String get stockChartTitle => 'Price';

  @override
  String get stockChartLine => 'Show as line';

  @override
  String get stockChartCandles => 'Show as candles';

  @override
  String get stockRange1M => '1M';

  @override
  String get stockRange3M => '3M';

  @override
  String get stockRange6M => '6M';

  @override
  String get stockRange1Y => '1Y';

  @override
  String stockRangeSuffix(String range) {
    return 'in $range';
  }

  @override
  String stockAvgLabel(String price) {
    return 'Avg $price';
  }

  @override
  String stockOhlc(String open, String high, String low, String close) {
    return 'O $open  H $high  L $low  C $close';
  }

  @override
  String stockVolume(String volume) {
    return 'Volume $volume';
  }

  @override
  String stockChartSemantics(String symbol, String range, String change) {
    return '$symbol price chart over $range, $change';
  }

  @override
  String get chartNotEnough => 'Not enough price history to draw a chart yet.';

  @override
  String get stockPositionTitle => 'Your position';

  @override
  String get stockOverallReturn => 'Overall return';

  @override
  String get stockWeight => 'Share of your portfolio';

  @override
  String get stockKeyStatsTitle => 'Key stats';

  @override
  String get stock52wRange => '52-week range';

  @override
  String get stock52wLow => '52-week low';

  @override
  String get stock52wHigh => '52-week high';

  @override
  String stock52wPosition(String percent) {
    return '$percent of the way up';
  }

  @override
  String stock52wSemantics(String low, String high, String percent) {
    return '52-week range from $low to $high; the price is $percent of the way up';
  }

  @override
  String get stockDma50 => '50 DMA';

  @override
  String get stockDma200 => '200 DMA';

  @override
  String get stockAbove => 'Above';

  @override
  String get stockBelow => 'Below';

  @override
  String get stockRsi => 'RSI (14)';

  @override
  String get rsiOverbought => 'Overbought';

  @override
  String get rsiOversold => 'Oversold';

  @override
  String get rsiNeutral => 'Neutral';

  @override
  String get stockVolumeRatio => 'Volume vs 20-day avg';

  @override
  String get predictionTitle => 'Direction outlook';

  @override
  String get predictionSubtitle => 'Where the technical signals lean over three horizons';

  @override
  String get predictionEngineRules => 'Rule-based score (no model)';

  @override
  String predictionEngineModel(String version) {
    return 'Model $version';
  }

  @override
  String get horizonDay => '1 day';

  @override
  String get horizonWeek => '1 week';

  @override
  String get horizonMonth => '1 month';

  @override
  String get directionUp => 'Up';

  @override
  String get directionDown => 'Down';

  @override
  String get directionNeutral => 'Flat';

  @override
  String get outlookBullish => 'Bullish';

  @override
  String get outlookBearish => 'Bearish';

  @override
  String get outlookNeutral => 'Neutral';

  @override
  String get predictionPushingUp => 'Pushing up';

  @override
  String get predictionPushingDown => 'Pushing down';

  @override
  String get predictionNoSignals => 'No strong signals';

  @override
  String predictionHorizonSemantics(String horizon, String direction, String confidence) {
    return '$horizon: $direction, $confidence% confidence';
  }

  @override
  String get scoreTitle => 'Fundamental score';

  @override
  String get scoreSubtitle =>
      'Graded against fixed thresholds, with no AI involved: the same numbers always give the same score.';

  @override
  String get scoreHowCalculated => 'How is this calculated?';

  @override
  String get scoreOutOf => '/ 100';

  @override
  String scoreSemantics(int score) {
    return 'Fundamental score $score out of 100';
  }

  @override
  String scoreProvisional(String grade) {
    return 'Provisional · $grade';
  }

  @override
  String scoreGradeLabel(String grade, String label) {
    return '$grade · $label';
  }

  @override
  String scoreConfidenceMedium(int used, int total) {
    return 'Some metrics were unavailable, so treat this as approximate. Based on $used of $total metrics.';
  }

  @override
  String scoreConfidenceLow(int used, int total) {
    return 'Provisional: too few metrics had data to score this reliably. Based on $used of $total metrics.';
  }

  @override
  String scoreAdjusted(String parts) {
    return 'Adjusted for this sector: $parts left out, as not meaningful for this kind of company. Scored out of 100 on the rest.';
  }

  @override
  String scoreSkippedPillar(String pillar) {
    return '$pillar (not measurable from this data)';
  }

  @override
  String get scoreNoData => 'Not enough fundamental data to score this stock.';

  @override
  String get scorePillarNoData => 'No data';

  @override
  String scorePillarPoints(String score, String max) {
    return '$score / $max';
  }

  @override
  String get scoreStrengths => 'Strengths';

  @override
  String get scoreConcerns => 'Watch out for';

  @override
  String get valuationTitle => 'Valuation';

  @override
  String get healthTitle => 'Financial health';

  @override
  String get metricsHint => 'Tap a metric to see what it means and its ideal range.';

  @override
  String get metricPe => 'P/E ratio';

  @override
  String metricForward(String value) {
    return 'Forward $value';
  }

  @override
  String get metricPb => 'P/B ratio';

  @override
  String get metricEvEbitda => 'EV/EBITDA';

  @override
  String get metricPeg => 'PEG ratio';

  @override
  String get metricDividendYield => 'Dividend yield';

  @override
  String get metricEps => 'Trailing EPS';

  @override
  String get metricRoe => 'ROE';

  @override
  String get metricRoce => 'ROCE';

  @override
  String get metricDebtToEquity => 'Debt to equity';

  @override
  String get metricFreeCashFlow => 'Free cash flow';

  @override
  String get metricProfitMargin => 'Profit margin';

  @override
  String get metricOperatingMargin => 'Operating margin';

  @override
  String get metricRevenueGrowth => 'Revenue growth';

  @override
  String get metricEarningsGrowth => 'Earnings growth';

  @override
  String get metricPromoterHolding => 'Promoter holding';

  @override
  String get metricSheetIdeal => 'Ideal';

  @override
  String get metricSheetContext => 'Context';

  @override
  String get metricSheetWatchOut => 'Watch out';

  @override
  String metricSheetThisStock(String value, String note) {
    return 'This stock: $value — $note';
  }

  @override
  String get metricSheetReadMore => 'Read more in the guide';

  @override
  String get metricSheetNoExplanation => 'No explanation available for this metric.';

  @override
  String get trendTitle => 'Revenue & profit';

  @override
  String get trendSubtitle => 'Annual figures from Yahoo Finance';

  @override
  String get trendRevenue => 'Revenue';

  @override
  String get trendProfit => 'Net profit';

  @override
  String get trendEmpty => 'No annual figures available for this stock.';

  @override
  String trendSemantics(String from, String to) {
    return 'Bar chart of annual revenue and net profit from $from to $to';
  }

  @override
  String get verdictGood => 'Good';

  @override
  String get verdictBad => 'Bad';

  @override
  String get verdictNeutral => 'Neutral';

  @override
  String get verdictExcluded => 'Excluded';

  @override
  String get verdictUnknown => 'No data';

  @override
  String get signalsTitle => 'Signal summary';

  @override
  String signalsTally(int bullish, int bearish, int neutral) {
    return '$bullish bullish · $bearish bearish · $neutral neutral';
  }

  @override
  String get signalsEmpty => 'No signals available.';

  @override
  String get dmaChartTitle => 'Price & moving averages';

  @override
  String get legendPrice => 'Price';

  @override
  String get dmaChartSemantics =>
      'Price over the past year with its 50 and 200 day moving averages';

  @override
  String get rsiTitle => 'RSI (14)';

  @override
  String get rsiSubtitle => 'Above 70 is overbought, below 30 oversold';

  @override
  String rsiSemantics(String value) {
    return 'Relative strength index over the past year, now $value';
  }

  @override
  String get macdTitle => 'MACD';

  @override
  String get macdSubtitle => 'Momentum: MACD and signal lines, with their gap as bars';

  @override
  String get legendMacd => 'MACD';

  @override
  String get legendSignal => 'Signal';

  @override
  String get macdSemantics => 'MACD line, signal line and histogram over the past year';

  @override
  String get levelsTitle => 'Support & resistance';

  @override
  String get levelsSubtitle => 'Pivot points from the last session';

  @override
  String get levelPivot => 'Pivot';

  @override
  String get levelsNow => 'Now';

  @override
  String get levelsEmpty => 'Not enough data for pivot points.';

  @override
  String get indicatorsTitle => 'Key indicators';

  @override
  String get aiSummaryTitle => 'In plain English';

  @override
  String get aiSummarySubtitle => 'An AI reading of this stock\'s fundamentals';

  @override
  String aiWriting(String symbol) {
    return 'Reading $symbol\'s numbers and writing a summary…';
  }

  @override
  String get aiRegenerate => 'Regenerate';

  @override
  String aiRegenerateIn(int seconds) {
    return 'Regenerate in ${seconds}s';
  }

  @override
  String aiRegenerateFailed(String message) {
    return 'Couldn\'t write a new one: $message';
  }

  @override
  String get aiJustWritten => 'Written just now';

  @override
  String get aiRecentlyWritten => 'Written in the last few hours';

  @override
  String get unavailableTitle => 'Not available for this stock';

  @override
  String get holdingOpenDetails => 'Open full details';

  @override
  String get learnTitle => 'Learn';

  @override
  String get learnHeadline => 'What the numbers actually mean';

  @override
  String get learnSubtitle =>
      'Every metric explained without jargon: what it measures, what counts as a good number, and what it quietly hides. Written by people, not AI. The thresholds here are the exact ones used to score your stocks.';

  @override
  String get learnIntroTitle => 'Before you read a single ratio';

  @override
  String get learnJumpTo => 'Jump to a metric';

  @override
  String get learnScored => 'Counts toward the score';

  @override
  String get learnContextOnly => 'Context only';

  @override
  String get learnHowGraded => 'How this metric is graded';

  @override
  String get learnBandAny => 'Any value';

  @override
  String learnBandUpTo(String max) {
    return 'Up to $max';
  }

  @override
  String learnBandBetween(String from, String to) {
    return '$from to $to';
  }

  @override
  String learnBandAbove(String from) {
    return 'Above $from';
  }

  @override
  String get learnScoringTitle => 'How the score is calculated';

  @override
  String get learnGradeBands => 'Grade bands';

  @override
  String learnGradeMin(int min) {
    return '$min+';
  }

  @override
  String get learnLimits => 'What the score cannot see';

  @override
  String get accountLearn => 'Learn the metrics';

  @override
  String get accountLearnHint => 'What P/E, ROE and the score mean';

  @override
  String get fundamentalsUnavailableHint =>
      'Fundamentals come from Yahoo Finance, which has no figures for this stock right now. ETFs, index funds and recent listings never have them; for other stocks, try again later.';

  @override
  String get marketsNews => 'News';

  @override
  String get marketsSectors => 'Sectors';

  @override
  String get newsSearchHint => 'Search news: a company, sector or topic';

  @override
  String get newsSearchClear => 'Clear search';

  @override
  String get newsPeriodDay => 'Today';

  @override
  String get newsPeriodWeek => '7 days';

  @override
  String get newsPeriodMonth => '1 month';

  @override
  String get newsPeriodQuarter => '3 months';

  @override
  String newsArticleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count articles',
      one: '1 article',
    );
    return '$_temp0';
  }

  @override
  String get newsNoHoldingsTitle => 'No sectors to follow yet';

  @override
  String get newsNoHoldingsBody =>
      'News for your sectors appears here once you hold stocks. You can still search above.';

  @override
  String newsNoResults(String query) {
    return 'No news for “$query”';
  }

  @override
  String get newsNoResultsBody =>
      'Try a shorter search or a longer period. If nothing ever comes back, the news service may be unavailable.';

  @override
  String newsResultsFor(String query) {
    return 'Results for “$query”';
  }

  @override
  String get sentimentTitle => 'Sentiment pulse';

  @override
  String sentimentPrompt(int count) {
    return 'Read the mood of $count headlines across your sectors with FinBERT, a language model trained on financial news.';
  }

  @override
  String get sentimentRun => 'Read the mood';

  @override
  String sentimentReading(int count) {
    return 'Reading $count headlines…';
  }

  @override
  String sentimentAnalysed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'from $count headlines',
      one: 'from 1 headline',
    );
    return '$_temp0';
  }

  @override
  String get sentimentFineprint =>
      'An automated reading of headlines, not of the companies, and not advice.';

  @override
  String get sentimentUnavailable => 'Sentiment reading isn\'t available on the server right now.';

  @override
  String get moodBullish => 'Bullish';

  @override
  String get moodBearish => 'Bearish';

  @override
  String get moodNeutral => 'Neutral';

  @override
  String get tonePositive => 'Positive';

  @override
  String get toneNegative => 'Negative';

  @override
  String get toneNeutral => 'Neutral';

  @override
  String moodBarSemantics(String bullish, String neutral, String bearish) {
    return 'Bullish $bullish, neutral $neutral, bearish $bearish';
  }

  @override
  String get breadthVix => 'India VIX';

  @override
  String get breadthIndices => 'Indices';

  @override
  String get breadthUpDown => 'up / down today';

  @override
  String get breadth52w => '52-week';

  @override
  String get breadthHighsLows => 'highs / lows';

  @override
  String get moversTitle => 'Index movers';

  @override
  String get moversSubtitle => 'Today\'s biggest rises and falls among NSE indices';

  @override
  String moversAll(int count) {
    return 'All $count indices';
  }

  @override
  String get moversAllTitle => 'All NSE indices today';

  @override
  String get sectorsYours => 'Your sectors';

  @override
  String get sectorsEmptyTitle => 'No sectors yet';

  @override
  String get sectorsEmptyBody =>
      'Your holdings, grouped by sector against their NSE index, appear here.';

  @override
  String sectorHoldings(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count holdings',
      one: '1 holding',
    );
    return '$_temp0';
  }

  @override
  String sectorIndex(String name) {
    return 'Index: $name';
  }

  @override
  String sectorDriver(String driver) {
    return 'Key driver: $driver';
  }

  @override
  String get sectorYourHoldings => 'Your holdings';

  @override
  String get newsGathering => 'Gathering headlines for your sectors. This can take up to a minute.';

  @override
  String get commonTooSlow => 'That took too long';

  @override
  String get newsNoneBackTitle => 'No headlines came back';

  @override
  String get newsNoneBackBody =>
      'The news service may be unavailable right now. Try again in a few minutes, or pull to refresh.';

  @override
  String get commonClose => 'Close';

  @override
  String get commonSave => 'Save';

  @override
  String get accountAi => 'AI';

  @override
  String get accountAiKey => 'OpenRouter key & model';

  @override
  String accountAiKeySaved(String model) {
    return 'Key saved · $model';
  }

  @override
  String get accountAiKeyMissing => 'Not set up. Needed for Home insights and Ask';

  @override
  String get aiSettingsTitle => 'AI settings';

  @override
  String get aiSettingsIntro =>
      'Home insights and Ask use your own OpenRouter key, so you choose the model and pay only for what you use. The agent and stock summaries don\'t need a key.';

  @override
  String get aiKeyTitle => 'OpenRouter API key';

  @override
  String get aiKeyStatusSaved => 'Saved';

  @override
  String get aiKeyStatusMissing => 'Not set';

  @override
  String get aiKeyLabel => 'Your OpenRouter key';

  @override
  String get aiKeyReplaceLabel => 'Paste a new key to replace the saved one';

  @override
  String get aiKeyUnusualPrefix =>
      'OpenRouter keys usually start with sk-or-. Check you copied the right one.';

  @override
  String get aiKeyEmpty => 'Paste your key first.';

  @override
  String get aiKeyWhitespace => 'A key has no spaces or line breaks. Check what was pasted.';

  @override
  String get aiKeyTooShort => 'That looks too short to be a key.';

  @override
  String get aiKeySave => 'Save key';

  @override
  String get aiKeyReplace => 'Replace key';

  @override
  String get aiKeySaved => 'Key saved on this phone';

  @override
  String get aiKeySaveFailed => 'Couldn\'t save the key on this phone. Try again.';

  @override
  String get aiKeyRemove => 'Remove';

  @override
  String get aiKeyRemoveTitle => 'Remove your key?';

  @override
  String get aiKeyRemoveBody =>
      'Insights and Ask will stop working until you add a key again. Answers already written stay until you log out.';

  @override
  String get aiKeyGet => 'Get a key at openrouter.ai';

  @override
  String get aiKeyHowKept =>
      'Your key is kept in this phone\'s secure storage and removed when you log out. Agentfolio\'s server passes it to OpenRouter with each request and doesn\'t keep it. Usage is billed to your OpenRouter account.';

  @override
  String get aiModelTitle => 'Model';

  @override
  String get aiModelSubtitle => 'Used for insights and answers from now on';

  @override
  String get aiModelOther => 'Another model';

  @override
  String get aiModelCustomLabel => 'OpenRouter model id';

  @override
  String get aiModelInvalid => 'Use the id OpenRouter shows, like provider/model-name.';

  @override
  String get aiModelInUse => 'In use';

  @override
  String get aiModelUse => 'Use this model';

  @override
  String get aiCheckKey => 'Check key';

  @override
  String get aiSetUp => 'Set up AI';

  @override
  String get aiInsightsTitle => 'AI insights';

  @override
  String get aiInsightsSubtitle => 'Your portfolio, read in plain English';

  @override
  String get aiInsightsNeedKey =>
      'Add your OpenRouter key to get a short read of your portfolio\'s health, best and worst performers, and concentration risk.';

  @override
  String get aiInsightsInvite =>
      'A short read of your portfolio\'s health, best and worst performers, concentration risk, and a few things to consider.';

  @override
  String get aiInsightsGenerate => 'Write insights';

  @override
  String get aiInsightsWriting => 'Reading your portfolio…';

  @override
  String aiUsesYourCredit(String model) {
    return 'Uses your OpenRouter credit · $model';
  }

  @override
  String aiWrittenBy(String model, String when) {
    return '$model · $when';
  }

  @override
  String get askTitle => 'Ask about your portfolio';

  @override
  String get askSubtitle => 'Answers use your holdings and P&L';

  @override
  String get askNeedKey => 'Add your OpenRouter key to ask questions about your portfolio.';

  @override
  String get askOwn => 'Ask your own question';

  @override
  String get askIntro =>
      'Pick a question or type your own. Answers are based only on your current holdings, P&L and funds.';

  @override
  String get askPlaceholder => 'Ask anything about your portfolio…';

  @override
  String get askThinking => 'Looking at your portfolio…';

  @override
  String get askStarterDiversified => 'How diversified is my portfolio?';

  @override
  String get askStarterUnderperforming => 'Which stocks are underperforming?';

  @override
  String get askStarterRisk => 'What is my risk exposure?';

  @override
  String get askStarterRebalance => 'Suggest rebalancing strategies';

  @override
  String get askStarterHealth => 'Summarize my portfolio health';

  @override
  String get agentTitle => 'Agent';

  @override
  String get agentFinance => 'Finance';

  @override
  String get agentTrading => 'Trading';

  @override
  String agentAskAbout(String symbol) {
    return 'Tell me about $symbol: how it\'s doing in my portfolio, and what its fundamentals and technicals say.';
  }

  @override
  String stockAskAgent(String symbol) {
    return 'Ask the agent about $symbol';
  }

  @override
  String get agentEmptyTitle => 'What would you like to know?';

  @override
  String get agentEmptyBody =>
      'Your finance agent can look at your holdings, prices, fundamentals and news. Try a starter or ask your own question.';

  @override
  String get tradingEmptyTitle => 'Trading assistant';

  @override
  String get tradingEmptyBody =>
      'Ask for trade ideas based on your risk profile. It proposes; nothing is placed until you approve.';

  @override
  String get agentPlaceholder => 'Message your finance agent…';

  @override
  String get tradingPlaceholder => 'Message your trading agent…';

  @override
  String get agentFootnote => 'AI can be wrong. Not financial advice. Tap to read more.';

  @override
  String get tradingFootnote => 'Proposals must be approved before execution.';

  @override
  String get agentStarterHealth => 'Portfolio check-up';

  @override
  String get agentStarterHealthPrompt =>
      'Give me a quick health check of my portfolio: overall P&L, today\'s move, and anything that needs attention.';

  @override
  String get agentStarterRisk => 'Where\'s my risk?';

  @override
  String get agentStarterRiskPrompt =>
      'Where is my portfolio most concentrated, and what risks does that create?';

  @override
  String get agentStarterLaggards => 'My laggards';

  @override
  String get agentStarterLaggardsPrompt =>
      'Which of my holdings are doing worst, and what\'s going on with them?';

  @override
  String get agentStarterExplain => 'Explain a metric';

  @override
  String get agentStarterExplainPrompt =>
      'Explain P/E, ROE and debt-to-equity in simple terms, using one of my holdings as an example.';

  @override
  String get tradingStarterSuggest => 'Suggest trades';

  @override
  String get tradingStarterSuggestPrompt =>
      'What trades would you recommend based on my risk profile and current holdings?';

  @override
  String get tradingStarterAnalyze => 'Analyze RELIANCE';

  @override
  String get tradingStarterAnalyzePrompt =>
      'Analyze RELIANCE-EQ technically and tell me if it\'s a good entry point.';

  @override
  String get tradingStarterPending => 'Pending proposals';

  @override
  String get tradingStarterPendingPrompt => 'Show my current pending proposals.';

  @override
  String get tradingStarterMargin => 'Check margin';

  @override
  String get tradingStarterMarginPrompt => 'What is my available margin and current exposure?';

  @override
  String get tradingLockedTitle => 'The trading agent is part of Premium';

  @override
  String get tradingLockedBody =>
      'It suggests trades from your risk profile, and nothing is placed until you approve. Premium is set up from the Trade tab.';

  @override
  String get tradingLockedAction => 'Go to Trade';

  @override
  String get chatSend => 'Send';

  @override
  String get chatYouSaid => 'You said';

  @override
  String get chatAgentSaid => 'The agent said';

  @override
  String get chatCopy => 'Copy reply';

  @override
  String get chatCopied => 'Copied';

  @override
  String get chatThinking => 'Thinking…';

  @override
  String chatWorkingFor(int seconds) {
    return 'Working on it… ${seconds}s';
  }

  @override
  String chatWorkingLong(int seconds) {
    return 'Still working (${seconds}s). Replies that check live prices can take a minute or two.';
  }

  @override
  String get chatNotSent => 'Not sent.';

  @override
  String get chatSendAgain => 'Send again';

  @override
  String get chatStillWorking => 'The agent has this and hasn\'t answered yet.';

  @override
  String get chatCheckAgain => 'Check again';

  @override
  String get chatLostConnection =>
      'Connection lost before the answer. The agent may still have received this.';

  @override
  String get chatApprovalUnknown =>
      'Connection lost before the answer. Check the Trade tab to see whether this went through before trying again.';

  @override
  String get chatNotSaved => 'Conversations aren\'t saved on your plan. New chat starts afresh.';

  @override
  String get chatConversations => 'Conversations';

  @override
  String get chatNew => 'New chat';

  @override
  String get chatSavedIsPremium =>
      'Saved conversations come with Premium. Your current chat continues until you start a new one.';

  @override
  String get chatNoThreads => 'No saved conversations yet. Your first message starts one.';

  @override
  String get chatToday => 'Today';

  @override
  String get chatYesterday => 'Yesterday';

  @override
  String get chatThisWeek => 'Previous 7 days';

  @override
  String get chatOlder => 'Older';

  @override
  String get chatThreadMenu => 'Conversation options';

  @override
  String get chatRename => 'Rename';

  @override
  String get chatRenameTitle => 'Rename conversation';

  @override
  String get chatRenameLabel => 'Name';

  @override
  String chatRenameFailed(String message) {
    return 'Couldn\'t rename: $message';
  }

  @override
  String get chatDelete => 'Delete';

  @override
  String get chatDeleteTitle => 'Delete this conversation?';

  @override
  String chatDeleteBody(String title) {
    return '\"$title\" and its messages will be deleted everywhere you use Agentfolio. This can\'t be undone.';
  }

  @override
  String chatDeleteFailed(String message) {
    return 'Couldn\'t delete: $message';
  }

  @override
  String get chatApproveTitle => 'Place this order?';

  @override
  String chatApproveBody(String id, String broker) {
    return 'Approving proposal $id places a real order on your $broker account straight away. Check the proposal\'s details first.';
  }

  @override
  String get chatYourBroker => 'broker';

  @override
  String get chatApproveConfirm => 'Approve and place order';

  @override
  String get approveTitle => 'Place this order?';

  @override
  String get approveConfirm => 'Confirm and place order';

  @override
  String get approveHold => 'Hold to place order';

  @override
  String get approveNoLock =>
      'This phone has no screen lock, so hold the button to confirm instead.';

  @override
  String get approveAuthReason => 'Confirm it\'s you to place this order';

  @override
  String get approveAuthFailed =>
      'Couldn\'t confirm it\'s you. Try again, or unlock your phone first.';

  @override
  String get approveNoDetails =>
      'Only the proposal id is known here. Check its details in the Trade tab first.';

  @override
  String approveWarning(String broker) {
    return 'This places a real order on your $broker account. It can\'t be undone from the app.';
  }

  @override
  String get orderBuy => 'BUY';

  @override
  String get orderSell => 'SELL';

  @override
  String orderHeadline(int quantity, String symbol) {
    return '$quantity × $symbol';
  }

  @override
  String get orderPrice => 'Price';

  @override
  String get orderMarket => 'Market price';

  @override
  String get orderTrigger => 'Trigger';

  @override
  String get orderValue => 'Order value';

  @override
  String get orderValueApprox => 'Approx. value';

  @override
  String get orderProduct => 'Product';

  @override
  String get orderType => 'Order type';

  @override
  String get orderExchange => 'Exchange';

  @override
  String get orderAccount => 'Account';

  @override
  String get orderProposal => 'Proposal';

  @override
  String get proposalsTitle => 'Trade proposals';

  @override
  String get proposalsSubtitle => 'From the trading agent. Nothing is placed until you approve.';

  @override
  String proposalsPending(int count) {
    return '$count pending';
  }

  @override
  String get proposalsNone =>
      'No proposals right now. Any the trading agent suggests appear here for you to approve or reject.';

  @override
  String get proposalApprove => 'Approve';

  @override
  String get proposalReject => 'Reject';

  @override
  String get proposalRejected => 'Proposal rejected';

  @override
  String get proposalIdCopied => 'Proposal id copied';

  @override
  String proposalOrderId(String id) {
    return 'Order ID $id';
  }

  @override
  String proposalExpiresIn(String time) {
    return 'Expires in $time';
  }

  @override
  String get proposalExpiredNow => 'This proposal has expired. Ask the agent for a fresh one.';

  @override
  String get statusPending => 'Pending';

  @override
  String get statusApproved => 'Approved';

  @override
  String get statusExecuted => 'Placed';

  @override
  String get statusFailed => 'Not placed';

  @override
  String get statusRejected => 'Rejected';

  @override
  String get statusExpired => 'Expired';

  @override
  String get statusUnknown => 'Unknown';

  @override
  String get outcomePlaced => 'Order placed';

  @override
  String get outcomePlacedBody => 'Your broker accepted the order.';

  @override
  String get outcomeNotPlaced => 'Order not placed';

  @override
  String get outcomeNotReceived => 'The approval didn\'t reach the server';

  @override
  String get outcomeNotReceivedBody =>
      'Nothing was placed. The proposal is still pending if you want to try again.';

  @override
  String get outcomeInProgress => 'Sent to your broker';

  @override
  String get outcomeInProgressBody =>
      'The result isn\'t back yet. Check Orders before doing anything else.';

  @override
  String get outcomeUnconfirmed => 'We couldn\'t confirm what happened';

  @override
  String get outcomeUnconfirmedBody =>
      'The connection dropped and the proposal is no longer on the server. Check Orders to see whether it was placed before trying again.';

  @override
  String get outcomeOpenOrders => 'Open Orders';

  @override
  String get liveTitle => 'Live price';

  @override
  String get liveNoHoldings => 'No holdings yet. Type any NSE symbol above to watch it.';

  @override
  String get liveAnySymbol => 'Any NSE symbol, e.g. RELIANCE';

  @override
  String get liveLoad => 'Watch';

  @override
  String get liveUnavailableHint =>
      'Price history isn\'t available for this symbol. Check the spelling, or try its NSE trading symbol.';

  @override
  String get liveLastClose => 'Last close · live updates during market hours';

  @override
  String liveTickAt(String when) {
    return 'Live · $when';
  }

  @override
  String liveDelayed(String when) {
    return 'Delayed · last update $when';
  }

  @override
  String liveLineLabel(String price) {
    return 'Live $price';
  }

  @override
  String liveChartLabel(String symbol) {
    return 'Daily candles for $symbol over the last three months, with the live price';
  }

  @override
  String get liveOn => 'Live';

  @override
  String get liveConnecting => 'Connecting';

  @override
  String get liveReconnecting => 'Reconnecting';

  @override
  String get livePaused => 'Paused';

  @override
  String get liveUnavailable => 'Unavailable';

  @override
  String get liveMarketClosed => 'Market closed';

  @override
  String get profileTitle => 'Risk profile';

  @override
  String get profileSubtitle =>
      'Every proposal is checked against it before it reaches your broker';

  @override
  String get profileNone =>
      'No risk profile yet. Set one up so the agent\'s proposals are checked against your limits.';

  @override
  String get profileSetUp => 'Set up risk profile';

  @override
  String get profileEdit => 'Edit';

  @override
  String get profileEditTitle => 'Edit risk profile';

  @override
  String get profileIntro =>
      'These limits shape what the trading agent suggests, and any order over them is blocked before it reaches your broker.';

  @override
  String get profileAboutYou => 'About you';

  @override
  String get profileLimits => 'Limits';

  @override
  String get profileAge => 'Age';

  @override
  String get profileAgeProblem => 'Between 18 and 120.';

  @override
  String get profileHorizon => 'Horizon';

  @override
  String get profileHorizonYears => 'Horizon (years)';

  @override
  String get profileHorizonProblem => 'Between 1 and 50 years.';

  @override
  String profileYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count years',
      one: '1 year',
    );
    return '$_temp0';
  }

  @override
  String get profileGoal => 'Goal';

  @override
  String get profileTolerance => 'Risk tolerance';

  @override
  String get profileTax => 'Tax bracket';

  @override
  String get profileMaxOrder => 'Max order';

  @override
  String get profileMaxOrderLabel => 'Largest single order';

  @override
  String get profileMaxOrderHelp => 'Any one order above this is blocked.';

  @override
  String get profileMaxOrderProblem => 'At least ₹1,000.';

  @override
  String get profileMaxPosition => 'Max position';

  @override
  String get profileMaxPositionLabel => 'Max % in one stock';

  @override
  String get profilePercentProblem => 'Between 1 and 100.';

  @override
  String get profileMaxTrades => 'Max trades a day';

  @override
  String get profileTradesProblem => 'Between 1 and 100.';

  @override
  String get profileProducts => 'Products';

  @override
  String get profileProductsProblem => 'Allow at least one.';

  @override
  String get profileSave => 'Save risk profile';

  @override
  String get profileSaved => 'Risk profile saved';

  @override
  String get profileDiscardTitle => 'Discard your changes?';

  @override
  String get profileDiscardBody => 'Your risk profile stays as it was.';

  @override
  String get profileDiscard => 'Discard';

  @override
  String get goalWealth => 'Wealth creation';

  @override
  String get goalIncome => 'Income';

  @override
  String get goalPreservation => 'Preservation';

  @override
  String get goalSpeculation => 'Speculation';

  @override
  String get toleranceLow => 'Low';

  @override
  String get toleranceMedium => 'Medium';

  @override
  String get toleranceHigh => 'High';

  @override
  String get productDelivery => 'Delivery';

  @override
  String get productDeliveryHint => 'Buy and hold shares';

  @override
  String get productIntraday => 'Intraday';

  @override
  String get productIntradayHint => 'Bought and sold the same day';

  @override
  String get briefTitle => 'Daily brief';

  @override
  String briefSubtitle(String number) {
    return 'An AI briefing on every holding, sent to $number';
  }

  @override
  String get briefYourWhatsapp => 'your WhatsApp';

  @override
  String get briefAutoSend => 'Send every day';

  @override
  String get briefNotSet => 'Not scheduled yet';

  @override
  String briefNext(String when) {
    return 'Next: $when IST';
  }

  @override
  String get briefPaused => 'Paused. Turn on to send daily again.';

  @override
  String briefLast(String when) {
    return 'Last sent $when IST';
  }

  @override
  String get briefTimeIst => 'Send time';

  @override
  String get briefPickTime => 'Send time (India time)';

  @override
  String briefSaved(String when) {
    return 'Saved. Next brief $when IST';
  }

  @override
  String get briefPauseTitle => 'Pause the daily brief?';

  @override
  String get briefPauseBody =>
      'Automatic sends stop until you turn them on again. You can still send one now.';

  @override
  String get briefPause => 'Pause';

  @override
  String get briefSendNow => 'Send a brief now';

  @override
  String get briefSendNowTitle => 'Send a brief now?';

  @override
  String briefSendNowBody(String number) {
    return 'A briefing on your holdings goes to $number in about 30 seconds.';
  }

  @override
  String get briefStarted => 'Briefing started. Check WhatsApp in about 30 seconds.';

  @override
  String get briefActivity => 'Recent activity';

  @override
  String get briefRefresh => 'Refresh';

  @override
  String get briefSent => 'Sent';

  @override
  String get briefRunning => 'Sending';

  @override
  String get briefFailed => 'Failed';

  @override
  String get premiumTitle => 'Premium trading agent';

  @override
  String get premiumSubtitle => 'Turn it on with your WhatsApp number';

  @override
  String get premiumPerkIdeas =>
      'Trade ideas from an AI agent that knows your holdings and your risk profile.';

  @override
  String get premiumPerkApprove =>
      'Every order waits for you: approve with Face ID or your passcode, or reject.';

  @override
  String get premiumPerkLive =>
      'Live prices, and a risk profile that blocks orders over your limits.';

  @override
  String get premiumPerkBrief => 'A daily portfolio brief on WhatsApp.';

  @override
  String get premiumNumberHelp =>
      'Briefs and alerts go here. Your broker login is reused from this session.';

  @override
  String get premiumNumberMissing => 'Enter your WhatsApp number.';

  @override
  String get premiumActivate => 'Activate Premium';

  @override
  String get rebalancerTitle => 'What-if rebalancer';

  @override
  String get rebalancerHint => 'Simulate selling and reinvesting. Nothing is traded.';

  @override
  String get rebalancerIntro =>
      'Drag a slider to sell part of a holding, then put the cash into another. A simulation only: nothing is sent to your broker.';

  @override
  String get rebalancerReset => 'Reset';

  @override
  String get rebalancerEmpty => 'No holdings to simulate yet';

  @override
  String get rebalancerFreed => 'Cash freed';

  @override
  String get rebalancerLeft => 'Left to deploy';

  @override
  String rebalancerSold(int percent) {
    return '$percent% sold';
  }

  @override
  String rebalancerSoldSemantics(int percent, String symbol) {
    return '$percent percent of $symbol sold';
  }

  @override
  String get rebalancerReinvest => 'Reinvest in';

  @override
  String get rebalancerAmount => 'Amount';

  @override
  String get rebalancerApply => 'Apply';

  @override
  String get rebalancerPickStock => 'Choose a stock to reinvest in.';

  @override
  String get rebalancerAmountPositive => 'Enter an amount above zero.';

  @override
  String rebalancerTooMuch(String amount) {
    return 'That\'s more than the $amount left to deploy.';
  }

  @override
  String get rebalancerNote => 'Whatever you don\'t reinvest stays as cash.';

  @override
  String get liveAfterHours => 'Market closed · last traded price';

  @override
  String lastLineLabel(String price) {
    return 'Last $price';
  }

  @override
  String get accountPrivacy => 'Privacy & security';

  @override
  String get accountLegal => 'Legal';

  @override
  String get privacyHideBalancesHint => 'Mask every amount, for using the app in public';

  @override
  String get privacyAnalytics => 'Share usage analytics';

  @override
  String get privacyAnalyticsHint =>
      'Screens and taps, to improve the app. Never amounts or messages. Crash reports are always sent.';

  @override
  String get lockSetting => 'App lock';

  @override
  String get lockSettingHint => 'Face ID, fingerprint or passcode to open Agentfolio';

  @override
  String get lockEnableReason => 'Confirm to turn on the app lock';

  @override
  String get lockNeedsScreenLock =>
      'Set a screen lock on this phone first, then turn on the app lock.';

  @override
  String get lockReason => 'Unlock Agentfolio';

  @override
  String get lockTitle => 'Agentfolio is locked';

  @override
  String get lockBody => 'Unlock with Face ID, fingerprint or your passcode.';

  @override
  String get lockTryAgain => 'Not unlocked. Try again.';

  @override
  String get lockUnlock => 'Unlock';

  @override
  String get lockSignOut => 'Log out instead';

  @override
  String get legalPrivacy => 'Privacy policy';

  @override
  String get legalTerms => 'Terms of use';

  @override
  String get legalRisk => 'Risk disclosure';

  @override
  String get legalLicences => 'Open-source licences';

  @override
  String get deleteTitle => 'Delete account';

  @override
  String get deleteTileHint => 'Permanently remove your Agentfolio account';

  @override
  String get deleteIntro =>
      'This permanently deletes your Agentfolio account. It can\'t be undone; to use Agentfolio again you would set it up from the start.';

  @override
  String get deleteGoesTitle => 'What is deleted';

  @override
  String get deleteGoesAccount => 'Your Agentfolio account and app password';

  @override
  String deleteGoesCredentials(String broker) {
    return 'Your stored $broker credentials';
  }

  @override
  String get deleteGoesChats => 'Saved conversations with the AI agents';

  @override
  String get deleteGoesSettings => 'Your risk profile, daily brief schedule and its history';

  @override
  String get deleteGoesDevice => 'Everything this phone keeps for you: sign-in, AI key and drafts';

  @override
  String get deleteStaysTitle => 'What stays';

  @override
  String deleteStaysBroker(String broker, String client) {
    return 'Your $broker account $client and any orders already placed: deleting here never touches your broker';
  }

  @override
  String get deleteStaysAudit =>
      'Records of trade decisions, kept as an audit trail and no longer linked to you';

  @override
  String get deletePassword => 'App password';

  @override
  String get deletePasswordMissing => 'Enter your app password to confirm it\'s you.';

  @override
  String get deleteUnderstand => 'I understand this can\'t be undone';

  @override
  String get deleteUnderstandMissing => 'Tick this to continue.';

  @override
  String get deleteSubmit => 'Delete my account';

  @override
  String get deleteFinalTitle => 'Delete your account now?';

  @override
  String get deleteFinalBody => 'Your account and everything listed is removed straight away.';

  @override
  String get deleteFinalConfirm => 'Delete permanently';

  @override
  String get deleteThrottled => 'Too many attempts. Wait a few minutes before trying again.';

  @override
  String get deletedTitle => 'Your account has been deleted';

  @override
  String get deletedBody =>
      'Everything this phone kept for you was removed too. Thank you for trying Agentfolio.';
}
