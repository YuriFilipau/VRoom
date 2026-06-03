import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vroom/core/network/json_utils.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_asset_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_asset_placement_entity.dart';
import 'package:vroom/features/ar_session/view/bloc/ar_session_bloc.dart';
import 'package:vroom/features/ar_session/view/components/ar_placement_helpers.dart';

Future<void> showArInteractionEditorDialog({
  required BuildContext context,
  required ArAssetPlacementEntity placement,
  required ArAssetEntity? asset,
}) {
  return showDialog<void>(
    context: context,
    builder: (_) => BlocProvider.value(
      value: context.read<ArSessionBloc>(),
      child: _ArInteractionEditorDialog(placement: placement, asset: asset),
    ),
  );
}

class _ArInteractionEditorDialog extends StatefulWidget {
  const _ArInteractionEditorDialog({
    required this.placement,
    required this.asset,
  });

  final ArAssetPlacementEntity placement;
  final ArAssetEntity? asset;

  @override
  State<_ArInteractionEditorDialog> createState() =>
      _ArInteractionEditorDialogState();
}

class _ArInteractionEditorDialogState
    extends State<_ArInteractionEditorDialog> {
  late String _type;
  late final TextEditingController _titleController;
  late final TextEditingController _bodyController;
  late final TextEditingController _questionController;
  late final TextEditingController _optionsController;
  int _correctIndex = 0;

  @override
  void initState() {
    super.initState();
    final payload = _payload;
    _type = _normalizeType(
      _read(payload['type']) ??
          _read(payload['interaction_type']) ??
          _read(widget.placement.meta['interaction_type']) ??
          _read(widget.placement.meta['interactionType']) ??
          _read(widget.placement.meta['type']),
    );
    _titleController = TextEditingController(
      text:
          _read(payload['title']) ??
          _read(widget.placement.meta['title']) ??
          arPlacementTitle(widget.placement, widget.asset),
    );
    _bodyController = TextEditingController(
      text:
          _read(payload['description']) ??
          _read(payload['text']) ??
          _read(payload['body']) ??
          _read(widget.placement.meta['description']) ??
          _read(widget.placement.meta['text']) ??
          '',
    );
    _questionController = TextEditingController(
      text:
          _read(payload['question']) ??
          _read(widget.placement.meta['question']) ??
          '',
    );
    _optionsController = TextEditingController(text: _optionsText(payload));
    _correctIndex =
        readInt(payload['correct_index']) ??
        readInt(payload['correctIndex']) ??
        readInt(widget.placement.meta['correct_index']) ??
        readInt(widget.placement.meta['correctIndex']) ??
        0;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    _questionController.dispose();
    _optionsController.dispose();
    super.dispose();
  }

  Map<String, dynamic> get _payload {
    return asMap(
      widget.placement.meta['interaction'] ??
          widget.placement.meta['interactive'] ??
          widget.placement.meta['action'],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isQuestion = _type == 'mini_question';

    return AlertDialog(
      title: const Text('Действие AR-объекта'),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: _type,
                decoration: const InputDecoration(labelText: 'Тип действия'),
                items: const [
                  DropdownMenuItem(value: 'none', child: Text('Без действия')),
                  DropdownMenuItem(
                    value: 'information',
                    child: Text('Информационная карточка'),
                  ),
                  DropdownMenuItem(value: 'hint', child: Text('Подсказка')),
                  DropdownMenuItem(
                    value: 'mini_question',
                    child: Text('Мини-вопрос'),
                  ),
                  DropdownMenuItem(
                    value: 'collectable',
                    child: Text('Собираемый объект'),
                  ),
                ],
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() => _type = value);
                },
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Название'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _bodyController,
                minLines: 2,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: isQuestion ? 'Пояснение' : 'Текст карточки',
                ),
              ),
              if (isQuestion) ...[
                const SizedBox(height: 12),
                TextField(
                  controller: _questionController,
                  minLines: 2,
                  maxLines: 3,
                  decoration: const InputDecoration(labelText: 'Вопрос'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _optionsController,
                  minLines: 3,
                  maxLines: 6,
                  decoration: const InputDecoration(
                    labelText: 'Варианты ответа',
                    helperText: 'Каждый вариант с новой строки',
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: (_correctIndex + 1).toString(),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Номер правильного ответа',
                  ),
                  onChanged: (value) {
                    _correctIndex = (int.tryParse(value) ?? 1) - 1;
                  },
                ),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Отмена'),
        ),
        FilledButton(onPressed: _save, child: const Text('Сохранить')),
      ],
    );
  }

  void _save() {
    final nextMeta = {...widget.placement.meta}
      ..remove('interaction')
      ..remove('interactive')
      ..remove('action')
      ..remove('interaction_type')
      ..remove('interactionType')
      ..remove('type')
      ..remove('title')
      ..remove('description')
      ..remove('text')
      ..remove('body')
      ..remove('question')
      ..remove('options')
      ..remove('correct_index')
      ..remove('correctIndex');

    if (_type != 'none') {
      nextMeta['interaction_type'] = _type;
      nextMeta['title'] = _titleController.text.trim();
      if (_bodyController.text.trim().isNotEmpty) {
        nextMeta['description'] = _bodyController.text.trim();
      }
      if (_type == 'mini_question') {
        final options = _optionsController.text
            .split('\n')
            .map((line) => line.trim())
            .where((line) => line.isNotEmpty)
            .toList(growable: false);
        nextMeta['question'] = _questionController.text.trim();
        nextMeta['options'] = options;
        nextMeta['correct_index'] = options.isEmpty
            ? 0
            : _correctIndex.clamp(0, options.length - 1).toInt();
      }
    }

    context.read<ArSessionBloc>().add(
      ArSessionPlacementUpserted(widget.placement.copyWith(meta: nextMeta)),
    );
    Navigator.of(context).pop();
  }

  String _optionsText(Map<String, dynamic> payload) {
    final options = asList(payload['options']).isNotEmpty
        ? asList(payload['options'])
        : asList(widget.placement.meta['options']);
    return options
        .map((option) {
          final json = asMap(option);
          return _read(json['label']) ??
              _read(json['title']) ??
              _read(json['text']) ??
              _read(json['value']) ??
              _read(option) ??
              '';
        })
        .where((option) => option.isNotEmpty)
        .join('\n');
  }

  String _normalizeType(String? raw) {
    final normalized = raw?.trim().toLowerCase();
    return switch (normalized) {
      'information' ||
      'hint' ||
      'mini_question' ||
      'collectable' => normalized!,
      'info' || 'card' || 'information_card' => 'information',
      'question' ||
      'quiz' ||
      'mini-question' ||
      'miniquestion' => 'mini_question',
      'collect' || 'collection' || 'collectible' => 'collectable',
      _ => 'none',
    };
  }

  String? _read(dynamic raw) {
    if (raw is Map || raw is List) {
      return null;
    }
    return readString(raw);
  }
}
