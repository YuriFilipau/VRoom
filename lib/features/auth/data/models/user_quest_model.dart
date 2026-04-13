import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vroom/features/auth/domain/entities/user_quest_entity.dart';

part 'user_quest_model.freezed.dart';
part 'user_quest_model.g.dart';

@freezed
abstract class UserQuest with _$UserQuest {
  const UserQuest._();

  const factory UserQuest({
    required int id,
    required String title,
    @JsonKey(name: 'image_url') required String imageUrl,
    @JsonKey(name: 'progress_percent') required int progressPercent,
  }) = _UserQuest;

  factory UserQuest.fromJson(Map<String, dynamic> json) =>
      _$UserQuestFromJson(json);

  UserQuestEntity toEntity() => UserQuestEntity(
    id: id,
    title: title,
    imageUrl: imageUrl,
    progressPercent: progressPercent,
  );
}
