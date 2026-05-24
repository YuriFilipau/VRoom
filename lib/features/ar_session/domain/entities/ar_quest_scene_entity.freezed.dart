// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ar_quest_scene_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ArQuestSceneEntity {

 String get sceneId; int get questId; int get eventId; String get title; int? get version; String? get updatedAt; int? get createdBy; bool get isPublished; List<ArAssetEntity> get assets; List<ArAssetPlacementEntity> get objects; ArSceneRootAnchorEntity? get rootAnchor; String? get arcoreToken;
/// Create a copy of ArQuestSceneEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArQuestSceneEntityCopyWith<ArQuestSceneEntity> get copyWith => _$ArQuestSceneEntityCopyWithImpl<ArQuestSceneEntity>(this as ArQuestSceneEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArQuestSceneEntity&&(identical(other.sceneId, sceneId) || other.sceneId == sceneId)&&(identical(other.questId, questId) || other.questId == questId)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.title, title) || other.title == title)&&(identical(other.version, version) || other.version == version)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.isPublished, isPublished) || other.isPublished == isPublished)&&const DeepCollectionEquality().equals(other.assets, assets)&&const DeepCollectionEquality().equals(other.objects, objects)&&(identical(other.rootAnchor, rootAnchor) || other.rootAnchor == rootAnchor)&&(identical(other.arcoreToken, arcoreToken) || other.arcoreToken == arcoreToken));
}


@override
int get hashCode => Object.hash(runtimeType,sceneId,questId,eventId,title,version,updatedAt,createdBy,isPublished,const DeepCollectionEquality().hash(assets),const DeepCollectionEquality().hash(objects),rootAnchor,arcoreToken);

@override
String toString() {
  return 'ArQuestSceneEntity(sceneId: $sceneId, questId: $questId, eventId: $eventId, title: $title, version: $version, updatedAt: $updatedAt, createdBy: $createdBy, isPublished: $isPublished, assets: $assets, objects: $objects, rootAnchor: $rootAnchor, arcoreToken: $arcoreToken)';
}


}

/// @nodoc
abstract mixin class $ArQuestSceneEntityCopyWith<$Res>  {
  factory $ArQuestSceneEntityCopyWith(ArQuestSceneEntity value, $Res Function(ArQuestSceneEntity) _then) = _$ArQuestSceneEntityCopyWithImpl;
@useResult
$Res call({
 String sceneId, int questId, int eventId, String title, int? version, String? updatedAt, int? createdBy, bool isPublished, List<ArAssetEntity> assets, List<ArAssetPlacementEntity> objects, ArSceneRootAnchorEntity? rootAnchor, String? arcoreToken
});


$ArSceneRootAnchorEntityCopyWith<$Res>? get rootAnchor;

}
/// @nodoc
class _$ArQuestSceneEntityCopyWithImpl<$Res>
    implements $ArQuestSceneEntityCopyWith<$Res> {
  _$ArQuestSceneEntityCopyWithImpl(this._self, this._then);

  final ArQuestSceneEntity _self;
  final $Res Function(ArQuestSceneEntity) _then;

/// Create a copy of ArQuestSceneEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sceneId = null,Object? questId = null,Object? eventId = null,Object? title = null,Object? version = freezed,Object? updatedAt = freezed,Object? createdBy = freezed,Object? isPublished = null,Object? assets = null,Object? objects = null,Object? rootAnchor = freezed,Object? arcoreToken = freezed,}) {
  return _then(_self.copyWith(
sceneId: null == sceneId ? _self.sceneId : sceneId // ignore: cast_nullable_to_non_nullable
as String,questId: null == questId ? _self.questId : questId // ignore: cast_nullable_to_non_nullable
as int,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as int?,isPublished: null == isPublished ? _self.isPublished : isPublished // ignore: cast_nullable_to_non_nullable
as bool,assets: null == assets ? _self.assets : assets // ignore: cast_nullable_to_non_nullable
as List<ArAssetEntity>,objects: null == objects ? _self.objects : objects // ignore: cast_nullable_to_non_nullable
as List<ArAssetPlacementEntity>,rootAnchor: freezed == rootAnchor ? _self.rootAnchor : rootAnchor // ignore: cast_nullable_to_non_nullable
as ArSceneRootAnchorEntity?,arcoreToken: freezed == arcoreToken ? _self.arcoreToken : arcoreToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ArQuestSceneEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArSceneRootAnchorEntityCopyWith<$Res>? get rootAnchor {
    if (_self.rootAnchor == null) {
    return null;
  }

  return $ArSceneRootAnchorEntityCopyWith<$Res>(_self.rootAnchor!, (value) {
    return _then(_self.copyWith(rootAnchor: value));
  });
}
}


/// Adds pattern-matching-related methods to [ArQuestSceneEntity].
extension ArQuestSceneEntityPatterns on ArQuestSceneEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArQuestSceneEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArQuestSceneEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArQuestSceneEntity value)  $default,){
final _that = this;
switch (_that) {
case _ArQuestSceneEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArQuestSceneEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ArQuestSceneEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sceneId,  int questId,  int eventId,  String title,  int? version,  String? updatedAt,  int? createdBy,  bool isPublished,  List<ArAssetEntity> assets,  List<ArAssetPlacementEntity> objects,  ArSceneRootAnchorEntity? rootAnchor,  String? arcoreToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArQuestSceneEntity() when $default != null:
return $default(_that.sceneId,_that.questId,_that.eventId,_that.title,_that.version,_that.updatedAt,_that.createdBy,_that.isPublished,_that.assets,_that.objects,_that.rootAnchor,_that.arcoreToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sceneId,  int questId,  int eventId,  String title,  int? version,  String? updatedAt,  int? createdBy,  bool isPublished,  List<ArAssetEntity> assets,  List<ArAssetPlacementEntity> objects,  ArSceneRootAnchorEntity? rootAnchor,  String? arcoreToken)  $default,) {final _that = this;
switch (_that) {
case _ArQuestSceneEntity():
return $default(_that.sceneId,_that.questId,_that.eventId,_that.title,_that.version,_that.updatedAt,_that.createdBy,_that.isPublished,_that.assets,_that.objects,_that.rootAnchor,_that.arcoreToken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sceneId,  int questId,  int eventId,  String title,  int? version,  String? updatedAt,  int? createdBy,  bool isPublished,  List<ArAssetEntity> assets,  List<ArAssetPlacementEntity> objects,  ArSceneRootAnchorEntity? rootAnchor,  String? arcoreToken)?  $default,) {final _that = this;
switch (_that) {
case _ArQuestSceneEntity() when $default != null:
return $default(_that.sceneId,_that.questId,_that.eventId,_that.title,_that.version,_that.updatedAt,_that.createdBy,_that.isPublished,_that.assets,_that.objects,_that.rootAnchor,_that.arcoreToken);case _:
  return null;

}
}

}

/// @nodoc


class _ArQuestSceneEntity implements ArQuestSceneEntity {
  const _ArQuestSceneEntity({required this.sceneId, required this.questId, required this.eventId, required this.title, required this.version, required this.updatedAt, required this.createdBy, required this.isPublished, required final  List<ArAssetEntity> assets, required final  List<ArAssetPlacementEntity> objects, this.rootAnchor, this.arcoreToken}): _assets = assets,_objects = objects;
  

@override final  String sceneId;
@override final  int questId;
@override final  int eventId;
@override final  String title;
@override final  int? version;
@override final  String? updatedAt;
@override final  int? createdBy;
@override final  bool isPublished;
 final  List<ArAssetEntity> _assets;
@override List<ArAssetEntity> get assets {
  if (_assets is EqualUnmodifiableListView) return _assets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_assets);
}

 final  List<ArAssetPlacementEntity> _objects;
@override List<ArAssetPlacementEntity> get objects {
  if (_objects is EqualUnmodifiableListView) return _objects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_objects);
}

@override final  ArSceneRootAnchorEntity? rootAnchor;
@override final  String? arcoreToken;

/// Create a copy of ArQuestSceneEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArQuestSceneEntityCopyWith<_ArQuestSceneEntity> get copyWith => __$ArQuestSceneEntityCopyWithImpl<_ArQuestSceneEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArQuestSceneEntity&&(identical(other.sceneId, sceneId) || other.sceneId == sceneId)&&(identical(other.questId, questId) || other.questId == questId)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.title, title) || other.title == title)&&(identical(other.version, version) || other.version == version)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.isPublished, isPublished) || other.isPublished == isPublished)&&const DeepCollectionEquality().equals(other._assets, _assets)&&const DeepCollectionEquality().equals(other._objects, _objects)&&(identical(other.rootAnchor, rootAnchor) || other.rootAnchor == rootAnchor)&&(identical(other.arcoreToken, arcoreToken) || other.arcoreToken == arcoreToken));
}


@override
int get hashCode => Object.hash(runtimeType,sceneId,questId,eventId,title,version,updatedAt,createdBy,isPublished,const DeepCollectionEquality().hash(_assets),const DeepCollectionEquality().hash(_objects),rootAnchor,arcoreToken);

@override
String toString() {
  return 'ArQuestSceneEntity(sceneId: $sceneId, questId: $questId, eventId: $eventId, title: $title, version: $version, updatedAt: $updatedAt, createdBy: $createdBy, isPublished: $isPublished, assets: $assets, objects: $objects, rootAnchor: $rootAnchor, arcoreToken: $arcoreToken)';
}


}

/// @nodoc
abstract mixin class _$ArQuestSceneEntityCopyWith<$Res> implements $ArQuestSceneEntityCopyWith<$Res> {
  factory _$ArQuestSceneEntityCopyWith(_ArQuestSceneEntity value, $Res Function(_ArQuestSceneEntity) _then) = __$ArQuestSceneEntityCopyWithImpl;
@override @useResult
$Res call({
 String sceneId, int questId, int eventId, String title, int? version, String? updatedAt, int? createdBy, bool isPublished, List<ArAssetEntity> assets, List<ArAssetPlacementEntity> objects, ArSceneRootAnchorEntity? rootAnchor, String? arcoreToken
});


@override $ArSceneRootAnchorEntityCopyWith<$Res>? get rootAnchor;

}
/// @nodoc
class __$ArQuestSceneEntityCopyWithImpl<$Res>
    implements _$ArQuestSceneEntityCopyWith<$Res> {
  __$ArQuestSceneEntityCopyWithImpl(this._self, this._then);

  final _ArQuestSceneEntity _self;
  final $Res Function(_ArQuestSceneEntity) _then;

/// Create a copy of ArQuestSceneEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sceneId = null,Object? questId = null,Object? eventId = null,Object? title = null,Object? version = freezed,Object? updatedAt = freezed,Object? createdBy = freezed,Object? isPublished = null,Object? assets = null,Object? objects = null,Object? rootAnchor = freezed,Object? arcoreToken = freezed,}) {
  return _then(_ArQuestSceneEntity(
sceneId: null == sceneId ? _self.sceneId : sceneId // ignore: cast_nullable_to_non_nullable
as String,questId: null == questId ? _self.questId : questId // ignore: cast_nullable_to_non_nullable
as int,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as int?,isPublished: null == isPublished ? _self.isPublished : isPublished // ignore: cast_nullable_to_non_nullable
as bool,assets: null == assets ? _self._assets : assets // ignore: cast_nullable_to_non_nullable
as List<ArAssetEntity>,objects: null == objects ? _self._objects : objects // ignore: cast_nullable_to_non_nullable
as List<ArAssetPlacementEntity>,rootAnchor: freezed == rootAnchor ? _self.rootAnchor : rootAnchor // ignore: cast_nullable_to_non_nullable
as ArSceneRootAnchorEntity?,arcoreToken: freezed == arcoreToken ? _self.arcoreToken : arcoreToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ArQuestSceneEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArSceneRootAnchorEntityCopyWith<$Res>? get rootAnchor {
    if (_self.rootAnchor == null) {
    return null;
  }

  return $ArSceneRootAnchorEntityCopyWith<$Res>(_self.rootAnchor!, (value) {
    return _then(_self.copyWith(rootAnchor: value));
  });
}
}

// dart format on
