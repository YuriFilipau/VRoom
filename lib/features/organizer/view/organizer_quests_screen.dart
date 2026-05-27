import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vroom/core/dependencies/get_it.dart' as di;
import 'package:vroom/core/network/api_exception.dart';
import 'package:vroom/core/router/app_routes.dart';
import 'package:vroom/features/organizer/domain/repository/organizer_repository.dart';
import 'package:vroom/features/organizer/view/components/organizer_logout_button.dart';

class OrganizerQuestsScreen extends StatelessWidget {
  const OrganizerQuestsScreen({super.key, required this.eventId});

  final int eventId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Квесты мероприятия'),
        actions: const [OrganizerLogoutButton()],
      ),
      body: FutureBuilder(
        future: di.locator<OrganizerRepository>().getQuests(eventId),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            final error = snapshot.error;
            final message = error is ApiException
                ? error.message
                : 'Не удалось загрузить квесты';
            return Center(child: Text(message));
          }

          final quests = snapshot.data ?? const [];
          if (quests.isEmpty) {
            return const Center(
              child: Text('В этом мероприятии пока нет квестов'),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            itemCount: quests.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final quest = quests[index];
              return ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                tileColor: Theme.of(context).cardColor,
                title: Text(quest.title),
                subtitle: Text(
                  'Ассетов: ${quest.assetCount} • ${quest.hasScene ? 'Сцена есть' : 'Сцены еще нет'}',
                ),
                trailing: const Icon(Icons.view_in_ar_rounded),
                onTap: () =>
                    context.push('${AppRoutes.ar.path}/${quest.id}?mode=admin'),
              );
            },
          );
        },
      ),
    );
  }
}
