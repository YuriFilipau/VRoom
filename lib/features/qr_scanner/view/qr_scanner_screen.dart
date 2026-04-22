import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:vroom/core/constants/app_colors.dart';
import 'package:vroom/core/constants/app_radii.dart';
import 'package:vroom/core/dependencies/get_it.dart' as di;
import 'package:vroom/core/router/app_routes.dart';
import 'package:vroom/features/qr_scanner/view/bloc/qr_scanner_bloc.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  late final MobileScannerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      formats: const [BarcodeFormat.qrCode],
      torchEnabled: false,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openAdminAr(BuildContext context) {
    context.push('${AppRoutes.ar.path}/demo-event?mode=admin');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkAppTheme = theme.brightness == Brightness.dark;
    final backgroundColor = isDarkAppTheme
        ? const Color(0xFFE7EAF2)
        : const Color(0xFF2A303B);
    final foregroundColor = isDarkAppTheme
        ? const Color(0xFF20242B)
        : Colors.white;
    final secondaryTextColor = isDarkAppTheme
        ? const Color(0xFF4A515F)
        : const Color(0xFFD4D8E0);
    final buttonColor = isDarkAppTheme
        ? const Color(0xFFD8DCE4)
        : const Color(0xFF3A414E);
    final iconButtonColor = isDarkAppTheme
        ? const Color(0xFFD3D7E0)
        : const Color(0xFF444B57);

    return BlocProvider(
      create: (_) => di.locator<QrScannerBloc>(),
      child: BlocConsumer<QrScannerBloc, QrScannerState>(
        listener: (context, state) {
          if (state.status == QrScannerStatus.success &&
              state.eventCode != null) {
            context.push('${AppRoutes.ar.path}/${state.eventCode}');
          }

          if (state.status == QrScannerStatus.failure &&
              state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
            context.read<QrScannerBloc>().add(const QrScannerReset());
          }
        },
        builder: (context, state) {
          final isBusy = state.status == QrScannerStatus.resolving;

          return Scaffold(
            backgroundColor: backgroundColor,
            body: SafeArea(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  MobileScanner(
                    controller: _controller,
                    onDetect: (capture) {
                      final value = capture.barcodes.first.rawValue;
                      if (value == null || value.isEmpty) {
                        return;
                      }
                      context.read<QrScannerBloc>().add(
                        QrScannerDetected(value),
                      );
                    },
                  ),
                  ColoredBox(color: backgroundColor.withValues(alpha: 0.88)),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 16,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            _RoundIconButton(
                              backgroundColor: iconButtonColor,
                              iconColor: foregroundColor,
                              onTap: () => context.pop(),
                              icon: Icons.arrow_back_rounded,
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  'Сканер QR-кода',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    color: foregroundColor,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 48),
                          ],
                        ),
                        const Spacer(),
                        const _ScannerFocusFrame(),
                        const SizedBox(height: 28),
                        Text(
                          'Наведите камеру на QR-код',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: secondaryTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 228,
                          height: 58,
                          child: FilledButton.icon(
                            onPressed: isBusy
                                ? null
                                : () => _openAdminAr(context),
                            style: FilledButton.styleFrom(
                              backgroundColor: buttonColor,
                              foregroundColor: foregroundColor,
                              disabledBackgroundColor: buttonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  AppRadii.lg,
                                ),
                                side: BorderSide(
                                  color: foregroundColor.withValues(
                                    alpha: 0.14,
                                  ),
                                ),
                              ),
                              textStyle: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            icon: isBusy
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : Icon(
                                    Icons.keyboard_alt_outlined,
                                    color: foregroundColor,
                                  ),
                            label: Text(
                              isBusy ? 'Обработка...' : 'Ввести код вручную',
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({
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

class _ScannerFocusFrame extends StatelessWidget {
  const _ScannerFocusFrame();

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
