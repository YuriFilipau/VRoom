import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vroom/core/dependencies/get_it.dart' as di;
import 'package:vroom/core/localization/app_localizations.dart';
import 'package:vroom/core/network/api_exception.dart';
import 'package:vroom/core/shared/widgets/auth_failure_redirect.dart';
import 'package:vroom/features/auth/view/bloc/auth_bloc.dart';
import 'package:vroom/features/participant/domain/entities/participant_profile_entity.dart';
import 'package:vroom/features/participant/domain/repository/participant_repository.dart';
import 'package:vroom/features/profile/view/components/profile_content.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<ParticipantProfileEntity> _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = _loadProfile();
  }

  Future<ParticipantProfileEntity> _loadProfile() {
    return di.locator<ParticipantRepository>().getProfile();
  }

  void _setProfile(ParticipantProfileEntity profile) {
    setState(() {
      _profileFuture = Future.value(profile);
    });
  }

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
                  future: _profileFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      final error = snapshot.error;
                      final message = error is ApiException
                          ? error.message
                          : l10n.profileLoadFailed;
                      if (error is ApiException && error.statusCode == 401) {
                        return AuthFailureRedirect(message: message);
                      }
                      return Center(child: Text(message));
                    }

                    final profile = snapshot.data;
                    if (profile == null) {
                      return Center(child: Text(l10n.profileUnavailable));
                    }

                    return ProfileContent(
                      user: profile,
                      onProfileChanged: _setProfile,
                    );
                  },
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                unauthenticated: () => const SizedBox.shrink(),
                orElse: () => Center(child: Text(l10n.genericError)),
              );
            },
          ),
        ),
      ),
    );
  }
}
