import 'package:flutter/material.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_session_mode.dart';

class OriginHintCard extends StatelessWidget {
  const OriginHintCard({
    super.key,
    required this.mode,
    required this.isResolvingSceneAnchor,
    required this.hasPersistentAnchor,
  });

  final ArSessionMode mode;
  final bool isResolvingSceneAnchor;
  final bool hasPersistentAnchor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.38),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            const Icon(
              Icons.center_focus_strong_rounded,
              color: Colors.white,
              size: 22,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                isResolvingSceneAnchor
                    ? 'Ищу persistent anchor сцены. Медленно наведите камеру на QR-зону и окружение, где админ сохранял сцену.'
                    : mode == ArSessionMode.admin
                    ? 'Наведите камеру на реальный QR-код события и тапните по поверхности в его центре. Это создаст root anchor всей сцены.'
                    : hasPersistentAnchor
                    ? 'У сцены есть persistent anchor. Если объекты не появились, медленно осмотрите зону QR, пока relocalization не завершится.'
                    : 'У сцены пока нет persistent anchor. Сначала администратор должен сохранить сцену.',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  height: 1.35,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
