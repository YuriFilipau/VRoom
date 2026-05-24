// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ar_asset_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ArAssetEntity {

 int get id; String get name; String get modelUri; double get scale; ArAssetPreviewIcon get previewIcon;
/// Create a copy of ArAssetEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArAssetEntityCopyWith<ArAssetEntity> get copyWith => _$ArAssetEntityCopyWithImpl<ArAssetEntity>(this as ArAssetEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArAssetEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.modelUri, modelUri) || other.modelUri == modelUri)&&(identical(other.scale, scale) || other.scale == scale)&&(identical(other.previewIcon, previewIcon) || other.previewIcon == previewIcon));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,modelUri,scale,previewIcon);

@override
String toString() {
  return 'ArAssetEntity(id: $id, name: $name, modelUri: $modelUri, scale: $scale, previewIcon: $previewIcon)';
}


}

/// @nodoc
abstract mixin class $ArAssetEntityCopyWith<$Res>  {
  factory $ArAssetEntityCopyWith(ArAssetEntity value, $Res Function(ArAssetEntity) _then) = _$ArAssetEntityCopyWithImpl;
@useResult
$Res call({
 int id, String name, String modelUri, double scale, ArAssetPreviewIcon previewIcon
});




}
/// @nodoc
class _$ArAssetEntityCopyWithImpl<$Res>
    implements $ArAssetEntityCopyWith<$Res> {
  _$ArAssetEntityCopyWithImpl(this._self, this._then);

  final ArAssetEntity _self;
  final $Res Function(ArAssetEntity) _then;

/// Create a copy of ArAssetEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? modelUri = null,Object? scale = null,Object? previewIcon = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,modelUri: null == modelUri ? _self.modelUri : modelUri // ignore: cast_nullable_to_non_nullable
as String,scale: null == scale ? _self.scale : scale // ignore: cast_nullable_to_non_nullable
as double,previewIcon: null == previewIcon ? _self.previewIcon : previewIcon // ignore: cast_nullable_to_non_nullable
as ArAssetPreviewIcon,
  ));
}

}


/// Adds pattern-matching-related methods to [ArAssetEntity].
extension ArAssetEntityPatterns on ArAssetEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArAssetEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArAssetEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArAssetEntity value)  $default,){
final _that = this;
switch (_that) {
case _ArAssetEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArAssetEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ArAssetEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String modelUri,  double scale,  ArAssetPreviewIcon previewIcon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArAssetEntity() when $default != null:
return $default(_that.id,_that.name,_that.modelUri,_that.scale,_that.previewIcon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String modelUri,  double scale,  ArAssetPreviewIcon previewIcon)  $default,) {final _that = this;
switch (_that) {
case _ArAssetEntity():
return $default(_that.id,_that.name,_that.modelUri,_that.scale,_that.previewIcon);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String modelUri,  double scale,  ArAssetPreviewIcon previewIcon)?  $default,) {final _that = this;
switch (_that) {
case _ArAssetEntity() when $default != null:
return $default(_that.id,_that.name,_that.modelUri,_that.scale,_that.previewIcon);case _:
  return null;

}
}

}

/// @nodoc


class _ArAssetEntity implements ArAssetEntity {
  const _ArAssetEntity({required this.id, required this.name, required this.modelUri, required this.scale, required this.previewIcon});
  

@override final  int id;
@override final  String name;
@override final  String modelUri;
@override final  double scale;
@override final  ArAssetPreviewIcon previewIcon;

/// Create a copy of ArAssetEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArAssetEntityCopyWith<_ArAssetEntity> get copyWith => __$ArAssetEntityCopyWithImpl<_ArAssetEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArAssetEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.modelUri, modelUri) || other.modelUri == modelUri)&&(identical(other.scale, scale) || other.scale == scale)&&(identical(other.previewIcon, previewIcon) || other.previewIcon == previewIcon));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,modelUri,scale,previewIcon);

@override
String toString() {
  return 'ArAssetEntity(id: $id, name: $name, modelUri: $modelUri, scale: $scale, previewIcon: $previewIcon)';
}


}

/// @nodoc
abstract mixin class _$ArAssetEntityCopyWith<$Res> implements $ArAssetEntityCopyWith<$Res> {
  factory _$ArAssetEntityCopyWith(_ArAssetEntity value, $Res Function(_ArAssetEntity) _then) = __$ArAssetEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String modelUri, double scale, ArAssetPreviewIcon previewIcon
});




}
/// @nodoc
class __$ArAssetEntityCopyWithImpl<$Res>
    implements _$ArAssetEntityCopyWith<$Res> {
  __$ArAssetEntityCopyWithImpl(this._self, this._then);

  final _ArAssetEntity _self;
  final $Res Function(_ArAssetEntity) _then;

/// Create a copy of ArAssetEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? modelUri = null,Object? scale = null,Object? previewIcon = null,}) {
  return _then(_ArAssetEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,modelUri: null == modelUri ? _self.modelUri : modelUri // ignore: cast_nullable_to_non_nullable
as String,scale: null == scale ? _self.scale : scale // ignore: cast_nullable_to_non_nullable
as double,previewIcon: null == previewIcon ? _self.previewIcon : previewIcon // ignore: cast_nullable_to_non_nullable
as ArAssetPreviewIcon,
  ));
}


}

// dart format on
