import 'package:flutter/material.dart';
import 'package:vroom/core/constants/app_colors.dart';
import 'package:vroom/core/dependencies/get_it.dart' as di;
import 'package:vroom/core/network/api_exception.dart';
import 'package:vroom/features/home/view/components/quest_card.dart';
import 'package:vroom/features/participant/domain/repository/participant_repository.dart';

class ParticipantEventDetailsScreen extends StatelessWidget {
  const ParticipantEventDetailsScreen({super.key, required this.eventId});

  final int eventId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Мероприятие')),
      body: FutureBuilder(
        future: di.locator<ParticipantRepository>().getEventDetail(eventId),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            final error = snapshot.error;
            final message = error is ApiException
                ? error.message
                : 'Не удалось загрузить мероприятие';
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(message, textAlign: TextAlign.center),
              ),
            );
          }

          final event = snapshot.data;
          if (event == null) {
            return const Center(child: Text('Мероприятие не найдено'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                QuestCard(
                  title: event.title,
                  imageUrl: event.imageUrl,
                  progressPercent: event.progressPercent,
                ),
                const SizedBox(height: 16),
                Text(
                  event.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _InfoChip(
                      label: event.certificateAvailable
                          ? 'Сертификат доступен'
                          : 'Сертификат еще недоступен',
                    ),
                    const SizedBox(width: 8),
                    _InfoChip(label: 'Квестов: ${event.scannedQuests.length}'),
                  ],
                ),
                const SizedBox(height: 22),
                Text(
                  'СКАНИРОВАННЫЕ КВЕСТЫ',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(letterSpacing: 0.7),
                ),
                const SizedBox(height: 12),
                if (event.scannedQuests.isEmpty)
                  Text(
                    'В этом мероприятии пока нет отсканированных квестов.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ...event.scannedQuests.map(
                  (quest) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.white12),
                      ),
                      child: ListTile(
                        title: Text(quest.title),
                        subtitle: Text(quest.statusLabel),
                        trailing: Text(
                          '${quest.progressPercent}%',
                          style: const TextStyle(
                            color: AppColors.primaryBlue,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
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

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(label),
    );
  }
}
