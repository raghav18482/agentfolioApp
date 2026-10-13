import 'package:agentfolio/app/di/injector.dart';
import 'package:agentfolio/app/router/routes.dart';
import 'package:agentfolio/app/shell/adaptive_shell.dart';
import 'package:agentfolio/app/shell/branch_switcher.dart';
import 'package:agentfolio/app/shell/coming_soon_screen.dart';
import 'package:agentfolio/app/splash/app_startup.dart';
import 'package:agentfolio/app/splash/splash_screen.dart';
import 'package:agentfolio/core/presentation/theme/app_motion.dart';
import 'package:agentfolio/core/storage/prefs.dart';
import 'package:agentfolio/core/telemetry/telemetry.dart';
import 'package:agentfolio/core/telemetry/telemetry_route_observer.dart';
import 'package:agentfolio/features/agent/domain/entities/agent.dart';
import 'package:agentfolio/features/agent/presentation/screens/agent_screen.dart';
import 'package:agentfolio/features/agent/presentation/view_models/agent_chat_view_model.dart';
import 'package:agentfolio/features/ai/presentation/screens/ai_settings_screen.dart';
import 'package:agentfolio/features/ai/presentation/view_models/ai_insights_view_model.dart';
import 'package:agentfolio/features/ai/presentation/view_models/ask_view_model.dart';
import 'package:agentfolio/features/ai/presentation/widgets/ask_sheet.dart';
import 'package:agentfolio/features/auth/presentation/providers/session_provider.dart';
import 'package:agentfolio/features/auth/presentation/screens/link_account_screen.dart';
import 'package:agentfolio/features/auth/presentation/screens/login_screen.dart';
import 'package:agentfolio/features/auth/presentation/view_models/link_account_view_model.dart';
import 'package:agentfolio/features/auth/presentation/view_models/login_view_model.dart';
import 'package:agentfolio/features/learn/presentation/screens/learn_screen.dart';
import 'package:agentfolio/features/learn/presentation/view_models/learn_view_model.dart';
import 'package:agentfolio/features/markets/presentation/screens/markets_screen.dart';
import 'package:agentfolio/features/markets/presentation/view_models/markets_view_model.dart';
import 'package:agentfolio/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:agentfolio/features/portfolio/presentation/screens/home_screen.dart';
import 'package:agentfolio/features/portfolio/presentation/screens/portfolio_screen.dart';
import 'package:agentfolio/features/portfolio/presentation/view_models/home_view_model.dart';
import 'package:agentfolio/features/portfolio/presentation/view_models/portfolio_view_model.dart';
import 'package:agentfolio/features/settings/presentation/screens/account_screen.dart';
import 'package:agentfolio/features/settings/presentation/screens/delete_account_screen.dart';
import 'package:agentfolio/features/settings/presentation/view_models/delete_account_view_model.dart';
import 'package:agentfolio/features/stock_detail/presentation/screens/stock_detail_screen.dart';
import 'package:agentfolio/features/stock_detail/presentation/view_models/stock_detail_view_model.dart';
import 'package:agentfolio/features/trading/domain/entities/trading.dart';
import 'package:agentfolio/features/trading/presentation/screens/rebalancer_screen.dart';
import 'package:agentfolio/features/trading/presentation/screens/risk_profile_screen.dart';
import 'package:agentfolio/features/trading/presentation/screens/trade_screen.dart';
import 'package:agentfolio/features/trading/presentation/view_models/live_watch_view_model.dart';
import 'package:agentfolio/features/trading/presentation/view_models/premium_view_model.dart';
import 'package:agentfolio/features/trading/presentation/view_models/rebalancer_view_model.dart';
import 'package:agentfolio/features/trading/presentation/view_models/risk_profile_view_model.dart';
import 'package:agentfolio/features/trading/presentation/view_models/trade_view_model.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

/// Builds the app's router. Re-evaluates redirects whenever launch progress
/// or the session changes, so signing out anywhere lands on Login, and a
/// session expiring mid-visit does too.
GoRouter buildRouter({
  required AppStartup startup,
  required SessionProvider session,
  required Prefs prefs,
  required Telemetry telemetry,
}) {
  final rootKey = GlobalKey<NavigatorState>(debugLabel: 'root');

  return GoRouter(
    navigatorKey: rootKey,
    initialLocation: Routes.splash,
    refreshListenable: Listenable.merge([startup, session]),
    observers: [TelemetryRouteObserver(telemetry)],
    redirect: (context, state) => resolveRedirect(
      location: state.uri,
      startupReady: startup.isReady,
      signedIn: session.isSignedIn,
      onboardingSeen: prefs.onboardingSeen,
    ),
    routes: [
      GoRoute(
        path: Routes.splash,
        name: 'splash',
        pageBuilder: (context, state) => _fadeThrough(state, const SplashScreen()),
      ),
      GoRoute(
        path: Routes.onboarding,
        name: 'onboarding',
        pageBuilder: (context, state) => _fadeThrough(state, const OnboardingScreen()),
      ),
      GoRoute(
        path: Routes.login,
        name: 'login',
        pageBuilder: (context, state) => _fadeThrough(
          state,
          ChangeNotifierProvider(create: (_) => sl<LoginViewModel>(), child: const LoginScreen()),
        ),
        routes: [
          GoRoute(
            path: 'link',
            name: 'link_account',
            builder: (context, state) => ChangeNotifierProvider(
              create: (_) => sl<LinkAccountViewModel>(),
              child: const LinkAccountScreen(),
            ),
          ),
        ],
      ),
      GoRoute(
        path: Routes.account,
        name: 'account',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const AccountScreen(),
        routes: [
          GoRoute(
            path: 'ai',
            name: 'ai_settings',
            builder: (context, state) => const AiSettingsScreen(),
          ),
          GoRoute(
            path: 'delete',
            name: 'delete_account',
            builder: (context, state) => ChangeNotifierProvider(
              create: (_) => DeleteAccountViewModel(session: sl(), telemetry: sl()),
              child: const DeleteAccountScreen(),
            ),
          ),
        ],
      ),
      // Above the shell: a focused, full-screen read, with the platform's own
      // push and swipe-back. Back lands on the tab, scrolled where it was.
      GoRoute(
        path: Routes.stock,
        name: 'stock_detail',
        parentNavigatorKey: rootKey,
        builder: (context, state) {
          final symbol = state.pathParameters['symbol']!;
          return ChangeNotifierProvider(
            // Keyed by symbol: a different stock is a different screen.
            key: ValueKey(symbol),
            create: (_) => sl<StockDetailViewModel>(param1: symbol),
            child: const StockDetailScreen(),
          );
        },
      ),
      GoRoute(
        path: Routes.tradeProfile,
        name: 'risk_profile',
        parentNavigatorKey: rootKey,
        builder: (context, state) => ChangeNotifierProvider(
          create: (_) => sl<RiskProfileViewModel>(param1: state.extra as RiskProfile?),
          child: const RiskProfileScreen(),
        ),
      ),
      GoRoute(
        path: Routes.rebalancer,
        name: 'rebalancer',
        parentNavigatorKey: rootKey,
        builder: (context, state) => ChangeNotifierProvider(
          create: (_) => sl<RebalancerViewModel>(),
          child: const RebalancerScreen(),
        ),
      ),
      GoRoute(
        path: Routes.learn,
        name: 'learn',
        parentNavigatorKey: rootKey,
        builder: (context, state) => ChangeNotifierProvider(
          create: (_) => sl<LearnViewModel>(),
          child: LearnScreen(focus: state.uri.queryParameters[Routes.learnFocusParam]),
        ),
      ),
      StatefulShellRoute(
        pageBuilder: (context, state, shell) => _fadeThrough(state, shell),
        navigatorContainerBuilder: (context, shell, children) => AdaptiveShell(
          navigationShell: shell,
          body: BranchSwitcher(currentIndex: shell.currentIndex, children: children),
        ),
        branches: [
          for (final (tab, path) in [
            (shellTabs[0], Routes.home),
            (shellTabs[1], Routes.portfolio),
            (shellTabs[2], Routes.markets),
            (shellTabs[3], Routes.trade),
            (shellTabs[4], Routes.agent),
          ])
            _tab(path, tab, telemetry),
        ],
      ),
    ],
  );
}

/// A tab's own navigator. Screens pushed inside a tab keep the bottom bar.
StatefulShellBranch _tab(String path, ShellTab tab, Telemetry telemetry) => StatefulShellBranch(
  observers: [TelemetryRouteObserver(telemetry)],
  routes: [
    GoRoute(
      path: path,
      name: tab.id,
      builder: (context, state) => switch (tab.id) {
        'home' => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => sl<HomeViewModel>()),
            ChangeNotifierProvider(create: (_) => sl<AiInsightsViewModel>()),
            Provider<AskViewModelFactory>.value(value: sl.call<AskViewModel>),
          ],
          child: const HomeScreen(),
        ),
        'portfolio' => ChangeNotifierProvider(
          create: (_) => sl<PortfolioViewModel>(),
          child: PortfolioScreen(showView: state.uri.queryParameters[Routes.portfolioViewParam]),
        ),
        'markets' => ChangeNotifierProvider(
          create: (_) => sl<MarketsViewModel>(),
          child: const MarketsScreen(),
        ),
        'trade' => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => sl<TradeViewModel>()),
            ChangeNotifierProvider(create: (_) => sl<LiveWatchViewModel>()),
            ChangeNotifierProvider(create: (_) => sl<PremiumViewModel>()),
          ],
          child: const TradeScreen(),
        ),
        'agent' => AgentScreen(
          create: (type) => sl<AgentChatViewModel>(param1: type),
          aboutSymbol: state.uri.queryParameters[Routes.agentAboutParam],
          showAgent: switch (state.uri.queryParameters[Routes.agentTypeParam]) {
            'trading' => AgentType.trading,
            'finance' => AgentType.finance,
            _ => null,
          },
        ),
        _ => ComingSoonScreen(tab: tab),
      },
    ),
  ],
);

/// Material's fade-through: the outgoing screen fades out, then the incoming
/// one fades and scales in. Used between unrelated top-level screens.
CustomTransitionPage<void> _fadeThrough(GoRouterState state, Widget child) =>
    CustomTransitionPage<void>(
      key: state.pageKey,
      name: state.name,
      child: child,
      transitionDuration: AppMotion.long,
      transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeThroughTransition(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        child: child,
      ),
    );
