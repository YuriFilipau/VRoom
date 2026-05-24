// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'participant_profile_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ParticipantProfileEntity {

 int get id; String get login; String get firstName; String get lastName; bool get isStaff; List<UserAchievementEntity> get achievements; List<UserActivityEntity> get recentActivities; int get joinedEventsCount; int get completedQuestsCount;
/// Create a copy of ParticipantProfileEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParticipantProfileEntityCopyWith<ParticipantProfileEntity> get copyWith => _$ParticipantProfileEntityCopyWithImpl<ParticipantProfileEntity>(this as ParticipantProfileEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParticipantProfileEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.login, login) || other.login == login)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.isStaff, isStaff) || other.isStaff == isStaff)&&const DeepCollectionEquality().equals(other.achievements, achievements)&&const DeepCollectionEquality().equals(other.recentActivities, recentActivities)&&(identical(other.joinedEventsCount, joinedEventsCount) || other.joinedEventsCount == joinedEventsCount)&&(identical(other.completedQuestsCount, completedQuestsCount) || other.completedQuestsCount == completedQuestsCount));
}


@override
int get hashCode => Object.hash(runtimeType,id,login,firstName,lastName,isStaff,const DeepCollectionEquality().hash(achievements),const DeepCollectionEquality().hash(recentActivities),joinedEventsCount,completedQuestsCount);

@override
String toString() {
  return 'ParticipantProfileEntity(id: $id, login: $login, firstName: $firstName, lastName: $lastName, isStaff: $isStaff, achievements: $achievements, recentActivities: $recentActivities, joinedEventsCount: $joinedEventsCount, completedQuestsCount: $completedQuestsCount)';
}


}

/// @nodoc
abstract mixin class $ParticipantProfileEntityCopyWith<$Res>  {
  factory $ParticipantProfileEntityCopyWith(ParticipantProfileEntity value, $Res Function(ParticipantProfileEntity) _then) = _$ParticipantProfileEntityCopyWithImpl;
@useResult
$Res call({
 int id, String login, String firstName, String lastName, bool isStaff, List<UserAchievementEntity> achievements, List<UserActivityEntity> recentActivities, int joinedEventsCount, int completedQuestsCount
});




}
/// @nodoc
class _$ParticipantProfileEntityCopyWithImpl<$Res>
    implements $ParticipantProfileEntityCopyWith<$Res> {
  _$ParticipantProfileEntityCopyWithImpl(this._self, this._then);

  final ParticipantProfileEntity _self;
  final $Res Function(ParticipantProfileEntity) _then;

/// Create a copy of ParticipantProfileEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? login = null,Object? firstName = null,Object? lastName = null,Object? isStaff = null,Object? achievements = null,Object? recentActivities = null,Object? joinedEventsCount = null,Object? completedQuestsCount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,login: null == login ? _self.login : login // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,isStaff: null == isStaff ? _self.isStaff : isStaff // ignore: cast_nullable_to_non_nullable
as bool,achievements: null == achievements ? _self.achievements : achievements // ignore: cast_nullable_to_non_nullable
as List<UserAchievementEntity>,recentActivities: null == recentActivities ? _self.recentActivities : recentActivities // ignore: cast_nullable_to_non_nullable
as List<UserActivityEntity>,joinedEventsCount: null == joinedEventsCount ? _self.joinedEventsCount : joinedEventsCount // ignore: cast_nullable_to_non_nullable
as int,completedQuestsCount: null == completedQuestsCount ? _self.completedQuestsCount : completedQuestsCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ParticipantProfileEntity].
extension ParticipantProfileEntityPatterns on ParticipantProfileEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ParticipantProfileEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ParticipantProfileEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ParticipantProfileEntity value)  $default,){
final _that = this;
switch (_that) {
case _ParticipantProfileEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ParticipantProfileEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ParticipantProfileEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String login,  String firstName,  String lastName,  bool isStaff,  List<UserAchievementEntity> achievements,  List<UserActivityEntity> recentActivities,  int joinedEventsCount,  int completedQuestsCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ParticipantProfileEntity() when $default != null:
return $default(_that.id,_that.login,_that.firstName,_that.lastName,_that.isStaff,_that.achievements,_that.recentActivities,_that.joinedEventsCount,_that.completedQuestsCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String login,  String firstName,  String lastName,  bool isStaff,  List<UserAchievementEntity> achievements,  List<UserActivityEntity> recentActivities,  int joinedEventsCount,  int completedQuestsCount)  $default,) {final _that = this;
switch (_that) {
case _ParticipantProfileEntity():
return $default(_that.id,_that.login,_that.firstName,_that.lastName,_that.isStaff,_that.achievements,_that.recentActivities,_that.joinedEventsCount,_that.completedQuestsCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String login,  String firstName,  String lastName,  bool isStaff,  List<UserAchievementEntity> achievements,  List<UserActivityEntity> recentActivities,  int joinedEventsCount,  int completedQuestsCount)?  $default,) {final _that = this;
switch (_that) {
case _ParticipantProfileEntity() when $default != null:
return $default(_that.id,_that.login,_that.firstName,_that.lastName,_that.isStaff,_that.achievements,_that.recentActivities,_that.joinedEventsCount,_that.completedQuestsCount);case _:
  return null;

}
}

}

/// @nodoc


class _ParticipantProfileEntity implements ParticipantProfileEntity {
  const _ParticipantProfileEntity({required this.id, required this.login, required this.firstName, required this.lastName, required this.isStaff, required final  List<UserAchievementEntity> achievements, required final  List<UserActivityEntity> recentActivities, required this.joinedEventsCount, required this.completedQuestsCount}): _achievements = achievements,_recentActivities = recentActivities;
  

@override final  int id;
@override final  String login;
@override final  String firstName;
@override final  String lastName;
@override final  bool isStaff;
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

@override final  int joinedEventsCount;
@override final  int completedQuestsCount;

/// Create a copy of ParticipantProfileEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParticipantProfileEntityCopyWith<_ParticipantProfileEntity> get copyWith => __$ParticipantProfileEntityCopyWithImpl<_ParticipantProfileEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParticipantProfileEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.login, login) || other.login == login)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.isStaff, isStaff) || other.isStaff == isStaff)&&const DeepCollectionEquality().equals(other._achievements, _achievements)&&const DeepCollectionEquality().equals(other._recentActivities, _recentActivities)&&(identical(other.joinedEventsCount, joinedEventsCount) || other.joinedEventsCount == joinedEventsCount)&&(identical(other.completedQuestsCount, completedQuestsCount) || other.completedQuestsCount == completedQuestsCount));
}


@override
int get hashCode => Object.hash(runtimeType,id,login,firstName,lastName,isStaff,const DeepCollectionEquality().hash(_achievements),const DeepCollectionEquality().hash(_recentActivities),joinedEventsCount,completedQuestsCount);

@override
String toString() {
  return 'ParticipantProfileEntity(id: $id, login: $login, firstName: $firstName, lastName: $lastName, isStaff: $isStaff, achievements: $achievements, recentActivities: $recentActivities, joinedEventsCount: $joinedEventsCount, completedQuestsCount: $completedQuestsCount)';
}


}

/// @nodoc
abstract mixin class _$ParticipantProfileEntityCopyWith<$Res> implements $ParticipantProfileEntityCopyWith<$Res> {
  factory _$ParticipantProfileEntityCopyWith(_ParticipantProfileEntity value, $Res Function(_ParticipantProfileEntity) _then) = __$ParticipantProfileEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String login, String firstName, String lastName, bool isStaff, List<UserAchievementEntity> achievements, List<UserActivityEntity> recentActivities, int joinedEventsCount, int completedQuestsCount
});




}
/// @nodoc
class __$ParticipantProfileEntityCopyWithImpl<$Res>
    implements _$ParticipantProfileEntityCopyWith<$Res> {
  __$ParticipantProfileEntityCopyWithImpl(this._self, this._then);

  final _ParticipantProfileEntity _self;
  final $Res Function(_ParticipantProfileEntity) _then;

/// Create a copy of ParticipantProfileEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? login = null,Object? firstName = null,Object? lastName = null,Object? isStaff = null,Object? achievements = null,Object? recentActivities = null,Object? joinedEventsCount = null,Object? completedQuestsCount = null,}) {
  return _then(_ParticipantProfileEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,login: null == login ? _self.login : login // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,isStaff: null == isStaff ? _self.isStaff : isStaff // ignore: cast_nullable_to_non_nullable
as bool,achievements: null == achievements ? _self._achievements : achievements // ignore: cast_nullable_to_non_nullable
as List<UserAchievementEntity>,recentActivities: null == recentActivities ? _self._recentActivities : recentActivities // ignore: cast_nullable_to_non_nullable
as List<UserActivityEntity>,joinedEventsCount: null == joinedEventsCount ? _self.joinedEventsCount : joinedEventsCount // ignore: cast_nullable_to_non_nullable
as int,completedQuestsCount: null == completedQuestsCount ? _self.completedQuestsCount : completedQuestsCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
