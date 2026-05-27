// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'participant_scanned_quest_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ParticipantScannedQuestEntity {

 int get id; String get title; String get imageUrl; int get progressPercent; String get statusLabel; bool get hasTest; bool get testCompleted; bool get testPassed; int? get score; int? get passingScore;
/// Create a copy of ParticipantScannedQuestEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParticipantScannedQuestEntityCopyWith<ParticipantScannedQuestEntity> get copyWith => _$ParticipantScannedQuestEntityCopyWithImpl<ParticipantScannedQuestEntity>(this as ParticipantScannedQuestEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParticipantScannedQuestEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.progressPercent, progressPercent) || other.progressPercent == progressPercent)&&(identical(other.statusLabel, statusLabel) || other.statusLabel == statusLabel)&&(identical(other.hasTest, hasTest) || other.hasTest == hasTest)&&(identical(other.testCompleted, testCompleted) || other.testCompleted == testCompleted)&&(identical(other.testPassed, testPassed) || other.testPassed == testPassed)&&(identical(other.score, score) || other.score == score)&&(identical(other.passingScore, passingScore) || other.passingScore == passingScore));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,imageUrl,progressPercent,statusLabel,hasTest,testCompleted,testPassed,score,passingScore);

@override
String toString() {
  return 'ParticipantScannedQuestEntity(id: $id, title: $title, imageUrl: $imageUrl, progressPercent: $progressPercent, statusLabel: $statusLabel, hasTest: $hasTest, testCompleted: $testCompleted, testPassed: $testPassed, score: $score, passingScore: $passingScore)';
}


}

/// @nodoc
abstract mixin class $ParticipantScannedQuestEntityCopyWith<$Res>  {
  factory $ParticipantScannedQuestEntityCopyWith(ParticipantScannedQuestEntity value, $Res Function(ParticipantScannedQuestEntity) _then) = _$ParticipantScannedQuestEntityCopyWithImpl;
@useResult
$Res call({
 int id, String title, String imageUrl, int progressPercent, String statusLabel, bool hasTest, bool testCompleted, bool testPassed, int? score, int? passingScore
});




}
/// @nodoc
class _$ParticipantScannedQuestEntityCopyWithImpl<$Res>
    implements $ParticipantScannedQuestEntityCopyWith<$Res> {
  _$ParticipantScannedQuestEntityCopyWithImpl(this._self, this._then);

  final ParticipantScannedQuestEntity _self;
  final $Res Function(ParticipantScannedQuestEntity) _then;

/// Create a copy of ParticipantScannedQuestEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? imageUrl = null,Object? progressPercent = null,Object? statusLabel = null,Object? hasTest = null,Object? testCompleted = null,Object? testPassed = null,Object? score = freezed,Object? passingScore = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,progressPercent: null == progressPercent ? _self.progressPercent : progressPercent // ignore: cast_nullable_to_non_nullable
as int,statusLabel: null == statusLabel ? _self.statusLabel : statusLabel // ignore: cast_nullable_to_non_nullable
as String,hasTest: null == hasTest ? _self.hasTest : hasTest // ignore: cast_nullable_to_non_nullable
as bool,testCompleted: null == testCompleted ? _self.testCompleted : testCompleted // ignore: cast_nullable_to_non_nullable
as bool,testPassed: null == testPassed ? _self.testPassed : testPassed // ignore: cast_nullable_to_non_nullable
as bool,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int?,passingScore: freezed == passingScore ? _self.passingScore : passingScore // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ParticipantScannedQuestEntity].
extension ParticipantScannedQuestEntityPatterns on ParticipantScannedQuestEntity {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ParticipantScannedQuestEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ParticipantScannedQuestEntity() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ParticipantScannedQuestEntity value)  $default,){
final _that = this;
switch (_that) {
case _ParticipantScannedQuestEntity():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ParticipantScannedQuestEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ParticipantScannedQuestEntity() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String imageUrl,  int progressPercent,  String statusLabel,  bool hasTest,  bool testCompleted,  bool testPassed,  int? score,  int? passingScore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ParticipantScannedQuestEntity() when $default != null:
return $default(_that.id,_that.title,_that.imageUrl,_that.progressPercent,_that.statusLabel,_that.hasTest,_that.testCompleted,_that.testPassed,_that.score,_that.passingScore);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String imageUrl,  int progressPercent,  String statusLabel,  bool hasTest,  bool testCompleted,  bool testPassed,  int? score,  int? passingScore)  $default,) {final _that = this;
switch (_that) {
case _ParticipantScannedQuestEntity():
return $default(_that.id,_that.title,_that.imageUrl,_that.progressPercent,_that.statusLabel,_that.hasTest,_that.testCompleted,_that.testPassed,_that.score,_that.passingScore);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String imageUrl,  int progressPercent,  String statusLabel,  bool hasTest,  bool testCompleted,  bool testPassed,  int? score,  int? passingScore)?  $default,) {final _that = this;
switch (_that) {
case _ParticipantScannedQuestEntity() when $default != null:
return $default(_that.id,_that.title,_that.imageUrl,_that.progressPercent,_that.statusLabel,_that.hasTest,_that.testCompleted,_that.testPassed,_that.score,_that.passingScore);case _:
  return null;

}
}

}

/// @nodoc


class _ParticipantScannedQuestEntity implements ParticipantScannedQuestEntity {
  const _ParticipantScannedQuestEntity({required this.id, required this.title, required this.imageUrl, required this.progressPercent, required this.statusLabel, required this.hasTest, required this.testCompleted, required this.testPassed, required this.score, required this.passingScore});
  

@override final  int id;
@override final  String title;
@override final  String imageUrl;
@override final  int progressPercent;
@override final  String statusLabel;
@override final  bool hasTest;
@override final  bool testCompleted;
@override final  bool testPassed;
@override final  int? score;
@override final  int? passingScore;

/// Create a copy of ParticipantScannedQuestEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParticipantScannedQuestEntityCopyWith<_ParticipantScannedQuestEntity> get copyWith => __$ParticipantScannedQuestEntityCopyWithImpl<_ParticipantScannedQuestEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParticipantScannedQuestEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.progressPercent, progressPercent) || other.progressPercent == progressPercent)&&(identical(other.statusLabel, statusLabel) || other.statusLabel == statusLabel)&&(identical(other.hasTest, hasTest) || other.hasTest == hasTest)&&(identical(other.testCompleted, testCompleted) || other.testCompleted == testCompleted)&&(identical(other.testPassed, testPassed) || other.testPassed == testPassed)&&(identical(other.score, score) || other.score == score)&&(identical(other.passingScore, passingScore) || other.passingScore == passingScore));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,imageUrl,progressPercent,statusLabel,hasTest,testCompleted,testPassed,score,passingScore);

@override
String toString() {
  return 'ParticipantScannedQuestEntity(id: $id, title: $title, imageUrl: $imageUrl, progressPercent: $progressPercent, statusLabel: $statusLabel, hasTest: $hasTest, testCompleted: $testCompleted, testPassed: $testPassed, score: $score, passingScore: $passingScore)';
}


}

/// @nodoc
abstract mixin class _$ParticipantScannedQuestEntityCopyWith<$Res> implements $ParticipantScannedQuestEntityCopyWith<$Res> {
  factory _$ParticipantScannedQuestEntityCopyWith(_ParticipantScannedQuestEntity value, $Res Function(_ParticipantScannedQuestEntity) _then) = __$ParticipantScannedQuestEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String imageUrl, int progressPercent, String statusLabel, bool hasTest, bool testCompleted, bool testPassed, int? score, int? passingScore
});




}
/// @nodoc
class __$ParticipantScannedQuestEntityCopyWithImpl<$Res>
    implements _$ParticipantScannedQuestEntityCopyWith<$Res> {
  __$ParticipantScannedQuestEntityCopyWithImpl(this._self, this._then);

  final _ParticipantScannedQuestEntity _self;
  final $Res Function(_ParticipantScannedQuestEntity) _then;

/// Create a copy of ParticipantScannedQuestEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? imageUrl = null,Object? progressPercent = null,Object? statusLabel = null,Object? hasTest = null,Object? testCompleted = null,Object? testPassed = null,Object? score = freezed,Object? passingScore = freezed,}) {
  return _then(_ParticipantScannedQuestEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,progressPercent: null == progressPercent ? _self.progressPercent : progressPercent // ignore: cast_nullable_to_non_nullable
as int,statusLabel: null == statusLabel ? _self.statusLabel : statusLabel // ignore: cast_nullable_to_non_nullable
as String,hasTest: null == hasTest ? _self.hasTest : hasTest // ignore: cast_nullable_to_non_nullable
as bool,testCompleted: null == testCompleted ? _self.testCompleted : testCompleted // ignore: cast_nullable_to_non_nullable
as bool,testPassed: null == testPassed ? _self.testPassed : testPassed // ignore: cast_nullable_to_non_nullable
as bool,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int?,passingScore: freezed == passingScore ? _self.passingScore : passingScore // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
