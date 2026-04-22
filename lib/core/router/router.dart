import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vroom/core/shared/widgets/bottom_navigation.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_session_mode.dart';
import 'package:vroom/features/ar_session/view/ar_session_screen.dart';
import 'package:vroom/features/auth/view/bloc/auth_bloc.dart';
import 'package:vroom/features/auth/view/login.dart';
import 'package:vroom/features/auth/view/register.dart';
import 'package:vroom/features/home/view/home_screen.dart';
import 'package:vroom/features/onboarding/domain/repository/onboarding_repository.dart';
import 'package:vroom/features/onboarding/view/onboarding_screen.dart';
import 'package:vroom/features/profile/view/profile_screen.dart';
import 'package:vroom/features/qr_scanner/view/qr_scanner_screen.dart';

import 'app_routes.dart';

class AppRouter {
  final AuthBloc authBloc;
  final OnboardingRepository onboardingRepository;

  AppRouter({required this.authBloc, required this.onboardingRepository});

  GoRouter get router => GoRouter(
    initialLocation: AppRoutes.splash.path,
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: (context, state) {
      final authState = authBloc.state;
      final currentPath = state.matchedLocation;
      final shouldShowOnboarding = onboardingRepository.shouldShowOnboarding();
      final isOnboardingPath = currentPath == AppRoutes.onboarding.path;

      final publicPaths = [
        AppRoutes.splash.path,
        AppRoutes.onboarding.path,
        AppRoutes.login.path,
        AppRoutes.register.path,
      ];

      if (authState is Initial || authState is Loading) {
        return null;
      }

      if (authState is Authenticated) {
        if (publicPaths.contains(currentPath)) {
          return AppRoutes.home.path;
        }
        return null;
      }

      if (authState is Unauthenticated || authState is Error) {
        if (currentPath == AppRoutes.splash.path) {
          return shouldShowOnboarding
              ? AppRoutes.onboarding.path
              : AppRoutes.login.path;
        }
        if (shouldShowOnboarding && !isOnboardingPath) {
          return AppRoutes.onboarding.path;
        }
        if (!shouldShowOnboarding && isOnboardingPath) {
          return AppRoutes.login.path;
        }
        if (publicPaths.contains(currentPath)) {
          return null;
        }
        return AppRoutes.login.path;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash.path,
        builder: (context, state) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.onboarding.path,
        builder: (context, state) {
          return OnboardingScreen(onboardingRepository: onboardingRepository);
        },
      ),
      GoRoute(
        path: AppRoutes.login.path,
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.register.path,
        builder: (context, state) {
          return const RegisterScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.scanner.path,
        name: AppRoutes.scanner.name,
        builder: (context, state) {
          return const QrScannerScreen();
        },
      ),
      GoRoute(
        path: '${AppRoutes.ar.path}/:eventCode',
        name: AppRoutes.ar.name,
        builder: (context, state) {
          final mode = switch (state.uri.queryParameters['mode']) {
            'admin' => ArSessionMode.admin,
            _ => ArSessionMode.user,
          };

          return ArSessionScreen(
            eventCode: state.pathParameters['eventCode'] ?? 'demo-event',
            mode: mode,
          );
        },
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
  late final StreamSubscription _subscription;

  GoRouterRefreshStream(Stream stream) {
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
