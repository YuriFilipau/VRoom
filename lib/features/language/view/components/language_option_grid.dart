import 'package:flutter/material.dart';
import 'package:vroom/core/localization/app_language.dart';
import 'package:vroom/features/language/view/components/language_option_card.dart';

class LanguageOptionGrid extends StatelessWidget {
  const LanguageOptionGrid({
    required this.selectedLanguage,
    required this.onLanguageSelected,
    this.padding = EdgeInsets.zero,
    this.physics,
    this.shrinkWrap = false,
    this.clipBehavior = Clip.none,
    super.key,
  });

  final AppLanguage selectedLanguage;
  final ValueChanged<AppLanguage> onLanguageSelected;
  final EdgeInsetsGeometry padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth >= 560 ? 3 : 2;

        return GridView.builder(
          padding: padding,
          physics: physics,
          shrinkWrap: shrinkWrap,
          clipBehavior: clipBehavior,
          itemCount: AppLanguage.values.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: 72,
          ),
          itemBuilder: (context, index) {
            final language = AppLanguage.values[index];

            return LanguageOptionCard(
              language: language,
              isSelected: language == selectedLanguage,
              onTap: () => onLanguageSelected(language),
            );
          },
        );
      },
    );
  }
}
