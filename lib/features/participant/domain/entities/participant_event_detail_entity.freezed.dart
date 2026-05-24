// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'participant_event_detail_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ParticipantEventDetailEntity {

 int get id; String get title; String get description; String get imageUrl; int get progressPercent; bool get certificateAvailable; List<ParticipantScannedQuestEntity> get scannedQuests;
/// Create a copy of ParticipantEventDetailEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParticipantEventDetailEntityCopyWith<ParticipantEventDetailEntity> get copyWith => _$ParticipantEventDetailEntityCopyWithImpl<ParticipantEventDetailEntity>(this as ParticipantEventDetailEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParticipantEventDetailEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.progressPercent, progressPercent) || other.progressPercent == progressPercent)&&(identical(other.certificateAvailable, certificateAvailable) || other.certificateAvailable == certificateAvailable)&&const DeepCollectionEquality().equals(other.scannedQuests, scannedQuests));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,imageUrl,progressPercent,certificateAvailable,const DeepCollectionEquality().hash(scannedQuests));

@override
String toString() {
  return 'ParticipantEventDetailEntity(id: $id, title: $title, description: $description, imageUrl: $imageUrl, progressPercent: $progressPercent, certificateAvailable: $certificateAvailable, scannedQuests: $scannedQuests)';
}


}

/// @nodoc
abstract mixin class $ParticipantEventDetailEntityCopyWith<$Res>  {
  factory $ParticipantEventDetailEntityCopyWith(ParticipantEventDetailEntity value, $Res Function(ParticipantEventDetailEntity) _then) = _$ParticipantEventDetailEntityCopyWithImpl;
@useResult
$Res call({
 int id, String title, String description, String imageUrl, int progressPercent, bool certificateAvailable, List<ParticipantScannedQuestEntity> scannedQuests
});




}
/// @nodoc
class _$ParticipantEventDetailEntityCopyWithImpl<$Res>
    implements $ParticipantEventDetailEntityCopyWith<$Res> {
  _$ParticipantEventDetailEntityCopyWithImpl(this._self, this._then);

  final ParticipantEventDetailEntity _self;
  final $Res Function(ParticipantEventDetailEntity) _then;

/// Create a copy of ParticipantEventDetailEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? imageUrl = null,Object? progressPercent = null,Object? certificateAvailable = null,Object? scannedQuests = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,progressPercent: null == progressPercent ? _self.progressPercent : progressPercent // ignore: cast_nullable_to_non_nullable
as int,certificateAvailable: null == certificateAvailable ? _self.certificateAvailable : certificateAvailable // ignore: cast_nullable_to_non_nullable
as bool,scannedQuests: null == scannedQuests ? _self.scannedQuests : scannedQuests // ignore: cast_nullable_to_non_nullable
as List<ParticipantScannedQuestEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [ParticipantEventDetailEntity].
extension ParticipantEventDetailEntityPatterns on ParticipantEventDetailEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ParticipantEventDetailEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ParticipantEventDetailEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ParticipantEventDetailEntity value)  $default,){
final _that = this;
switch (_that) {
case _ParticipantEventDetailEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ParticipantEventDetailEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ParticipantEventDetailEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String description,  String imageUrl,  int progressPercent,  bool certificateAvailable,  List<ParticipantScannedQuestEntity> scannedQuests)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ParticipantEventDetailEntity() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.imageUrl,_that.progressPercent,_that.certificateAvailable,_that.scannedQuests);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String description,  String imageUrl,  int progressPercent,  bool certificateAvailable,  List<ParticipantScannedQuestEntity> scannedQuests)  $default,) {final _that = this;
switch (_that) {
case _ParticipantEventDetailEntity():
return $default(_that.id,_that.title,_that.description,_that.imageUrl,_that.progressPercent,_that.certificateAvailable,_that.scannedQuests);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String description,  String imageUrl,  int progressPercent,  bool certificateAvailable,  List<ParticipantScannedQuestEntity> scannedQuests)?  $default,) {final _that = this;
switch (_that) {
case _ParticipantEventDetailEntity() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.imageUrl,_that.progressPercent,_that.certificateAvailable,_that.scannedQuests);case _:
  return null;

}
}

}

/// @nodoc


class _ParticipantEventDetailEntity implements ParticipantEventDetailEntity {
  const _ParticipantEventDetailEntity({required this.id, required this.title, required this.description, required this.imageUrl, required this.progressPercent, required this.certificateAvailable, required final  List<ParticipantScannedQuestEntity> scannedQuests}): _scannedQuests = scannedQuests;
  

@override final  int id;
@override final  String title;
@override final  String description;
@override final  String imageUrl;
@override final  int progressPercent;
@override final  bool certificateAvailable;
 final  List<ParticipantScannedQuestEntity> _scannedQuests;
@override List<ParticipantScannedQuestEntity> get scannedQuests {
  if (_scannedQuests is EqualUnmodifiableListView) return _scannedQuests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_scannedQuests);
}


/// Create a copy of ParticipantEventDetailEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParticipantEventDetailEntityCopyWith<_ParticipantEventDetailEntity> get copyWith => __$ParticipantEventDetailEntityCopyWithImpl<_ParticipantEventDetailEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParticipantEventDetailEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.progressPercent, progressPercent) || other.progressPercent == progressPercent)&&(identical(other.certificateAvailable, certificateAvailable) || other.certificateAvailable == certificateAvailable)&&const DeepCollectionEquality().equals(other._scannedQuests, _scannedQuests));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,imageUrl,progressPercent,certificateAvailable,const DeepCollectionEquality().hash(_scannedQuests));

@override
String toString() {
  return 'ParticipantEventDetailEntity(id: $id, title: $title, description: $description, imageUrl: $imageUrl, progressPercent: $progressPercent, certificateAvailable: $certificateAvailable, scannedQuests: $scannedQuests)';
}


}

/// @nodoc
abstract mixin class _$ParticipantEventDetailEntityCopyWith<$Res> implements $ParticipantEventDetailEntityCopyWith<$Res> {
  factory _$ParticipantEventDetailEntityCopyWith(_ParticipantEventDetailEntity value, $Res Function(_ParticipantEventDetailEntity) _then) = __$ParticipantEventDetailEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String description, String imageUrl, int progressPercent, bool certificateAvailable, List<ParticipantScannedQuestEntity> scannedQuests
});




}
/// @nodoc
class __$ParticipantEventDetailEntityCopyWithImpl<$Res>
    implements _$ParticipantEventDetailEntityCopyWith<$Res> {
  __$ParticipantEventDetailEntityCopyWithImpl(this._self, this._then);

  final _ParticipantEventDetailEntity _self;
  final $Res Function(_ParticipantEventDetailEntity) _then;

/// Create a copy of ParticipantEventDetailEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? imageUrl = null,Object? progressPercent = null,Object? certificateAvailable = null,Object? scannedQuests = null,}) {
  return _then(_ParticipantEventDetailEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,progressPercent: null == progressPercent ? _self.progressPercent : progressPercent // ignore: cast_nullable_to_non_nullable
as int,certificateAvailable: null == certificateAvailable ? _self.certificateAvailable : certificateAvailable // ignore: cast_nullable_to_non_nullable
as bool,scannedQuests: null == scannedQuests ? _self._scannedQuests : scannedQuests // ignore: cast_nullable_to_non_nullable
as List<ParticipantScannedQuestEntity>,
  ));
}


}

// dart format on
