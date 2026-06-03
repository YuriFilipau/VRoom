import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vroom/core/localization/app_localizations.dart';
import 'package:vroom/features/auth/view/bloc/auth_bloc.dart';

class OrganizerLogoutButton extends StatelessWidget {
  const OrganizerLogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Tooltip(
      message: l10n.profileLogout,
      child: IconButton(
        onPressed: () {
          context.read<AuthBloc>().add(const AuthEvent.logout());
        },
        icon: const Icon(Icons.logout_rounded),
      ),
    );
  }
}
