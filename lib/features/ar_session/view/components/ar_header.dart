import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vroom/features/ar_session/view/components/ar_session_ui_bits.dart';

class ArHeader extends StatelessWidget {
  const ArHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.planeCount,
    required this.hasSceneRootAnchor,
  });

  final String title;
  final String subtitle;
  final int planeCount;
  final bool hasSceneRootAnchor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GlassIconButton(
          onTap: () => context.pop(),
          icon: Icons.arrow_back_rounded,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.72),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    hasSceneRootAnchor
                        ? 'Persistent anchor сцены активен. Найдено плоскостей: $planeCount'
                        : planeCount > 0
                        ? 'Найдено плоскостей: $planeCount. Ищу корневой anchor сцены.'
                        : 'Сканируйте окружение вокруг QR до успешной привязки',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.62),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
