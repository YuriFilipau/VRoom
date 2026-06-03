// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ar_anchor_reach_result_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ArAnchorReachResultEntity {

 int get questId; String get anchorId; String get anchorRole; bool get testUnlocked; bool get questCompleted; bool get created; String? get requiredTestAnchorId; String? get finishAnchorId; Map<String, dynamic> get nextAction;
/// Create a copy of ArAnchorReachResultEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArAnchorReachResultEntityCopyWith<ArAnchorReachResultEntity> get copyWith => _$ArAnchorReachResultEntityCopyWithImpl<ArAnchorReachResultEntity>(this as ArAnchorReachResultEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArAnchorReachResultEntity&&(identical(other.questId, questId) || other.questId == questId)&&(identical(other.anchorId, anchorId) || other.anchorId == anchorId)&&(identical(other.anchorRole, anchorRole) || other.anchorRole == anchorRole)&&(identical(other.testUnlocked, testUnlocked) || other.testUnlocked == testUnlocked)&&(identical(other.questCompleted, questCompleted) || other.questCompleted == questCompleted)&&(identical(other.created, created) || other.created == created)&&(identical(other.requiredTestAnchorId, requiredTestAnchorId) || other.requiredTestAnchorId == requiredTestAnchorId)&&(identical(other.finishAnchorId, finishAnchorId) || other.finishAnchorId == finishAnchorId)&&const DeepCollectionEquality().equals(other.nextAction, nextAction));
}


@override
int get hashCode => Object.hash(runtimeType,questId,anchorId,anchorRole,testUnlocked,questCompleted,created,requiredTestAnchorId,finishAnchorId,const DeepCollectionEquality().hash(nextAction));

@override
String toString() {
  return 'ArAnchorReachResultEntity(questId: $questId, anchorId: $anchorId, anchorRole: $anchorRole, testUnlocked: $testUnlocked, questCompleted: $questCompleted, created: $created, requiredTestAnchorId: $requiredTestAnchorId, finishAnchorId: $finishAnchorId, nextAction: $nextAction)';
}


}

/// @nodoc
abstract mixin class $ArAnchorReachResultEntityCopyWith<$Res>  {
  factory $ArAnchorReachResultEntityCopyWith(ArAnchorReachResultEntity value, $Res Function(ArAnchorReachResultEntity) _then) = _$ArAnchorReachResultEntityCopyWithImpl;
@useResult
$Res call({
 int questId, String anchorId, String anchorRole, bool testUnlocked, bool questCompleted, bool created, String? requiredTestAnchorId, String? finishAnchorId, Map<String, dynamic> nextAction
});




}
/// @nodoc
class _$ArAnchorReachResultEntityCopyWithImpl<$Res>
    implements $ArAnchorReachResultEntityCopyWith<$Res> {
  _$ArAnchorReachResultEntityCopyWithImpl(this._self, this._then);

  final ArAnchorReachResultEntity _self;
  final $Res Function(ArAnchorReachResultEntity) _then;

/// Create a copy of ArAnchorReachResultEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? questId = null,Object? anchorId = null,Object? anchorRole = null,Object? testUnlocked = null,Object? questCompleted = null,Object? created = null,Object? requiredTestAnchorId = freezed,Object? finishAnchorId = freezed,Object? nextAction = null,}) {
  return _then(_self.copyWith(
questId: null == questId ? _self.questId : questId // ignore: cast_nullable_to_non_nullable
as int,anchorId: null == anchorId ? _self.anchorId : anchorId // ignore: cast_nullable_to_non_nullable
as String,anchorRole: null == anchorRole ? _self.anchorRole : anchorRole // ignore: cast_nullable_to_non_nullable
as String,testUnlocked: null == testUnlocked ? _self.testUnlocked : testUnlocked // ignore: cast_nullable_to_non_nullable
as bool,questCompleted: null == questCompleted ? _self.questCompleted : questCompleted // ignore: cast_nullable_to_non_nullable
as bool,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as bool,requiredTestAnchorId: freezed == requiredTestAnchorId ? _self.requiredTestAnchorId : requiredTestAnchorId // ignore: cast_nullable_to_non_nullable
as String?,finishAnchorId: freezed == finishAnchorId ? _self.finishAnchorId : finishAnchorId // ignore: cast_nullable_to_non_nullable
as String?,nextAction: null == nextAction ? _self.nextAction : nextAction // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [ArAnchorReachResultEntity].
extension ArAnchorReachResultEntityPatterns on ArAnchorReachResultEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArAnchorReachResultEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArAnchorReachResultEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArAnchorReachResultEntity value)  $default,){
final _that = this;
switch (_that) {
case _ArAnchorReachResultEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArAnchorReachResultEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ArAnchorReachResultEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int questId,  String anchorId,  String anchorRole,  bool testUnlocked,  bool questCompleted,  bool created,  String? requiredTestAnchorId,  String? finishAnchorId,  Map<String, dynamic> nextAction)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArAnchorReachResultEntity() when $default != null:
return $default(_that.questId,_that.anchorId,_that.anchorRole,_that.testUnlocked,_that.questCompleted,_that.created,_that.requiredTestAnchorId,_that.finishAnchorId,_that.nextAction);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int questId,  String anchorId,  String anchorRole,  bool testUnlocked,  bool questCompleted,  bool created,  String? requiredTestAnchorId,  String? finishAnchorId,  Map<String, dynamic> nextAction)  $default,) {final _that = this;
switch (_that) {
case _ArAnchorReachResultEntity():
return $default(_that.questId,_that.anchorId,_that.anchorRole,_that.testUnlocked,_that.questCompleted,_that.created,_that.requiredTestAnchorId,_that.finishAnchorId,_that.nextAction);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int questId,  String anchorId,  String anchorRole,  bool testUnlocked,  bool questCompleted,  bool created,  String? requiredTestAnchorId,  String? finishAnchorId,  Map<String, dynamic> nextAction)?  $default,) {final _that = this;
switch (_that) {
case _ArAnchorReachResultEntity() when $default != null:
return $default(_that.questId,_that.anchorId,_that.anchorRole,_that.testUnlocked,_that.questCompleted,_that.created,_that.requiredTestAnchorId,_that.finishAnchorId,_that.nextAction);case _:
  return null;

}
}

}

/// @nodoc


class _ArAnchorReachResultEntity implements ArAnchorReachResultEntity {
  const _ArAnchorReachResultEntity({required this.questId, required this.anchorId, required this.anchorRole, required this.testUnlocked, required this.questCompleted, required this.created, this.requiredTestAnchorId, this.finishAnchorId, final  Map<String, dynamic> nextAction = const {}}): _nextAction = nextAction;
  

@override final  int questId;
@override final  String anchorId;
@override final  String anchorRole;
@override final  bool testUnlocked;
@override final  bool questCompleted;
@override final  bool created;
@override final  String? requiredTestAnchorId;
@override final  String? finishAnchorId;
 final  Map<String, dynamic> _nextAction;
@override@JsonKey() Map<String, dynamic> get nextAction {
  if (_nextAction is EqualUnmodifiableMapView) return _nextAction;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_nextAction);
}


/// Create a copy of ArAnchorReachResultEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArAnchorReachResultEntityCopyWith<_ArAnchorReachResultEntity> get copyWith => __$ArAnchorReachResultEntityCopyWithImpl<_ArAnchorReachResultEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArAnchorReachResultEntity&&(identical(other.questId, questId) || other.questId == questId)&&(identical(other.anchorId, anchorId) || other.anchorId == anchorId)&&(identical(other.anchorRole, anchorRole) || other.anchorRole == anchorRole)&&(identical(other.testUnlocked, testUnlocked) || other.testUnlocked == testUnlocked)&&(identical(other.questCompleted, questCompleted) || other.questCompleted == questCompleted)&&(identical(other.created, created) || other.created == created)&&(identical(other.requiredTestAnchorId, requiredTestAnchorId) || other.requiredTestAnchorId == requiredTestAnchorId)&&(identical(other.finishAnchorId, finishAnchorId) || other.finishAnchorId == finishAnchorId)&&const DeepCollectionEquality().equals(other._nextAction, _nextAction));
}


@override
int get hashCode => Object.hash(runtimeType,questId,anchorId,anchorRole,testUnlocked,questCompleted,created,requiredTestAnchorId,finishAnchorId,const DeepCollectionEquality().hash(_nextAction));

@override
String toString() {
  return 'ArAnchorReachResultEntity(questId: $questId, anchorId: $anchorId, anchorRole: $anchorRole, testUnlocked: $testUnlocked, questCompleted: $questCompleted, created: $created, requiredTestAnchorId: $requiredTestAnchorId, finishAnchorId: $finishAnchorId, nextAction: $nextAction)';
}


}

/// @nodoc
abstract mixin class _$ArAnchorReachResultEntityCopyWith<$Res> implements $ArAnchorReachResultEntityCopyWith<$Res> {
  factory _$ArAnchorReachResultEntityCopyWith(_ArAnchorReachResultEntity value, $Res Function(_ArAnchorReachResultEntity) _then) = __$ArAnchorReachResultEntityCopyWithImpl;
@override @useResult
$Res call({
 int questId, String anchorId, String anchorRole, bool testUnlocked, bool questCompleted, bool created, String? requiredTestAnchorId, String? finishAnchorId, Map<String, dynamic> nextAction
});




}
/// @nodoc
class __$ArAnchorReachResultEntityCopyWithImpl<$Res>
    implements _$ArAnchorReachResultEntityCopyWith<$Res> {
  __$ArAnchorReachResultEntityCopyWithImpl(this._self, this._then);

  final _ArAnchorReachResultEntity _self;
  final $Res Function(_ArAnchorReachResultEntity) _then;

/// Create a copy of ArAnchorReachResultEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? questId = null,Object? anchorId = null,Object? anchorRole = null,Object? testUnlocked = null,Object? questCompleted = null,Object? created = null,Object? requiredTestAnchorId = freezed,Object? finishAnchorId = freezed,Object? nextAction = null,}) {
  return _then(_ArAnchorReachResultEntity(
questId: null == questId ? _self.questId : questId // ignore: cast_nullable_to_non_nullable
as int,anchorId: null == anchorId ? _self.anchorId : anchorId // ignore: cast_nullable_to_non_nullable
as String,anchorRole: null == anchorRole ? _self.anchorRole : anchorRole // ignore: cast_nullable_to_non_nullable
as String,testUnlocked: null == testUnlocked ? _self.testUnlocked : testUnlocked // ignore: cast_nullable_to_non_nullable
as bool,questCompleted: null == questCompleted ? _self.questCompleted : questCompleted // ignore: cast_nullable_to_non_nullable
as bool,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as bool,requiredTestAnchorId: freezed == requiredTestAnchorId ? _self.requiredTestAnchorId : requiredTestAnchorId // ignore: cast_nullable_to_non_nullable
as String?,finishAnchorId: freezed == finishAnchorId ? _self.finishAnchorId : finishAnchorId // ignore: cast_nullable_to_non_nullable
as String?,nextAction: null == nextAction ? _self._nextAction : nextAction // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
