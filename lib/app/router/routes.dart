/// Every route path, and the name each reports to telemetry as its screen.
abstract final class Routes {
  static const splash = '/splash';
  static const onboarding = '/welcome';
  static const login = '/login';

  /// Nested under Login: Back from setup always lands on Login.
  static const linkAccount = '/login/link';

  static const home = '/home';
  static const portfolio = '/portfolio';

  /// Portfolio opened on one of its views (`orders`), e.g. to check what
  /// became of an approval.
  static const portfolioViewParam = 'view';
  static const portfolioOrders = '/portfolio?view=orders';
  static const markets = '/markets';
  static const trade = '/trade';

  /// Editing the risk profile, full screen above the tabs. `extra` carries
  /// the saved profile, or null for a first one.
  static const tradeProfile = '/trade/profile';

  /// The what-if rebalancer: a simulation, never an order.
  static const rebalancer = '/rebalancer';
  static const agent = '/agent';

  /// The agent with a new conversation about one stock, ready to send.
  static const agentAboutParam = 'about';
  static String agentAbout(String symbol) =>
      Uri(path: agent, queryParameters: {agentAboutParam: symbol}).toString();

  /// The agent tab on one agent.
  static const agentTypeParam = 'agent';
  static String agentWith({required bool trading}) => Uri(
    path: agent,
    queryParameters: {agentTypeParam: trading ? 'trading' : 'finance'},
  ).toString();

  static const account = '/account';
  static const aiSettings = '/account/ai';
  static const deleteAccount = '/account/delete';

  /// One stock, full screen above the tabs. `:symbol` is the broker's
  /// trading symbol, URL-encoded (`M%26M-EQ`).
  static const stock = '/stock/:symbol';
  static String stockOf(String symbol) => '/stock/${Uri.encodeComponent(symbol)}';

  /// The metrics guide. `?focus=` scrolls to a metric or [learnScoringAnchor].
  static const learn = '/learn';
  static const learnFocusParam = 'focus';
  static const learnScoringAnchor = 'how-it-works';
  static String learnAt(String focus) =>
      Uri(path: learn, queryParameters: {learnFocusParam: focus}).toString();

  /// Reachable without signing in; a signed-in user is sent on to Home.
  static const Set<String> guestOnly = {onboarding, login, linkAccount};

  /// Query parameter carrying where the user was headed before sign-in.
  static const fromParam = 'from';
}

/// Where the router should send the user, or null to stay.
///
/// Pure, so every rule is unit-tested without building a router:
/// * nothing but the splash until launch work is done;
/// * then signed-in users go where they were headed (or Home), signed-out
///   users to Login, and first-timers to Onboarding;
/// * guest-only screens bounce signed-in users onward;
/// * everything else needs a session, and remembers where it was headed.
String? resolveRedirect({
  required Uri location,
  required bool startupReady,
  required bool signedIn,
  required bool onboardingSeen,
}) {
  final path = location.path;
  final from = _safeFrom(location.queryParameters[Routes.fromParam]);

  if (!startupReady) {
    if (path == Routes.splash) return null;
    // Keep a deep link so it survives the splash.
    final target = location.toString();
    return Uri(path: Routes.splash, queryParameters: {Routes.fromParam: target}).toString();
  }

  if (path == Routes.splash) {
    if (signedIn) return from ?? Routes.home;
    final guestDestination = onboardingSeen ? Routes.login : Routes.onboarding;
    return from == null
        ? guestDestination
        : Uri(path: Routes.login, queryParameters: {Routes.fromParam: from}).toString();
  }

  if (Routes.guestOnly.contains(path)) return signedIn ? (from ?? Routes.home) : null;

  if (!signedIn) {
    return Uri(
      path: Routes.login,
      queryParameters: {Routes.fromParam: location.toString()},
    ).toString();
  }
  return null;
}

/// Only in-app paths are honoured as a return destination. Anything else
/// (another scheme, a host, the splash itself) is dropped.
String? _safeFrom(String? from) {
  if (from == null || from.isEmpty) return null;
  final uri = Uri.tryParse(from);
  if (uri == null || uri.hasScheme || uri.hasAuthority || !from.startsWith('/')) return null;
  if (uri.path == Routes.splash || Routes.guestOnly.contains(uri.path)) return null;
  return from;
}
