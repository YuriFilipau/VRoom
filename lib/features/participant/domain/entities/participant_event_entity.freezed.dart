// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'participant_event_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ParticipantEventEntity {

 int get id; String get title; String get description; String get imageUrl; int get progressPercent; bool get certificateAvailable; String get statusLabel; int get scannedQuestsCount; int get totalQuestsCount;
/// Create a copy of ParticipantEventEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParticipantEventEntityCopyWith<ParticipantEventEntity> get copyWith => _$ParticipantEventEntityCopyWithImpl<ParticipantEventEntity>(this as ParticipantEventEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParticipantEventEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.progressPercent, progressPercent) || other.progressPercent == progressPercent)&&(identical(other.certificateAvailable, certificateAvailable) || other.certificateAvailable == certificateAvailable)&&(identical(other.statusLabel, statusLabel) || other.statusLabel == statusLabel)&&(identical(other.scannedQuestsCount, scannedQuestsCount) || other.scannedQuestsCount == scannedQuestsCount)&&(identical(other.totalQuestsCount, totalQuestsCount) || other.totalQuestsCount == totalQuestsCount));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,imageUrl,progressPercent,certificateAvailable,statusLabel,scannedQuestsCount,totalQuestsCount);

@override
String toString() {
  return 'ParticipantEventEntity(id: $id, title: $title, description: $description, imageUrl: $imageUrl, progressPercent: $progressPercent, certificateAvailable: $certificateAvailable, statusLabel: $statusLabel, scannedQuestsCount: $scannedQuestsCount, totalQuestsCount: $totalQuestsCount)';
}


}

/// @nodoc
abstract mixin class $ParticipantEventEntityCopyWith<$Res>  {
  factory $ParticipantEventEntityCopyWith(ParticipantEventEntity value, $Res Function(ParticipantEventEntity) _then) = _$ParticipantEventEntityCopyWithImpl;
@useResult
$Res call({
 int id, String title, String description, String imageUrl, int progressPercent, bool certificateAvailable, String statusLabel, int scannedQuestsCount, int totalQuestsCount
});




}
/// @nodoc
class _$ParticipantEventEntityCopyWithImpl<$Res>
    implements $ParticipantEventEntityCopyWith<$Res> {
  _$ParticipantEventEntityCopyWithImpl(this._self, this._then);

  final ParticipantEventEntity _self;
  final $Res Function(ParticipantEventEntity) _then;

/// Create a copy of ParticipantEventEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? imageUrl = null,Object? progressPercent = null,Object? certificateAvailable = null,Object? statusLabel = null,Object? scannedQuestsCount = null,Object? totalQuestsCount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,progressPercent: null == progressPercent ? _self.progressPercent : progressPercent // ignore: cast_nullable_to_non_nullable
as int,certificateAvailable: null == certificateAvailable ? _self.certificateAvailable : certificateAvailable // ignore: cast_nullable_to_non_nullable
as bool,statusLabel: null == statusLabel ? _self.statusLabel : statusLabel // ignore: cast_nullable_to_non_nullable
as String,scannedQuestsCount: null == scannedQuestsCount ? _self.scannedQuestsCount : scannedQuestsCount // ignore: cast_nullable_to_non_nullable
as int,totalQuestsCount: null == totalQuestsCount ? _self.totalQuestsCount : totalQuestsCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ParticipantEventEntity].
extension ParticipantEventEntityPatterns on ParticipantEventEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ParticipantEventEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ParticipantEventEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ParticipantEventEntity value)  $default,){
final _that = this;
switch (_that) {
case _ParticipantEventEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ParticipantEventEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ParticipantEventEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String description,  String imageUrl,  int progressPercent,  bool certificateAvailable,  String statusLabel,  int scannedQuestsCount,  int totalQuestsCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ParticipantEventEntity() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.imageUrl,_that.progressPercent,_that.certificateAvailable,_that.statusLabel,_that.scannedQuestsCount,_that.totalQuestsCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String description,  String imageUrl,  int progressPercent,  bool certificateAvailable,  String statusLabel,  int scannedQuestsCount,  int totalQuestsCount)  $default,) {final _that = this;
switch (_that) {
case _ParticipantEventEntity():
return $default(_that.id,_that.title,_that.description,_that.imageUrl,_that.progressPercent,_that.certificateAvailable,_that.statusLabel,_that.scannedQuestsCount,_that.totalQuestsCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String description,  String imageUrl,  int progressPercent,  bool certificateAvailable,  String statusLabel,  int scannedQuestsCount,  int totalQuestsCount)?  $default,) {final _that = this;
switch (_that) {
case _ParticipantEventEntity() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.imageUrl,_that.progressPercent,_that.certificateAvailable,_that.statusLabel,_that.scannedQuestsCount,_that.totalQuestsCount);case _:
  return null;

}
}

}

/// @nodoc


class _ParticipantEventEntity implements ParticipantEventEntity {
  const _ParticipantEventEntity({required this.id, required this.title, required this.description, required this.imageUrl, required this.progressPercent, required this.certificateAvailable, required this.statusLabel, required this.scannedQuestsCount, required this.totalQuestsCount});
  

@override final  int id;
@override final  String title;
@override final  String description;
@override final  String imageUrl;
@override final  int progressPercent;
@override final  bool certificateAvailable;
@override final  String statusLabel;
@override final  int scannedQuestsCount;
@override final  int totalQuestsCount;

/// Create a copy of ParticipantEventEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParticipantEventEntityCopyWith<_ParticipantEventEntity> get copyWith => __$ParticipantEventEntityCopyWithImpl<_ParticipantEventEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParticipantEventEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.progressPercent, progressPercent) || other.progressPercent == progressPercent)&&(identical(other.certificateAvailable, certificateAvailable) || other.certificateAvailable == certificateAvailable)&&(identical(other.statusLabel, statusLabel) || other.statusLabel == statusLabel)&&(identical(other.scannedQuestsCount, scannedQuestsCount) || other.scannedQuestsCount == scannedQuestsCount)&&(identical(other.totalQuestsCount, totalQuestsCount) || other.totalQuestsCount == totalQuestsCount));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,imageUrl,progressPercent,certificateAvailable,statusLabel,scannedQuestsCount,totalQuestsCount);

@override
String toString() {
  return 'ParticipantEventEntity(id: $id, title: $title, description: $description, imageUrl: $imageUrl, progressPercent: $progressPercent, certificateAvailable: $certificateAvailable, statusLabel: $statusLabel, scannedQuestsCount: $scannedQuestsCount, totalQuestsCount: $totalQuestsCount)';
}


}

/// @nodoc
abstract mixin class _$ParticipantEventEntityCopyWith<$Res> implements $ParticipantEventEntityCopyWith<$Res> {
  factory _$ParticipantEventEntityCopyWith(_ParticipantEventEntity value, $Res Function(_ParticipantEventEntity) _then) = __$ParticipantEventEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String description, String imageUrl, int progressPercent, bool certificateAvailable, String statusLabel, int scannedQuestsCount, int totalQuestsCount
});




}
/// @nodoc
class __$ParticipantEventEntityCopyWithImpl<$Res>
    implements _$ParticipantEventEntityCopyWith<$Res> {
  __$ParticipantEventEntityCopyWithImpl(this._self, this._then);

  final _ParticipantEventEntity _self;
  final $Res Function(_ParticipantEventEntity) _then;

/// Create a copy of ParticipantEventEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? imageUrl = null,Object? progressPercent = null,Object? certificateAvailable = null,Object? statusLabel = null,Object? scannedQuestsCount = null,Object? totalQuestsCount = null,}) {
  return _then(_ParticipantEventEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,progressPercent: null == progressPercent ? _self.progressPercent : progressPercent // ignore: cast_nullable_to_non_nullable
as int,certificateAvailable: null == certificateAvailable ? _self.certificateAvailable : certificateAvailable // ignore: cast_nullable_to_non_nullable
as bool,statusLabel: null == statusLabel ? _self.statusLabel : statusLabel // ignore: cast_nullable_to_non_nullable
as String,scannedQuestsCount: null == scannedQuestsCount ? _self.scannedQuestsCount : scannedQuestsCount // ignore: cast_nullable_to_non_nullable
as int,totalQuestsCount: null == totalQuestsCount ? _self.totalQuestsCount : totalQuestsCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
