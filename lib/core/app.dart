import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vroom/core/router/router.dart';
import 'package:vroom/core/theme/app_theme.dart';
import 'package:vroom/core/theme/bloc/theme_bloc.dart';
import 'package:vroom/features/auth/view/bloc/auth_bloc.dart';
import 'package:vroom/features/onboarding/domain/repository/onboarding_repository.dart';

import 'dependencies/get_it.dart' as di;

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<AuthBloc>()),
        BlocProvider(create: (_) => di.locator<ThemeBloc>()),
      ],
      child: Builder(
        builder: (context) {
          final authBloc = context.read<AuthBloc>();
          final appRouter = AppRouter(
            authBloc: authBloc,
            onboardingRepository: di.locator<OnboardingRepository>(),
          );

          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
              return MaterialApp.router(
                title: 'VRoom',
                routerConfig: appRouter.router,
                debugShowCheckedModeBanner: false,
                theme: AppTheme.light,
                darkTheme: AppTheme.dark,
                themeMode: themeState.themeMode,
              );
            },
          );
        },
      ),
    );
  }
}
