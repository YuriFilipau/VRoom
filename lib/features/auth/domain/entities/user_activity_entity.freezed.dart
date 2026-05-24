// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_activity_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserActivityEntity {

 int get id; String get title; String get timeLabel;
/// Create a copy of UserActivityEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserActivityEntityCopyWith<UserActivityEntity> get copyWith => _$UserActivityEntityCopyWithImpl<UserActivityEntity>(this as UserActivityEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserActivityEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.timeLabel, timeLabel) || other.timeLabel == timeLabel));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,timeLabel);

@override
String toString() {
  return 'UserActivityEntity(id: $id, title: $title, timeLabel: $timeLabel)';
}


}

/// @nodoc
abstract mixin class $UserActivityEntityCopyWith<$Res>  {
  factory $UserActivityEntityCopyWith(UserActivityEntity value, $Res Function(UserActivityEntity) _then) = _$UserActivityEntityCopyWithImpl;
@useResult
$Res call({
 int id, String title, String timeLabel
});




}
/// @nodoc
class _$UserActivityEntityCopyWithImpl<$Res>
    implements $UserActivityEntityCopyWith<$Res> {
  _$UserActivityEntityCopyWithImpl(this._self, this._then);

  final UserActivityEntity _self;
  final $Res Function(UserActivityEntity) _then;

/// Create a copy of UserActivityEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? timeLabel = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,timeLabel: null == timeLabel ? _self.timeLabel : timeLabel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UserActivityEntity].
extension UserActivityEntityPatterns on UserActivityEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserActivityEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserActivityEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserActivityEntity value)  $default,){
final _that = this;
switch (_that) {
case _UserActivityEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserActivityEntity value)?  $default,){
final _that = this;
switch (_that) {
case _UserActivityEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String timeLabel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserActivityEntity() when $default != null:
return $default(_that.id,_that.title,_that.timeLabel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String timeLabel)  $default,) {final _that = this;
switch (_that) {
case _UserActivityEntity():
return $default(_that.id,_that.title,_that.timeLabel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String timeLabel)?  $default,) {final _that = this;
switch (_that) {
case _UserActivityEntity() when $default != null:
return $default(_that.id,_that.title,_that.timeLabel);case _:
  return null;

}
}

}

/// @nodoc


class _UserActivityEntity implements UserActivityEntity {
  const _UserActivityEntity({required this.id, required this.title, required this.timeLabel});
  

@override final  int id;
@override final  String title;
@override final  String timeLabel;

/// Create a copy of UserActivityEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserActivityEntityCopyWith<_UserActivityEntity> get copyWith => __$UserActivityEntityCopyWithImpl<_UserActivityEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserActivityEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.timeLabel, timeLabel) || other.timeLabel == timeLabel));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,timeLabel);

@override
String toString() {
  return 'UserActivityEntity(id: $id, title: $title, timeLabel: $timeLabel)';
}


}

/// @nodoc
abstract mixin class _$UserActivityEntityCopyWith<$Res> implements $UserActivityEntityCopyWith<$Res> {
  factory _$UserActivityEntityCopyWith(_UserActivityEntity value, $Res Function(_UserActivityEntity) _then) = __$UserActivityEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String timeLabel
});




}
/// @nodoc
class __$UserActivityEntityCopyWithImpl<$Res>
    implements _$UserActivityEntityCopyWith<$Res> {
  __$UserActivityEntityCopyWithImpl(this._self, this._then);

  final _UserActivityEntity _self;
  final $Res Function(_UserActivityEntity) _then;

/// Create a copy of UserActivityEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? timeLabel = null,}) {
  return _then(_UserActivityEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,timeLabel: null == timeLabel ? _self.timeLabel : timeLabel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
