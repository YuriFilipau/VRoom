import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vroom/core/constants/app_colors.dart';
import 'package:vroom/core/constants/app_radii.dart';
import 'package:vroom/core/localization/app_language.dart';
import 'package:vroom/core/localization/app_localizations.dart';
import 'package:vroom/core/localization/bloc/language_bloc.dart';
import 'package:vroom/core/theme/dashboard_material_theme.dart';
import 'package:vroom/features/language/view/components/language_option_grid.dart';

Future<void> showLanguagePickerSheet(BuildContext context) {
  final languageBloc = context.read<LanguageBloc>();

  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) {
      return BlocProvider.value(
        value: languageBloc,
        child: const _LanguagePickerSheet(),
      );
    },
  );
}

class _LanguagePickerSheet extends StatelessWidget {
  const _LanguagePickerSheet();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final dashboardTheme = Theme.of(
      context,
    ).extension<DashboardMaterialTheme>()!;

    return SafeArea(
      top: false,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: dashboardTheme.navBackground,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppRadii.lg),
          ),
          border: Border(top: BorderSide(color: dashboardTheme.navBorder)),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              16,
              10,
              16,
              16 + MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 42,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.textMuted.withValues(alpha: 0.55),
                      borderRadius: BorderRadius.circular(AppRadii.pill),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  l10n.profileLanguagePickerTitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 16),
                BlocBuilder<LanguageBloc, LanguageState>(
                  builder: (context, state) {
                    return LanguageOptionGrid(
                      selectedLanguage: state.effectiveLanguage,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      onLanguageSelected: (language) {
                        _selectLanguage(context, language);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _selectLanguage(BuildContext context, AppLanguage language) {
    context.read<LanguageBloc>().add(LanguageEvent.selected(language));
    Navigator.of(context).pop();
  }
}
