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
              _ActionTypePicker(
                value: _type,
                onChanged: (value) => setState(() => _type = value),
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

class _ActionTypePicker extends StatelessWidget {
  const _ActionTypePicker({required this.value, required this.onChanged});

  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final selected = _actionTypeOptions.firstWhere(
      (option) => option.value == value,
      orElse: () => _actionTypeOptions.first,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        return PopupMenuButton<String>(
          initialValue: value,
          onSelected: onChanged,
          constraints: const BoxConstraints(minWidth: 260, maxWidth: 340),
          itemBuilder: (context) => _actionTypeOptions
              .map(
                (option) => PopupMenuItem<String>(
                  value: option.value,
                  child: Row(
                    children: [
                      Icon(option.icon, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          option.label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(growable: false),
          child: SizedBox(
            width: constraints.maxWidth,
            child: InputDecorator(
              decoration: const InputDecoration(labelText: 'Тип действия'),
              child: Row(
                children: [
                  Icon(selected.icon, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      selected.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.keyboard_arrow_down_rounded, size: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ActionTypeOption {
  const _ActionTypeOption({
    required this.value,
    required this.label,
    required this.icon,
  });

  final String value;
  final String label;
  final IconData icon;
}

const _actionTypeOptions = [
  _ActionTypeOption(
    value: 'none',
    label: 'Без действия',
    icon: Icons.block_rounded,
  ),
  _ActionTypeOption(
    value: 'information',
    label: 'Информационная карточка',
    icon: Icons.info_outline_rounded,
  ),
  _ActionTypeOption(
    value: 'hint',
    label: 'Подсказка',
    icon: Icons.lightbulb_outline_rounded,
  ),
  _ActionTypeOption(
    value: 'mini_question',
    label: 'Мини-вопрос',
    icon: Icons.quiz_outlined,
  ),
  _ActionTypeOption(
    value: 'collectable',
    label: 'Собираемый объект',
    icon: Icons.add_task_rounded,
  ),
];
