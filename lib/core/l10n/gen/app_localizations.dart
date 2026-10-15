import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Agentfolio'**
  String get appName;

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'Your portfolio, with an AI analyst on call'**
  String get appTagline;

  /// No description provided for @commonRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get commonRetry;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get commonContinue;

  /// No description provided for @commonSomethingWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get commonSomethingWrong;

  /// No description provided for @splashConnecting.
  ///
  /// In en, this message translates to:
  /// **'Connecting securely…'**
  String get splashConnecting;

  /// No description provided for @splashSlow.
  ///
  /// In en, this message translates to:
  /// **'This is taking longer than usual. Check your connection.'**
  String get splashSlow;

  /// No description provided for @splashOfflineTitle.
  ///
  /// In en, this message translates to:
  /// **'Can\'t reach Agentfolio'**
  String get splashOfflineTitle;

  /// No description provided for @splashOfflineBody.
  ///
  /// In en, this message translates to:
  /// **'Check your internet connection and try again.'**
  String get splashOfflineBody;

  /// No description provided for @tabHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get tabHome;

  /// No description provided for @tabPortfolio.
  ///
  /// In en, this message translates to:
  /// **'Portfolio'**
  String get tabPortfolio;

  /// No description provided for @tabMarkets.
  ///
  /// In en, this message translates to:
  /// **'Markets'**
  String get tabMarkets;

  /// No description provided for @tabTrade.
  ///
  /// In en, this message translates to:
  /// **'Trade'**
  String get tabTrade;

  /// No description provided for @tabAgent.
  ///
  /// In en, this message translates to:
  /// **'Agent'**
  String get tabAgent;

  /// No description provided for @accountTitle.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get accountTitle;

  /// No description provided for @comingSoonTitle.
  ///
  /// In en, this message translates to:
  /// **'{screen} is on its way'**
  String comingSoonTitle(String screen);

  /// No description provided for @comingSoonBody.
  ///
  /// In en, this message translates to:
  /// **'This screen arrives in an upcoming phase of the app.'**
  String get comingSoonBody;

  /// No description provided for @commonPaste.
  ///
  /// In en, this message translates to:
  /// **'Paste'**
  String get commonPaste;

  /// No description provided for @commonShow.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get commonShow;

  /// No description provided for @commonHide.
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get commonHide;

  /// No description provided for @commonBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get commonBack;

  /// No description provided for @commonDiscard.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get commonDiscard;

  /// No description provided for @commonKeepEditing.
  ///
  /// In en, this message translates to:
  /// **'Keep editing'**
  String get commonKeepEditing;

  /// No description provided for @onboardingSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardingSkip;

  /// No description provided for @onboardingNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNext;

  /// No description provided for @onboardingSlide1Title.
  ///
  /// In en, this message translates to:
  /// **'Your whole portfolio, at a glance'**
  String get onboardingSlide1Title;

  /// No description provided for @onboardingSlide1Body.
  ///
  /// In en, this message translates to:
  /// **'Holdings, P&L, sectors and cash from your broker, live — with charts that make the numbers obvious.'**
  String get onboardingSlide1Body;

  /// No description provided for @onboardingSlide2Title.
  ///
  /// In en, this message translates to:
  /// **'An AI analyst that knows your holdings'**
  String get onboardingSlide2Title;

  /// No description provided for @onboardingSlide2Body.
  ///
  /// In en, this message translates to:
  /// **'Ask questions in plain language, get research on any stock you own, and review trade ideas before anything is placed. You approve every order.'**
  String get onboardingSlide2Body;

  /// No description provided for @onboardingLogin.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get onboardingLogin;

  /// No description provided for @onboardingSetUp.
  ///
  /// In en, this message translates to:
  /// **'Set up your account'**
  String get onboardingSetUp;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your {broker} credentials are already stored, encrypted. Just your number and app password.'**
  String loginSubtitle(String broker);

  /// No description provided for @loginSubmit.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get loginSubmit;

  /// No description provided for @loginNewHere.
  ///
  /// In en, this message translates to:
  /// **'First time here, or registered before app passwords existed?'**
  String get loginNewHere;

  /// No description provided for @loginSetUpLink.
  ///
  /// In en, this message translates to:
  /// **'Set up your account'**
  String get loginSetUpLink;

  /// No description provided for @loginNoBrokerAccount.
  ///
  /// In en, this message translates to:
  /// **'No {broker} account yet?'**
  String loginNoBrokerAccount(String broker);

  /// No description provided for @loginOpenDemat.
  ///
  /// In en, this message translates to:
  /// **'Open a free Demat account'**
  String get loginOpenDemat;

  /// No description provided for @loginRetryIn.
  ///
  /// In en, this message translates to:
  /// **'Try again in {time}'**
  String loginRetryIn(String time);

  /// No description provided for @loginRelink.
  ///
  /// In en, this message translates to:
  /// **'Re-link your account'**
  String get loginRelink;

  /// No description provided for @loginSessionLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'You\'re signed in, but we couldn\'t load your account. Please try again.'**
  String get loginSessionLoadFailed;

  /// No description provided for @fieldWhatsapp.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp number'**
  String get fieldWhatsapp;

  /// No description provided for @fieldWhatsappHint.
  ///
  /// In en, this message translates to:
  /// **'98765 43210'**
  String get fieldWhatsappHint;

  /// No description provided for @fieldWhatsappHelp.
  ///
  /// In en, this message translates to:
  /// **'Pick your country code, then the number without it. This is also where premium briefings are sent.'**
  String get fieldWhatsappHelp;

  /// No description provided for @fieldAppPassword.
  ///
  /// In en, this message translates to:
  /// **'App password'**
  String get fieldAppPassword;

  /// No description provided for @fieldAppPasswordLoginHint.
  ///
  /// In en, this message translates to:
  /// **'The password you chose during setup'**
  String get fieldAppPasswordLoginHint;

  /// No description provided for @fieldAppPasswordNewHint.
  ///
  /// In en, this message translates to:
  /// **'At least {count} characters'**
  String fieldAppPasswordNewHint(int count);

  /// No description provided for @fieldAppPasswordNewHelp.
  ///
  /// In en, this message translates to:
  /// **'Choose something new — not your trading PIN.'**
  String get fieldAppPasswordNewHelp;

  /// No description provided for @fieldAppPasswordConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm app password'**
  String get fieldAppPasswordConfirm;

  /// No description provided for @countryPickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Country code'**
  String get countryPickerTitle;

  /// No description provided for @countryPickerSearch.
  ///
  /// In en, this message translates to:
  /// **'Search countries'**
  String get countryPickerSearch;

  /// No description provided for @countryPickerNoMatch.
  ///
  /// In en, this message translates to:
  /// **'No country matches “{query}”'**
  String countryPickerNoMatch(String query);

  /// No description provided for @countryPickerButton.
  ///
  /// In en, this message translates to:
  /// **'Country code {code}, change'**
  String countryPickerButton(String code);

  /// No description provided for @linkTitle.
  ///
  /// In en, this message translates to:
  /// **'Set up your account'**
  String get linkTitle;

  /// No description provided for @linkStepOf.
  ///
  /// In en, this message translates to:
  /// **'Step {step} of {total}'**
  String linkStepOf(int step, int total);

  /// No description provided for @linkBrokerStepTitle.
  ///
  /// In en, this message translates to:
  /// **'{broker} credentials'**
  String linkBrokerStepTitle(String broker);

  /// No description provided for @linkBrokerStepSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter them once. We verify them with {broker}, encrypt them, and from then on you log in with just your WhatsApp number and an app password.'**
  String linkBrokerStepSubtitle(String broker);

  /// No description provided for @linkWhereToFind.
  ///
  /// In en, this message translates to:
  /// **'Not sure where to find these?'**
  String get linkWhereToFind;

  /// No description provided for @linkSetupGuide.
  ///
  /// In en, this message translates to:
  /// **'Open the setup guide'**
  String get linkSetupGuide;

  /// No description provided for @linkSignInStepTitle.
  ///
  /// In en, this message translates to:
  /// **'How you\'ll log in from now on'**
  String get linkSignInStepTitle;

  /// No description provided for @linkSignInStepSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your WhatsApp number and a new app password. Your broker credentials stay encrypted behind it.'**
  String get linkSignInStepSubtitle;

  /// No description provided for @linkContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get linkContinue;

  /// No description provided for @linkSubmit.
  ///
  /// In en, this message translates to:
  /// **'Verify and finish'**
  String get linkSubmit;

  /// No description provided for @linkVerifying.
  ///
  /// In en, this message translates to:
  /// **'Verifying with {broker}…'**
  String linkVerifying(String broker);

  /// No description provided for @linkConsent.
  ///
  /// In en, this message translates to:
  /// **'I agree to the {terms} and {privacy}.'**
  String linkConsent(String terms, String privacy);

  /// No description provided for @linkConsentTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms'**
  String get linkConsentTerms;

  /// No description provided for @linkConsentPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get linkConsentPrivacy;

  /// No description provided for @linkConsentRequired.
  ///
  /// In en, this message translates to:
  /// **'Please accept the Terms and Privacy Policy to continue.'**
  String get linkConsentRequired;

  /// No description provided for @linkAlreadySetUp.
  ///
  /// In en, this message translates to:
  /// **'Already set up?'**
  String get linkAlreadySetUp;

  /// No description provided for @linkLogInInstead.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get linkLogInInstead;

  /// No description provided for @linkDiscardTitle.
  ///
  /// In en, this message translates to:
  /// **'Discard what you\'ve entered?'**
  String get linkDiscardTitle;

  /// No description provided for @linkDiscardBody.
  ///
  /// In en, this message translates to:
  /// **'Your credentials haven\'t been saved. Leaving now clears them from this screen.'**
  String get linkDiscardBody;

  /// No description provided for @accountLinkedBroker.
  ///
  /// In en, this message translates to:
  /// **'Linked account'**
  String get accountLinkedBroker;

  /// No description provided for @accountGuides.
  ///
  /// In en, this message translates to:
  /// **'Guides'**
  String get accountGuides;

  /// No description provided for @accountSetupGuide.
  ///
  /// In en, this message translates to:
  /// **'Setup guide'**
  String get accountSetupGuide;

  /// No description provided for @accountSetupGuideHint.
  ///
  /// In en, this message translates to:
  /// **'Where to find your broker credentials'**
  String get accountSetupGuideHint;

  /// No description provided for @accountConnectMcp.
  ///
  /// In en, this message translates to:
  /// **'Connect an AI assistant'**
  String get accountConnectMcp;

  /// No description provided for @accountConnectMcpHint.
  ///
  /// In en, this message translates to:
  /// **'Use Agentfolio from Claude, ChatGPT or Cursor'**
  String get accountConnectMcpHint;

  /// No description provided for @accountLogout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get accountLogout;

  /// No description provided for @accountLogoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Log out of Agentfolio?'**
  String get accountLogoutTitle;

  /// No description provided for @accountLogoutBody.
  ///
  /// In en, this message translates to:
  /// **'You\'ll need your WhatsApp number and app password to log back in. Nothing is stored on this phone after you log out.'**
  String get accountLogoutBody;

  /// No description provided for @accountVersion.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String accountVersion(String version);

  /// No description provided for @privacyHideBalances.
  ///
  /// In en, this message translates to:
  /// **'Hide balances'**
  String get privacyHideBalances;

  /// No description provided for @privacyShowBalances.
  ///
  /// In en, this message translates to:
  /// **'Show balances'**
  String get privacyShowBalances;

  /// No description provided for @homeCurrentValue.
  ///
  /// In en, this message translates to:
  /// **'Current value'**
  String get homeCurrentValue;

  /// No description provided for @homeInvested.
  ///
  /// In en, this message translates to:
  /// **'Invested'**
  String get homeInvested;

  /// No description provided for @homeCash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get homeCash;

  /// No description provided for @homeOverallPnl.
  ///
  /// In en, this message translates to:
  /// **'Overall P&L'**
  String get homeOverallPnl;

  /// No description provided for @homeDayPnl.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get homeDayPnl;

  /// No description provided for @homeUpdated.
  ///
  /// In en, this message translates to:
  /// **'Updated {time}'**
  String homeUpdated(String time);

  /// No description provided for @homeStaleTitle.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t refresh · showing data from {time}'**
  String homeStaleTitle(String time);

  /// No description provided for @homeAvailableCash.
  ///
  /// In en, this message translates to:
  /// **'Available cash'**
  String get homeAvailableCash;

  /// No description provided for @homeNetValue.
  ///
  /// In en, this message translates to:
  /// **'Net value'**
  String get homeNetValue;

  /// No description provided for @homeNoHoldingsTitle.
  ///
  /// In en, this message translates to:
  /// **'No holdings yet'**
  String get homeNoHoldingsTitle;

  /// No description provided for @homeNoHoldingsBody.
  ///
  /// In en, this message translates to:
  /// **'Stocks you hold with your broker appear here, with their charts and P&L.'**
  String get homeNoHoldingsBody;

  /// No description provided for @homeHeatmapTitle.
  ///
  /// In en, this message translates to:
  /// **'P&L heatmap'**
  String get homeHeatmapTitle;

  /// No description provided for @homeHeatmapSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Size is value · colour is gain or loss'**
  String get homeHeatmapSubtitle;

  /// No description provided for @homeHeatmapSemantics.
  ///
  /// In en, this message translates to:
  /// **'Heatmap of {count} holdings sized by value and coloured by profit or loss'**
  String homeHeatmapSemantics(int count);

  /// No description provided for @homeHeatmapOthers.
  ///
  /// In en, this message translates to:
  /// **'+{count} more'**
  String homeHeatmapOthers(int count);

  /// No description provided for @homeMoversTitle.
  ///
  /// In en, this message translates to:
  /// **'Top movers'**
  String get homeMoversTitle;

  /// No description provided for @homeMoversSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Biggest gains and losses in rupees'**
  String get homeMoversSubtitle;

  /// No description provided for @homeMoversGainers.
  ///
  /// In en, this message translates to:
  /// **'Gainers'**
  String get homeMoversGainers;

  /// No description provided for @homeMoversLosers.
  ///
  /// In en, this message translates to:
  /// **'Losers'**
  String get homeMoversLosers;

  /// No description provided for @homeMoversFlat.
  ///
  /// In en, this message translates to:
  /// **'Nothing has moved yet.'**
  String get homeMoversFlat;

  /// No description provided for @homeSectorTitle.
  ///
  /// In en, this message translates to:
  /// **'Sector allocation'**
  String get homeSectorTitle;

  /// No description provided for @homeCashTitle.
  ///
  /// In en, this message translates to:
  /// **'Cash vs invested'**
  String get homeCashTitle;

  /// No description provided for @homeTotalValue.
  ///
  /// In en, this message translates to:
  /// **'Total value'**
  String get homeTotalValue;

  /// No description provided for @homeTotalCapital.
  ///
  /// In en, this message translates to:
  /// **'Total capital'**
  String get homeTotalCapital;

  /// No description provided for @homeCashSemantics.
  ///
  /// In en, this message translates to:
  /// **'Ring chart: {invested} invested, {cash} in cash'**
  String homeCashSemantics(String invested, String cash);

  /// No description provided for @holdingQuantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get holdingQuantity;

  /// No description provided for @holdingAverage.
  ///
  /// In en, this message translates to:
  /// **'Average price'**
  String get holdingAverage;

  /// No description provided for @holdingLastPrice.
  ///
  /// In en, this message translates to:
  /// **'Last price'**
  String get holdingLastPrice;

  /// No description provided for @benchmarkTitle.
  ///
  /// In en, this message translates to:
  /// **'Portfolio vs NIFTY 50'**
  String get benchmarkTitle;

  /// No description provided for @benchmarkSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Cumulative returns · last {days} days'**
  String benchmarkSubtitle(int days);

  /// No description provided for @benchmarkNotEnoughData.
  ///
  /// In en, this message translates to:
  /// **'Not enough history yet to compare with the market.'**
  String get benchmarkNotEnoughData;

  /// No description provided for @benchmarkPortfolio.
  ///
  /// In en, this message translates to:
  /// **'My portfolio'**
  String get benchmarkPortfolio;

  /// No description provided for @benchmarkNifty.
  ///
  /// In en, this message translates to:
  /// **'NIFTY 50'**
  String get benchmarkNifty;

  /// No description provided for @benchmarkSemantics.
  ///
  /// In en, this message translates to:
  /// **'Line chart: portfolio {portfolio}, NIFTY 50 {nifty} over the period'**
  String benchmarkSemantics(String portfolio, String nifty);

  /// No description provided for @benchmarkBeta.
  ///
  /// In en, this message translates to:
  /// **'Beta'**
  String get benchmarkBeta;

  /// No description provided for @benchmarkAlpha.
  ///
  /// In en, this message translates to:
  /// **'Alpha (daily)'**
  String get benchmarkAlpha;

  /// No description provided for @benchmarkRSquared.
  ///
  /// In en, this message translates to:
  /// **'R-squared'**
  String get benchmarkRSquared;

  /// No description provided for @benchmarkDays.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get benchmarkDays;

  /// No description provided for @benchmarkBandAggressive.
  ///
  /// In en, this message translates to:
  /// **'High volatility'**
  String get benchmarkBandAggressive;

  /// No description provided for @benchmarkBandMarket.
  ///
  /// In en, this message translates to:
  /// **'Moves with market'**
  String get benchmarkBandMarket;

  /// No description provided for @benchmarkBandDefensive.
  ///
  /// In en, this message translates to:
  /// **'Defensive'**
  String get benchmarkBandDefensive;

  /// No description provided for @infoIdeal.
  ///
  /// In en, this message translates to:
  /// **'Ideal values'**
  String get infoIdeal;

  /// No description provided for @infoTip.
  ///
  /// In en, this message translates to:
  /// **'Pro tip'**
  String get infoTip;

  /// No description provided for @benchmarkBetaInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Portfolio Beta (β)'**
  String get benchmarkBetaInfoTitle;

  /// No description provided for @benchmarkBetaInfoBody.
  ///
  /// In en, this message translates to:
  /// **'Measures how sensitive your portfolio is to market (NIFTY 50) movements. A beta of 1.0 means your portfolio moves exactly with the market.'**
  String get benchmarkBetaInfoBody;

  /// No description provided for @benchmarkBetaInfoIdeal.
  ///
  /// In en, this message translates to:
  /// **'β < 0.8 = Defensive (less volatile)\nβ ≈ 1.0 = Moves with market\nβ > 1.2 = Aggressive (more volatile)'**
  String get benchmarkBetaInfoIdeal;

  /// No description provided for @benchmarkBetaInfoTip.
  ///
  /// In en, this message translates to:
  /// **'For long-term wealth building, β between 0.8–1.2 is considered balanced. Lower beta during uncertain markets helps protect capital.'**
  String get benchmarkBetaInfoTip;

  /// No description provided for @benchmarkAlphaInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Alpha (α)'**
  String get benchmarkAlphaInfoTitle;

  /// No description provided for @benchmarkAlphaInfoBody.
  ///
  /// In en, this message translates to:
  /// **'The excess daily return your portfolio generates beyond what the market movement explains. Positive alpha = you\'re beating the market after adjusting for risk.'**
  String get benchmarkAlphaInfoBody;

  /// No description provided for @benchmarkAlphaInfoIdeal.
  ///
  /// In en, this message translates to:
  /// **'α > 0 = Outperforming the market\nα = 0 = Matching the market\nα < 0 = Underperforming'**
  String get benchmarkAlphaInfoIdeal;

  /// No description provided for @benchmarkAlphaInfoTip.
  ///
  /// In en, this message translates to:
  /// **'Even a small positive daily alpha compounds significantly over time. Consistent α > 0.01% daily is excellent.'**
  String get benchmarkAlphaInfoTip;

  /// No description provided for @benchmarkR2InfoTitle.
  ///
  /// In en, this message translates to:
  /// **'R-Squared (R²)'**
  String get benchmarkR2InfoTitle;

  /// No description provided for @benchmarkR2InfoBody.
  ///
  /// In en, this message translates to:
  /// **'Shows what percentage of your portfolio\'s movement is explained by the market. R² of 1.0 means your portfolio perfectly tracks NIFTY 50.'**
  String get benchmarkR2InfoBody;

  /// No description provided for @benchmarkR2InfoIdeal.
  ///
  /// In en, this message translates to:
  /// **'R² > 0.7 = Closely tracks the market\nR² 0.4–0.7 = Moderate correlation\nR² < 0.4 = Largely independent of market'**
  String get benchmarkR2InfoIdeal;

  /// No description provided for @benchmarkR2InfoTip.
  ///
  /// In en, this message translates to:
  /// **'High R² with low beta = diversified market tracker. Low R² = your returns come from stock-specific factors, not the broad market.'**
  String get benchmarkR2InfoTip;

  /// No description provided for @portfolioHoldings.
  ///
  /// In en, this message translates to:
  /// **'Holdings'**
  String get portfolioHoldings;

  /// No description provided for @portfolioPositions.
  ///
  /// In en, this message translates to:
  /// **'Positions'**
  String get portfolioPositions;

  /// No description provided for @portfolioOrders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get portfolioOrders;

  /// No description provided for @holdingsCount.
  ///
  /// In en, this message translates to:
  /// **'Stocks'**
  String get holdingsCount;

  /// No description provided for @holdingsReturns.
  ///
  /// In en, this message translates to:
  /// **'Returns'**
  String get holdingsReturns;

  /// No description provided for @holdingsSearch.
  ///
  /// In en, this message translates to:
  /// **'Search holdings'**
  String get holdingsSearch;

  /// No description provided for @holdingsClearSearch.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get holdingsClearSearch;

  /// No description provided for @holdingsNoMatch.
  ///
  /// In en, this message translates to:
  /// **'No holding matches “{query}”'**
  String holdingsNoMatch(String query);

  /// No description provided for @holdingsSortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort by'**
  String get holdingsSortBy;

  /// No description provided for @holdingsSortValue.
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get holdingsSortValue;

  /// No description provided for @holdingsSortPnl.
  ///
  /// In en, this message translates to:
  /// **'P&L'**
  String get holdingsSortPnl;

  /// No description provided for @holdingsSortPnlPercent.
  ///
  /// In en, this message translates to:
  /// **'P&L %'**
  String get holdingsSortPnlPercent;

  /// No description provided for @holdingsSortInvested.
  ///
  /// In en, this message translates to:
  /// **'Invested'**
  String get holdingsSortInvested;

  /// No description provided for @holdingsSortName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get holdingsSortName;

  /// No description provided for @positionsDayPnl.
  ///
  /// In en, this message translates to:
  /// **'Day P&L'**
  String get positionsDayPnl;

  /// No description provided for @positionsOpen.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 open position} other{{count} open positions}}'**
  String positionsOpen(int count);

  /// No description provided for @positionsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No open positions today'**
  String get positionsEmptyTitle;

  /// No description provided for @positionsEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Intraday and delivery positions you open today show up here.'**
  String get positionsEmptyBody;

  /// No description provided for @positionDetail.
  ///
  /// In en, this message translates to:
  /// **'Net {qty} · Buy {buy} · Sell {sell}'**
  String positionDetail(String qty, String buy, String sell);

  /// No description provided for @positionLtp.
  ///
  /// In en, this message translates to:
  /// **'LTP {price}'**
  String positionLtp(String price);

  /// No description provided for @ordersOrders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get ordersOrders;

  /// No description provided for @ordersTrades.
  ///
  /// In en, this message translates to:
  /// **'Trades'**
  String get ordersTrades;

  /// No description provided for @ordersEmpty.
  ///
  /// In en, this message translates to:
  /// **'No orders today'**
  String get ordersEmpty;

  /// No description provided for @tradesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No executed trades today'**
  String get tradesEmpty;

  /// No description provided for @holdingsValue.
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get holdingsValue;

  /// No description provided for @stockTabOverview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get stockTabOverview;

  /// No description provided for @stockTabFundamentals.
  ///
  /// In en, this message translates to:
  /// **'Fundamentals'**
  String get stockTabFundamentals;

  /// No description provided for @stockTabTechnicals.
  ///
  /// In en, this message translates to:
  /// **'Technicals'**
  String get stockTabTechnicals;

  /// No description provided for @stockTabAi.
  ///
  /// In en, this message translates to:
  /// **'AI'**
  String get stockTabAi;

  /// No description provided for @stockHeld.
  ///
  /// In en, this message translates to:
  /// **'HELD'**
  String get stockHeld;

  /// No description provided for @stockOneDay.
  ///
  /// In en, this message translates to:
  /// **'1D'**
  String get stockOneDay;

  /// No description provided for @stockChartTitle.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get stockChartTitle;

  /// No description provided for @stockChartLine.
  ///
  /// In en, this message translates to:
  /// **'Show as line'**
  String get stockChartLine;

  /// No description provided for @stockChartCandles.
  ///
  /// In en, this message translates to:
  /// **'Show as candles'**
  String get stockChartCandles;

  /// No description provided for @stockRange1M.
  ///
  /// In en, this message translates to:
  /// **'1M'**
  String get stockRange1M;

  /// No description provided for @stockRange3M.
  ///
  /// In en, this message translates to:
  /// **'3M'**
  String get stockRange3M;

  /// No description provided for @stockRange6M.
  ///
  /// In en, this message translates to:
  /// **'6M'**
  String get stockRange6M;

  /// No description provided for @stockRange1Y.
  ///
  /// In en, this message translates to:
  /// **'1Y'**
  String get stockRange1Y;

  /// No description provided for @stockRangeSuffix.
  ///
  /// In en, this message translates to:
  /// **'in {range}'**
  String stockRangeSuffix(String range);

  /// No description provided for @stockAvgLabel.
  ///
  /// In en, this message translates to:
  /// **'Avg {price}'**
  String stockAvgLabel(String price);

  /// No description provided for @stockOhlc.
  ///
  /// In en, this message translates to:
  /// **'O {open}  H {high}  L {low}  C {close}'**
  String stockOhlc(String open, String high, String low, String close);

  /// No description provided for @stockVolume.
  ///
  /// In en, this message translates to:
  /// **'Volume {volume}'**
  String stockVolume(String volume);

  /// No description provided for @stockChartSemantics.
  ///
  /// In en, this message translates to:
  /// **'{symbol} price chart over {range}, {change}'**
  String stockChartSemantics(String symbol, String range, String change);

  /// No description provided for @chartNotEnough.
  ///
  /// In en, this message translates to:
  /// **'Not enough price history to draw a chart yet.'**
  String get chartNotEnough;

  /// No description provided for @stockPositionTitle.
  ///
  /// In en, this message translates to:
  /// **'Your position'**
  String get stockPositionTitle;

  /// No description provided for @stockOverallReturn.
  ///
  /// In en, this message translates to:
  /// **'Overall return'**
  String get stockOverallReturn;

  /// No description provided for @stockWeight.
  ///
  /// In en, this message translates to:
  /// **'Share of your portfolio'**
  String get stockWeight;

  /// No description provided for @stockKeyStatsTitle.
  ///
  /// In en, this message translates to:
  /// **'Key stats'**
  String get stockKeyStatsTitle;

  /// No description provided for @stock52wRange.
  ///
  /// In en, this message translates to:
  /// **'52-week range'**
  String get stock52wRange;

  /// No description provided for @stock52wLow.
  ///
  /// In en, this message translates to:
  /// **'52-week low'**
  String get stock52wLow;

  /// No description provided for @stock52wHigh.
  ///
  /// In en, this message translates to:
  /// **'52-week high'**
  String get stock52wHigh;

  /// No description provided for @stock52wPosition.
  ///
  /// In en, this message translates to:
  /// **'{percent} of the way up'**
  String stock52wPosition(String percent);

  /// No description provided for @stock52wSemantics.
  ///
  /// In en, this message translates to:
  /// **'52-week range from {low} to {high}; the price is {percent} of the way up'**
  String stock52wSemantics(String low, String high, String percent);

  /// No description provided for @stockDma50.
  ///
  /// In en, this message translates to:
  /// **'50 DMA'**
  String get stockDma50;

  /// No description provided for @stockDma200.
  ///
  /// In en, this message translates to:
  /// **'200 DMA'**
  String get stockDma200;

  /// No description provided for @stockAbove.
  ///
  /// In en, this message translates to:
  /// **'Above'**
  String get stockAbove;

  /// No description provided for @stockBelow.
  ///
  /// In en, this message translates to:
  /// **'Below'**
  String get stockBelow;

  /// No description provided for @stockRsi.
  ///
  /// In en, this message translates to:
  /// **'RSI (14)'**
  String get stockRsi;

  /// No description provided for @rsiOverbought.
  ///
  /// In en, this message translates to:
  /// **'Overbought'**
  String get rsiOverbought;

  /// No description provided for @rsiOversold.
  ///
  /// In en, this message translates to:
  /// **'Oversold'**
  String get rsiOversold;

  /// No description provided for @rsiNeutral.
  ///
  /// In en, this message translates to:
  /// **'Neutral'**
  String get rsiNeutral;

  /// No description provided for @stockVolumeRatio.
  ///
  /// In en, this message translates to:
  /// **'Volume vs 20-day avg'**
  String get stockVolumeRatio;

  /// No description provided for @predictionTitle.
  ///
  /// In en, this message translates to:
  /// **'Direction outlook'**
  String get predictionTitle;

  /// No description provided for @predictionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Where the technical signals lean over three horizons'**
  String get predictionSubtitle;

  /// No description provided for @predictionEngineRules.
  ///
  /// In en, this message translates to:
  /// **'Rule-based score (no model)'**
  String get predictionEngineRules;

  /// No description provided for @predictionEngineModel.
  ///
  /// In en, this message translates to:
  /// **'Model {version}'**
  String predictionEngineModel(String version);

  /// No description provided for @horizonDay.
  ///
  /// In en, this message translates to:
  /// **'1 day'**
  String get horizonDay;

  /// No description provided for @horizonWeek.
  ///
  /// In en, this message translates to:
  /// **'1 week'**
  String get horizonWeek;

  /// No description provided for @horizonMonth.
  ///
  /// In en, this message translates to:
  /// **'1 month'**
  String get horizonMonth;

  /// No description provided for @directionUp.
  ///
  /// In en, this message translates to:
  /// **'Up'**
  String get directionUp;

  /// No description provided for @directionDown.
  ///
  /// In en, this message translates to:
  /// **'Down'**
  String get directionDown;

  /// No description provided for @directionNeutral.
  ///
  /// In en, this message translates to:
  /// **'Flat'**
  String get directionNeutral;

  /// No description provided for @outlookBullish.
  ///
  /// In en, this message translates to:
  /// **'Bullish'**
  String get outlookBullish;

  /// No description provided for @outlookBearish.
  ///
  /// In en, this message translates to:
  /// **'Bearish'**
  String get outlookBearish;

  /// No description provided for @outlookNeutral.
  ///
  /// In en, this message translates to:
  /// **'Neutral'**
  String get outlookNeutral;

  /// No description provided for @predictionPushingUp.
  ///
  /// In en, this message translates to:
  /// **'Pushing up'**
  String get predictionPushingUp;

  /// No description provided for @predictionPushingDown.
  ///
  /// In en, this message translates to:
  /// **'Pushing down'**
  String get predictionPushingDown;

  /// No description provided for @predictionNoSignals.
  ///
  /// In en, this message translates to:
  /// **'No strong signals'**
  String get predictionNoSignals;

  /// No description provided for @predictionHorizonSemantics.
  ///
  /// In en, this message translates to:
  /// **'{horizon}: {direction}, {confidence}% confidence'**
  String predictionHorizonSemantics(String horizon, String direction, String confidence);

  /// No description provided for @scoreTitle.
  ///
  /// In en, this message translates to:
  /// **'Fundamental score'**
  String get scoreTitle;

  /// No description provided for @scoreSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Graded against fixed thresholds, with no AI involved: the same numbers always give the same score.'**
  String get scoreSubtitle;

  /// No description provided for @scoreHowCalculated.
  ///
  /// In en, this message translates to:
  /// **'How is this calculated?'**
  String get scoreHowCalculated;

  /// No description provided for @scoreOutOf.
  ///
  /// In en, this message translates to:
  /// **'/ 100'**
  String get scoreOutOf;

  /// No description provided for @scoreSemantics.
  ///
  /// In en, this message translates to:
  /// **'Fundamental score {score} out of 100'**
  String scoreSemantics(int score);

  /// No description provided for @scoreProvisional.
  ///
  /// In en, this message translates to:
  /// **'Provisional · {grade}'**
  String scoreProvisional(String grade);

  /// No description provided for @scoreGradeLabel.
  ///
  /// In en, this message translates to:
  /// **'{grade} · {label}'**
  String scoreGradeLabel(String grade, String label);

  /// No description provided for @scoreConfidenceMedium.
  ///
  /// In en, this message translates to:
  /// **'Some metrics were unavailable, so treat this as approximate. Based on {used} of {total} metrics.'**
  String scoreConfidenceMedium(int used, int total);

  /// No description provided for @scoreConfidenceLow.
  ///
  /// In en, this message translates to:
  /// **'Provisional: too few metrics had data to score this reliably. Based on {used} of {total} metrics.'**
  String scoreConfidenceLow(int used, int total);

  /// No description provided for @scoreAdjusted.
  ///
  /// In en, this message translates to:
  /// **'Adjusted for this sector: {parts} left out, as not meaningful for this kind of company. Scored out of 100 on the rest.'**
  String scoreAdjusted(String parts);

  /// No description provided for @scoreSkippedPillar.
  ///
  /// In en, this message translates to:
  /// **'{pillar} (not measurable from this data)'**
  String scoreSkippedPillar(String pillar);

  /// No description provided for @scoreNoData.
  ///
  /// In en, this message translates to:
  /// **'Not enough fundamental data to score this stock.'**
  String get scoreNoData;

  /// No description provided for @scorePillarNoData.
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get scorePillarNoData;

  /// No description provided for @scorePillarPoints.
  ///
  /// In en, this message translates to:
  /// **'{score} / {max}'**
  String scorePillarPoints(String score, String max);

  /// No description provided for @scoreStrengths.
  ///
  /// In en, this message translates to:
  /// **'Strengths'**
  String get scoreStrengths;

  /// No description provided for @scoreConcerns.
  ///
  /// In en, this message translates to:
  /// **'Watch out for'**
  String get scoreConcerns;

  /// No description provided for @valuationTitle.
  ///
  /// In en, this message translates to:
  /// **'Valuation'**
  String get valuationTitle;

  /// No description provided for @healthTitle.
  ///
  /// In en, this message translates to:
  /// **'Financial health'**
  String get healthTitle;

  /// No description provided for @metricsHint.
  ///
  /// In en, this message translates to:
  /// **'Tap a metric to see what it means and its ideal range.'**
  String get metricsHint;

  /// No description provided for @metricPe.
  ///
  /// In en, this message translates to:
  /// **'P/E ratio'**
  String get metricPe;

  /// No description provided for @metricForward.
  ///
  /// In en, this message translates to:
  /// **'Forward {value}'**
  String metricForward(String value);

  /// No description provided for @metricPb.
  ///
  /// In en, this message translates to:
  /// **'P/B ratio'**
  String get metricPb;

  /// No description provided for @metricEvEbitda.
  ///
  /// In en, this message translates to:
  /// **'EV/EBITDA'**
  String get metricEvEbitda;

  /// No description provided for @metricPeg.
  ///
  /// In en, this message translates to:
  /// **'PEG ratio'**
  String get metricPeg;

  /// No description provided for @metricDividendYield.
  ///
  /// In en, this message translates to:
  /// **'Dividend yield'**
  String get metricDividendYield;

  /// No description provided for @metricEps.
  ///
  /// In en, this message translates to:
  /// **'Trailing EPS'**
  String get metricEps;

  /// No description provided for @metricRoe.
  ///
  /// In en, this message translates to:
  /// **'ROE'**
  String get metricRoe;

  /// No description provided for @metricRoce.
  ///
  /// In en, this message translates to:
  /// **'ROCE'**
  String get metricRoce;

  /// No description provided for @metricDebtToEquity.
  ///
  /// In en, this message translates to:
  /// **'Debt to equity'**
  String get metricDebtToEquity;

  /// No description provided for @metricFreeCashFlow.
  ///
  /// In en, this message translates to:
  /// **'Free cash flow'**
  String get metricFreeCashFlow;

  /// No description provided for @metricProfitMargin.
  ///
  /// In en, this message translates to:
  /// **'Profit margin'**
  String get metricProfitMargin;

  /// No description provided for @metricOperatingMargin.
  ///
  /// In en, this message translates to:
  /// **'Operating margin'**
  String get metricOperatingMargin;

  /// No description provided for @metricRevenueGrowth.
  ///
  /// In en, this message translates to:
  /// **'Revenue growth'**
  String get metricRevenueGrowth;

  /// No description provided for @metricEarningsGrowth.
  ///
  /// In en, this message translates to:
  /// **'Earnings growth'**
  String get metricEarningsGrowth;

  /// No description provided for @metricPromoterHolding.
  ///
  /// In en, this message translates to:
  /// **'Promoter holding'**
  String get metricPromoterHolding;

  /// No description provided for @metricSheetIdeal.
  ///
  /// In en, this message translates to:
  /// **'Ideal'**
  String get metricSheetIdeal;

  /// No description provided for @metricSheetContext.
  ///
  /// In en, this message translates to:
  /// **'Context'**
  String get metricSheetContext;

  /// No description provided for @metricSheetWatchOut.
  ///
  /// In en, this message translates to:
  /// **'Watch out'**
  String get metricSheetWatchOut;

  /// No description provided for @metricSheetThisStock.
  ///
  /// In en, this message translates to:
  /// **'This stock: {value} — {note}'**
  String metricSheetThisStock(String value, String note);

  /// No description provided for @metricSheetReadMore.
  ///
  /// In en, this message translates to:
  /// **'Read more in the guide'**
  String get metricSheetReadMore;

  /// No description provided for @metricSheetNoExplanation.
  ///
  /// In en, this message translates to:
  /// **'No explanation available for this metric.'**
  String get metricSheetNoExplanation;

  /// No description provided for @trendTitle.
  ///
  /// In en, this message translates to:
  /// **'Revenue & profit'**
  String get trendTitle;

  /// No description provided for @trendSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Annual figures from Yahoo Finance'**
  String get trendSubtitle;

  /// No description provided for @trendRevenue.
  ///
  /// In en, this message translates to:
  /// **'Revenue'**
  String get trendRevenue;

  /// No description provided for @trendProfit.
  ///
  /// In en, this message translates to:
  /// **'Net profit'**
  String get trendProfit;

  /// No description provided for @trendEmpty.
  ///
  /// In en, this message translates to:
  /// **'No annual figures available for this stock.'**
  String get trendEmpty;

  /// No description provided for @trendSemantics.
  ///
  /// In en, this message translates to:
  /// **'Bar chart of annual revenue and net profit from {from} to {to}'**
  String trendSemantics(String from, String to);

  /// No description provided for @verdictGood.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get verdictGood;

  /// No description provided for @verdictBad.
  ///
  /// In en, this message translates to:
  /// **'Bad'**
  String get verdictBad;

  /// No description provided for @verdictNeutral.
  ///
  /// In en, this message translates to:
  /// **'Neutral'**
  String get verdictNeutral;

  /// No description provided for @verdictExcluded.
  ///
  /// In en, this message translates to:
  /// **'Excluded'**
  String get verdictExcluded;

  /// No description provided for @verdictUnknown.
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get verdictUnknown;

  /// No description provided for @signalsTitle.
  ///
  /// In en, this message translates to:
  /// **'Signal summary'**
  String get signalsTitle;

  /// No description provided for @signalsTally.
  ///
  /// In en, this message translates to:
  /// **'{bullish} bullish · {bearish} bearish · {neutral} neutral'**
  String signalsTally(int bullish, int bearish, int neutral);

  /// No description provided for @signalsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No signals available.'**
  String get signalsEmpty;

  /// No description provided for @dmaChartTitle.
  ///
  /// In en, this message translates to:
  /// **'Price & moving averages'**
  String get dmaChartTitle;

  /// No description provided for @legendPrice.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get legendPrice;

  /// No description provided for @dmaChartSemantics.
  ///
  /// In en, this message translates to:
  /// **'Price over the past year with its 50 and 200 day moving averages'**
  String get dmaChartSemantics;

  /// No description provided for @rsiTitle.
  ///
  /// In en, this message translates to:
  /// **'RSI (14)'**
  String get rsiTitle;

  /// No description provided for @rsiSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Above 70 is overbought, below 30 oversold'**
  String get rsiSubtitle;

  /// No description provided for @rsiSemantics.
  ///
  /// In en, this message translates to:
  /// **'Relative strength index over the past year, now {value}'**
  String rsiSemantics(String value);

  /// No description provided for @macdTitle.
  ///
  /// In en, this message translates to:
  /// **'MACD'**
  String get macdTitle;

  /// No description provided for @macdSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Momentum: MACD and signal lines, with their gap as bars'**
  String get macdSubtitle;

  /// No description provided for @legendMacd.
  ///
  /// In en, this message translates to:
  /// **'MACD'**
  String get legendMacd;

  /// No description provided for @legendSignal.
  ///
  /// In en, this message translates to:
  /// **'Signal'**
  String get legendSignal;

  /// No description provided for @macdSemantics.
  ///
  /// In en, this message translates to:
  /// **'MACD line, signal line and histogram over the past year'**
  String get macdSemantics;

  /// No description provided for @levelsTitle.
  ///
  /// In en, this message translates to:
  /// **'Support & resistance'**
  String get levelsTitle;

  /// No description provided for @levelsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pivot points from the last session'**
  String get levelsSubtitle;

  /// No description provided for @levelPivot.
  ///
  /// In en, this message translates to:
  /// **'Pivot'**
  String get levelPivot;

  /// No description provided for @levelsNow.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get levelsNow;

  /// No description provided for @levelsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Not enough data for pivot points.'**
  String get levelsEmpty;

  /// No description provided for @indicatorsTitle.
  ///
  /// In en, this message translates to:
  /// **'Key indicators'**
  String get indicatorsTitle;

  /// No description provided for @aiSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'In plain English'**
  String get aiSummaryTitle;

  /// No description provided for @aiSummarySubtitle.
  ///
  /// In en, this message translates to:
  /// **'An AI reading of this stock\'s fundamentals'**
  String get aiSummarySubtitle;

  /// No description provided for @aiWriting.
  ///
  /// In en, this message translates to:
  /// **'Reading {symbol}\'s numbers and writing a summary…'**
  String aiWriting(String symbol);

  /// No description provided for @aiRegenerate.
  ///
  /// In en, this message translates to:
  /// **'Regenerate'**
  String get aiRegenerate;

  /// No description provided for @aiRegenerateIn.
  ///
  /// In en, this message translates to:
  /// **'Regenerate in {seconds}s'**
  String aiRegenerateIn(int seconds);

  /// No description provided for @aiRegenerateFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t write a new one: {message}'**
  String aiRegenerateFailed(String message);

  /// No description provided for @aiJustWritten.
  ///
  /// In en, this message translates to:
  /// **'Written just now'**
  String get aiJustWritten;

  /// No description provided for @aiRecentlyWritten.
  ///
  /// In en, this message translates to:
  /// **'Written in the last few hours'**
  String get aiRecentlyWritten;

  /// No description provided for @unavailableTitle.
  ///
  /// In en, this message translates to:
  /// **'Not available for this stock'**
  String get unavailableTitle;

  /// No description provided for @holdingOpenDetails.
  ///
  /// In en, this message translates to:
  /// **'Open full details'**
  String get holdingOpenDetails;

  /// No description provided for @learnTitle.
  ///
  /// In en, this message translates to:
  /// **'Learn'**
  String get learnTitle;

  /// No description provided for @learnHeadline.
  ///
  /// In en, this message translates to:
  /// **'What the numbers actually mean'**
  String get learnHeadline;

  /// No description provided for @learnSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Every metric explained without jargon: what it measures, what counts as a good number, and what it quietly hides. Written by people, not AI. The thresholds here are the exact ones used to score your stocks.'**
  String get learnSubtitle;

  /// No description provided for @learnIntroTitle.
  ///
  /// In en, this message translates to:
  /// **'Before you read a single ratio'**
  String get learnIntroTitle;

  /// No description provided for @learnJumpTo.
  ///
  /// In en, this message translates to:
  /// **'Jump to a metric'**
  String get learnJumpTo;

  /// No description provided for @learnScored.
  ///
  /// In en, this message translates to:
  /// **'Counts toward the score'**
  String get learnScored;

  /// No description provided for @learnContextOnly.
  ///
  /// In en, this message translates to:
  /// **'Context only'**
  String get learnContextOnly;

  /// No description provided for @learnHowGraded.
  ///
  /// In en, this message translates to:
  /// **'How this metric is graded'**
  String get learnHowGraded;

  /// No description provided for @learnBandAny.
  ///
  /// In en, this message translates to:
  /// **'Any value'**
  String get learnBandAny;

  /// No description provided for @learnBandUpTo.
  ///
  /// In en, this message translates to:
  /// **'Up to {max}'**
  String learnBandUpTo(String max);

  /// No description provided for @learnBandBetween.
  ///
  /// In en, this message translates to:
  /// **'{from} to {to}'**
  String learnBandBetween(String from, String to);

  /// No description provided for @learnBandAbove.
  ///
  /// In en, this message translates to:
  /// **'Above {from}'**
  String learnBandAbove(String from);

  /// No description provided for @learnScoringTitle.
  ///
  /// In en, this message translates to:
  /// **'How the score is calculated'**
  String get learnScoringTitle;

  /// No description provided for @learnGradeBands.
  ///
  /// In en, this message translates to:
  /// **'Grade bands'**
  String get learnGradeBands;

  /// No description provided for @learnGradeMin.
  ///
  /// In en, this message translates to:
  /// **'{min}+'**
  String learnGradeMin(int min);

  /// No description provided for @learnLimits.
  ///
  /// In en, this message translates to:
  /// **'What the score cannot see'**
  String get learnLimits;

  /// No description provided for @accountLearn.
  ///
  /// In en, this message translates to:
  /// **'Learn the metrics'**
  String get accountLearn;

  /// No description provided for @accountLearnHint.
  ///
  /// In en, this message translates to:
  /// **'What P/E, ROE and the score mean'**
  String get accountLearnHint;

  /// No description provided for @fundamentalsUnavailableHint.
  ///
  /// In en, this message translates to:
  /// **'Fundamentals come from Yahoo Finance, which has no figures for this stock right now. ETFs, index funds and recent listings never have them; for other stocks, try again later.'**
  String get fundamentalsUnavailableHint;

  /// No description provided for @marketsNews.
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get marketsNews;

  /// No description provided for @marketsSectors.
  ///
  /// In en, this message translates to:
  /// **'Sectors'**
  String get marketsSectors;

  /// No description provided for @newsSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search news: a company, sector or topic'**
  String get newsSearchHint;

  /// No description provided for @newsSearchClear.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get newsSearchClear;

  /// No description provided for @newsPeriodDay.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get newsPeriodDay;

  /// No description provided for @newsPeriodWeek.
  ///
  /// In en, this message translates to:
  /// **'7 days'**
  String get newsPeriodWeek;

  /// No description provided for @newsPeriodMonth.
  ///
  /// In en, this message translates to:
  /// **'1 month'**
  String get newsPeriodMonth;

  /// No description provided for @newsPeriodQuarter.
  ///
  /// In en, this message translates to:
  /// **'3 months'**
  String get newsPeriodQuarter;

  /// No description provided for @newsArticleCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 article} other{{count} articles}}'**
  String newsArticleCount(int count);

  /// No description provided for @newsNoHoldingsTitle.
  ///
  /// In en, this message translates to:
  /// **'No sectors to follow yet'**
  String get newsNoHoldingsTitle;

  /// No description provided for @newsNoHoldingsBody.
  ///
  /// In en, this message translates to:
  /// **'News for your sectors appears here once you hold stocks. You can still search above.'**
  String get newsNoHoldingsBody;

  /// No description provided for @newsNoResults.
  ///
  /// In en, this message translates to:
  /// **'No news for “{query}”'**
  String newsNoResults(String query);

  /// No description provided for @newsNoResultsBody.
  ///
  /// In en, this message translates to:
  /// **'Try a shorter search or a longer period. If nothing ever comes back, the news service may be unavailable.'**
  String get newsNoResultsBody;

  /// No description provided for @newsResultsFor.
  ///
  /// In en, this message translates to:
  /// **'Results for “{query}”'**
  String newsResultsFor(String query);

  /// No description provided for @sentimentTitle.
  ///
  /// In en, this message translates to:
  /// **'Sentiment pulse'**
  String get sentimentTitle;

  /// No description provided for @sentimentPrompt.
  ///
  /// In en, this message translates to:
  /// **'Read the mood of {count} headlines across your sectors with FinBERT, a language model trained on financial news.'**
  String sentimentPrompt(int count);

  /// No description provided for @sentimentRun.
  ///
  /// In en, this message translates to:
  /// **'Read the mood'**
  String get sentimentRun;

  /// No description provided for @sentimentReading.
  ///
  /// In en, this message translates to:
  /// **'Reading {count} headlines…'**
  String sentimentReading(int count);

  /// No description provided for @sentimentAnalysed.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{from 1 headline} other{from {count} headlines}}'**
  String sentimentAnalysed(int count);

  /// No description provided for @sentimentFineprint.
  ///
  /// In en, this message translates to:
  /// **'An automated reading of headlines, not of the companies, and not advice.'**
  String get sentimentFineprint;

  /// No description provided for @sentimentUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Sentiment reading isn\'t available on the server right now.'**
  String get sentimentUnavailable;

  /// No description provided for @moodBullish.
  ///
  /// In en, this message translates to:
  /// **'Bullish'**
  String get moodBullish;

  /// No description provided for @moodBearish.
  ///
  /// In en, this message translates to:
  /// **'Bearish'**
  String get moodBearish;

  /// No description provided for @moodNeutral.
  ///
  /// In en, this message translates to:
  /// **'Neutral'**
  String get moodNeutral;

  /// No description provided for @tonePositive.
  ///
  /// In en, this message translates to:
  /// **'Positive'**
  String get tonePositive;

  /// No description provided for @toneNegative.
  ///
  /// In en, this message translates to:
  /// **'Negative'**
  String get toneNegative;

  /// No description provided for @toneNeutral.
  ///
  /// In en, this message translates to:
  /// **'Neutral'**
  String get toneNeutral;

  /// No description provided for @moodBarSemantics.
  ///
  /// In en, this message translates to:
  /// **'Bullish {bullish}, neutral {neutral}, bearish {bearish}'**
  String moodBarSemantics(String bullish, String neutral, String bearish);

  /// No description provided for @breadthVix.
  ///
  /// In en, this message translates to:
  /// **'India VIX'**
  String get breadthVix;

  /// No description provided for @breadthIndices.
  ///
  /// In en, this message translates to:
  /// **'Indices'**
  String get breadthIndices;

  /// No description provided for @breadthUpDown.
  ///
  /// In en, this message translates to:
  /// **'up / down today'**
  String get breadthUpDown;

  /// No description provided for @breadth52w.
  ///
  /// In en, this message translates to:
  /// **'52-week'**
  String get breadth52w;

  /// No description provided for @breadthHighsLows.
  ///
  /// In en, this message translates to:
  /// **'highs / lows'**
  String get breadthHighsLows;

  /// No description provided for @moversTitle.
  ///
  /// In en, this message translates to:
  /// **'Index movers'**
  String get moversTitle;

  /// No description provided for @moversSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Today\'s biggest rises and falls among NSE indices'**
  String get moversSubtitle;

  /// No description provided for @moversAll.
  ///
  /// In en, this message translates to:
  /// **'All {count} indices'**
  String moversAll(int count);

  /// No description provided for @moversAllTitle.
  ///
  /// In en, this message translates to:
  /// **'All NSE indices today'**
  String get moversAllTitle;

  /// No description provided for @sectorsYours.
  ///
  /// In en, this message translates to:
  /// **'Your sectors'**
  String get sectorsYours;

  /// No description provided for @sectorsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No sectors yet'**
  String get sectorsEmptyTitle;

  /// No description provided for @sectorsEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Your holdings, grouped by sector against their NSE index, appear here.'**
  String get sectorsEmptyBody;

  /// No description provided for @sectorHoldings.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 holding} other{{count} holdings}}'**
  String sectorHoldings(int count);

  /// No description provided for @sectorIndex.
  ///
  /// In en, this message translates to:
  /// **'Index: {name}'**
  String sectorIndex(String name);

  /// No description provided for @sectorDriver.
  ///
  /// In en, this message translates to:
  /// **'Key driver: {driver}'**
  String sectorDriver(String driver);

  /// No description provided for @sectorYourHoldings.
  ///
  /// In en, this message translates to:
  /// **'Your holdings'**
  String get sectorYourHoldings;

  /// No description provided for @newsGathering.
  ///
  /// In en, this message translates to:
  /// **'Gathering headlines for your sectors. This can take up to a minute.'**
  String get newsGathering;

  /// No description provided for @commonTooSlow.
  ///
  /// In en, this message translates to:
  /// **'That took too long'**
  String get commonTooSlow;

  /// No description provided for @newsNoneBackTitle.
  ///
  /// In en, this message translates to:
  /// **'No headlines came back'**
  String get newsNoneBackTitle;

  /// No description provided for @newsNoneBackBody.
  ///
  /// In en, this message translates to:
  /// **'The news service may be unavailable right now. Try again in a few minutes, or pull to refresh.'**
  String get newsNoneBackBody;

  /// No description provided for @commonClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @accountAi.
  ///
  /// In en, this message translates to:
  /// **'AI'**
  String get accountAi;

  /// No description provided for @accountAiKey.
  ///
  /// In en, this message translates to:
  /// **'OpenRouter key & model'**
  String get accountAiKey;

  /// No description provided for @accountAiKeySaved.
  ///
  /// In en, this message translates to:
  /// **'Key saved · {model}'**
  String accountAiKeySaved(String model);

  /// No description provided for @accountAiKeyMissing.
  ///
  /// In en, this message translates to:
  /// **'Not set up. Needed for Home insights and Ask'**
  String get accountAiKeyMissing;

  /// No description provided for @aiSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'AI settings'**
  String get aiSettingsTitle;

  /// No description provided for @aiSettingsIntro.
  ///
  /// In en, this message translates to:
  /// **'Home insights and Ask use your own OpenRouter key, so you choose the model and pay only for what you use. The agent and stock summaries don\'t need a key.'**
  String get aiSettingsIntro;

  /// No description provided for @aiKeyTitle.
  ///
  /// In en, this message translates to:
  /// **'OpenRouter API key'**
  String get aiKeyTitle;

  /// No description provided for @aiKeyStatusSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get aiKeyStatusSaved;

  /// No description provided for @aiKeyStatusMissing.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get aiKeyStatusMissing;

  /// No description provided for @aiKeyLabel.
  ///
  /// In en, this message translates to:
  /// **'Your OpenRouter key'**
  String get aiKeyLabel;

  /// No description provided for @aiKeyReplaceLabel.
  ///
  /// In en, this message translates to:
  /// **'Paste a new key to replace the saved one'**
  String get aiKeyReplaceLabel;

  /// No description provided for @aiKeyUnusualPrefix.
  ///
  /// In en, this message translates to:
  /// **'OpenRouter keys usually start with sk-or-. Check you copied the right one.'**
  String get aiKeyUnusualPrefix;

  /// No description provided for @aiKeyEmpty.
  ///
  /// In en, this message translates to:
  /// **'Paste your key first.'**
  String get aiKeyEmpty;

  /// No description provided for @aiKeyWhitespace.
  ///
  /// In en, this message translates to:
  /// **'A key has no spaces or line breaks. Check what was pasted.'**
  String get aiKeyWhitespace;

  /// No description provided for @aiKeyTooShort.
  ///
  /// In en, this message translates to:
  /// **'That looks too short to be a key.'**
  String get aiKeyTooShort;

  /// No description provided for @aiKeySave.
  ///
  /// In en, this message translates to:
  /// **'Save key'**
  String get aiKeySave;

  /// No description provided for @aiKeyReplace.
  ///
  /// In en, this message translates to:
  /// **'Replace key'**
  String get aiKeyReplace;

  /// No description provided for @aiKeySaved.
  ///
  /// In en, this message translates to:
  /// **'Key saved on this phone'**
  String get aiKeySaved;

  /// No description provided for @aiKeySaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t save the key on this phone. Try again.'**
  String get aiKeySaveFailed;

  /// No description provided for @aiKeyRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get aiKeyRemove;

  /// No description provided for @aiKeyRemoveTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove your key?'**
  String get aiKeyRemoveTitle;

  /// No description provided for @aiKeyRemoveBody.
  ///
  /// In en, this message translates to:
  /// **'Insights and Ask will stop working until you add a key again. Answers already written stay until you log out.'**
  String get aiKeyRemoveBody;

  /// No description provided for @aiKeyGet.
  ///
  /// In en, this message translates to:
  /// **'Get a key at openrouter.ai'**
  String get aiKeyGet;

  /// No description provided for @aiKeyHowKept.
  ///
  /// In en, this message translates to:
  /// **'Your key is kept in this phone\'s secure storage and removed when you log out. Agentfolio\'s server passes it to OpenRouter with each request and doesn\'t keep it. Usage is billed to your OpenRouter account.'**
  String get aiKeyHowKept;

  /// No description provided for @aiModelTitle.
  ///
  /// In en, this message translates to:
  /// **'Model'**
  String get aiModelTitle;

  /// No description provided for @aiModelSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Used for insights and answers from now on'**
  String get aiModelSubtitle;

  /// No description provided for @aiModelOther.
  ///
  /// In en, this message translates to:
  /// **'Another model'**
  String get aiModelOther;

  /// No description provided for @aiModelCustomLabel.
  ///
  /// In en, this message translates to:
  /// **'OpenRouter model id'**
  String get aiModelCustomLabel;

  /// No description provided for @aiModelInvalid.
  ///
  /// In en, this message translates to:
  /// **'Use the id OpenRouter shows, like provider/model-name.'**
  String get aiModelInvalid;

  /// No description provided for @aiModelInUse.
  ///
  /// In en, this message translates to:
  /// **'In use'**
  String get aiModelInUse;

  /// No description provided for @aiModelUse.
  ///
  /// In en, this message translates to:
  /// **'Use this model'**
  String get aiModelUse;

  /// No description provided for @aiCheckKey.
  ///
  /// In en, this message translates to:
  /// **'Check key'**
  String get aiCheckKey;

  /// No description provided for @aiSetUp.
  ///
  /// In en, this message translates to:
  /// **'Set up AI'**
  String get aiSetUp;

  /// No description provided for @aiInsightsTitle.
  ///
  /// In en, this message translates to:
  /// **'AI insights'**
  String get aiInsightsTitle;

  /// No description provided for @aiInsightsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your portfolio, read in plain English'**
  String get aiInsightsSubtitle;

  /// No description provided for @aiInsightsNeedKey.
  ///
  /// In en, this message translates to:
  /// **'Add your OpenRouter key to get a short read of your portfolio\'s health, best and worst performers, and concentration risk.'**
  String get aiInsightsNeedKey;

  /// No description provided for @aiInsightsInvite.
  ///
  /// In en, this message translates to:
  /// **'A short read of your portfolio\'s health, best and worst performers, concentration risk, and a few things to consider.'**
  String get aiInsightsInvite;

  /// No description provided for @aiInsightsGenerate.
  ///
  /// In en, this message translates to:
  /// **'Write insights'**
  String get aiInsightsGenerate;

  /// No description provided for @aiInsightsWriting.
  ///
  /// In en, this message translates to:
  /// **'Reading your portfolio…'**
  String get aiInsightsWriting;

  /// No description provided for @aiUsesYourCredit.
  ///
  /// In en, this message translates to:
  /// **'Uses your OpenRouter credit · {model}'**
  String aiUsesYourCredit(String model);

  /// No description provided for @aiWrittenBy.
  ///
  /// In en, this message translates to:
  /// **'{model} · {when}'**
  String aiWrittenBy(String model, String when);

  /// No description provided for @askTitle.
  ///
  /// In en, this message translates to:
  /// **'Ask about your portfolio'**
  String get askTitle;

  /// No description provided for @askSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Answers use your holdings and P&L'**
  String get askSubtitle;

  /// No description provided for @askNeedKey.
  ///
  /// In en, this message translates to:
  /// **'Add your OpenRouter key to ask questions about your portfolio.'**
  String get askNeedKey;

  /// No description provided for @askOwn.
  ///
  /// In en, this message translates to:
  /// **'Ask your own question'**
  String get askOwn;

  /// No description provided for @askIntro.
  ///
  /// In en, this message translates to:
  /// **'Pick a question or type your own. Answers are based only on your current holdings, P&L and funds.'**
  String get askIntro;

  /// No description provided for @askPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Ask anything about your portfolio…'**
  String get askPlaceholder;

  /// No description provided for @askThinking.
  ///
  /// In en, this message translates to:
  /// **'Looking at your portfolio…'**
  String get askThinking;

  /// No description provided for @askStarterDiversified.
  ///
  /// In en, this message translates to:
  /// **'How diversified is my portfolio?'**
  String get askStarterDiversified;

  /// No description provided for @askStarterUnderperforming.
  ///
  /// In en, this message translates to:
  /// **'Which stocks are underperforming?'**
  String get askStarterUnderperforming;

  /// No description provided for @askStarterRisk.
  ///
  /// In en, this message translates to:
  /// **'What is my risk exposure?'**
  String get askStarterRisk;

  /// No description provided for @askStarterRebalance.
  ///
  /// In en, this message translates to:
  /// **'Suggest rebalancing strategies'**
  String get askStarterRebalance;

  /// No description provided for @askStarterHealth.
  ///
  /// In en, this message translates to:
  /// **'Summarize my portfolio health'**
  String get askStarterHealth;

  /// No description provided for @agentTitle.
  ///
  /// In en, this message translates to:
  /// **'Agent'**
  String get agentTitle;

  /// No description provided for @agentFinance.
  ///
  /// In en, this message translates to:
  /// **'Finance'**
  String get agentFinance;

  /// No description provided for @agentTrading.
  ///
  /// In en, this message translates to:
  /// **'Trading'**
  String get agentTrading;

  /// No description provided for @agentAskAbout.
  ///
  /// In en, this message translates to:
  /// **'Tell me about {symbol}: how it\'s doing in my portfolio, and what its fundamentals and technicals say.'**
  String agentAskAbout(String symbol);

  /// No description provided for @stockAskAgent.
  ///
  /// In en, this message translates to:
  /// **'Ask the agent about {symbol}'**
  String stockAskAgent(String symbol);

  /// No description provided for @agentEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'What would you like to know?'**
  String get agentEmptyTitle;

  /// No description provided for @agentEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Your finance agent can look at your holdings, prices, fundamentals and news. Try a starter or ask your own question.'**
  String get agentEmptyBody;

  /// No description provided for @tradingEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Trading assistant'**
  String get tradingEmptyTitle;

  /// No description provided for @tradingEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Ask for trade ideas based on your risk profile. It proposes; nothing is placed until you approve.'**
  String get tradingEmptyBody;

  /// No description provided for @agentPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Message your finance agent…'**
  String get agentPlaceholder;

  /// No description provided for @tradingPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Message your trading agent…'**
  String get tradingPlaceholder;

  /// No description provided for @agentFootnote.
  ///
  /// In en, this message translates to:
  /// **'AI can be wrong. Not financial advice. Tap to read more.'**
  String get agentFootnote;

  /// No description provided for @tradingFootnote.
  ///
  /// In en, this message translates to:
  /// **'Proposals must be approved before execution.'**
  String get tradingFootnote;

  /// No description provided for @agentStarterHealth.
  ///
  /// In en, this message translates to:
  /// **'Portfolio check-up'**
  String get agentStarterHealth;

  /// No description provided for @agentStarterHealthPrompt.
  ///
  /// In en, this message translates to:
  /// **'Give me a quick health check of my portfolio: overall P&L, today\'s move, and anything that needs attention.'**
  String get agentStarterHealthPrompt;

  /// No description provided for @agentStarterRisk.
  ///
  /// In en, this message translates to:
  /// **'Where\'s my risk?'**
  String get agentStarterRisk;

  /// No description provided for @agentStarterRiskPrompt.
  ///
  /// In en, this message translates to:
  /// **'Where is my portfolio most concentrated, and what risks does that create?'**
  String get agentStarterRiskPrompt;

  /// No description provided for @agentStarterLaggards.
  ///
  /// In en, this message translates to:
  /// **'My laggards'**
  String get agentStarterLaggards;

  /// No description provided for @agentStarterLaggardsPrompt.
  ///
  /// In en, this message translates to:
  /// **'Which of my holdings are doing worst, and what\'s going on with them?'**
  String get agentStarterLaggardsPrompt;

  /// No description provided for @agentStarterExplain.
  ///
  /// In en, this message translates to:
  /// **'Explain a metric'**
  String get agentStarterExplain;

  /// No description provided for @agentStarterExplainPrompt.
  ///
  /// In en, this message translates to:
  /// **'Explain P/E, ROE and debt-to-equity in simple terms, using one of my holdings as an example.'**
  String get agentStarterExplainPrompt;

  /// No description provided for @tradingStarterSuggest.
  ///
  /// In en, this message translates to:
  /// **'Suggest trades'**
  String get tradingStarterSuggest;

  /// No description provided for @tradingStarterSuggestPrompt.
  ///
  /// In en, this message translates to:
  /// **'What trades would you recommend based on my risk profile and current holdings?'**
  String get tradingStarterSuggestPrompt;

  /// No description provided for @tradingStarterAnalyze.
  ///
  /// In en, this message translates to:
  /// **'Analyze RELIANCE'**
  String get tradingStarterAnalyze;

  /// No description provided for @tradingStarterAnalyzePrompt.
  ///
  /// In en, this message translates to:
  /// **'Analyze RELIANCE-EQ technically and tell me if it\'s a good entry point.'**
  String get tradingStarterAnalyzePrompt;

  /// No description provided for @tradingStarterPending.
  ///
  /// In en, this message translates to:
  /// **'Pending proposals'**
  String get tradingStarterPending;

  /// No description provided for @tradingStarterPendingPrompt.
  ///
  /// In en, this message translates to:
  /// **'Show my current pending proposals.'**
  String get tradingStarterPendingPrompt;

  /// No description provided for @tradingStarterMargin.
  ///
  /// In en, this message translates to:
  /// **'Check margin'**
  String get tradingStarterMargin;

  /// No description provided for @tradingStarterMarginPrompt.
  ///
  /// In en, this message translates to:
  /// **'What is my available margin and current exposure?'**
  String get tradingStarterMarginPrompt;

  /// No description provided for @tradingLockedTitle.
  ///
  /// In en, this message translates to:
  /// **'The trading agent is part of Premium'**
  String get tradingLockedTitle;

  /// No description provided for @tradingLockedBody.
  ///
  /// In en, this message translates to:
  /// **'It suggests trades from your risk profile, and nothing is placed until you approve. Premium is set up from the Trade tab.'**
  String get tradingLockedBody;

  /// No description provided for @tradingLockedAction.
  ///
  /// In en, this message translates to:
  /// **'Go to Trade'**
  String get tradingLockedAction;

  /// No description provided for @chatSend.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get chatSend;

  /// No description provided for @chatYouSaid.
  ///
  /// In en, this message translates to:
  /// **'You said'**
  String get chatYouSaid;

  /// No description provided for @chatAgentSaid.
  ///
  /// In en, this message translates to:
  /// **'The agent said'**
  String get chatAgentSaid;

  /// No description provided for @chatCopy.
  ///
  /// In en, this message translates to:
  /// **'Copy reply'**
  String get chatCopy;

  /// No description provided for @chatCopied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get chatCopied;

  /// No description provided for @chatThinking.
  ///
  /// In en, this message translates to:
  /// **'Thinking…'**
  String get chatThinking;

  /// No description provided for @chatWorkingFor.
  ///
  /// In en, this message translates to:
  /// **'Working on it… {seconds}s'**
  String chatWorkingFor(int seconds);

  /// No description provided for @chatWorkingLong.
  ///
  /// In en, this message translates to:
  /// **'Still working ({seconds}s). Replies that check live prices can take a minute or two.'**
  String chatWorkingLong(int seconds);

  /// No description provided for @chatNotSent.
  ///
  /// In en, this message translates to:
  /// **'Not sent.'**
  String get chatNotSent;

  /// No description provided for @chatSendAgain.
  ///
  /// In en, this message translates to:
  /// **'Send again'**
  String get chatSendAgain;

  /// No description provided for @chatStillWorking.
  ///
  /// In en, this message translates to:
  /// **'The agent has this and hasn\'t answered yet.'**
  String get chatStillWorking;

  /// No description provided for @chatCheckAgain.
  ///
  /// In en, this message translates to:
  /// **'Check again'**
  String get chatCheckAgain;

  /// No description provided for @chatLostConnection.
  ///
  /// In en, this message translates to:
  /// **'Connection lost before the answer. The agent may still have received this.'**
  String get chatLostConnection;

  /// No description provided for @chatApprovalUnknown.
  ///
  /// In en, this message translates to:
  /// **'Connection lost before the answer. Check the Trade tab to see whether this went through before trying again.'**
  String get chatApprovalUnknown;

  /// No description provided for @chatNotSaved.
  ///
  /// In en, this message translates to:
  /// **'Conversations aren\'t saved on your plan. New chat starts afresh.'**
  String get chatNotSaved;

  /// No description provided for @chatConversations.
  ///
  /// In en, this message translates to:
  /// **'Conversations'**
  String get chatConversations;

  /// No description provided for @chatNew.
  ///
  /// In en, this message translates to:
  /// **'New chat'**
  String get chatNew;

  /// No description provided for @chatSavedIsPremium.
  ///
  /// In en, this message translates to:
  /// **'Saved conversations come with Premium. Your current chat continues until you start a new one.'**
  String get chatSavedIsPremium;

  /// No description provided for @chatNoThreads.
  ///
  /// In en, this message translates to:
  /// **'No saved conversations yet. Your first message starts one.'**
  String get chatNoThreads;

  /// No description provided for @chatToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get chatToday;

  /// No description provided for @chatYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get chatYesterday;

  /// No description provided for @chatThisWeek.
  ///
  /// In en, this message translates to:
  /// **'Previous 7 days'**
  String get chatThisWeek;

  /// No description provided for @chatOlder.
  ///
  /// In en, this message translates to:
  /// **'Older'**
  String get chatOlder;

  /// No description provided for @chatThreadMenu.
  ///
  /// In en, this message translates to:
  /// **'Conversation options'**
  String get chatThreadMenu;

  /// No description provided for @chatRename.
  ///
  /// In en, this message translates to:
  /// **'Rename'**
  String get chatRename;

  /// No description provided for @chatRenameTitle.
  ///
  /// In en, this message translates to:
  /// **'Rename conversation'**
  String get chatRenameTitle;

  /// No description provided for @chatRenameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get chatRenameLabel;

  /// No description provided for @chatRenameFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t rename: {message}'**
  String chatRenameFailed(String message);

  /// No description provided for @chatDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get chatDelete;

  /// No description provided for @chatDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this conversation?'**
  String get chatDeleteTitle;

  /// No description provided for @chatDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'\"{title}\" and its messages will be deleted everywhere you use Agentfolio. This can\'t be undone.'**
  String chatDeleteBody(String title);

  /// No description provided for @chatDeleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t delete: {message}'**
  String chatDeleteFailed(String message);

  /// No description provided for @chatApproveTitle.
  ///
  /// In en, this message translates to:
  /// **'Place this order?'**
  String get chatApproveTitle;

  /// No description provided for @chatApproveBody.
  ///
  /// In en, this message translates to:
  /// **'Approving proposal {id} places a real order on your {broker} account straight away. Check the proposal\'s details first.'**
  String chatApproveBody(String id, String broker);

  /// No description provided for @chatYourBroker.
  ///
  /// In en, this message translates to:
  /// **'broker'**
  String get chatYourBroker;

  /// No description provided for @chatApproveConfirm.
  ///
  /// In en, this message translates to:
  /// **'Approve and place order'**
  String get chatApproveConfirm;

  /// No description provided for @approveTitle.
  ///
  /// In en, this message translates to:
  /// **'Place this order?'**
  String get approveTitle;

  /// No description provided for @approveConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm and place order'**
  String get approveConfirm;

  /// No description provided for @approveHold.
  ///
  /// In en, this message translates to:
  /// **'Hold to place order'**
  String get approveHold;

  /// No description provided for @approveNoLock.
  ///
  /// In en, this message translates to:
  /// **'This phone has no screen lock, so hold the button to confirm instead.'**
  String get approveNoLock;

  /// No description provided for @approveAuthReason.
  ///
  /// In en, this message translates to:
  /// **'Confirm it\'s you to place this order'**
  String get approveAuthReason;

  /// No description provided for @approveAuthFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t confirm it\'s you. Try again, or unlock your phone first.'**
  String get approveAuthFailed;

  /// No description provided for @approveNoDetails.
  ///
  /// In en, this message translates to:
  /// **'Only the proposal id is known here. Check its details in the Trade tab first.'**
  String get approveNoDetails;

  /// No description provided for @approveWarning.
  ///
  /// In en, this message translates to:
  /// **'This places a real order on your {broker} account. It can\'t be undone from the app.'**
  String approveWarning(String broker);

  /// No description provided for @orderBuy.
  ///
  /// In en, this message translates to:
  /// **'BUY'**
  String get orderBuy;

  /// No description provided for @orderSell.
  ///
  /// In en, this message translates to:
  /// **'SELL'**
  String get orderSell;

  /// No description provided for @orderHeadline.
  ///
  /// In en, this message translates to:
  /// **'{quantity} × {symbol}'**
  String orderHeadline(int quantity, String symbol);

  /// No description provided for @orderPrice.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get orderPrice;

  /// No description provided for @orderMarket.
  ///
  /// In en, this message translates to:
  /// **'Market price'**
  String get orderMarket;

  /// No description provided for @orderTrigger.
  ///
  /// In en, this message translates to:
  /// **'Trigger'**
  String get orderTrigger;

  /// No description provided for @orderValue.
  ///
  /// In en, this message translates to:
  /// **'Order value'**
  String get orderValue;

  /// No description provided for @orderValueApprox.
  ///
  /// In en, this message translates to:
  /// **'Approx. value'**
  String get orderValueApprox;

  /// No description provided for @orderProduct.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get orderProduct;

  /// No description provided for @orderType.
  ///
  /// In en, this message translates to:
  /// **'Order type'**
  String get orderType;

  /// No description provided for @orderExchange.
  ///
  /// In en, this message translates to:
  /// **'Exchange'**
  String get orderExchange;

  /// No description provided for @orderAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get orderAccount;

  /// No description provided for @orderProposal.
  ///
  /// In en, this message translates to:
  /// **'Proposal'**
  String get orderProposal;

  /// No description provided for @proposalsTitle.
  ///
  /// In en, this message translates to:
  /// **'Trade proposals'**
  String get proposalsTitle;

  /// No description provided for @proposalsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'From the trading agent. Nothing is placed until you approve.'**
  String get proposalsSubtitle;

  /// No description provided for @proposalsPending.
  ///
  /// In en, this message translates to:
  /// **'{count} pending'**
  String proposalsPending(int count);

  /// No description provided for @proposalsNone.
  ///
  /// In en, this message translates to:
  /// **'No proposals right now. Any the trading agent suggests appear here for you to approve or reject.'**
  String get proposalsNone;

  /// No description provided for @proposalApprove.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get proposalApprove;

  /// No description provided for @proposalReject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get proposalReject;

  /// No description provided for @proposalRejected.
  ///
  /// In en, this message translates to:
  /// **'Proposal rejected'**
  String get proposalRejected;

  /// No description provided for @proposalIdCopied.
  ///
  /// In en, this message translates to:
  /// **'Proposal id copied'**
  String get proposalIdCopied;

  /// No description provided for @proposalOrderId.
  ///
  /// In en, this message translates to:
  /// **'Order ID {id}'**
  String proposalOrderId(String id);

  /// No description provided for @proposalExpiresIn.
  ///
  /// In en, this message translates to:
  /// **'Expires in {time}'**
  String proposalExpiresIn(String time);

  /// No description provided for @proposalExpiredNow.
  ///
  /// In en, this message translates to:
  /// **'This proposal has expired. Ask the agent for a fresh one.'**
  String get proposalExpiredNow;

  /// No description provided for @statusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get statusPending;

  /// No description provided for @statusApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get statusApproved;

  /// No description provided for @statusExecuted.
  ///
  /// In en, this message translates to:
  /// **'Placed'**
  String get statusExecuted;

  /// No description provided for @statusFailed.
  ///
  /// In en, this message translates to:
  /// **'Not placed'**
  String get statusFailed;

  /// No description provided for @statusRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get statusRejected;

  /// No description provided for @statusExpired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get statusExpired;

  /// No description provided for @statusUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get statusUnknown;

  /// No description provided for @outcomePlaced.
  ///
  /// In en, this message translates to:
  /// **'Order placed'**
  String get outcomePlaced;

  /// No description provided for @outcomePlacedBody.
  ///
  /// In en, this message translates to:
  /// **'Your broker accepted the order.'**
  String get outcomePlacedBody;

  /// No description provided for @outcomeNotPlaced.
  ///
  /// In en, this message translates to:
  /// **'Order not placed'**
  String get outcomeNotPlaced;

  /// No description provided for @outcomeNotReceived.
  ///
  /// In en, this message translates to:
  /// **'The approval didn\'t reach the server'**
  String get outcomeNotReceived;

  /// No description provided for @outcomeNotReceivedBody.
  ///
  /// In en, this message translates to:
  /// **'Nothing was placed. The proposal is still pending if you want to try again.'**
  String get outcomeNotReceivedBody;

  /// No description provided for @outcomeInProgress.
  ///
  /// In en, this message translates to:
  /// **'Sent to your broker'**
  String get outcomeInProgress;

  /// No description provided for @outcomeInProgressBody.
  ///
  /// In en, this message translates to:
  /// **'The result isn\'t back yet. Check Orders before doing anything else.'**
  String get outcomeInProgressBody;

  /// No description provided for @outcomeUnconfirmed.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t confirm what happened'**
  String get outcomeUnconfirmed;

  /// No description provided for @outcomeUnconfirmedBody.
  ///
  /// In en, this message translates to:
  /// **'The connection dropped and the proposal is no longer on the server. Check Orders to see whether it was placed before trying again.'**
  String get outcomeUnconfirmedBody;

  /// No description provided for @outcomeOpenOrders.
  ///
  /// In en, this message translates to:
  /// **'Open Orders'**
  String get outcomeOpenOrders;

  /// No description provided for @liveTitle.
  ///
  /// In en, this message translates to:
  /// **'Live price'**
  String get liveTitle;

  /// No description provided for @liveNoHoldings.
  ///
  /// In en, this message translates to:
  /// **'No holdings yet. Type any NSE symbol above to watch it.'**
  String get liveNoHoldings;

  /// No description provided for @liveAnySymbol.
  ///
  /// In en, this message translates to:
  /// **'Any NSE symbol, e.g. RELIANCE'**
  String get liveAnySymbol;

  /// No description provided for @liveLoad.
  ///
  /// In en, this message translates to:
  /// **'Watch'**
  String get liveLoad;

  /// No description provided for @liveUnavailableHint.
  ///
  /// In en, this message translates to:
  /// **'Price history isn\'t available for this symbol. Check the spelling, or try its NSE trading symbol.'**
  String get liveUnavailableHint;

  /// No description provided for @liveLastClose.
  ///
  /// In en, this message translates to:
  /// **'Last close · live updates during market hours'**
  String get liveLastClose;

  /// No description provided for @liveTickAt.
  ///
  /// In en, this message translates to:
  /// **'Live · {when}'**
  String liveTickAt(String when);

  /// No description provided for @liveDelayed.
  ///
  /// In en, this message translates to:
  /// **'Delayed · last update {when}'**
  String liveDelayed(String when);

  /// No description provided for @liveLineLabel.
  ///
  /// In en, this message translates to:
  /// **'Live {price}'**
  String liveLineLabel(String price);

  /// No description provided for @liveChartLabel.
  ///
  /// In en, this message translates to:
  /// **'Daily candles for {symbol} over the last three months, with the live price'**
  String liveChartLabel(String symbol);

  /// No description provided for @liveOn.
  ///
  /// In en, this message translates to:
  /// **'Live'**
  String get liveOn;

  /// No description provided for @liveConnecting.
  ///
  /// In en, this message translates to:
  /// **'Connecting'**
  String get liveConnecting;

  /// No description provided for @liveReconnecting.
  ///
  /// In en, this message translates to:
  /// **'Reconnecting'**
  String get liveReconnecting;

  /// No description provided for @livePaused.
  ///
  /// In en, this message translates to:
  /// **'Paused'**
  String get livePaused;

  /// No description provided for @liveUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Unavailable'**
  String get liveUnavailable;

  /// No description provided for @liveMarketClosed.
  ///
  /// In en, this message translates to:
  /// **'Market closed'**
  String get liveMarketClosed;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Risk profile'**
  String get profileTitle;

  /// No description provided for @profileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Every proposal is checked against it before it reaches your broker'**
  String get profileSubtitle;

  /// No description provided for @profileNone.
  ///
  /// In en, this message translates to:
  /// **'No risk profile yet. Set one up so the agent\'s proposals are checked against your limits.'**
  String get profileNone;

  /// No description provided for @profileSetUp.
  ///
  /// In en, this message translates to:
  /// **'Set up risk profile'**
  String get profileSetUp;

  /// No description provided for @profileEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get profileEdit;

  /// No description provided for @profileEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit risk profile'**
  String get profileEditTitle;

  /// No description provided for @profileIntro.
  ///
  /// In en, this message translates to:
  /// **'These limits shape what the trading agent suggests, and any order over them is blocked before it reaches your broker.'**
  String get profileIntro;

  /// No description provided for @profileAboutYou.
  ///
  /// In en, this message translates to:
  /// **'About you'**
  String get profileAboutYou;

  /// No description provided for @profileLimits.
  ///
  /// In en, this message translates to:
  /// **'Limits'**
  String get profileLimits;

  /// No description provided for @profileAge.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get profileAge;

  /// No description provided for @profileAgeProblem.
  ///
  /// In en, this message translates to:
  /// **'Between 18 and 120.'**
  String get profileAgeProblem;

  /// No description provided for @profileHorizon.
  ///
  /// In en, this message translates to:
  /// **'Horizon'**
  String get profileHorizon;

  /// No description provided for @profileHorizonYears.
  ///
  /// In en, this message translates to:
  /// **'Horizon (years)'**
  String get profileHorizonYears;

  /// No description provided for @profileHorizonProblem.
  ///
  /// In en, this message translates to:
  /// **'Between 1 and 50 years.'**
  String get profileHorizonProblem;

  /// No description provided for @profileYears.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 year} other{{count} years}}'**
  String profileYears(int count);

  /// No description provided for @profileGoal.
  ///
  /// In en, this message translates to:
  /// **'Goal'**
  String get profileGoal;

  /// No description provided for @profileTolerance.
  ///
  /// In en, this message translates to:
  /// **'Risk tolerance'**
  String get profileTolerance;

  /// No description provided for @profileTax.
  ///
  /// In en, this message translates to:
  /// **'Tax bracket'**
  String get profileTax;

  /// No description provided for @profileMaxOrder.
  ///
  /// In en, this message translates to:
  /// **'Max order'**
  String get profileMaxOrder;

  /// No description provided for @profileMaxOrderLabel.
  ///
  /// In en, this message translates to:
  /// **'Largest single order'**
  String get profileMaxOrderLabel;

  /// No description provided for @profileMaxOrderHelp.
  ///
  /// In en, this message translates to:
  /// **'Any one order above this is blocked.'**
  String get profileMaxOrderHelp;

  /// No description provided for @profileMaxOrderProblem.
  ///
  /// In en, this message translates to:
  /// **'At least ₹1,000.'**
  String get profileMaxOrderProblem;

  /// No description provided for @profileMaxPosition.
  ///
  /// In en, this message translates to:
  /// **'Max position'**
  String get profileMaxPosition;

  /// No description provided for @profileMaxPositionLabel.
  ///
  /// In en, this message translates to:
  /// **'Max % in one stock'**
  String get profileMaxPositionLabel;

  /// No description provided for @profilePercentProblem.
  ///
  /// In en, this message translates to:
  /// **'Between 1 and 100.'**
  String get profilePercentProblem;

  /// No description provided for @profileMaxTrades.
  ///
  /// In en, this message translates to:
  /// **'Max trades a day'**
  String get profileMaxTrades;

  /// No description provided for @profileTradesProblem.
  ///
  /// In en, this message translates to:
  /// **'Between 1 and 100.'**
  String get profileTradesProblem;

  /// No description provided for @profileProducts.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get profileProducts;

  /// No description provided for @profileProductsProblem.
  ///
  /// In en, this message translates to:
  /// **'Allow at least one.'**
  String get profileProductsProblem;

  /// No description provided for @profileSave.
  ///
  /// In en, this message translates to:
  /// **'Save risk profile'**
  String get profileSave;

  /// No description provided for @profileSaved.
  ///
  /// In en, this message translates to:
  /// **'Risk profile saved'**
  String get profileSaved;

  /// No description provided for @profileDiscardTitle.
  ///
  /// In en, this message translates to:
  /// **'Discard your changes?'**
  String get profileDiscardTitle;

  /// No description provided for @profileDiscardBody.
  ///
  /// In en, this message translates to:
  /// **'Your risk profile stays as it was.'**
  String get profileDiscardBody;

  /// No description provided for @profileDiscard.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get profileDiscard;

  /// No description provided for @goalWealth.
  ///
  /// In en, this message translates to:
  /// **'Wealth creation'**
  String get goalWealth;

  /// No description provided for @goalIncome.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get goalIncome;

  /// No description provided for @goalPreservation.
  ///
  /// In en, this message translates to:
  /// **'Preservation'**
  String get goalPreservation;

  /// No description provided for @goalSpeculation.
  ///
  /// In en, this message translates to:
  /// **'Speculation'**
  String get goalSpeculation;

  /// No description provided for @toleranceLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get toleranceLow;

  /// No description provided for @toleranceMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get toleranceMedium;

  /// No description provided for @toleranceHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get toleranceHigh;

  /// No description provided for @productDelivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get productDelivery;

  /// No description provided for @productDeliveryHint.
  ///
  /// In en, this message translates to:
  /// **'Buy and hold shares'**
  String get productDeliveryHint;

  /// No description provided for @productIntraday.
  ///
  /// In en, this message translates to:
  /// **'Intraday'**
  String get productIntraday;

  /// No description provided for @productIntradayHint.
  ///
  /// In en, this message translates to:
  /// **'Bought and sold the same day'**
  String get productIntradayHint;

  /// No description provided for @briefTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily brief'**
  String get briefTitle;

  /// No description provided for @briefSubtitle.
  ///
  /// In en, this message translates to:
  /// **'An AI briefing on every holding, sent to {number}'**
  String briefSubtitle(String number);

  /// No description provided for @briefYourWhatsapp.
  ///
  /// In en, this message translates to:
  /// **'your WhatsApp'**
  String get briefYourWhatsapp;

  /// No description provided for @briefAutoSend.
  ///
  /// In en, this message translates to:
  /// **'Send every day'**
  String get briefAutoSend;

  /// No description provided for @briefNotSet.
  ///
  /// In en, this message translates to:
  /// **'Not scheduled yet'**
  String get briefNotSet;

  /// No description provided for @briefNext.
  ///
  /// In en, this message translates to:
  /// **'Next: {when} IST'**
  String briefNext(String when);

  /// No description provided for @briefPaused.
  ///
  /// In en, this message translates to:
  /// **'Paused. Turn on to send daily again.'**
  String get briefPaused;

  /// No description provided for @briefLast.
  ///
  /// In en, this message translates to:
  /// **'Last sent {when} IST'**
  String briefLast(String when);

  /// No description provided for @briefTimeIst.
  ///
  /// In en, this message translates to:
  /// **'Send time'**
  String get briefTimeIst;

  /// No description provided for @briefPickTime.
  ///
  /// In en, this message translates to:
  /// **'Send time (India time)'**
  String get briefPickTime;

  /// No description provided for @briefSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved. Next brief {when} IST'**
  String briefSaved(String when);

  /// No description provided for @briefPauseTitle.
  ///
  /// In en, this message translates to:
  /// **'Pause the daily brief?'**
  String get briefPauseTitle;

  /// No description provided for @briefPauseBody.
  ///
  /// In en, this message translates to:
  /// **'Automatic sends stop until you turn them on again. You can still send one now.'**
  String get briefPauseBody;

  /// No description provided for @briefPause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get briefPause;

  /// No description provided for @briefSendNow.
  ///
  /// In en, this message translates to:
  /// **'Send a brief now'**
  String get briefSendNow;

  /// No description provided for @briefSendNowTitle.
  ///
  /// In en, this message translates to:
  /// **'Send a brief now?'**
  String get briefSendNowTitle;

  /// No description provided for @briefSendNowBody.
  ///
  /// In en, this message translates to:
  /// **'A briefing on your holdings goes to {number} in about 30 seconds.'**
  String briefSendNowBody(String number);

  /// No description provided for @briefStarted.
  ///
  /// In en, this message translates to:
  /// **'Briefing started. Check WhatsApp in about 30 seconds.'**
  String get briefStarted;

  /// No description provided for @briefActivity.
  ///
  /// In en, this message translates to:
  /// **'Recent activity'**
  String get briefActivity;

  /// No description provided for @briefRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get briefRefresh;

  /// No description provided for @briefSent.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get briefSent;

  /// No description provided for @briefRunning.
  ///
  /// In en, this message translates to:
  /// **'Sending'**
  String get briefRunning;

  /// No description provided for @briefFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get briefFailed;

  /// No description provided for @premiumTitle.
  ///
  /// In en, this message translates to:
  /// **'Premium trading agent'**
  String get premiumTitle;

  /// No description provided for @premiumSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Turn it on with your WhatsApp number'**
  String get premiumSubtitle;

  /// No description provided for @premiumPerkIdeas.
  ///
  /// In en, this message translates to:
  /// **'Trade ideas from an AI agent that knows your holdings and your risk profile.'**
  String get premiumPerkIdeas;

  /// No description provided for @premiumPerkApprove.
  ///
  /// In en, this message translates to:
  /// **'Every order waits for you: approve with Face ID or your passcode, or reject.'**
  String get premiumPerkApprove;

  /// No description provided for @premiumPerkLive.
  ///
  /// In en, this message translates to:
  /// **'Live prices, and a risk profile that blocks orders over your limits.'**
  String get premiumPerkLive;

  /// No description provided for @premiumPerkBrief.
  ///
  /// In en, this message translates to:
  /// **'A daily portfolio brief on WhatsApp.'**
  String get premiumPerkBrief;

  /// No description provided for @premiumNumberHelp.
  ///
  /// In en, this message translates to:
  /// **'Briefs and alerts go here. Your broker login is reused from this session.'**
  String get premiumNumberHelp;

  /// No description provided for @premiumNumberMissing.
  ///
  /// In en, this message translates to:
  /// **'Enter your WhatsApp number.'**
  String get premiumNumberMissing;

  /// No description provided for @premiumActivate.
  ///
  /// In en, this message translates to:
  /// **'Activate Premium'**
  String get premiumActivate;

  /// No description provided for @rebalancerTitle.
  ///
  /// In en, this message translates to:
  /// **'What-if rebalancer'**
  String get rebalancerTitle;

  /// No description provided for @rebalancerHint.
  ///
  /// In en, this message translates to:
  /// **'Simulate selling and reinvesting. Nothing is traded.'**
  String get rebalancerHint;

  /// No description provided for @rebalancerIntro.
  ///
  /// In en, this message translates to:
  /// **'Drag a slider to sell part of a holding, then put the cash into another. A simulation only: nothing is sent to your broker.'**
  String get rebalancerIntro;

  /// No description provided for @rebalancerReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get rebalancerReset;

  /// No description provided for @rebalancerEmpty.
  ///
  /// In en, this message translates to:
  /// **'No holdings to simulate yet'**
  String get rebalancerEmpty;

  /// No description provided for @rebalancerFreed.
  ///
  /// In en, this message translates to:
  /// **'Cash freed'**
  String get rebalancerFreed;

  /// No description provided for @rebalancerLeft.
  ///
  /// In en, this message translates to:
  /// **'Left to deploy'**
  String get rebalancerLeft;

  /// No description provided for @rebalancerSold.
  ///
  /// In en, this message translates to:
  /// **'{percent}% sold'**
  String rebalancerSold(int percent);

  /// No description provided for @rebalancerSoldSemantics.
  ///
  /// In en, this message translates to:
  /// **'{percent} percent of {symbol} sold'**
  String rebalancerSoldSemantics(int percent, String symbol);

  /// No description provided for @rebalancerReinvest.
  ///
  /// In en, this message translates to:
  /// **'Reinvest in'**
  String get rebalancerReinvest;

  /// No description provided for @rebalancerAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get rebalancerAmount;

  /// No description provided for @rebalancerApply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get rebalancerApply;

  /// No description provided for @rebalancerPickStock.
  ///
  /// In en, this message translates to:
  /// **'Choose a stock to reinvest in.'**
  String get rebalancerPickStock;

  /// No description provided for @rebalancerAmountPositive.
  ///
  /// In en, this message translates to:
  /// **'Enter an amount above zero.'**
  String get rebalancerAmountPositive;

  /// No description provided for @rebalancerTooMuch.
  ///
  /// In en, this message translates to:
  /// **'That\'s more than the {amount} left to deploy.'**
  String rebalancerTooMuch(String amount);

  /// No description provided for @rebalancerNote.
  ///
  /// In en, this message translates to:
  /// **'Whatever you don\'t reinvest stays as cash.'**
  String get rebalancerNote;

  /// No description provided for @liveAfterHours.
  ///
  /// In en, this message translates to:
  /// **'Market closed · last traded price'**
  String get liveAfterHours;

  /// No description provided for @lastLineLabel.
  ///
  /// In en, this message translates to:
  /// **'Last {price}'**
  String lastLineLabel(String price);

  /// No description provided for @accountPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy & security'**
  String get accountPrivacy;

  /// No description provided for @accountLegal.
  ///
  /// In en, this message translates to:
  /// **'Legal'**
  String get accountLegal;

  /// No description provided for @privacyHideBalancesHint.
  ///
  /// In en, this message translates to:
  /// **'Mask every amount, for using the app in public'**
  String get privacyHideBalancesHint;

  /// No description provided for @privacyAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Share usage analytics'**
  String get privacyAnalytics;

  /// No description provided for @privacyAnalyticsHint.
  ///
  /// In en, this message translates to:
  /// **'Screens and taps, to improve the app. Never amounts or messages. Crash reports are always sent.'**
  String get privacyAnalyticsHint;

  /// No description provided for @lockSetting.
  ///
  /// In en, this message translates to:
  /// **'App lock'**
  String get lockSetting;

  /// No description provided for @lockSettingHint.
  ///
  /// In en, this message translates to:
  /// **'Face ID, fingerprint or passcode to open Agentfolio'**
  String get lockSettingHint;

  /// No description provided for @lockEnableReason.
  ///
  /// In en, this message translates to:
  /// **'Confirm to turn on the app lock'**
  String get lockEnableReason;

  /// No description provided for @lockNeedsScreenLock.
  ///
  /// In en, this message translates to:
  /// **'Set a screen lock on this phone first, then turn on the app lock.'**
  String get lockNeedsScreenLock;

  /// No description provided for @lockReason.
  ///
  /// In en, this message translates to:
  /// **'Unlock Agentfolio'**
  String get lockReason;

  /// No description provided for @lockTitle.
  ///
  /// In en, this message translates to:
  /// **'Agentfolio is locked'**
  String get lockTitle;

  /// No description provided for @lockBody.
  ///
  /// In en, this message translates to:
  /// **'Unlock with Face ID, fingerprint or your passcode.'**
  String get lockBody;

  /// No description provided for @lockTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Not unlocked. Try again.'**
  String get lockTryAgain;

  /// No description provided for @lockUnlock.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get lockUnlock;

  /// No description provided for @lockSignOut.
  ///
  /// In en, this message translates to:
  /// **'Log out instead'**
  String get lockSignOut;

  /// No description provided for @legalPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get legalPrivacy;

  /// No description provided for @legalTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms of use'**
  String get legalTerms;

  /// No description provided for @legalRisk.
  ///
  /// In en, this message translates to:
  /// **'Risk disclosure'**
  String get legalRisk;

  /// No description provided for @legalLicences.
  ///
  /// In en, this message translates to:
  /// **'Open-source licences'**
  String get legalLicences;

  /// No description provided for @deleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get deleteTitle;

  /// No description provided for @deleteTileHint.
  ///
  /// In en, this message translates to:
  /// **'Permanently remove your Agentfolio account'**
  String get deleteTileHint;

  /// No description provided for @deleteIntro.
  ///
  /// In en, this message translates to:
  /// **'This permanently deletes your Agentfolio account. It can\'t be undone; to use Agentfolio again you would set it up from the start.'**
  String get deleteIntro;

  /// No description provided for @deleteGoesTitle.
  ///
  /// In en, this message translates to:
  /// **'What is deleted'**
  String get deleteGoesTitle;

  /// No description provided for @deleteGoesAccount.
  ///
  /// In en, this message translates to:
  /// **'Your Agentfolio account and app password'**
  String get deleteGoesAccount;

  /// No description provided for @deleteGoesCredentials.
  ///
  /// In en, this message translates to:
  /// **'Your stored {broker} credentials'**
  String deleteGoesCredentials(String broker);

  /// No description provided for @deleteGoesChats.
  ///
  /// In en, this message translates to:
  /// **'Saved conversations with the AI agents'**
  String get deleteGoesChats;

  /// No description provided for @deleteGoesSettings.
  ///
  /// In en, this message translates to:
  /// **'Your risk profile, daily brief schedule and its history'**
  String get deleteGoesSettings;

  /// No description provided for @deleteGoesDevice.
  ///
  /// In en, this message translates to:
  /// **'Everything this phone keeps for you: sign-in, AI key and drafts'**
  String get deleteGoesDevice;

  /// No description provided for @deleteStaysTitle.
  ///
  /// In en, this message translates to:
  /// **'What stays'**
  String get deleteStaysTitle;

  /// No description provided for @deleteStaysBroker.
  ///
  /// In en, this message translates to:
  /// **'Your {broker} account {client} and any orders already placed: deleting here never touches your broker'**
  String deleteStaysBroker(String broker, String client);

  /// No description provided for @deleteStaysAudit.
  ///
  /// In en, this message translates to:
  /// **'Records of trade decisions, kept as an audit trail and no longer linked to you'**
  String get deleteStaysAudit;

  /// No description provided for @deletePassword.
  ///
  /// In en, this message translates to:
  /// **'App password'**
  String get deletePassword;

  /// No description provided for @deletePasswordMissing.
  ///
  /// In en, this message translates to:
  /// **'Enter your app password to confirm it\'s you.'**
  String get deletePasswordMissing;

  /// No description provided for @deleteUnderstand.
  ///
  /// In en, this message translates to:
  /// **'I understand this can\'t be undone'**
  String get deleteUnderstand;

  /// No description provided for @deleteUnderstandMissing.
  ///
  /// In en, this message translates to:
  /// **'Tick this to continue.'**
  String get deleteUnderstandMissing;

  /// No description provided for @deleteSubmit.
  ///
  /// In en, this message translates to:
  /// **'Delete my account'**
  String get deleteSubmit;

  /// No description provided for @deleteFinalTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete your account now?'**
  String get deleteFinalTitle;

  /// No description provided for @deleteFinalBody.
  ///
  /// In en, this message translates to:
  /// **'Your account and everything listed is removed straight away.'**
  String get deleteFinalBody;

  /// No description provided for @deleteFinalConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete permanently'**
  String get deleteFinalConfirm;

  /// No description provided for @deleteThrottled.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Wait a few minutes before trying again.'**
  String get deleteThrottled;

  /// No description provided for @deletedTitle.
  ///
  /// In en, this message translates to:
  /// **'Your account has been deleted'**
  String get deletedTitle;

  /// No description provided for @deletedBody.
  ///
  /// In en, this message translates to:
  /// **'Everything this phone kept for you was removed too. Thank you for trying Agentfolio.'**
  String get deletedBody;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
