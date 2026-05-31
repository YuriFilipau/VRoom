import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vroom/core/localization/bloc/language_bloc.dart';
import 'package:vroom/core/router/app_routes.dart';
import 'package:vroom/core/shared/widgets/app_splash_screen.dart';
import 'package:vroom/core/shared/widgets/bottom_navigation.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_session_mode.dart';
import 'package:vroom/features/ar_session/view/ar_session_screen.dart';
import 'package:vroom/features/auth/view/bloc/auth_bloc.dart';
import 'package:vroom/features/auth/view/login.dart';
import 'package:vroom/features/auth/view/register.dart';
import 'package:vroom/features/home/view/home_screen.dart';
import 'package:vroom/features/onboarding/domain/repository/onboarding_repository.dart';
import 'package:vroom/features/onboarding/view/onboarding_screen.dart';
import 'package:vroom/features/organizer/view/organizer_events_screen.dart';
import 'package:vroom/features/organizer/view/organizer_quests_screen.dart';
import 'package:vroom/features/participant/view/participant_event_details_screen.dart';
import 'package:vroom/features/profile/view/profile_screen.dart';
import 'package:vroom/features/quest_test/view/quest_test_screen.dart';
import 'package:vroom/features/qr_scanner/view/qr_scanner_screen.dart';

class AppRouter {
  final AuthBloc authBloc;
  final LanguageBloc languageBloc;
  final OnboardingRepository onboardingRepository;

  AppRouter({
    required this.authBloc,
    required this.languageBloc,
    required this.onboardingRepository,
  });

  late final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash.path,
    refreshListenable: GoRouterRefreshStream([
      authBloc.stream,
      languageBloc.stream,
    ]),
    redirect: (context, state) {
      final authState = authBloc.state;
      final languageState = languageBloc.state;
      final currentPath = state.matchedLocation;
      final shouldShowOnboarding = onboardingRepository.shouldShowOnboarding();
      final isOnboardingPath = currentPath == AppRoutes.onboarding.path;

      final publicPaths = <String>{
        AppRoutes.splash.path,
        AppRoutes.onboarding.path,
        AppRoutes.login.path,
        AppRoutes.register.path,
      };

      if (authState is Initial || authState is Loading) {
        return null;
      }

      if (authState is Unauthenticated || authState is Error) {
        if (currentPath == AppRoutes.splash.path) {
          return shouldShowOnboarding || !languageState.hasSelectedLanguage
              ? AppRoutes.onboarding.path
              : AppRoutes.login.path;
        }
        if ((shouldShowOnboarding || !languageState.hasSelectedLanguage) &&
            !isOnboardingPath) {
          return AppRoutes.onboarding.path;
        }
        if (!shouldShowOnboarding &&
            languageState.hasSelectedLanguage &&
            isOnboardingPath) {
          return AppRoutes.login.path;
        }
        return publicPaths.contains(currentPath) ? null : AppRoutes.login.path;
      }

      if (authState is Authenticated) {
        final user = authState.user;
        final isOrganizerRoute = currentPath.startsWith(
          AppRoutes.organizerEvents.path,
        );
        final isParticipantShellRoute =
            currentPath == AppRoutes.home.path ||
            currentPath == AppRoutes.profile.path ||
            currentPath == AppRoutes.scanner.path ||
            currentPath.startsWith(AppRoutes.questTest.path) ||
            currentPath.startsWith('${AppRoutes.participantEvent.path}/');

        if (publicPaths.contains(currentPath) ||
            currentPath == AppRoutes.splash.path) {
          return user.isStaff
              ? AppRoutes.organizerEvents.path
              : AppRoutes.home.path;
        }

        if (user.isStaff) {
          if (isParticipantShellRoute) {
            return AppRoutes.organizerEvents.path;
          }
          return null;
        }

        if (isOrganizerRoute) {
          return AppRoutes.home.path;
        }
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash.path,
        builder: (context, state) => const AppSplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding.path,
        builder: (context, state) =>
            OnboardingScreen(onboardingRepository: onboardingRepository),
      ),
      GoRoute(
        path: AppRoutes.login.path,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register.path,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.scanner.path,
        name: AppRoutes.scanner.name,
        builder: (context, state) => const QrScannerScreen(),
      ),
      GoRoute(
        path: '${AppRoutes.ar.path}/:questId',
        name: AppRoutes.ar.name,
        builder: (context, state) {
          final questId =
              int.tryParse(state.pathParameters['questId'] ?? '') ?? 0;
          final mode = switch (state.uri.queryParameters['mode']) {
            'admin' => ArSessionMode.admin,
            _ => ArSessionMode.user,
          };
          final scanSessionId = state.uri.queryParameters['sessionId'];

          return ArSessionScreen(
            questId: questId,
            mode: mode,
            scanSessionId: scanSessionId,
          );
        },
      ),
      GoRoute(
        path: '${AppRoutes.questTest.path}/:questId/test',
        name: AppRoutes.questTest.name,
        builder: (context, state) {
          final questId =
              int.tryParse(state.pathParameters['questId'] ?? '') ?? 0;
          return QuestTestScreen(questId: questId);
        },
      ),
      GoRoute(
        path: AppRoutes.organizerEvents.path,
        name: AppRoutes.organizerEvents.name,
        builder: (context, state) => const OrganizerEventsScreen(),
        routes: [
          GoRoute(
            path: ':eventId/quests',
            name: AppRoutes.organizerQuests.name,
            builder: (context, state) {
              final eventId =
                  int.tryParse(state.pathParameters['eventId'] ?? '') ?? 0;
              return OrganizerQuestsScreen(eventId: eventId);
            },
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) =>
            BottomNavigationScaffold(shell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home.path,
                name: AppRoutes.home.name,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: HomeScreen()),
              ),
              GoRoute(
                path: '${AppRoutes.participantEvent.path}/:eventId',
                name: AppRoutes.participantEvent.name,
                builder: (context, state) {
                  final eventId =
                      int.tryParse(state.pathParameters['eventId'] ?? '') ?? 0;
                  return ParticipantEventDetailsScreen(eventId: eventId);
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile.path,
                name: AppRoutes.profile.name,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: ProfileScreen()),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  late final List<StreamSubscription<dynamic>> _subscriptions;

  GoRouterRefreshStream(List<Stream<dynamic>> streams) {
    _subscriptions = streams
        .map(
          (stream) =>
              stream.asBroadcastStream().listen((_) => notifyListeners()),
        )
        .toList(growable: false);
  }

  @override
  void dispose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    super.dispose();
  }
}
