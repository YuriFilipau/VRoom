import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:open_filex/open_filex.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vroom/core/constants/app_colors.dart';
import 'package:vroom/core/constants/app_radii.dart';
import 'package:vroom/core/dependencies/get_it.dart' as di;
import 'package:vroom/core/network/api_exception.dart';
import 'package:vroom/core/router/app_routes.dart';
import 'package:vroom/core/shared/widgets/app_gradient_button.dart';
import 'package:vroom/core/shared/widgets/auth_failure_redirect.dart';
import 'package:vroom/features/home/view/components/quest_card.dart';
import 'package:vroom/features/participant/domain/entities/participant_certificate_entity.dart';
import 'package:vroom/features/participant/domain/entities/participant_event_detail_entity.dart';
import 'package:vroom/features/participant/domain/entities/participant_scanned_quest_entity.dart';
import 'package:vroom/features/participant/domain/repository/participant_repository.dart';

class ParticipantEventDetailsScreen extends StatefulWidget {
  const ParticipantEventDetailsScreen({super.key, required this.eventId});

  final int eventId;

  @override
  State<ParticipantEventDetailsScreen> createState() =>
      _ParticipantEventDetailsScreenState();
}

class _ParticipantEventDetailsScreenState
    extends State<ParticipantEventDetailsScreen> {
  late Future<ParticipantEventDetailEntity> _eventFuture;
  bool _isIssuingCertificate = false;

  ParticipantRepository get _repository => di.locator<ParticipantRepository>();

  @override
  void initState() {
    super.initState();
    _eventFuture = _repository.getEventDetail(widget.eventId);
  }

  void _reloadEvent() {
    setState(() {
      _eventFuture = _repository.getEventDetail(widget.eventId);
    });
  }

  Future<void> _issueCertificate() async {
    setState(() {
      _isIssuingCertificate = true;
    });
    try {
      final certificate = await _repository.issueCertificate(widget.eventId);
      if (!mounted) {
        return;
      }
      _showCertificateReady(certificate);
      _reloadEvent();
    } on ApiException catch (error) {
      _showMessage(error.message);
    } catch (_) {
      _showMessage('Не удалось получить сертификат');
    } finally {
      if (mounted) {
        setState(() {
          _isIssuingCertificate = false;
        });
      }
    }
  }

  Future<void> _openCertificate(
    ParticipantCertificateEntity certificate,
  ) async {
    try {
      final resolved = await _repository.getCertificate(widget.eventId);
      final filePath = await _repository.downloadCertificatePdf(widget.eventId);
      final openResult = await OpenFilex.open(filePath);
      if (openResult.type == ResultType.done) {
        return;
      }

      final url = resolved.artifactUrl ?? certificate.artifactUrl;
      final uri = url == null ? null : Uri.tryParse(url);
      if (uri != null && await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        return;
      }

      if (url != null && url.isNotEmpty) {
        await Clipboard.setData(ClipboardData(text: url));
        _showMessage('Не удалось открыть PDF автоматически. Ссылка скопирована.');
        return;
      }

      _showMessage(
        openResult.message.isEmpty
            ? 'Не удалось открыть сертификат'
            : openResult.message,
      );
    } on ApiException catch (error) {
      _showMessage(error.message);
    } catch (_) {
      _showMessage('Не удалось открыть сертификат');
    }
  }

  void _showCertificateReady(ParticipantCertificateEntity certificate) {
    final number = certificate.certificateNumber;
    final issuedAt = certificate.issuedAt;
    final lines = [
      if (number != null) 'Номер: $number',
      if (issuedAt != null) 'Дата выдачи: $issuedAt',
      if (certificate.artifactUrl != null) 'Сертификат готов к открытию.',
    ];

    _showMessage(lines.isEmpty ? 'Сертификат готов.' : lines.join('\n'));
  }

  void _showMessage(String message) {
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Мероприятие')),
      body: FutureBuilder<ParticipantEventDetailEntity>(
        future: _eventFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            final error = snapshot.error;
            final message = error is ApiException
                ? error.message
                : 'Не удалось загрузить мероприятие';
            if (error is ApiException && error.statusCode == 401) {
              return AuthFailureRedirect(message: message);
            }
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
                _CertificatePanel(
                  certificate: event.certificate,
                  isIssuing: _isIssuingCertificate,
                  onIssue: _issueCertificate,
                  onOpen: () => _openCertificate(event.certificate),
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
                    child: _ScannedQuestTile(quest: quest, eventId: event.id),
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

class _CertificatePanel extends StatelessWidget {
  const _CertificatePanel({
    required this.certificate,
    required this.isIssuing,
    required this.onIssue,
    required this.onOpen,
  });

  final ParticipantCertificateEntity certificate;
  final bool isIssuing;
  final VoidCallback onIssue;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final status = !certificate.available
        ? 'Сертификат пока недоступен'
        : certificate.issued
        ? 'Сертификат выдан'
        : 'Сертификат доступен';

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(AppRadii.md),
        border: Border.all(
          color: AppColors.primaryBlue.withValues(alpha: 0.18),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(status, style: Theme.of(context).textTheme.bodyLarge),
            if (certificate.certificateNumber != null ||
                certificate.issuedAt != null) ...[
              const SizedBox(height: 6),
              Text(
                [
                  if (certificate.certificateNumber != null)
                    'Номер: ${certificate.certificateNumber}',
                  if (certificate.issuedAt != null)
                    'Дата: ${certificate.issuedAt}',
                ].join('\n'),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
            const SizedBox(height: 12),
            if (certificate.available && !certificate.issued)
              AppGradientButton(
                label: 'Получить сертификат',
                isLoading: isIssuing,
                onPressed: isIssuing ? null : onIssue,
              )
            else if (certificate.issued)
              OutlinedButton.icon(
                onPressed: onOpen,
                icon: const Icon(Icons.open_in_new_rounded),
                label: const Text('Открыть сертификат'),
              ),
          ],
        ),
      ),
    );
  }
}

class _ScannedQuestTile extends StatelessWidget {
  const _ScannedQuestTile({required this.quest, required this.eventId});

  final ParticipantScannedQuestEntity quest;
  final int eventId;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.md),
        border: Border.all(color: Colors.white12),
      ),
      child: ListTile(
        title: Text(quest.title),
        subtitle: Text(_subtitle),
        trailing: quest.hasTest && !quest.testPassed
            ? TextButton(
                onPressed: () => context.push(
                  '${AppRoutes.questTest.path}/${quest.id}/test?eventId=$eventId',
                ),
                child: const Text('Пройти тест'),
              )
            : Text(
                '${quest.progressPercent}%',
                style: const TextStyle(
                  color: AppColors.primaryBlue,
                  fontWeight: FontWeight.w700,
                ),
              ),
      ),
    );
  }

  String get _subtitle {
    final parts = <String>[quest.statusLabel];
    if (quest.hasTest) {
      if (quest.testPassed) {
        parts.add('Тест пройден');
      } else if (quest.testCompleted) {
        parts.add('Тест завершён');
      } else {
        parts.add('Есть тест');
      }
      if (quest.score != null) {
        parts.add('Баллы: ${quest.score}');
      }
    }
    return parts.join(' · ');
  }
}
