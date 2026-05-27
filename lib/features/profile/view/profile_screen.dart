import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vroom/core/dependencies/get_it.dart' as di;
import 'package:vroom/core/localization/app_localizations.dart';
import 'package:vroom/core/network/api_exception.dart';
import 'package:vroom/features/auth/view/bloc/auth_bloc.dart';
import 'package:vroom/features/participant/domain/repository/participant_repository.dart';
import 'package:vroom/features/profile/view/components/profile_content.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

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
                authenticated: (_) => FutureBuilder(
                  future: di.locator<ParticipantRepository>().getProfile(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      final error = snapshot.error;
                      final message = error is ApiException
                          ? error.message
                          : l10n.profileLoadFailed;
                      return Center(child: Text(message));
                    }

                    final profile = snapshot.data;
                    if (profile == null) {
                      return Center(child: Text(l10n.profileUnavailable));
                    }

                    return ProfileContent(user: profile);
                  },
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                orElse: () => Center(child: Text(l10n.genericError)),
              );
            },
          ),
        ),
      ),
    );
  }
}
