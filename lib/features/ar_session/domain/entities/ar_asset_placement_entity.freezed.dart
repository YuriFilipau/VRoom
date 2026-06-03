// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ar_asset_placement_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ArAssetPlacementEntity {

 String get id; int get assetId; String get nodeName; List<double> get localTransform; Map<String, dynamic> get meta;
/// Create a copy of ArAssetPlacementEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArAssetPlacementEntityCopyWith<ArAssetPlacementEntity> get copyWith => _$ArAssetPlacementEntityCopyWithImpl<ArAssetPlacementEntity>(this as ArAssetPlacementEntity, _$identity);

  /// Serializes this ArAssetPlacementEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArAssetPlacementEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.assetId, assetId) || other.assetId == assetId)&&(identical(other.nodeName, nodeName) || other.nodeName == nodeName)&&const DeepCollectionEquality().equals(other.localTransform, localTransform)&&const DeepCollectionEquality().equals(other.meta, meta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,assetId,nodeName,const DeepCollectionEquality().hash(localTransform),const DeepCollectionEquality().hash(meta));

@override
String toString() {
  return 'ArAssetPlacementEntity(id: $id, assetId: $assetId, nodeName: $nodeName, localTransform: $localTransform, meta: $meta)';
}


}

/// @nodoc
abstract mixin class $ArAssetPlacementEntityCopyWith<$Res>  {
  factory $ArAssetPlacementEntityCopyWith(ArAssetPlacementEntity value, $Res Function(ArAssetPlacementEntity) _then) = _$ArAssetPlacementEntityCopyWithImpl;
@useResult
$Res call({
 String id, int assetId, String nodeName, List<double> localTransform, Map<String, dynamic> meta
});




}
/// @nodoc
class _$ArAssetPlacementEntityCopyWithImpl<$Res>
    implements $ArAssetPlacementEntityCopyWith<$Res> {
  _$ArAssetPlacementEntityCopyWithImpl(this._self, this._then);

  final ArAssetPlacementEntity _self;
  final $Res Function(ArAssetPlacementEntity) _then;

/// Create a copy of ArAssetPlacementEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? assetId = null,Object? nodeName = null,Object? localTransform = null,Object? meta = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,assetId: null == assetId ? _self.assetId : assetId // ignore: cast_nullable_to_non_nullable
as int,nodeName: null == nodeName ? _self.nodeName : nodeName // ignore: cast_nullable_to_non_nullable
as String,localTransform: null == localTransform ? _self.localTransform : localTransform // ignore: cast_nullable_to_non_nullable
as List<double>,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [ArAssetPlacementEntity].
extension ArAssetPlacementEntityPatterns on ArAssetPlacementEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArAssetPlacementEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArAssetPlacementEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArAssetPlacementEntity value)  $default,){
final _that = this;
switch (_that) {
case _ArAssetPlacementEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArAssetPlacementEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ArAssetPlacementEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int assetId,  String nodeName,  List<double> localTransform,  Map<String, dynamic> meta)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArAssetPlacementEntity() when $default != null:
return $default(_that.id,_that.assetId,_that.nodeName,_that.localTransform,_that.meta);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int assetId,  String nodeName,  List<double> localTransform,  Map<String, dynamic> meta)  $default,) {final _that = this;
switch (_that) {
case _ArAssetPlacementEntity():
return $default(_that.id,_that.assetId,_that.nodeName,_that.localTransform,_that.meta);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int assetId,  String nodeName,  List<double> localTransform,  Map<String, dynamic> meta)?  $default,) {final _that = this;
switch (_that) {
case _ArAssetPlacementEntity() when $default != null:
return $default(_that.id,_that.assetId,_that.nodeName,_that.localTransform,_that.meta);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ArAssetPlacementEntity extends ArAssetPlacementEntity {
  const _ArAssetPlacementEntity({required this.id, required this.assetId, required this.nodeName, required final  List<double> localTransform, final  Map<String, dynamic> meta = const {}}): _localTransform = localTransform,_meta = meta,super._();
  factory _ArAssetPlacementEntity.fromJson(Map<String, dynamic> json) => _$ArAssetPlacementEntityFromJson(json);

@override final  String id;
@override final  int assetId;
@override final  String nodeName;
 final  List<double> _localTransform;
@override List<double> get localTransform {
  if (_localTransform is EqualUnmodifiableListView) return _localTransform;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_localTransform);
}

 final  Map<String, dynamic> _meta;
@override@JsonKey() Map<String, dynamic> get meta {
  if (_meta is EqualUnmodifiableMapView) return _meta;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_meta);
}


/// Create a copy of ArAssetPlacementEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArAssetPlacementEntityCopyWith<_ArAssetPlacementEntity> get copyWith => __$ArAssetPlacementEntityCopyWithImpl<_ArAssetPlacementEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ArAssetPlacementEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArAssetPlacementEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.assetId, assetId) || other.assetId == assetId)&&(identical(other.nodeName, nodeName) || other.nodeName == nodeName)&&const DeepCollectionEquality().equals(other._localTransform, _localTransform)&&const DeepCollectionEquality().equals(other._meta, _meta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,assetId,nodeName,const DeepCollectionEquality().hash(_localTransform),const DeepCollectionEquality().hash(_meta));

@override
String toString() {
  return 'ArAssetPlacementEntity(id: $id, assetId: $assetId, nodeName: $nodeName, localTransform: $localTransform, meta: $meta)';
}


}

/// @nodoc
abstract mixin class _$ArAssetPlacementEntityCopyWith<$Res> implements $ArAssetPlacementEntityCopyWith<$Res> {
  factory _$ArAssetPlacementEntityCopyWith(_ArAssetPlacementEntity value, $Res Function(_ArAssetPlacementEntity) _then) = __$ArAssetPlacementEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, int assetId, String nodeName, List<double> localTransform, Map<String, dynamic> meta
});




}
/// @nodoc
class __$ArAssetPlacementEntityCopyWithImpl<$Res>
    implements _$ArAssetPlacementEntityCopyWith<$Res> {
  __$ArAssetPlacementEntityCopyWithImpl(this._self, this._then);

  final _ArAssetPlacementEntity _self;
  final $Res Function(_ArAssetPlacementEntity) _then;

/// Create a copy of ArAssetPlacementEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? assetId = null,Object? nodeName = null,Object? localTransform = null,Object? meta = null,}) {
  return _then(_ArAssetPlacementEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,assetId: null == assetId ? _self.assetId : assetId // ignore: cast_nullable_to_non_nullable
as int,nodeName: null == nodeName ? _self.nodeName : nodeName // ignore: cast_nullable_to_non_nullable
as String,localTransform: null == localTransform ? _self._localTransform : localTransform // ignore: cast_nullable_to_non_nullable
as List<double>,meta: null == meta ? _self._meta : meta // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
