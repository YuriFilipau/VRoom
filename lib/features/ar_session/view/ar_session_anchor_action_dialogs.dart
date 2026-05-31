part of 'ar_session_screen.dart';

extension _ArSessionAnchorActionDialogs on _ArSessionViewState {
  Future<void> _handleAnchorReachResult(
    ArAnchorReachResultEntity result,
  ) async {
    if (!mounted) {
      return;
    }

    final actionLabel = result.nextAction['label']?.toString();
    if (result.anchorRole == 'test_anchor' && result.testUnlocked) {
      await showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Тест открыт'),
          content: const Text(
            'Контрольная точка пройдена. Теперь можно перейти к тесту.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Позже'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                context.push(
                  '${AppRoutes.questTest.path}/${result.questId}/test',
                );
              },
              child: Text(actionLabel ?? 'Начать тест'),
            ),
          ],
        ),
      );
      return;
    }

    if (result.anchorRole == 'finish_anchor' && result.questCompleted) {
      await showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text(actionLabel ?? 'Квест завершён'),
          content: const Text('Контрольная точка завершения пройдена.'),
          actions: [
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Готово'),
            ),
          ],
        ),
      );
    }
  }
}
