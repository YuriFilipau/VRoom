import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_activity_entity.freezed.dart';

@freezed
abstract class UserActivityEntity with _$UserActivityEntity {
  const factory UserActivityEntity({
    required int id,
    required String title,
    required String timeLabel,
  }) = _UserActivityEntity;
}
