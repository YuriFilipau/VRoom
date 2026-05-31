import 'package:flutter/material.dart';
import 'package:vroom/core/constants/app_sizes.dart';
import 'package:vroom/core/dependencies/get_it.dart' as di;
import 'package:vroom/core/localization/app_localizations.dart';
import 'package:vroom/core/network/api_exception.dart';
import 'package:vroom/core/shared/widgets/app_gradient_button.dart';
import 'package:vroom/features/participant/domain/entities/participant_profile_entity.dart';
import 'package:vroom/features/participant/domain/repository/participant_repository.dart';

Future<ParticipantProfileEntity?> showChangePasswordSheet(
  BuildContext context,
) {
  return showModalBottomSheet<ParticipantProfileEntity>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    useSafeArea: true,
    builder: (_) => const _ProfilePasswordSheet(),
  );
}

class _ProfilePasswordSheet extends StatefulWidget {
  const _ProfilePasswordSheet();

  @override
  State<_ProfilePasswordSheet> createState() => _ProfilePasswordSheetState();
}

class _ProfilePasswordSheetState extends State<_ProfilePasswordSheet> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isSaving = false;
  String? _error;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final mediaQuery = MediaQuery.of(context);
    final bottomInset = mediaQuery.viewInsets.bottom;
    final bottomPadding = bottomInset > 0
        ? bottomInset + AppSizes.spacing20
        : mediaQuery.padding.bottom + AppSizes.spacing32;

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 18, 20, bottomPadding),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.profileChangePassword,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSizes.spacing16),
            TextField(
              controller: _currentPasswordController,
              enabled: !_isSaving,
              obscureText: true,
              decoration: InputDecoration(
                labelText: l10n.profileCurrentPassword,
              ),
            ),
            const SizedBox(height: AppSizes.spacing12),
            TextField(
              controller: _newPasswordController,
              enabled: !_isSaving,
              obscureText: true,
              decoration: InputDecoration(labelText: l10n.profileNewPassword),
            ),
            const SizedBox(height: AppSizes.spacing12),
            TextField(
              controller: _confirmPasswordController,
              enabled: !_isSaving,
              obscureText: true,
              decoration: InputDecoration(
                labelText: l10n.profileConfirmPassword,
              ),
            ),
            if (_error != null) ...[
              const SizedBox(height: AppSizes.spacing12),
              Text(
                _error!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
            const SizedBox(height: AppSizes.spacing20),
            AppGradientButton(
              label: l10n.profileSave,
              isLoading: _isSaving,
              onPressed: _isSaving ? null : _save,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    if (_newPasswordController.text != _confirmPasswordController.text) {
      setState(() {
        _error = l10n.profilePasswordMismatch;
      });
      return;
    }

    setState(() {
      _isSaving = true;
      _error = null;
    });

    try {
      final updated = await di.locator<ParticipantRepository>().changePassword(
        currentPassword: _currentPasswordController.text,
        newPassword: _newPasswordController.text,
      );
      if (mounted) {
        Navigator.of(context).pop(updated);
      }
    } on ApiException catch (error) {
      if (mounted) {
        setState(() {
          _error = error.message;
          _isSaving = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _error = l10n.genericError;
          _isSaving = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
