// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_achievement_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserAchievement {

 int get id; String get title;@JsonKey(name: 'icon_key') String get iconKey;@JsonKey(name: 'is_unlocked') bool get isUnlocked;
/// Create a copy of UserAchievement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserAchievementCopyWith<UserAchievement> get copyWith => _$UserAchievementCopyWithImpl<UserAchievement>(this as UserAchievement, _$identity);

  /// Serializes this UserAchievement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserAchievement&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.iconKey, iconKey) || other.iconKey == iconKey)&&(identical(other.isUnlocked, isUnlocked) || other.isUnlocked == isUnlocked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,iconKey,isUnlocked);

@override
String toString() {
  return 'UserAchievement(id: $id, title: $title, iconKey: $iconKey, isUnlocked: $isUnlocked)';
}


}

/// @nodoc
abstract mixin class $UserAchievementCopyWith<$Res>  {
  factory $UserAchievementCopyWith(UserAchievement value, $Res Function(UserAchievement) _then) = _$UserAchievementCopyWithImpl;
@useResult
$Res call({
 int id, String title,@JsonKey(name: 'icon_key') String iconKey,@JsonKey(name: 'is_unlocked') bool isUnlocked
});




}
/// @nodoc
class _$UserAchievementCopyWithImpl<$Res>
    implements $UserAchievementCopyWith<$Res> {
  _$UserAchievementCopyWithImpl(this._self, this._then);

  final UserAchievement _self;
  final $Res Function(UserAchievement) _then;

/// Create a copy of UserAchievement
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


/// Adds pattern-matching-related methods to [UserAchievement].
extension UserAchievementPatterns on UserAchievement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserAchievement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserAchievement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserAchievement value)  $default,){
final _that = this;
switch (_that) {
case _UserAchievement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserAchievement value)?  $default,){
final _that = this;
switch (_that) {
case _UserAchievement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title, @JsonKey(name: 'icon_key')  String iconKey, @JsonKey(name: 'is_unlocked')  bool isUnlocked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserAchievement() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title, @JsonKey(name: 'icon_key')  String iconKey, @JsonKey(name: 'is_unlocked')  bool isUnlocked)  $default,) {final _that = this;
switch (_that) {
case _UserAchievement():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title, @JsonKey(name: 'icon_key')  String iconKey, @JsonKey(name: 'is_unlocked')  bool isUnlocked)?  $default,) {final _that = this;
switch (_that) {
case _UserAchievement() when $default != null:
return $default(_that.id,_that.title,_that.iconKey,_that.isUnlocked);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserAchievement extends UserAchievement {
  const _UserAchievement({required this.id, required this.title, @JsonKey(name: 'icon_key') required this.iconKey, @JsonKey(name: 'is_unlocked') required this.isUnlocked}): super._();
  factory _UserAchievement.fromJson(Map<String, dynamic> json) => _$UserAchievementFromJson(json);

@override final  int id;
@override final  String title;
@override@JsonKey(name: 'icon_key') final  String iconKey;
@override@JsonKey(name: 'is_unlocked') final  bool isUnlocked;

/// Create a copy of UserAchievement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserAchievementCopyWith<_UserAchievement> get copyWith => __$UserAchievementCopyWithImpl<_UserAchievement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserAchievementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserAchievement&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.iconKey, iconKey) || other.iconKey == iconKey)&&(identical(other.isUnlocked, isUnlocked) || other.isUnlocked == isUnlocked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,iconKey,isUnlocked);

@override
String toString() {
  return 'UserAchievement(id: $id, title: $title, iconKey: $iconKey, isUnlocked: $isUnlocked)';
}


}

/// @nodoc
abstract mixin class _$UserAchievementCopyWith<$Res> implements $UserAchievementCopyWith<$Res> {
  factory _$UserAchievementCopyWith(_UserAchievement value, $Res Function(_UserAchievement) _then) = __$UserAchievementCopyWithImpl;
@override @useResult
$Res call({
 int id, String title,@JsonKey(name: 'icon_key') String iconKey,@JsonKey(name: 'is_unlocked') bool isUnlocked
});




}
/// @nodoc
class __$UserAchievementCopyWithImpl<$Res>
    implements _$UserAchievementCopyWith<$Res> {
  __$UserAchievementCopyWithImpl(this._self, this._then);

  final _UserAchievement _self;
  final $Res Function(_UserAchievement) _then;

/// Create a copy of UserAchievement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? iconKey = null,Object? isUnlocked = null,}) {
  return _then(_UserAchievement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,iconKey: null == iconKey ? _self.iconKey : iconKey // ignore: cast_nullable_to_non_nullable
as String,isUnlocked: null == isUnlocked ? _self.isUnlocked : isUnlocked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
