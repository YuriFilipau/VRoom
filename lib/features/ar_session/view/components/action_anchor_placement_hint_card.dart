import 'package:flutter/material.dart';

class ActionAnchorPlacementHintCard extends StatelessWidget {
  const ActionAnchorPlacementHintCard({
    required this.role,
    required this.onCancel,
    super.key,
  });

  final String role;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final isTestAnchor = role == 'test_anchor';

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.58),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
        child: Row(
          children: [
            Icon(
              isTestAnchor
                  ? Icons.fact_check_outlined
                  : Icons.flag_circle_outlined,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                isTestAnchor
                    ? 'Тапните по поверхности, где должна быть точка начала теста.'
                    : 'Тапните по поверхности, где должна быть точка окончания квеста.',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  height: 1.25,
                ),
              ),
            ),
            IconButton(
              tooltip: 'Отмена',
              onPressed: onCancel,
              icon: const Icon(Icons.close_rounded),
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
