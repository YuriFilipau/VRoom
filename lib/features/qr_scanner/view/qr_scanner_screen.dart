import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:vroom/core/constants/app_radii.dart';
import 'package:vroom/core/dependencies/get_it.dart' as di;
import 'package:vroom/core/localization/app_localizations.dart';
import 'package:vroom/core/router/app_routes.dart';
import 'package:vroom/features/auth/view/bloc/auth_bloc.dart';
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

  Future<void> _stopScanner() async {
    try {
      await _controller.stop();
    } catch (_) {
      // The native camera can already be stopping during navigation/dispose.
    }
  }

  Future<void> _resumeScanning(BuildContext context) async {
    if (!mounted) {
      return;
    }
    context.read<QrScannerBloc>().add(const QrScannerReset());
    try {
      await _controller.start();
    } catch (_) {
      // If the controller is not attached yet, MobileScanner will start itself.
    }
  }

  Future<void> _openManualEntry(BuildContext context) async {
    final bloc = context.read<QrScannerBloc>();
    final l10n = AppLocalizations.of(context);
    final value = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 24,
          ),
          title: Text(l10n.qrManualTitle),
          content: SizedBox(
            width: 420,
            child: TextField(
              controller: _manualCodeController,
              autofocus: true,
              minLines: 1,
              maxLines: 3,
              decoration: InputDecoration(hintText: l10n.qrManualHint),
            ),
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

    bloc.add(const QrScannerReset());
    bloc.add(QrScannerDetected(value));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final foregroundColor = Colors.white;
    final secondaryTextColor = Colors.white.withValues(alpha: 0.82);
    final buttonColor = Colors.black.withValues(alpha: 0.46);
    final iconButtonColor = Colors.black.withValues(alpha: 0.42);

    return BlocProvider(
      create: (_) => di.locator<QrScannerBloc>(),
      child: BlocConsumer<QrScannerBloc, QrScannerState>(
        listenWhen: (previous, current) {
          return previous.status != current.status ||
              previous.errorMessage != current.errorMessage ||
              previous.questId != current.questId ||
              previous.scanSessionId != current.scanSessionId;
        },
        listener: (context, state) {
          if (state.status == QrScannerStatus.success &&
              state.questId != null) {
            unawaited(_stopScanner());
            final sessionId = state.scanSessionId;
            final sessionQuery = sessionId == null
                ? ''
                : '?sessionId=${Uri.encodeComponent(sessionId)}';
            context.push('${AppRoutes.ar.path}/${state.questId}$sessionQuery');
          }

          if (state.status == QrScannerStatus.failure &&
              state.errorMessage != null) {
            unawaited(_stopScanner());
            final messenger = ScaffoldMessenger.of(context);
            messenger.hideCurrentSnackBar();
            if (state.authFailure) {
              messenger.showSnackBar(
                SnackBar(
                  content: Text(
                    '${state.errorMessage!} Возвращаем на экран входа...',
                  ),
                ),
              );
              Future.delayed(const Duration(seconds: 2), () {
                if (!mounted || !context.mounted) {
                  return;
                }
                context.read<AuthBloc>().add(const AuthEvent.logout());
                context.go(AppRoutes.login.path);
              });
              return;
            }
            messenger.showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                action: SnackBarAction(
                  label: l10n.qrScanAgain,
                  onPressed: () => unawaited(_resumeScanning(context)),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          final isBusy = state.status == QrScannerStatus.resolving;
          final hasScanError = state.status == QrScannerStatus.failure;

          return Scaffold(
            backgroundColor: Colors.black,
            body: Stack(
              fit: StackFit.expand,
              children: [
                MobileScanner(
                  controller: _controller,
                  onDetect: (capture) {
                    if (!mounted) {
                      return;
                    }
                    if (context.read<QrScannerBloc>().state.status !=
                        QrScannerStatus.idle) {
                      return;
                    }
                    final value = capture.barcodes.first.rawValue;
                    if (value == null || value.isEmpty) {
                      return;
                    }
                    context.read<QrScannerBloc>().add(QrScannerDetected(value));
                  },
                ),
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
                        if (hasScanError) ...[
                          const SizedBox(height: 14),
                          TextButton.icon(
                            onPressed: () =>
                                unawaited(_resumeScanning(context)),
                            style: TextButton.styleFrom(
                              foregroundColor: foregroundColor,
                              backgroundColor: buttonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  AppRadii.md,
                                ),
                              ),
                            ),
                            icon: const Icon(Icons.qr_code_scanner_rounded),
                            label: Text(l10n.qrScanAgain),
                          ),
                        ],
                        const Spacer(),
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            minWidth: 276,
                            maxWidth: 320,
                          ),
                          child: SizedBox(
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
                                isBusy
                                    ? l10n.qrProcessing
                                    : l10n.qrManualButton,
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.fade,
                              ),
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
