import 'package:flutter/material.dart';
import 'package:vroom/core/constants/app_radii.dart';
import 'package:vroom/features/ar_session/view/bloc/ar_session_bloc.dart';
import 'package:vroom/features/ar_session/view/components/ar_placement_helpers.dart';
import 'package:vroom/features/ar_session/view/components/finish_anchor_button.dart';

class ArSettingsSceneStatus extends StatelessWidget {
  const ArSettingsSceneStatus({
    required this.state,
    required this.hasSceneRootAnchor,
    required this.isResolvingSceneAnchor,
    super.key,
  });

  final ArSessionState state;
  final bool hasSceneRootAnchor;
  final bool isResolvingSceneAnchor;

  @override
  Widget build(BuildContext context) {
    final value = hasSceneRootAnchor
        ? 'Anchor активен, объектов: ${state.placements.length}'
        : isResolvingSceneAnchor
        ? 'Идёт поиск точки сцены'
        : 'Начальная точка сцены не готова';

    return ArSettingsPanel(
      child: Row(
        children: [
          const Icon(Icons.view_in_ar_rounded),
          const SizedBox(width: 12),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class ArSettingsAnchorsSection extends StatelessWidget {
  const ArSettingsAnchorsSection({
    required this.state,
    required this.supportsAr,
    required this.hasSceneRootAnchor,
    required this.onResetSceneAnchor,
    required this.onPlaceTestAnchor,
    required this.onPlaceFinishAnchor,
    super.key,
  });

  final ArSessionState state;
  final bool supportsAr;
  final bool hasSceneRootAnchor;
  final VoidCallback onResetSceneAnchor;
  final VoidCallback onPlaceTestAnchor;
  final VoidCallback onPlaceFinishAnchor;

  @override
  Widget build(BuildContext context) {
    final finishAnchor = state.placements
        .where((item) => item.isFinishAnchor)
        .firstOrNull;
    final hasFinishAnchor =
        finishAnchor != null &&
        !arPlacementHasDefaultActionTransform(finishAnchor);

    return ArSettingsSection(
      title: 'Anchor-ы',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OutlinedButton.icon(
            onPressed: supportsAr ? onResetSceneAnchor : null,
            icon: const Icon(Icons.center_focus_strong_outlined),
            label: Text(
              hasSceneRootAnchor
                  ? 'Повторить поиск точки сцены'
                  : 'Создать начальную точку',
            ),
          ),
          if (state.hasTest) ...[
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: supportsAr && hasSceneRootAnchor
                  ? () {
                      Navigator.of(context).pop();
                      onPlaceTestAnchor();
                    }
                  : null,
              icon: const Icon(Icons.fact_check_outlined),
              label: const Text('Поставить точку начала теста'),
            ),
          ] else ...[
            const SizedBox(height: 10),
            FinishAnchorButton(
              hasFinishAnchor: hasFinishAnchor,
              enabled: supportsAr && hasSceneRootAnchor,
              onPlaceRequested: () {
                Navigator.of(context).pop();
                onPlaceFinishAnchor();
              },
            ),
          ],
        ],
      ),
    );
  }
}

class ArSettingsSection extends StatelessWidget {
  const ArSettingsSection({
    required this.title,
    required this.child,
    super.key,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}

class ArSettingsPanel extends StatelessWidget {
  const ArSettingsPanel({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.md),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Padding(padding: const EdgeInsets.all(12), child: child),
    );
  }
}
