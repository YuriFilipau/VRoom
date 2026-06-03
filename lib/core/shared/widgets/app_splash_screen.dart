import 'package:flutter/material.dart';
import 'package:vroom/core/constants/app_colors.dart';

class AppSplashScreen extends StatelessWidget {
  const AppSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF070B14), Color(0xFF071716), Color(0xFF070B14)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(child: _AppSplashLogo()),
      ),
    );
  }
}

class _AppSplashLogo extends StatelessWidget {
  const _AppSplashLogo();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ShaderMask(
          shaderCallback: AppColors.primaryGradient.createShader,
          child: const Text(
            'A',
            style: TextStyle(
              color: Colors.white,
              fontSize: 72,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'ARient',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: AppColors.textPrimary,
            fontSize: 30,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
