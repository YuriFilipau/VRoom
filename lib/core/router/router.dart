import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vroom/core/shared/widgets/bottom_navigation.dart';
import 'package:vroom/features/auth/view/bloc/auth_bloc.dart';
import 'package:vroom/features/auth/view/home.dart';
import 'package:vroom/features/auth/view/login.dart';
import 'package:vroom/features/auth/view/register.dart';

import 'app_routes.dart';

class AppRouter {
  final AuthBloc authBloc;

  AppRouter({required this.authBloc});

  GoRouter get router => GoRouter(
    initialLocation: AppRoutes.splash.path,
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: (context, state) {
      final authState = authBloc.state;
      final isGoingToLogin = state.matchedLocation == AppRoutes.login.path;
      final isGoingToSplash = state.matchedLocation == AppRoutes.splash.path;

      // Если состояние Initial - остаемся на splash (ждем загрузки)
      if (authState is Initial) {
        return null; // остаемся на splash
      }

      if (authState is Unauthenticated || authState is Error) {
        return isGoingToLogin ? null : AppRoutes.login.path;
      }

      if (authState is Authenticated) {
        return isGoingToSplash ? null : AppRoutes.home.path;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash.path,
        builder: (context, state) {
          return Scaffold(body: Center(child: Text('SPLASH')));
        },
      ),
      GoRoute(
        path: AppRoutes.login.path,
        builder: (context, state) {
          return LoginScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.register.path,
        builder: (context, state) {
          return RegisterScreen();
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
                pageBuilder: (context, state) => NoTransitionPage(
                  child: HomeScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.scanner.path,
                name: AppRoutes.scanner.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  child: Scaffold(body: Center(child: Text('scanner'))),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile.path,
                name: AppRoutes.profile.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  child: Scaffold(body: Center(child: Text('profile'))),
                ),
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
