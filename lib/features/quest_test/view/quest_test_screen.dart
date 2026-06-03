import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vroom/core/constants/app_colors.dart';
import 'package:vroom/core/constants/app_radii.dart';
import 'package:vroom/core/dependencies/get_it.dart' as di;
import 'package:vroom/core/router/app_routes.dart';
import 'package:vroom/core/shared/widgets/app_gradient_button.dart';
import 'package:vroom/features/quest_test/domain/entities/quest_test_entity.dart';
import 'package:vroom/features/quest_test/view/bloc/quest_test_bloc.dart';

class QuestTestScreen extends StatelessWidget {
  const QuestTestScreen({required this.questId, this.eventId, super.key});

  final int questId;
  final int? eventId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          di.locator<QuestTestBloc>()
            ..add(QuestTestEvent.loadRequested(questId)),
      child: _QuestTestView(eventId: eventId),
    );
  }
}

class _QuestTestView extends StatelessWidget {
  const _QuestTestView({required this.eventId});

  final int? eventId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuestTestBloc, QuestTestState>(
      listener: (context, state) {
        if (state.status == QuestTestStatus.submitted) {
          final targetEventId = eventId;
          if (targetEventId != null && targetEventId > 0) {
            context.go('${AppRoutes.participantEvent.path}/$targetEventId');
          } else {
            context.go(AppRoutes.home.path);
          }
          return;
        }

        final message = state.message;
        if (message != null && message.isNotEmpty) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Тест квеста')),
          body: switch (state.status) {
            QuestTestStatus.loading || QuestTestStatus.initial => const Center(
              child: CircularProgressIndicator(),
            ),
            QuestTestStatus.failure => _FailureMessage(
              message: state.message ?? 'Тест для этого квеста недоступен.',
            ),
            _ => _TestContent(state: state),
          },
        );
      },
    );
  }
}

class _TestContent extends StatelessWidget {
  const _TestContent({required this.state});

  final QuestTestState state;

  @override
  Widget build(BuildContext context) {
    final test = state.test;
    if (test == null) {
      return const _FailureMessage(
        message: 'Тест для этого квеста недоступен.',
      );
    }

    final isSubmitting = state.status == QuestTestStatus.submitting;
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        Text(test.title, style: Theme.of(context).textTheme.titleLarge),
        if (test.description.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(test.description, style: Theme.of(context).textTheme.bodyMedium),
        ],
        const SizedBox(height: 14),
        _ResultBanner(
          result: state.latestResult,
          passingScore: test.passingScore,
        ),
        const SizedBox(height: 16),
        ...test.questions.map(
          (question) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: _QuestionCard(
              question: question,
              selectedOptions:
                  state.selectedAnswers[question.id] ?? const <int>[],
            ),
          ),
        ),
        const SizedBox(height: 8),
        AppGradientButton(
          label: isSubmitting ? 'Отправка...' : 'Завершить тест',
          isLoading: isSubmitting,
          onPressed: isSubmitting || !state.canSubmit
              ? null
              : () => context.read<QuestTestBloc>().add(
                  const QuestTestEvent.submitRequested(),
                ),
        ),
      ],
    );
  }
}

class _ResultBanner extends StatelessWidget {
  const _ResultBanner({required this.result, required this.passingScore});

  final QuestTestResultEntity? result;
  final int passingScore;

  @override
  Widget build(BuildContext context) {
    if (result == null) {
      return _InfoBox(
        text: 'Проходной результат: $passingScore баллов.',
        color: AppColors.primaryBlue,
      );
    }

    return _InfoBox(
      text: result!.isPassed
          ? 'Последний результат: ${result!.score}. Тест пройден.'
          : 'Последний результат: ${result!.score}. Можно попробовать улучшить результат.',
      color: result!.isPassed ? AppColors.success : AppColors.error,
    );
  }
}

class _QuestionCard extends StatelessWidget {
  const _QuestionCard({required this.question, required this.selectedOptions});

  final QuestTestQuestionEntity question;
  final List<int> selectedOptions;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.md),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(question.text, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 10),
            if (question.type == QuestTestQuestionType.multiple)
              ...question.options.map((option) {
                final selected = selectedOptions.contains(option.id);
                return CheckboxListTile(
                  value: selected,
                  contentPadding: EdgeInsets.zero,
                  title: Text(option.text),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (_) => _toggle(context, option.id),
                );
              })
            else
              ...question.options.map((option) {
                return RadioListTile<int>(
                  value: option.id,
                  groupValue: selectedOptions.firstOrNull,
                  contentPadding: EdgeInsets.zero,
                  title: Text(option.text),
                  onChanged: (optionId) {
                    if (optionId != null) {
                      _toggle(context, optionId);
                    }
                  },
                );
              }),
          ],
        ),
      ),
    );
  }

  void _toggle(BuildContext context, int optionId) {
    context.read<QuestTestBloc>().add(
      QuestTestEvent.optionToggled(questionId: question.id, optionId: optionId),
    );
  }
}

class _InfoBox extends StatelessWidget {
  const _InfoBox({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }
}

class _FailureMessage extends StatelessWidget {
  const _FailureMessage({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(message, textAlign: TextAlign.center),
      ),
    );
  }
}
