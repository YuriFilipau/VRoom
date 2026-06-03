import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_quest_entity.freezed.dart';

@freezed
abstract class UserQuestEntity with _$UserQuestEntity {
  const factory UserQuestEntity({
    required int id,
    required String title,
    required String imageUrl,
    required int progressPercent,
  }) = _UserQuestEntity;
}
