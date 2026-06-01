import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vroom/core/dependencies/get_it.dart' as di;
import 'package:vroom/core/network/api_exception.dart';
import 'package:vroom/core/router/app_routes.dart';
import 'package:vroom/core/shared/widgets/auth_failure_redirect.dart';
import 'package:vroom/features/organizer/domain/repository/organizer_repository.dart';
import 'package:vroom/features/organizer/view/components/organizer_logout_button.dart';

class OrganizerEventsScreen extends StatelessWidget {
  const OrganizerEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мероприятия organizer'),
        actions: const [OrganizerLogoutButton()],
      ),
      body: FutureBuilder(
        future: di.locator<OrganizerRepository>().getEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            final error = snapshot.error;
            final message = error is ApiException
                ? error.message
                : 'Не удалось загрузить мероприятия organizer';
            if (error is ApiException && error.statusCode == 401) {
              return AuthFailureRedirect(message: message);
            }
            return Center(child: Text(message));
          }

          final events = snapshot.data ?? const [];
          if (events.isEmpty) {
            return const Center(
              child: Text('Для organizer пока нет мероприятий'),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            itemCount: events.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final event = events[index];
              return ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                tileColor: Theme.of(context).cardColor,
                title: Text(event.title),
                subtitle: Text(
                  '${event.subtitle}\nКвестов: ${event.questCount}',
                ),
                isThreeLine: true,
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () => context.push(
                  '${AppRoutes.organizerEvents.path}/${event.id}/quests',
                ),
              );
            },
          );
        },
      ),
    );
  }
}
