// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserEntity {

 int get id; String get login; String get firstName; String get lastName; bool get isStaff; List<UserQuestEntity> get quests; List<UserAchievementEntity> get achievements; List<UserActivityEntity> get recentActivities;
/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserEntityCopyWith<UserEntity> get copyWith => _$UserEntityCopyWithImpl<UserEntity>(this as UserEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.login, login) || other.login == login)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.isStaff, isStaff) || other.isStaff == isStaff)&&const DeepCollectionEquality().equals(other.quests, quests)&&const DeepCollectionEquality().equals(other.achievements, achievements)&&const DeepCollectionEquality().equals(other.recentActivities, recentActivities));
}


@override
int get hashCode => Object.hash(runtimeType,id,login,firstName,lastName,isStaff,const DeepCollectionEquality().hash(quests),const DeepCollectionEquality().hash(achievements),const DeepCollectionEquality().hash(recentActivities));

@override
String toString() {
  return 'UserEntity(id: $id, login: $login, firstName: $firstName, lastName: $lastName, isStaff: $isStaff, quests: $quests, achievements: $achievements, recentActivities: $recentActivities)';
}


}

/// @nodoc
abstract mixin class $UserEntityCopyWith<$Res>  {
  factory $UserEntityCopyWith(UserEntity value, $Res Function(UserEntity) _then) = _$UserEntityCopyWithImpl;
@useResult
$Res call({
 int id, String login, String firstName, String lastName, bool isStaff, List<UserQuestEntity> quests, List<UserAchievementEntity> achievements, List<UserActivityEntity> recentActivities
});




}
/// @nodoc
class _$UserEntityCopyWithImpl<$Res>
    implements $UserEntityCopyWith<$Res> {
  _$UserEntityCopyWithImpl(this._self, this._then);

  final UserEntity _self;
  final $Res Function(UserEntity) _then;

/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? login = null,Object? firstName = null,Object? lastName = null,Object? isStaff = null,Object? quests = null,Object? achievements = null,Object? recentActivities = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,login: null == login ? _self.login : login // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,isStaff: null == isStaff ? _self.isStaff : isStaff // ignore: cast_nullable_to_non_nullable
as bool,quests: null == quests ? _self.quests : quests // ignore: cast_nullable_to_non_nullable
as List<UserQuestEntity>,achievements: null == achievements ? _self.achievements : achievements // ignore: cast_nullable_to_non_nullable
as List<UserAchievementEntity>,recentActivities: null == recentActivities ? _self.recentActivities : recentActivities // ignore: cast_nullable_to_non_nullable
as List<UserActivityEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [UserEntity].
extension UserEntityPatterns on UserEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserEntity value)  $default,){
final _that = this;
switch (_that) {
case _UserEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserEntity value)?  $default,){
final _that = this;
switch (_that) {
case _UserEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String login,  String firstName,  String lastName,  bool isStaff,  List<UserQuestEntity> quests,  List<UserAchievementEntity> achievements,  List<UserActivityEntity> recentActivities)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserEntity() when $default != null:
return $default(_that.id,_that.login,_that.firstName,_that.lastName,_that.isStaff,_that.quests,_that.achievements,_that.recentActivities);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String login,  String firstName,  String lastName,  bool isStaff,  List<UserQuestEntity> quests,  List<UserAchievementEntity> achievements,  List<UserActivityEntity> recentActivities)  $default,) {final _that = this;
switch (_that) {
case _UserEntity():
return $default(_that.id,_that.login,_that.firstName,_that.lastName,_that.isStaff,_that.quests,_that.achievements,_that.recentActivities);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String login,  String firstName,  String lastName,  bool isStaff,  List<UserQuestEntity> quests,  List<UserAchievementEntity> achievements,  List<UserActivityEntity> recentActivities)?  $default,) {final _that = this;
switch (_that) {
case _UserEntity() when $default != null:
return $default(_that.id,_that.login,_that.firstName,_that.lastName,_that.isStaff,_that.quests,_that.achievements,_that.recentActivities);case _:
  return null;

}
}

}

/// @nodoc


class _UserEntity implements UserEntity {
  const _UserEntity({required this.id, required this.login, required this.firstName, required this.lastName, required this.isStaff, required final  List<UserQuestEntity> quests, required final  List<UserAchievementEntity> achievements, required final  List<UserActivityEntity> recentActivities}): _quests = quests,_achievements = achievements,_recentActivities = recentActivities;
  

@override final  int id;
@override final  String login;
@override final  String firstName;
@override final  String lastName;
@override final  bool isStaff;
 final  List<UserQuestEntity> _quests;
@override List<UserQuestEntity> get quests {
  if (_quests is EqualUnmodifiableListView) return _quests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_quests);
}

 final  List<UserAchievementEntity> _achievements;
@override List<UserAchievementEntity> get achievements {
  if (_achievements is EqualUnmodifiableListView) return _achievements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_achievements);
}

 final  List<UserActivityEntity> _recentActivities;
@override List<UserActivityEntity> get recentActivities {
  if (_recentActivities is EqualUnmodifiableListView) return _recentActivities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentActivities);
}


/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserEntityCopyWith<_UserEntity> get copyWith => __$UserEntityCopyWithImpl<_UserEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.login, login) || other.login == login)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.isStaff, isStaff) || other.isStaff == isStaff)&&const DeepCollectionEquality().equals(other._quests, _quests)&&const DeepCollectionEquality().equals(other._achievements, _achievements)&&const DeepCollectionEquality().equals(other._recentActivities, _recentActivities));
}


@override
int get hashCode => Object.hash(runtimeType,id,login,firstName,lastName,isStaff,const DeepCollectionEquality().hash(_quests),const DeepCollectionEquality().hash(_achievements),const DeepCollectionEquality().hash(_recentActivities));

@override
String toString() {
  return 'UserEntity(id: $id, login: $login, firstName: $firstName, lastName: $lastName, isStaff: $isStaff, quests: $quests, achievements: $achievements, recentActivities: $recentActivities)';
}


}

/// @nodoc
abstract mixin class _$UserEntityCopyWith<$Res> implements $UserEntityCopyWith<$Res> {
  factory _$UserEntityCopyWith(_UserEntity value, $Res Function(_UserEntity) _then) = __$UserEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String login, String firstName, String lastName, bool isStaff, List<UserQuestEntity> quests, List<UserAchievementEntity> achievements, List<UserActivityEntity> recentActivities
});




}
/// @nodoc
class __$UserEntityCopyWithImpl<$Res>
    implements _$UserEntityCopyWith<$Res> {
  __$UserEntityCopyWithImpl(this._self, this._then);

  final _UserEntity _self;
  final $Res Function(_UserEntity) _then;

/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? login = null,Object? firstName = null,Object? lastName = null,Object? isStaff = null,Object? quests = null,Object? achievements = null,Object? recentActivities = null,}) {
  return _then(_UserEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,login: null == login ? _self.login : login // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,isStaff: null == isStaff ? _self.isStaff : isStaff // ignore: cast_nullable_to_non_nullable
as bool,quests: null == quests ? _self._quests : quests // ignore: cast_nullable_to_non_nullable
as List<UserQuestEntity>,achievements: null == achievements ? _self._achievements : achievements // ignore: cast_nullable_to_non_nullable
as List<UserAchievementEntity>,recentActivities: null == recentActivities ? _self._recentActivities : recentActivities // ignore: cast_nullable_to_non_nullable
as List<UserActivityEntity>,
  ));
}


}

// dart format on
