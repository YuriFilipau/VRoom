import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:vroom/core/localization/app_language.dart';
import 'package:vroom/core/localization/app_localizations.dart';
import 'package:vroom/core/localization/bloc/language_bloc.dart';
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
        BlocProvider(create: (_) => di.locator<LanguageBloc>()),
      ],
      child: Builder(
        builder: (context) {
          final authBloc = context.read<AuthBloc>();
          final languageBloc = context.read<LanguageBloc>();
          final appRouter = AppRouter(
            authBloc: authBloc,
            languageBloc: languageBloc,
            onboardingRepository: di.locator<OnboardingRepository>(),
          );

          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
              return BlocBuilder<LanguageBloc, LanguageState>(
                builder: (context, languageState) {
                  final language = languageState.effectiveLanguage;

                  return MaterialApp.router(
                    title: 'VRoom',
                    routerConfig: appRouter.router,
                    debugShowCheckedModeBanner: false,
                    theme: AppTheme.light,
                    darkTheme: AppTheme.dark,
                    themeMode: themeState.themeMode,
                    locale: language.locale,
                    supportedLocales: AppLanguage.values
                        .map((language) => language.locale)
                        .toList(growable: false),
                    localizationsDelegates: const [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
