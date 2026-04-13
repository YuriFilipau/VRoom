import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vroom/features/auth/view/bloc/auth_bloc.dart';
import 'package:vroom/features/home/view/components/home_content.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          unauthenticated: () => context.go('/login'),
          orElse: () {},
        );
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return state.maybeWhen(
                authenticated: (user) => HomeContent(user: user),
                loading: () => const Center(child: CircularProgressIndicator()),
                orElse: () => const Center(child: Text('Что-то пошло не так')),
              );
            },
          ),
        ),
      ),
    );
  }
}
