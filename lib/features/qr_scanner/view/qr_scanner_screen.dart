import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:vroom/core/constants/app_radii.dart';
import 'package:vroom/core/dependencies/get_it.dart' as di;
import 'package:vroom/core/localization/app_localizations.dart';
import 'package:vroom/core/router/app_routes.dart';
import 'package:vroom/features/qr_scanner/view/bloc/qr_scanner_bloc.dart';
import 'package:vroom/features/qr_scanner/view/components/qr_scanner_controls.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  late final MobileScannerController _controller;
  final TextEditingController _manualCodeController = TextEditingController();

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
    _manualCodeController.dispose();
    super.dispose();
  }

  Future<void> _openManualEntry(BuildContext context) async {
    final bloc = context.read<QrScannerBloc>();
    final l10n = AppLocalizations.of(context);
    final value = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(l10n.qrManualTitle),
          content: TextField(
            controller: _manualCodeController,
            autofocus: true,
            decoration: InputDecoration(hintText: l10n.qrManualHint),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(l10n.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.of(
                dialogContext,
              ).pop(_manualCodeController.text.trim()),
              child: Text(l10n.open),
            ),
          ],
        );
      },
    );

    _manualCodeController.clear();
    if (!mounted || value == null || value.isEmpty) {
      return;
    }

    bloc.add(QrScannerDetected(value));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
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
              state.questId != null) {
            context.push('${AppRoutes.ar.path}/${state.questId}');
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
            body: Stack(
              fit: StackFit.expand,
              children: [
                MobileScanner(
                  controller: _controller,
                  onDetect: (capture) {
                    final value = capture.barcodes.first.rawValue;
                    if (value == null || value.isEmpty) {
                      return;
                    }
                    context.read<QrScannerBloc>().add(QrScannerDetected(value));
                  },
                ),
                ColoredBox(color: backgroundColor.withValues(alpha: 0.88)),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 16,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            QrRoundIconButton(
                              backgroundColor: iconButtonColor,
                              iconColor: foregroundColor,
                              onTap: () => context.pop(),
                              icon: Icons.arrow_back_rounded,
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  l10n.qrScannerTitle,
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
                        const ScannerFocusFrame(),
                        const SizedBox(height: 28),
                        Text(
                          l10n.qrScannerHint,
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
                                : () => _openManualEntry(context),
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
                              isBusy ? l10n.qrProcessing : l10n.qrManualButton,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
