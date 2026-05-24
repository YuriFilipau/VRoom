import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vroom/core/dependencies/get_it.dart' as di;
import 'package:vroom/core/network/api_exception.dart';
import 'package:vroom/core/router/app_routes.dart';
import 'package:vroom/features/auth/view/bloc/auth_bloc.dart';
import 'package:vroom/features/home/view/components/home_content.dart';
import 'package:vroom/features/participant/domain/repository/participant_repository.dart';

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
                authenticated: (user) => FutureBuilder(
                  future: di.locator<ParticipantRepository>().getMyEvents(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      final error = snapshot.error;
                      final message = error is ApiException
                          ? error.message
                          : 'Не удалось загрузить мероприятия';
                      return Center(child: Text(message));
                    }

                    return HomeContent(
                      user: user,
                      events: snapshot.data ?? const [],
                      onEventTap: (event) => context.push(
                        '${AppRoutes.participantEvent.path}/${event.id}',
                      ),
                    );
                  },
                ),
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
