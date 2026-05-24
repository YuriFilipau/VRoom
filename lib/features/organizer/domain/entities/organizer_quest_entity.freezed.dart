// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'organizer_quest_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrganizerQuestEntity {

 int get id; String get title; int get assetCount; bool get hasScene;
/// Create a copy of OrganizerQuestEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrganizerQuestEntityCopyWith<OrganizerQuestEntity> get copyWith => _$OrganizerQuestEntityCopyWithImpl<OrganizerQuestEntity>(this as OrganizerQuestEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrganizerQuestEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.assetCount, assetCount) || other.assetCount == assetCount)&&(identical(other.hasScene, hasScene) || other.hasScene == hasScene));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,assetCount,hasScene);

@override
String toString() {
  return 'OrganizerQuestEntity(id: $id, title: $title, assetCount: $assetCount, hasScene: $hasScene)';
}


}

/// @nodoc
abstract mixin class $OrganizerQuestEntityCopyWith<$Res>  {
  factory $OrganizerQuestEntityCopyWith(OrganizerQuestEntity value, $Res Function(OrganizerQuestEntity) _then) = _$OrganizerQuestEntityCopyWithImpl;
@useResult
$Res call({
 int id, String title, int assetCount, bool hasScene
});




}
/// @nodoc
class _$OrganizerQuestEntityCopyWithImpl<$Res>
    implements $OrganizerQuestEntityCopyWith<$Res> {
  _$OrganizerQuestEntityCopyWithImpl(this._self, this._then);

  final OrganizerQuestEntity _self;
  final $Res Function(OrganizerQuestEntity) _then;

/// Create a copy of OrganizerQuestEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? assetCount = null,Object? hasScene = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,assetCount: null == assetCount ? _self.assetCount : assetCount // ignore: cast_nullable_to_non_nullable
as int,hasScene: null == hasScene ? _self.hasScene : hasScene // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [OrganizerQuestEntity].
extension OrganizerQuestEntityPatterns on OrganizerQuestEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrganizerQuestEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrganizerQuestEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrganizerQuestEntity value)  $default,){
final _that = this;
switch (_that) {
case _OrganizerQuestEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrganizerQuestEntity value)?  $default,){
final _that = this;
switch (_that) {
case _OrganizerQuestEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  int assetCount,  bool hasScene)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrganizerQuestEntity() when $default != null:
return $default(_that.id,_that.title,_that.assetCount,_that.hasScene);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  int assetCount,  bool hasScene)  $default,) {final _that = this;
switch (_that) {
case _OrganizerQuestEntity():
return $default(_that.id,_that.title,_that.assetCount,_that.hasScene);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  int assetCount,  bool hasScene)?  $default,) {final _that = this;
switch (_that) {
case _OrganizerQuestEntity() when $default != null:
return $default(_that.id,_that.title,_that.assetCount,_that.hasScene);case _:
  return null;

}
}

}

/// @nodoc


class _OrganizerQuestEntity implements OrganizerQuestEntity {
  const _OrganizerQuestEntity({required this.id, required this.title, required this.assetCount, required this.hasScene});
  

@override final  int id;
@override final  String title;
@override final  int assetCount;
@override final  bool hasScene;

/// Create a copy of OrganizerQuestEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrganizerQuestEntityCopyWith<_OrganizerQuestEntity> get copyWith => __$OrganizerQuestEntityCopyWithImpl<_OrganizerQuestEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrganizerQuestEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.assetCount, assetCount) || other.assetCount == assetCount)&&(identical(other.hasScene, hasScene) || other.hasScene == hasScene));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,assetCount,hasScene);

@override
String toString() {
  return 'OrganizerQuestEntity(id: $id, title: $title, assetCount: $assetCount, hasScene: $hasScene)';
}


}

/// @nodoc
abstract mixin class _$OrganizerQuestEntityCopyWith<$Res> implements $OrganizerQuestEntityCopyWith<$Res> {
  factory _$OrganizerQuestEntityCopyWith(_OrganizerQuestEntity value, $Res Function(_OrganizerQuestEntity) _then) = __$OrganizerQuestEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, int assetCount, bool hasScene
});




}
/// @nodoc
class __$OrganizerQuestEntityCopyWithImpl<$Res>
    implements _$OrganizerQuestEntityCopyWith<$Res> {
  __$OrganizerQuestEntityCopyWithImpl(this._self, this._then);

  final _OrganizerQuestEntity _self;
  final $Res Function(_OrganizerQuestEntity) _then;

/// Create a copy of OrganizerQuestEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? assetCount = null,Object? hasScene = null,}) {
  return _then(_OrganizerQuestEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,assetCount: null == assetCount ? _self.assetCount : assetCount // ignore: cast_nullable_to_non_nullable
as int,hasScene: null == hasScene ? _self.hasScene : hasScene // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
