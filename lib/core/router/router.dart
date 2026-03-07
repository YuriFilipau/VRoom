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
      final currentPath = state.matchedLocation;

      final publicPaths = [
        AppRoutes.splash.path,
        AppRoutes.login.path,
        AppRoutes.register.path,
      ];

      if (authState is Initial || authState is Loading) {
        return null;
      }

      if (authState is Unauthenticated || authState is Error) {
        if (currentPath == AppRoutes.splash.path) {
          return AppRoutes.login.path;
        }
        if (publicPaths.contains(currentPath)) {
          return null;
        }
        return AppRoutes.login.path;
      }

      if (authState is Authenticated) {
        if (publicPaths.contains(currentPath)) {
          return AppRoutes.home.path;
        }
        return null;
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
                pageBuilder: (context, state) =>
                    NoTransitionPage(child: HomeScreen()),
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
