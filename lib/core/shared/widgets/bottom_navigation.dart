import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationScaffold extends StatelessWidget {
  final StatefulNavigationShell shell;

  const BottomNavigationScaffold({super.key, required this.shell});

  void _onTap(int index) =>
      shell.goBranch(index, initialLocation: index == shell.currentIndex);

  void _onQRScan(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Сканер QR-кода открыт'),
        backgroundColor: Color(0xFF00D2D3),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1E1F2E),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SafeArea(
          top: false,
          right: false,
          left: false,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1E1F2E),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(
                    icon: Icons.explore_outlined,
                    selectedIcon: Icons.explore,
                    index: 0,
                    label: 'Квесты',
                  ),

                  GestureDetector(
                    onTap: () => _onQRScan(context),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF6C5CE7), Color(0xFF00D2D3)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF00D2D3).withOpacity(0.5),
                            blurRadius: 15,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.qr_code_scanner,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),

                  _buildNavItem(
                    icon: Icons.person_outline,
                    selectedIcon: Icons.person,
                    index: 1,
                    label: 'Профиль',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required IconData selectedIcon,
    required int index,
    required String label,
  }) {
    final isSelected = shell.currentIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => _onTap(index),
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSelected ? selectedIcon : icon,
                color: isSelected
                    ? const Color(0xFF00D2D3) // secondary color
                    : const Color(0xFFB2B3C9), // textSecondary color
                size: 28,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isSelected
                      ? const Color(0xFF00D2D3)
                      : const Color(0xFFB2B3C9),
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
              if (isSelected)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  width: 4,
                  height: 4,
                  decoration: const BoxDecoration(
                    color: Color(0xFF00D2D3),
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}