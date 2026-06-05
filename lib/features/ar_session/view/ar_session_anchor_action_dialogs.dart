part of 'ar_session_screen.dart';

extension _ArSessionAnchorActionDialogs on _ArSessionViewState {
  Future<void> _handleAnchorReachResult(
    ArAnchorReachResultEntity result,
  ) async {
    if (!mounted) {
      return;
    }

    final actionLabel = result.nextAction['label']?.toString();
    if (result.anchorRole == 'test_anchor') {
      final completed = result.progressCompleted;
      final total = result.progressTotal;
      final isProgressIncomplete =
          total != null && total > 0 && (completed ?? 0) < total;
      final canOpenTest = result.testUnlocked && !isProgressIncomplete;
      await showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text(
            canOpenTest
                ? 'Тест открыт'
                : isProgressIncomplete
                ? 'Ещё не все объекты собраны'
                : 'Точка теста',
          ),
          content: Text(
            canOpenTest
                ? 'Контрольная точка пройдена. Можно перейти к тесту.'
                : isProgressIncomplete
                ? 'Соберите все AR-объекты: найдено ${completed ?? 0}/$total. После этого тест откроется.'
                : 'Точка найдена, но тест пока недоступен. Проверьте, что квест открыт из актуального QR-кода.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Позже'),
            ),
            if (canOpenTest)
              FilledButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  final eventId = context.read<ArSessionBloc>().state.eventId;
                  final eventQuery = eventId > 0 ? '?eventId=$eventId' : '';
                  context.push(
                    '${AppRoutes.questTest.path}/${result.questId}/test$eventQuery',
                  );
                },
                child: Text(actionLabel ?? 'Начать тест'),
              ),
          ],
        ),
      );
      return;
    }

    if (result.anchorRole == 'finish_anchor') {
      await showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text(
            result.questCompleted
                ? actionLabel ?? 'Квест завершён'
                : 'Точка завершения',
          ),
          content: Text(
            result.questCompleted
                ? 'Контрольная точка завершения пройдена. Результат сохранён.'
                : 'Точка найдена, но квест не был завершён. Если в квесте есть тест, сначала пройдите его.',
          ),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                if (result.questCompleted && mounted && context.canPop()) {
                  context.pop();
                }
              },
              child: const Text('Готово'),
            ),
          ],
        ),
      );
      return;
    }

    final completed = result.progressCompleted;
    final total = result.progressTotal;
    final progress = completed == null || total == null
        ? ''
        : ' Прогресс: найдено $completed/$total.';
    _showMessage('${actionLabel ?? 'Действие зафиксировано.'}$progress');
  }
}
