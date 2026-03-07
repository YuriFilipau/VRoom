import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vroom/core/router/router.dart';
import 'package:vroom/features/auth/view/bloc/auth_bloc.dart';

import 'dependencies/get_it.dart' as di;

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.locator<AuthBloc>(),
      child: Builder(
        builder: (context) {
          final authBloc = context.read<AuthBloc>();
          final appRouter = AppRouter(authBloc: authBloc);
          return MaterialApp.router(
            title: 'VRoom',
            routerConfig: appRouter.router,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
