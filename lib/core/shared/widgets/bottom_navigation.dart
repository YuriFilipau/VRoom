import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vroom/core/constants/app_colors.dart';
import 'package:vroom/core/theme/dashboard_material_theme.dart';

class BottomNavigationScaffold extends StatelessWidget {
  const BottomNavigationScaffold({super.key, required this.shell});

  final StatefulNavigationShell shell;

  void _onTap(int index) {
    shell.goBranch(index, initialLocation: index == shell.currentIndex);
  }

  void _onQRScan(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Сканер QR-кода открыт'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dashboardTheme = Theme.of(
      context,
    ).extension<DashboardMaterialTheme>()!;

    return Scaffold(
      body: shell,
      bottomNavigationBar: ColoredBox(
        color: dashboardTheme.navBackground,
        child: SafeArea(
          top: false,
          left: false,
          right: false,
          minimum: EdgeInsets.zero,
          child: SizedBox(
            height: 80,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: dashboardTheme.navBackground,
                      border: Border(
                        top: BorderSide(color: dashboardTheme.navBorder),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: _NavItem(
                            icon: Icons.home_outlined,
                            selectedIcon: Icons.home,
                            label: 'Главная',
                            selected: shell.currentIndex == 0,
                            onTap: () => _onTap(0),
                          ),
                        ),
                        const SizedBox(width: 88),
                        Expanded(
                          child: _NavItem(
                            icon: Icons.person_outline,
                            selectedIcon: Icons.person,
                            label: 'Профиль',
                            selected: shell.currentIndex == 1,
                            onTap: () => _onTap(1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: -28,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: GestureDetector(
                      onTap: () => _onQRScan(context),
                      child: Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: AppColors.primaryGradient,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryBlue.withValues(
                                alpha: 0.35,
                              ),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                          border: Border.all(
                            color: dashboardTheme.navBackground,
                            width: 5,
                          ),
                        ),
                        child: const Icon(
                          Icons.qr_code_scanner,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dashboardTheme = Theme.of(
      context,
    ).extension<DashboardMaterialTheme>()!;

    return InkWell(
      onTap: onTap,
      child: SizedBox.expand(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                selected ? selectedIcon : icon,
                color: selected
                    ? dashboardTheme.navIconActive
                    : dashboardTheme.navIconInactive,
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: selected
                      ? dashboardTheme.navIconActive
                      : dashboardTheme.navLabelInactive,
                  fontSize: 12,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
