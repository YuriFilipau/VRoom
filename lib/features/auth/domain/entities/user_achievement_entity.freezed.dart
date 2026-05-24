// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_achievement_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserAchievementEntity {

 int get id; String get title; String get iconKey; bool get isUnlocked;
/// Create a copy of UserAchievementEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserAchievementEntityCopyWith<UserAchievementEntity> get copyWith => _$UserAchievementEntityCopyWithImpl<UserAchievementEntity>(this as UserAchievementEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserAchievementEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.iconKey, iconKey) || other.iconKey == iconKey)&&(identical(other.isUnlocked, isUnlocked) || other.isUnlocked == isUnlocked));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,iconKey,isUnlocked);

@override
String toString() {
  return 'UserAchievementEntity(id: $id, title: $title, iconKey: $iconKey, isUnlocked: $isUnlocked)';
}


}

/// @nodoc
abstract mixin class $UserAchievementEntityCopyWith<$Res>  {
  factory $UserAchievementEntityCopyWith(UserAchievementEntity value, $Res Function(UserAchievementEntity) _then) = _$UserAchievementEntityCopyWithImpl;
@useResult
$Res call({
 int id, String title, String iconKey, bool isUnlocked
});




}
/// @nodoc
class _$UserAchievementEntityCopyWithImpl<$Res>
    implements $UserAchievementEntityCopyWith<$Res> {
  _$UserAchievementEntityCopyWithImpl(this._self, this._then);

  final UserAchievementEntity _self;
  final $Res Function(UserAchievementEntity) _then;

/// Create a copy of UserAchievementEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? iconKey = null,Object? isUnlocked = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,iconKey: null == iconKey ? _self.iconKey : iconKey // ignore: cast_nullable_to_non_nullable
as String,isUnlocked: null == isUnlocked ? _self.isUnlocked : isUnlocked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [UserAchievementEntity].
extension UserAchievementEntityPatterns on UserAchievementEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserAchievementEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserAchievementEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserAchievementEntity value)  $default,){
final _that = this;
switch (_that) {
case _UserAchievementEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserAchievementEntity value)?  $default,){
final _that = this;
switch (_that) {
case _UserAchievementEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String iconKey,  bool isUnlocked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserAchievementEntity() when $default != null:
return $default(_that.id,_that.title,_that.iconKey,_that.isUnlocked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String iconKey,  bool isUnlocked)  $default,) {final _that = this;
switch (_that) {
case _UserAchievementEntity():
return $default(_that.id,_that.title,_that.iconKey,_that.isUnlocked);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String iconKey,  bool isUnlocked)?  $default,) {final _that = this;
switch (_that) {
case _UserAchievementEntity() when $default != null:
return $default(_that.id,_that.title,_that.iconKey,_that.isUnlocked);case _:
  return null;

}
}

}

/// @nodoc


class _UserAchievementEntity implements UserAchievementEntity {
  const _UserAchievementEntity({required this.id, required this.title, required this.iconKey, required this.isUnlocked});
  

@override final  int id;
@override final  String title;
@override final  String iconKey;
@override final  bool isUnlocked;

/// Create a copy of UserAchievementEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserAchievementEntityCopyWith<_UserAchievementEntity> get copyWith => __$UserAchievementEntityCopyWithImpl<_UserAchievementEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserAchievementEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.iconKey, iconKey) || other.iconKey == iconKey)&&(identical(other.isUnlocked, isUnlocked) || other.isUnlocked == isUnlocked));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,iconKey,isUnlocked);

@override
String toString() {
  return 'UserAchievementEntity(id: $id, title: $title, iconKey: $iconKey, isUnlocked: $isUnlocked)';
}


}

/// @nodoc
abstract mixin class _$UserAchievementEntityCopyWith<$Res> implements $UserAchievementEntityCopyWith<$Res> {
  factory _$UserAchievementEntityCopyWith(_UserAchievementEntity value, $Res Function(_UserAchievementEntity) _then) = __$UserAchievementEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String iconKey, bool isUnlocked
});




}
/// @nodoc
class __$UserAchievementEntityCopyWithImpl<$Res>
    implements _$UserAchievementEntityCopyWith<$Res> {
  __$UserAchievementEntityCopyWithImpl(this._self, this._then);

  final _UserAchievementEntity _self;
  final $Res Function(_UserAchievementEntity) _then;

/// Create a copy of UserAchievementEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? iconKey = null,Object? isUnlocked = null,}) {
  return _then(_UserAchievementEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,iconKey: null == iconKey ? _self.iconKey : iconKey // ignore: cast_nullable_to_non_nullable
as String,isUnlocked: null == isUnlocked ? _self.isUnlocked : isUnlocked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
