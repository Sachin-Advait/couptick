import 'package:couptick/common/utils/global_keys.dart';
import 'package:couptick/screens/campaign_detail_screen.dart';
import 'package:couptick/screens/claim_form_screen.dart';
import 'package:couptick/screens/claim_submitted_screen.dart';
import 'package:couptick/screens/dashboard/dashboard.dart';
import 'package:couptick/screens/game_detail_screen.dart';
import 'package:couptick/screens/game_play_screen.dart';
import 'package:couptick/screens/games/brick_breaker_screen.dart';
import 'package:couptick/screens/games/dino_run_screen.dart';
import 'package:couptick/screens/games/flutter_2048_screen.dart';
import 'package:couptick/screens/games/snake_game_screen.dart';
import 'package:couptick/screens/games/sokoban_screen.dart';
import 'package:couptick/screens/games/super_dash_screen.dart';
import 'package:couptick/screens/games/tetris_screen.dart';
import 'package:couptick/screens/games_hub_screen.dart';
import 'package:couptick/screens/home_screen.dart';
import 'package:couptick/screens/leaderboard_screen.dart';
import 'package:couptick/screens/login_screen.dart';
import 'package:couptick/screens/my_wins_screen.dart';
import 'package:couptick/screens/processing_tickets_screen.dart';
import 'package:couptick/screens/product_screen.dart';
import 'package:couptick/screens/profile_screen.dart';
import 'package:couptick/screens/profile_setup_screen.dart';
import 'package:couptick/screens/register_screen.dart';
import 'package:couptick/screens/splash/bloc/splash_bloc.dart';
import 'package:couptick/screens/splash/view/splash_view.dart';
import 'package:couptick/screens/ticket_awarded_screen.dart';
import 'package:couptick/screens/ticket_wallet_screen.dart';
import 'package:couptick/screens/transactions_screen.dart';
import 'package:couptick/screens/winners_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part 'app_routes.dart';

// ==================== CONFIGURE TRANSITION HERE ====================
class PageTransitionConfig {
  static const Duration transitionDuration = Duration(milliseconds: 250);
  static const Curve transitionCurve = Curves.easeInOut;
  static const Offset slideBeginOffset = Offset(0.08, 0.0);
}

Page<dynamic> buildPageWithTransition({
  required Widget child,
  required LocalKey key,
}) {
  return CustomTransitionPage(
    key: key,
    child: child,
    transitionDuration: PageTransitionConfig.transitionDuration,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position:
              Tween<Offset>(
                begin: PageTransitionConfig.slideBeginOffset,
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: PageTransitionConfig.transitionCurve,
                ),
              ),
          child: child,
        ),
      );
    },
  );
}

/// ─────────────────────────────────────────
/// APP ROUTER
/// ─────────────────────────────────────────

class Pages {
  static GoRouter get appRouter => _router;

  static final GoRouter _router = GoRouter(
    initialLocation: Routes.splash,
    navigatorKey: GlobalKeys.navigatorKey,
    routes: [
      /// ─────────────────────────
      /// AUTH
      /// ─────────────────────────
      GoRoute(
        path: Routes.splash,
        name: Routes.splash,
        pageBuilder: (context, state) => buildPageWithTransition(
          key: state.pageKey,
          child: BlocProvider(
            create: (context) => SplashBloc()..add(NavigateToNextEvent()),
            child: const SplashView(),
          ),
        ),
      ),

      GoRoute(
        path: Routes.login,
        name: Routes.login,
        pageBuilder: (context, state) => buildPageWithTransition(
          key: state.pageKey,
          child: const LoginScreen(),
        ),
      ),

      GoRoute(
        path: Routes.register,
        name: Routes.register,
        pageBuilder: (context, state) => buildPageWithTransition(
          key: state.pageKey,
          child: const RegisterScreen(),
        ),
      ),

      GoRoute(
        path: Routes.profileSetup,
        name: Routes.profileSetup,
        pageBuilder: (context, state) => buildPageWithTransition(
          key: state.pageKey,
          child: const ProfileSetupScreen(),
        ),
      ),

      /// ─────────────────────────
      /// SHELL ROUTES
      /// ─────────────────────────
      ShellRoute(
        builder: (context, state, child) {
          return Dashboard(child: child);
        },

        routes: [
          /// HOME
          GoRoute(
            path: Routes.home,
            name: Routes.home,
            pageBuilder: (context, state) => buildPageWithTransition(
              key: state.pageKey,
              child: const HomeScreen(),
            ),
          ),

          /// PRODUCTS
          GoRoute(
            path: Routes.products,
            name: Routes.products,
            pageBuilder: (context, state) => buildPageWithTransition(
              key: state.pageKey,
              child: const ProductsScreen(),
            ),
          ),

          /// GAMES HUB
          GoRoute(
            path: Routes.gamesHub,
            name: Routes.gamesHub,
            pageBuilder: (context, state) => buildPageWithTransition(
              key: state.pageKey,
              child: const GamesHubScreen(),
            ),
          ),

          /// WALLET
          GoRoute(
            path: Routes.ticketWallet,
            name: Routes.ticketWallet,
            pageBuilder: (context, state) => buildPageWithTransition(
              key: state.pageKey,
              child: const TicketWalletScreen(),
            ),
          ),

          /// PROFILE
          GoRoute(
            path: Routes.profile,
            name: Routes.profile,
            pageBuilder: (context, state) => buildPageWithTransition(
              key: state.pageKey,
              child: const ProfileScreen(),
            ),
          ),

          /// WINNERS
          GoRoute(
            path: Routes.winners,
            name: Routes.winners,
            pageBuilder: (context, state) => buildPageWithTransition(
              key: state.pageKey,
              child: const WinnersScreen(),
            ),
          ),

          /// CAMPAIGN DETAIL
          GoRoute(
            path: Routes.campaignDetail,
            name: Routes.campaignDetail,
            pageBuilder: (context, state) => buildPageWithTransition(
              key: state.pageKey,
              child: const CampaignDetailScreen(),
            ),
          ),

          /// GAME PLAY
          GoRoute(
            path: Routes.gamePlay,
            name: Routes.gamePlay,
            pageBuilder: (context, state) => buildPageWithTransition(
              key: state.pageKey,
              child: const GamePlayScreen(),
            ),
          ),

          /// GAME DETAIL
          GoRoute(
            path: Routes.gameDetail,
            name: Routes.gameDetail,
            pageBuilder: (context, state) => buildPageWithTransition(
              key: state.pageKey,
              child: GameDetailScreen(
                gameTitle:
                    (state.extra as Map<String, dynamic>?)?['title'] ?? 'Game',
              ),
            ),
          ),

          /// LEADERBOARD
          GoRoute(
            path: Routes.leaderboard,
            name: Routes.leaderboard,
            pageBuilder: (context, state) => buildPageWithTransition(
              key: state.pageKey,
              child: const LeaderboardScreen(),
            ),
          ),

          /// GAMES
          GoRoute(
            path: Routes.gameSnake,
            name: Routes.gameSnake,
            pageBuilder: (context, state) => buildPageWithTransition(
              key: state.pageKey,
              child: const SnakeGameScreen(),
            ),
          ),

          GoRoute(
            path: Routes.game2048,
            name: Routes.game2048,
            pageBuilder: (context, state) => buildPageWithTransition(
              key: state.pageKey,
              child: const Flutter2048Screen(),
            ),
          ),

          GoRoute(
            path: Routes.gameDino,
            name: Routes.gameDino,
            pageBuilder: (context, state) => buildPageWithTransition(
              key: state.pageKey,
              child: const DinoRunScreen(),
            ),
          ),

          GoRoute(
            path: Routes.gameTetris,
            name: Routes.gameTetris,
            pageBuilder: (context, state) => buildPageWithTransition(
              key: state.pageKey,
              child: const TetrisScreen(),
            ),
          ),

          GoRoute(
            path: Routes.gameBrick,
            name: Routes.gameBrick,
            pageBuilder: (context, state) => buildPageWithTransition(
              key: state.pageKey,
              child: const BrickBreakerScreen(),
            ),
          ),

          GoRoute(
            path: Routes.gameDash,
            name: Routes.gameDash,
            pageBuilder: (context, state) => buildPageWithTransition(
              key: state.pageKey,
              child: const SuperDashScreen(),
            ),
          ),

          GoRoute(
            path: Routes.gameSokoban,
            name: Routes.gameSokoban,
            pageBuilder: (context, state) => buildPageWithTransition(
              key: state.pageKey,
              child: const SokobanScreen(),
            ),
          ),

          /// TICKETS
          GoRoute(
            path: Routes.ticketsAwarded,
            name: Routes.ticketsAwarded,
            pageBuilder: (context, state) => buildPageWithTransition(
              key: state.pageKey,
              child: const TicketsAwardedScreen(),
            ),
          ),

          GoRoute(
            path: Routes.processingTickets,
            name: Routes.processingTickets,
            pageBuilder: (context, state) => buildPageWithTransition(
              key: state.pageKey,
              child: const ProcessingTicketsScreen(),
            ),
          ),

          GoRoute(
            path: Routes.myWins,
            name: Routes.myWins,
            pageBuilder: (context, state) => buildPageWithTransition(
              key: state.pageKey,
              child: const MyWinsScreen(),
            ),
          ),

          /// CLAIM FORM
          GoRoute(
            path: Routes.claimForm,
            name: Routes.claimForm,
            pageBuilder: (context, state) => buildPageWithTransition(
              key: state.pageKey,
              child: ClaimFormScreen(
                prize:
                    (state.extra as Map<String, dynamic>?)?['prize'] ?? 'Prize',

                value: (state.extra as Map<String, dynamic>?)?['value'] ?? '₹0',
              ),
            ),
          ),

          /// CLAIM SUBMITTED
          GoRoute(
            path: Routes.claimSubmitted,
            name: Routes.claimSubmitted,
            pageBuilder: (context, state) => buildPageWithTransition(
              key: state.pageKey,
              child: ClaimSubmittedScreen(
                prize:
                    (state.extra as Map<String, dynamic>?)?['prize'] ?? 'Prize',

                value: (state.extra as Map<String, dynamic>?)?['value'] ?? '₹0',

                referenceId:
                    (state.extra as Map<String, dynamic>?)?['referenceId'] ??
                    'CLM-${DateTime.now().millisecondsSinceEpoch}',
              ),
            ),
          ),

          /// TRANSACTIONS
          GoRoute(
            path: Routes.transactions,
            name: Routes.transactions,
            pageBuilder: (context, state) => buildPageWithTransition(
              key: state.pageKey,
              child: const TransactionsScreen(),
            ),
          ),
        ],
      ),
    ],
  );
}
