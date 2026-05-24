// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qr_scan_result_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QrScanResultEntity {

 int get questId; int? get eventId; String? get scanSessionId;
/// Create a copy of QrScanResultEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QrScanResultEntityCopyWith<QrScanResultEntity> get copyWith => _$QrScanResultEntityCopyWithImpl<QrScanResultEntity>(this as QrScanResultEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QrScanResultEntity&&(identical(other.questId, questId) || other.questId == questId)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.scanSessionId, scanSessionId) || other.scanSessionId == scanSessionId));
}


@override
int get hashCode => Object.hash(runtimeType,questId,eventId,scanSessionId);

@override
String toString() {
  return 'QrScanResultEntity(questId: $questId, eventId: $eventId, scanSessionId: $scanSessionId)';
}


}

/// @nodoc
abstract mixin class $QrScanResultEntityCopyWith<$Res>  {
  factory $QrScanResultEntityCopyWith(QrScanResultEntity value, $Res Function(QrScanResultEntity) _then) = _$QrScanResultEntityCopyWithImpl;
@useResult
$Res call({
 int questId, int? eventId, String? scanSessionId
});




}
/// @nodoc
class _$QrScanResultEntityCopyWithImpl<$Res>
    implements $QrScanResultEntityCopyWith<$Res> {
  _$QrScanResultEntityCopyWithImpl(this._self, this._then);

  final QrScanResultEntity _self;
  final $Res Function(QrScanResultEntity) _then;

/// Create a copy of QrScanResultEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? questId = null,Object? eventId = freezed,Object? scanSessionId = freezed,}) {
  return _then(_self.copyWith(
questId: null == questId ? _self.questId : questId // ignore: cast_nullable_to_non_nullable
as int,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int?,scanSessionId: freezed == scanSessionId ? _self.scanSessionId : scanSessionId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [QrScanResultEntity].
extension QrScanResultEntityPatterns on QrScanResultEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QrScanResultEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QrScanResultEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QrScanResultEntity value)  $default,){
final _that = this;
switch (_that) {
case _QrScanResultEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QrScanResultEntity value)?  $default,){
final _that = this;
switch (_that) {
case _QrScanResultEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int questId,  int? eventId,  String? scanSessionId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QrScanResultEntity() when $default != null:
return $default(_that.questId,_that.eventId,_that.scanSessionId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int questId,  int? eventId,  String? scanSessionId)  $default,) {final _that = this;
switch (_that) {
case _QrScanResultEntity():
return $default(_that.questId,_that.eventId,_that.scanSessionId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int questId,  int? eventId,  String? scanSessionId)?  $default,) {final _that = this;
switch (_that) {
case _QrScanResultEntity() when $default != null:
return $default(_that.questId,_that.eventId,_that.scanSessionId);case _:
  return null;

}
}

}

/// @nodoc


class _QrScanResultEntity implements QrScanResultEntity {
  const _QrScanResultEntity({required this.questId, this.eventId, this.scanSessionId});
  

@override final  int questId;
@override final  int? eventId;
@override final  String? scanSessionId;

/// Create a copy of QrScanResultEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QrScanResultEntityCopyWith<_QrScanResultEntity> get copyWith => __$QrScanResultEntityCopyWithImpl<_QrScanResultEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QrScanResultEntity&&(identical(other.questId, questId) || other.questId == questId)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.scanSessionId, scanSessionId) || other.scanSessionId == scanSessionId));
}


@override
int get hashCode => Object.hash(runtimeType,questId,eventId,scanSessionId);

@override
String toString() {
  return 'QrScanResultEntity(questId: $questId, eventId: $eventId, scanSessionId: $scanSessionId)';
}


}

/// @nodoc
abstract mixin class _$QrScanResultEntityCopyWith<$Res> implements $QrScanResultEntityCopyWith<$Res> {
  factory _$QrScanResultEntityCopyWith(_QrScanResultEntity value, $Res Function(_QrScanResultEntity) _then) = __$QrScanResultEntityCopyWithImpl;
@override @useResult
$Res call({
 int questId, int? eventId, String? scanSessionId
});




}
/// @nodoc
class __$QrScanResultEntityCopyWithImpl<$Res>
    implements _$QrScanResultEntityCopyWith<$Res> {
  __$QrScanResultEntityCopyWithImpl(this._self, this._then);

  final _QrScanResultEntity _self;
  final $Res Function(_QrScanResultEntity) _then;

/// Create a copy of QrScanResultEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? questId = null,Object? eventId = freezed,Object? scanSessionId = freezed,}) {
  return _then(_QrScanResultEntity(
questId: null == questId ? _self.questId : questId // ignore: cast_nullable_to_non_nullable
as int,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int?,scanSessionId: freezed == scanSessionId ? _self.scanSessionId : scanSessionId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
