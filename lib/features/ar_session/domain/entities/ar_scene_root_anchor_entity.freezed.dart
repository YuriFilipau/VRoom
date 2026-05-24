// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ar_scene_root_anchor_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ArSceneRootAnchorEntity {

 String get anchorName; String get cloudAnchorId; List<double> get anchorTransform; int get ttl; String? get platform;
/// Create a copy of ArSceneRootAnchorEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArSceneRootAnchorEntityCopyWith<ArSceneRootAnchorEntity> get copyWith => _$ArSceneRootAnchorEntityCopyWithImpl<ArSceneRootAnchorEntity>(this as ArSceneRootAnchorEntity, _$identity);

  /// Serializes this ArSceneRootAnchorEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArSceneRootAnchorEntity&&(identical(other.anchorName, anchorName) || other.anchorName == anchorName)&&(identical(other.cloudAnchorId, cloudAnchorId) || other.cloudAnchorId == cloudAnchorId)&&const DeepCollectionEquality().equals(other.anchorTransform, anchorTransform)&&(identical(other.ttl, ttl) || other.ttl == ttl)&&(identical(other.platform, platform) || other.platform == platform));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,anchorName,cloudAnchorId,const DeepCollectionEquality().hash(anchorTransform),ttl,platform);

@override
String toString() {
  return 'ArSceneRootAnchorEntity(anchorName: $anchorName, cloudAnchorId: $cloudAnchorId, anchorTransform: $anchorTransform, ttl: $ttl, platform: $platform)';
}


}

/// @nodoc
abstract mixin class $ArSceneRootAnchorEntityCopyWith<$Res>  {
  factory $ArSceneRootAnchorEntityCopyWith(ArSceneRootAnchorEntity value, $Res Function(ArSceneRootAnchorEntity) _then) = _$ArSceneRootAnchorEntityCopyWithImpl;
@useResult
$Res call({
 String anchorName, String cloudAnchorId, List<double> anchorTransform, int ttl, String? platform
});




}
/// @nodoc
class _$ArSceneRootAnchorEntityCopyWithImpl<$Res>
    implements $ArSceneRootAnchorEntityCopyWith<$Res> {
  _$ArSceneRootAnchorEntityCopyWithImpl(this._self, this._then);

  final ArSceneRootAnchorEntity _self;
  final $Res Function(ArSceneRootAnchorEntity) _then;

/// Create a copy of ArSceneRootAnchorEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? anchorName = null,Object? cloudAnchorId = null,Object? anchorTransform = null,Object? ttl = null,Object? platform = freezed,}) {
  return _then(_self.copyWith(
anchorName: null == anchorName ? _self.anchorName : anchorName // ignore: cast_nullable_to_non_nullable
as String,cloudAnchorId: null == cloudAnchorId ? _self.cloudAnchorId : cloudAnchorId // ignore: cast_nullable_to_non_nullable
as String,anchorTransform: null == anchorTransform ? _self.anchorTransform : anchorTransform // ignore: cast_nullable_to_non_nullable
as List<double>,ttl: null == ttl ? _self.ttl : ttl // ignore: cast_nullable_to_non_nullable
as int,platform: freezed == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ArSceneRootAnchorEntity].
extension ArSceneRootAnchorEntityPatterns on ArSceneRootAnchorEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArSceneRootAnchorEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArSceneRootAnchorEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArSceneRootAnchorEntity value)  $default,){
final _that = this;
switch (_that) {
case _ArSceneRootAnchorEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArSceneRootAnchorEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ArSceneRootAnchorEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String anchorName,  String cloudAnchorId,  List<double> anchorTransform,  int ttl,  String? platform)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArSceneRootAnchorEntity() when $default != null:
return $default(_that.anchorName,_that.cloudAnchorId,_that.anchorTransform,_that.ttl,_that.platform);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String anchorName,  String cloudAnchorId,  List<double> anchorTransform,  int ttl,  String? platform)  $default,) {final _that = this;
switch (_that) {
case _ArSceneRootAnchorEntity():
return $default(_that.anchorName,_that.cloudAnchorId,_that.anchorTransform,_that.ttl,_that.platform);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String anchorName,  String cloudAnchorId,  List<double> anchorTransform,  int ttl,  String? platform)?  $default,) {final _that = this;
switch (_that) {
case _ArSceneRootAnchorEntity() when $default != null:
return $default(_that.anchorName,_that.cloudAnchorId,_that.anchorTransform,_that.ttl,_that.platform);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ArSceneRootAnchorEntity implements ArSceneRootAnchorEntity {
  const _ArSceneRootAnchorEntity({required this.anchorName, required this.cloudAnchorId, required final  List<double> anchorTransform, required this.ttl, required this.platform}): _anchorTransform = anchorTransform;
  factory _ArSceneRootAnchorEntity.fromJson(Map<String, dynamic> json) => _$ArSceneRootAnchorEntityFromJson(json);

@override final  String anchorName;
@override final  String cloudAnchorId;
 final  List<double> _anchorTransform;
@override List<double> get anchorTransform {
  if (_anchorTransform is EqualUnmodifiableListView) return _anchorTransform;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_anchorTransform);
}

@override final  int ttl;
@override final  String? platform;

/// Create a copy of ArSceneRootAnchorEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArSceneRootAnchorEntityCopyWith<_ArSceneRootAnchorEntity> get copyWith => __$ArSceneRootAnchorEntityCopyWithImpl<_ArSceneRootAnchorEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ArSceneRootAnchorEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArSceneRootAnchorEntity&&(identical(other.anchorName, anchorName) || other.anchorName == anchorName)&&(identical(other.cloudAnchorId, cloudAnchorId) || other.cloudAnchorId == cloudAnchorId)&&const DeepCollectionEquality().equals(other._anchorTransform, _anchorTransform)&&(identical(other.ttl, ttl) || other.ttl == ttl)&&(identical(other.platform, platform) || other.platform == platform));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,anchorName,cloudAnchorId,const DeepCollectionEquality().hash(_anchorTransform),ttl,platform);

@override
String toString() {
  return 'ArSceneRootAnchorEntity(anchorName: $anchorName, cloudAnchorId: $cloudAnchorId, anchorTransform: $anchorTransform, ttl: $ttl, platform: $platform)';
}


}

/// @nodoc
abstract mixin class _$ArSceneRootAnchorEntityCopyWith<$Res> implements $ArSceneRootAnchorEntityCopyWith<$Res> {
  factory _$ArSceneRootAnchorEntityCopyWith(_ArSceneRootAnchorEntity value, $Res Function(_ArSceneRootAnchorEntity) _then) = __$ArSceneRootAnchorEntityCopyWithImpl;
@override @useResult
$Res call({
 String anchorName, String cloudAnchorId, List<double> anchorTransform, int ttl, String? platform
});




}
/// @nodoc
class __$ArSceneRootAnchorEntityCopyWithImpl<$Res>
    implements _$ArSceneRootAnchorEntityCopyWith<$Res> {
  __$ArSceneRootAnchorEntityCopyWithImpl(this._self, this._then);

  final _ArSceneRootAnchorEntity _self;
  final $Res Function(_ArSceneRootAnchorEntity) _then;

/// Create a copy of ArSceneRootAnchorEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? anchorName = null,Object? cloudAnchorId = null,Object? anchorTransform = null,Object? ttl = null,Object? platform = freezed,}) {
  return _then(_ArSceneRootAnchorEntity(
anchorName: null == anchorName ? _self.anchorName : anchorName // ignore: cast_nullable_to_non_nullable
as String,cloudAnchorId: null == cloudAnchorId ? _self.cloudAnchorId : cloudAnchorId // ignore: cast_nullable_to_non_nullable
as String,anchorTransform: null == anchorTransform ? _self._anchorTransform : anchorTransform // ignore: cast_nullable_to_non_nullable
as List<double>,ttl: null == ttl ? _self.ttl : ttl // ignore: cast_nullable_to_non_nullable
as int,platform: freezed == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
