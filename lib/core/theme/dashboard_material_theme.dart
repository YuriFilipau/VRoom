import 'package:flutter/material.dart';

@immutable
class DashboardMaterialTheme extends ThemeExtension<DashboardMaterialTheme> {
  const DashboardMaterialTheme({
    required this.cardBackground,
    required this.cardBorder,
    required this.softSurface,
    required this.sectionTitle,
    required this.subtitleText,
    required this.progressTrack,
    required this.navBackground,
    required this.navBorder,
    required this.navIconActive,
    required this.navIconInactive,
    required this.navLabelInactive,
    required this.achievementActiveBackground,
    required this.achievementActiveBorder,
    required this.achievementInactiveBackground,
    required this.achievementInactiveBorder,
    required this.achievementInactiveText,
  });

  final Color cardBackground;
  final Color cardBorder;
  final Color softSurface;
  final Color sectionTitle;
  final Color subtitleText;
  final Color progressTrack;
  final Color navBackground;
  final Color navBorder;
  final Color navIconActive;
  final Color navIconInactive;
  final Color navLabelInactive;
  final Color achievementActiveBackground;
  final Color achievementActiveBorder;
  final Color achievementInactiveBackground;
  final Color achievementInactiveBorder;
  final Color achievementInactiveText;

  factory DashboardMaterialTheme.light() {
    return const DashboardMaterialTheme(
      cardBackground: Colors.white,
      cardBorder: Color(0xFFDDE2E8),
      softSurface: Color(0xFFE8EAED),
      sectionTitle: Color(0xFF5F6775),
      subtitleText: Color(0xFF788292),
      progressTrack: Color(0xFFE6EBF0),
      navBackground: Color(0xFFF7F8FA),
      navBorder: Color(0xFFDCE1E7),
      navIconActive: Color(0xFF2F9FE7),
      navIconInactive: Color(0xFFA3ACBA),
      navLabelInactive: Color(0xFF8D97A8),
      achievementActiveBackground: Color(0xFFEAF4FF),
      achievementActiveBorder: Color(0xFFBBD9F8),
      achievementInactiveBackground: Color(0xFFF6F8FA),
      achievementInactiveBorder: Color(0xFFE4E8EE),
      achievementInactiveText: Color(0xFF9AA3B2),
    );
  }

  factory DashboardMaterialTheme.dark() {
    return const DashboardMaterialTheme(
      cardBackground: Color(0xFF171C28),
      cardBorder: Color(0xFF2A3140),
      softSurface: Color(0xFF171C28),
      sectionTitle: Color(0xFF7F889B),
      subtitleText: Color(0xFF8D96A7),
      progressTrack: Color(0xFF2B3242),
      navBackground: Color(0xFF151A26),
      navBorder: Color(0xFF2A3140),
      navIconActive: Color(0xFF2F9FE7),
      navIconInactive: Color(0xFF717C90),
      navLabelInactive: Color(0xFF737E93),
      achievementActiveBackground: Color(0xFF131F38),
      achievementActiveBorder: Color(0xFF25416B),
      achievementInactiveBackground: Color(0xFF141923),
      achievementInactiveBorder: Color(0xFF1F2532),
      achievementInactiveText: Color(0xFF667086),
    );
  }

  @override
  DashboardMaterialTheme copyWith({
    Color? cardBackground,
    Color? cardBorder,
    Color? softSurface,
    Color? sectionTitle,
    Color? subtitleText,
    Color? progressTrack,
    Color? navBackground,
    Color? navBorder,
    Color? navIconActive,
    Color? navIconInactive,
    Color? navLabelInactive,
    Color? achievementActiveBackground,
    Color? achievementActiveBorder,
    Color? achievementInactiveBackground,
    Color? achievementInactiveBorder,
    Color? achievementInactiveText,
  }) {
    return DashboardMaterialTheme(
      cardBackground: cardBackground ?? this.cardBackground,
      cardBorder: cardBorder ?? this.cardBorder,
      softSurface: softSurface ?? this.softSurface,
      sectionTitle: sectionTitle ?? this.sectionTitle,
      subtitleText: subtitleText ?? this.subtitleText,
      progressTrack: progressTrack ?? this.progressTrack,
      navBackground: navBackground ?? this.navBackground,
      navBorder: navBorder ?? this.navBorder,
      navIconActive: navIconActive ?? this.navIconActive,
      navIconInactive: navIconInactive ?? this.navIconInactive,
      navLabelInactive: navLabelInactive ?? this.navLabelInactive,
      achievementActiveBackground:
          achievementActiveBackground ?? this.achievementActiveBackground,
      achievementActiveBorder:
          achievementActiveBorder ?? this.achievementActiveBorder,
      achievementInactiveBackground:
          achievementInactiveBackground ?? this.achievementInactiveBackground,
      achievementInactiveBorder:
          achievementInactiveBorder ?? this.achievementInactiveBorder,
      achievementInactiveText:
          achievementInactiveText ?? this.achievementInactiveText,
    );
  }

  @override
  DashboardMaterialTheme lerp(
    ThemeExtension<DashboardMaterialTheme>? other,
    double t,
  ) {
    if (other is! DashboardMaterialTheme) {
      return this;
    }

    return DashboardMaterialTheme(
      cardBackground:
          Color.lerp(cardBackground, other.cardBackground, t) ?? cardBackground,
      cardBorder: Color.lerp(cardBorder, other.cardBorder, t) ?? cardBorder,
      softSurface: Color.lerp(softSurface, other.softSurface, t) ?? softSurface,
      sectionTitle:
          Color.lerp(sectionTitle, other.sectionTitle, t) ?? sectionTitle,
      subtitleText:
          Color.lerp(subtitleText, other.subtitleText, t) ?? subtitleText,
      progressTrack:
          Color.lerp(progressTrack, other.progressTrack, t) ?? progressTrack,
      navBackground:
          Color.lerp(navBackground, other.navBackground, t) ?? navBackground,
      navBorder: Color.lerp(navBorder, other.navBorder, t) ?? navBorder,
      navIconActive:
          Color.lerp(navIconActive, other.navIconActive, t) ?? navIconActive,
      navIconInactive:
          Color.lerp(navIconInactive, other.navIconInactive, t) ?? navIconInactive,
      navLabelInactive:
          Color.lerp(navLabelInactive, other.navLabelInactive, t) ??
          navLabelInactive,
      achievementActiveBackground:
          Color.lerp(
            achievementActiveBackground,
            other.achievementActiveBackground,
            t,
          ) ??
          achievementActiveBackground,
      achievementActiveBorder:
          Color.lerp(achievementActiveBorder, other.achievementActiveBorder, t) ??
          achievementActiveBorder,
      achievementInactiveBackground:
          Color.lerp(
            achievementInactiveBackground,
            other.achievementInactiveBackground,
            t,
          ) ??
          achievementInactiveBackground,
      achievementInactiveBorder:
          Color.lerp(
            achievementInactiveBorder,
            other.achievementInactiveBorder,
            t,
          ) ??
          achievementInactiveBorder,
      achievementInactiveText:
          Color.lerp(achievementInactiveText, other.achievementInactiveText, t) ??
          achievementInactiveText,
    );
  }
}
