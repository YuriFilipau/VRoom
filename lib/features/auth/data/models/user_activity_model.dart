import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vroom/features/auth/domain/entities/user_activity_entity.dart';

part 'user_activity_model.freezed.dart';
part 'user_activity_model.g.dart';

@freezed
abstract class UserActivity with _$UserActivity {
  const UserActivity._();

  const factory UserActivity({
    required int id,
    required String title,
    @JsonKey(name: 'time_label') required String timeLabel,
  }) = _UserActivity;

  factory UserActivity.fromJson(Map<String, dynamic> json) =>
      _$UserActivityFromJson(json);

  UserActivityEntity toEntity() => UserActivityEntity(
    id: id,
    title: title,
    timeLabel: timeLabel,
  );
}
