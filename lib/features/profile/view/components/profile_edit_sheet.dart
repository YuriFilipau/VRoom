import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vroom/core/constants/app_colors.dart';
import 'package:vroom/core/constants/app_radii.dart';
import 'package:vroom/core/constants/app_sizes.dart';
import 'package:vroom/core/dependencies/get_it.dart' as di;
import 'package:vroom/core/localization/app_localizations.dart';
import 'package:vroom/core/network/api_exception.dart';
import 'package:vroom/core/shared/widgets/app_gradient_button.dart';
import 'package:vroom/features/participant/domain/entities/participant_profile_entity.dart';
import 'package:vroom/features/participant/domain/repository/participant_repository.dart';

Future<ParticipantProfileEntity?> showEditProfileSheet(
  BuildContext context,
  ParticipantProfileEntity user,
) {
  return showModalBottomSheet<ParticipantProfileEntity>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    useSafeArea: true,
    builder: (_) => _ProfileEditSheet(user: user),
  );
}

class _ProfileEditSheet extends StatefulWidget {
  const _ProfileEditSheet({required this.user});

  final ParticipantProfileEntity user;

  @override
  State<_ProfileEditSheet> createState() => _ProfileEditSheetState();
}

class _ProfileEditSheetState extends State<_ProfileEditSheet> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _schoolController;
  late final TextEditingController _schoolClassController;
  final _imagePicker = ImagePicker();
  XFile? _avatarFile;
  bool _isSaving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    final user = widget.user;
    _firstNameController = TextEditingController(text: user.firstName);
    _lastNameController = TextEditingController(text: user.lastName);
    _schoolController = TextEditingController(text: user.school ?? '');
    _schoolClassController = TextEditingController(
      text: _initialClassValue(user),
    );
  }

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
              l10n.profileEdit,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSizes.spacing16),
            InputDecorator(
              decoration: InputDecoration(labelText: l10n.profileLogin),
              child: Text(widget.user.login),
            ),
            const SizedBox(height: AppSizes.spacing12),
            TextField(
              controller: _firstNameController,
              enabled: !_isSaving,
              decoration: InputDecoration(labelText: l10n.firstName),
            ),
            const SizedBox(height: AppSizes.spacing12),
            TextField(
              controller: _lastNameController,
              enabled: !_isSaving,
              decoration: InputDecoration(labelText: l10n.lastName),
            ),
            const SizedBox(height: AppSizes.spacing12),
            TextField(
              controller: _schoolController,
              enabled: !_isSaving,
              decoration: InputDecoration(labelText: l10n.school),
            ),
            const SizedBox(height: AppSizes.spacing12),
            TextField(
              controller: _schoolClassController,
              enabled: !_isSaving,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(labelText: l10n.schoolClass),
            ),
            const SizedBox(height: AppSizes.spacing12),
            _AvatarPicker(
              avatarUrl: widget.user.avatarUrl,
              selectedFile: _avatarFile,
              initials: _initials(widget.user),
              title: l10n.profileAvatarPhoto,
              buttonLabel: l10n.profileChooseAvatar,
              onPick: _isSaving ? null : _pickAvatar,
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
    setState(() {
      _isSaving = true;
      _error = null;
    });

    try {
      final avatar = _avatarFile == null
          ? null
          : await MultipartFile.fromFile(
              _avatarFile!.path,
              filename: _avatarFile!.name,
            );
      final updated = await di.locator<ParticipantRepository>().updateProfile(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        school: _schoolController.text,
        schoolClass: _schoolClassController.text.toUpperCase(),
        avatar: avatar,
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
          _error = AppLocalizations.of(context).genericError;
          _isSaving = false;
        });
      }
    }
  }

  Future<void> _pickAvatar() async {
    try {
      final file = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 88,
      );
      if (file == null || !mounted) {
        return;
      }

      setState(() {
        _avatarFile = file;
        _error = null;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _error = AppLocalizations.of(context).genericError;
      });
    }
  }

  String _initials(ParticipantProfileEntity user) {
    final first = user.firstName.isEmpty ? '' : user.firstName[0];
    final last = user.lastName.isEmpty ? '' : user.lastName[0];
    return (first + last).toUpperCase();
  }

  String _initialClassValue(ParticipantProfileEntity user) {
    if (user.schoolClass?.isNotEmpty ?? false) {
      return user.schoolClass!;
    }
    return [
      if (user.schoolClassNumber != null) '${user.schoolClassNumber}',
      if (user.schoolClassLetter != null) user.schoolClassLetter!,
    ].join();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _schoolController.dispose();
    _schoolClassController.dispose();
    super.dispose();
  }
}

class _AvatarPicker extends StatelessWidget {
  const _AvatarPicker({
    required this.avatarUrl,
    required this.selectedFile,
    required this.initials,
    required this.title,
    required this.buttonLabel,
    required this.onPick,
  });

  final String? avatarUrl;
  final XFile? selectedFile;
  final String initials;
  final String title;
  final String buttonLabel;
  final VoidCallback? onPick;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.sm),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.spacing12),
        child: Row(
          children: [
            ClipOval(
              child: SizedBox(
                width: 64,
                height: 64,
                child: _AvatarPreview(
                  avatarUrl: avatarUrl,
                  selectedFile: selectedFile,
                  initials: initials,
                ),
              ),
            ),
            const SizedBox(width: AppSizes.spacing12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: AppSizes.spacing8),
                  OutlinedButton.icon(
                    onPressed: onPick,
                    icon: const Icon(Icons.photo_library_outlined, size: 20),
                    label: Text(buttonLabel, maxLines: 1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AvatarPreview extends StatelessWidget {
  const _AvatarPreview({
    required this.avatarUrl,
    required this.selectedFile,
    required this.initials,
  });

  final String? avatarUrl;
  final XFile? selectedFile;
  final String initials;

  @override
  Widget build(BuildContext context) {
    final file = selectedFile;
    if (file != null) {
      return Image.file(File(file.path), fit: BoxFit.cover);
    }

    final url = avatarUrl?.trim();
    if (url != null && url.isNotEmpty) {
      return Image.network(
        url,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => _InitialsAvatar(initials: initials),
      );
    }

    return _InitialsAvatar(initials: initials);
  }
}

class _InitialsAvatar extends StatelessWidget {
  const _InitialsAvatar({required this.initials});

  final String initials;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
      child: Center(
        child: Text(
          initials,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
