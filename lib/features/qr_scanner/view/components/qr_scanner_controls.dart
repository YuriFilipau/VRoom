import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vroom/core/constants/app_colors.dart';

class QrRoundIconButton extends StatelessWidget {
  const QrRoundIconButton({
    super.key,
    required this.backgroundColor,
    required this.iconColor,
    required this.onTap,
    required this.icon,
  });

  final Color backgroundColor;
  final Color iconColor;
  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 48,
          height: 48,
          child: Icon(icon, color: iconColor),
        ),
      ),
    );
  }
}

class ScannerFocusFrame extends StatelessWidget {
  const ScannerFocusFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      height: 280,
      child: CustomPaint(
        painter: _ScannerFocusPainter(),
        child: Center(
          child: ClipOval(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Container(
                width: 118,
                height: 118,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primaryCyan.withValues(alpha: 0.16),
                  ),
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primaryBlue.withValues(alpha: 0.06),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ScannerFocusPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final softAccent = Paint()
      ..color = AppColors.primaryCyan.withValues(alpha: 0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final corner = Paint()
      ..shader = AppColors.primaryGradient.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final frameRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: 250,
        height: 190,
      ),
      const Radius.circular(26),
    );

    canvas.drawRRect(frameRect, softAccent);
    final circlePaint = Paint()
      ..color = AppColors.primaryBlue.withValues(alpha: 0.07)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 58, circlePaint);

    const length = 28.0;
    const radius = 10.0;
    final rect = frameRect.outerRect;
    final path = Path()
      ..moveTo(rect.left, rect.top + length)
      ..lineTo(rect.left, rect.top + radius)
      ..quadraticBezierTo(rect.left, rect.top, rect.left + radius, rect.top)
      ..lineTo(rect.left + length, rect.top)
      ..moveTo(rect.right - length, rect.top)
      ..lineTo(rect.right - radius, rect.top)
      ..quadraticBezierTo(rect.right, rect.top, rect.right, rect.top + radius)
      ..lineTo(rect.right, rect.top + length)
      ..moveTo(rect.left, rect.bottom - length)
      ..lineTo(rect.left, rect.bottom - radius)
      ..quadraticBezierTo(
        rect.left,
        rect.bottom,
        rect.left + radius,
        rect.bottom,
      )
      ..lineTo(rect.left + length, rect.bottom)
      ..moveTo(rect.right - length, rect.bottom)
      ..lineTo(rect.right - radius, rect.bottom)
      ..quadraticBezierTo(
        rect.right,
        rect.bottom,
        rect.right,
        rect.bottom - radius,
      )
      ..lineTo(rect.right, rect.bottom - length);

    canvas.drawPath(path, corner);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
