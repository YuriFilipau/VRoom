import 'package:flutter/material.dart';

class ArMiniQuestionOption {
  const ArMiniQuestionOption({
    required this.label,
    required this.isCorrect,
    this.answerIndex,
  });

  final String label;
  final bool isCorrect;
  final int? answerIndex;
}

class ArInteractionSheet extends StatelessWidget {
  const ArInteractionSheet({
    required this.icon,
    required this.title,
    required this.body,
    required this.primaryLabel,
    required this.onPrimaryPressed,
    super.key,
  });

  final IconData icon;
  final String title;
  final String body;
  final String primaryLabel;
  final VoidCallback onPrimaryPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Color(0xFF141A24),
          borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Icon(icon, color: Colors.white),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                body,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.78),
                  fontSize: 16,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: onPrimaryPressed,
                child: Text(primaryLabel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ArMiniQuestionSheet extends StatelessWidget {
  const ArMiniQuestionSheet({
    required this.title,
    required this.question,
    required this.options,
    required this.onOptionSelected,
    super.key,
  });

  final String title;
  final String question;
  final List<ArMiniQuestionOption> options;
  final ValueChanged<ArMiniQuestionOption> onOptionSelected;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Color(0xFF141A24),
          borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Row(
                children: [
                  Icon(Icons.quiz_outlined, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    'Мини-вопрос',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                question,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.78),
                  fontSize: 16,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 16),
              for (final option in options) ...[
                OutlinedButton(
                  onPressed: () => onOptionSelected(option),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: BorderSide(
                      color: Colors.white.withValues(alpha: 0.22),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 14,
                    ),
                  ),
                  child: Text(option.label),
                ),
                const SizedBox(height: 8),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
