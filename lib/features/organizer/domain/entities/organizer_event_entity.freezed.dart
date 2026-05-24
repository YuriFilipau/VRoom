// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'organizer_event_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrganizerEventEntity {

 int get id; String get title; String get subtitle; int get questCount;
/// Create a copy of OrganizerEventEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrganizerEventEntityCopyWith<OrganizerEventEntity> get copyWith => _$OrganizerEventEntityCopyWithImpl<OrganizerEventEntity>(this as OrganizerEventEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrganizerEventEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.questCount, questCount) || other.questCount == questCount));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,subtitle,questCount);

@override
String toString() {
  return 'OrganizerEventEntity(id: $id, title: $title, subtitle: $subtitle, questCount: $questCount)';
}


}

/// @nodoc
abstract mixin class $OrganizerEventEntityCopyWith<$Res>  {
  factory $OrganizerEventEntityCopyWith(OrganizerEventEntity value, $Res Function(OrganizerEventEntity) _then) = _$OrganizerEventEntityCopyWithImpl;
@useResult
$Res call({
 int id, String title, String subtitle, int questCount
});




}
/// @nodoc
class _$OrganizerEventEntityCopyWithImpl<$Res>
    implements $OrganizerEventEntityCopyWith<$Res> {
  _$OrganizerEventEntityCopyWithImpl(this._self, this._then);

  final OrganizerEventEntity _self;
  final $Res Function(OrganizerEventEntity) _then;

/// Create a copy of OrganizerEventEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? subtitle = null,Object? questCount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,questCount: null == questCount ? _self.questCount : questCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [OrganizerEventEntity].
extension OrganizerEventEntityPatterns on OrganizerEventEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrganizerEventEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrganizerEventEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrganizerEventEntity value)  $default,){
final _that = this;
switch (_that) {
case _OrganizerEventEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrganizerEventEntity value)?  $default,){
final _that = this;
switch (_that) {
case _OrganizerEventEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String subtitle,  int questCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrganizerEventEntity() when $default != null:
return $default(_that.id,_that.title,_that.subtitle,_that.questCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String subtitle,  int questCount)  $default,) {final _that = this;
switch (_that) {
case _OrganizerEventEntity():
return $default(_that.id,_that.title,_that.subtitle,_that.questCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String subtitle,  int questCount)?  $default,) {final _that = this;
switch (_that) {
case _OrganizerEventEntity() when $default != null:
return $default(_that.id,_that.title,_that.subtitle,_that.questCount);case _:
  return null;

}
}

}

/// @nodoc


class _OrganizerEventEntity implements OrganizerEventEntity {
  const _OrganizerEventEntity({required this.id, required this.title, required this.subtitle, required this.questCount});
  

@override final  int id;
@override final  String title;
@override final  String subtitle;
@override final  int questCount;

/// Create a copy of OrganizerEventEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrganizerEventEntityCopyWith<_OrganizerEventEntity> get copyWith => __$OrganizerEventEntityCopyWithImpl<_OrganizerEventEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrganizerEventEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.questCount, questCount) || other.questCount == questCount));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,subtitle,questCount);

@override
String toString() {
  return 'OrganizerEventEntity(id: $id, title: $title, subtitle: $subtitle, questCount: $questCount)';
}


}

/// @nodoc
abstract mixin class _$OrganizerEventEntityCopyWith<$Res> implements $OrganizerEventEntityCopyWith<$Res> {
  factory _$OrganizerEventEntityCopyWith(_OrganizerEventEntity value, $Res Function(_OrganizerEventEntity) _then) = __$OrganizerEventEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String subtitle, int questCount
});




}
/// @nodoc
class __$OrganizerEventEntityCopyWithImpl<$Res>
    implements _$OrganizerEventEntityCopyWith<$Res> {
  __$OrganizerEventEntityCopyWithImpl(this._self, this._then);

  final _OrganizerEventEntity _self;
  final $Res Function(_OrganizerEventEntity) _then;

/// Create a copy of OrganizerEventEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? subtitle = null,Object? questCount = null,}) {
  return _then(_OrganizerEventEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,questCount: null == questCount ? _self.questCount : questCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
