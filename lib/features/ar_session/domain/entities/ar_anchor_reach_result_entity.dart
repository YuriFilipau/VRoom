import 'package:freezed_annotation/freezed_annotation.dart';

part 'ar_anchor_reach_result_entity.freezed.dart';

@freezed
abstract class ArAnchorReachResultEntity with _$ArAnchorReachResultEntity {
  const factory ArAnchorReachResultEntity({
    required int questId,
    required String anchorId,
    required String anchorRole,
    required bool testUnlocked,
    required bool questCompleted,
    required bool created,
    int? progressCompleted,
    int? progressTotal,
    String? requiredTestAnchorId,
    String? finishAnchorId,
    @Default({}) Map<String, dynamic> nextAction,
  }) = _ArAnchorReachResultEntity;
}
