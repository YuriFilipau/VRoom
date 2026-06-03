// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'participant_certificate_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ParticipantCertificateEntity {

 int get eventId; bool get available; bool get issued; String get requirementMode; int? get scoreThreshold; String? get certificateNumber; String? get issuedAt; String? get artifactUrl; String? get renderedContent;
/// Create a copy of ParticipantCertificateEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParticipantCertificateEntityCopyWith<ParticipantCertificateEntity> get copyWith => _$ParticipantCertificateEntityCopyWithImpl<ParticipantCertificateEntity>(this as ParticipantCertificateEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParticipantCertificateEntity&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.available, available) || other.available == available)&&(identical(other.issued, issued) || other.issued == issued)&&(identical(other.requirementMode, requirementMode) || other.requirementMode == requirementMode)&&(identical(other.scoreThreshold, scoreThreshold) || other.scoreThreshold == scoreThreshold)&&(identical(other.certificateNumber, certificateNumber) || other.certificateNumber == certificateNumber)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt)&&(identical(other.artifactUrl, artifactUrl) || other.artifactUrl == artifactUrl)&&(identical(other.renderedContent, renderedContent) || other.renderedContent == renderedContent));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,available,issued,requirementMode,scoreThreshold,certificateNumber,issuedAt,artifactUrl,renderedContent);

@override
String toString() {
  return 'ParticipantCertificateEntity(eventId: $eventId, available: $available, issued: $issued, requirementMode: $requirementMode, scoreThreshold: $scoreThreshold, certificateNumber: $certificateNumber, issuedAt: $issuedAt, artifactUrl: $artifactUrl, renderedContent: $renderedContent)';
}


}

/// @nodoc
abstract mixin class $ParticipantCertificateEntityCopyWith<$Res>  {
  factory $ParticipantCertificateEntityCopyWith(ParticipantCertificateEntity value, $Res Function(ParticipantCertificateEntity) _then) = _$ParticipantCertificateEntityCopyWithImpl;
@useResult
$Res call({
 int eventId, bool available, bool issued, String requirementMode, int? scoreThreshold, String? certificateNumber, String? issuedAt, String? artifactUrl, String? renderedContent
});




}
/// @nodoc
class _$ParticipantCertificateEntityCopyWithImpl<$Res>
    implements $ParticipantCertificateEntityCopyWith<$Res> {
  _$ParticipantCertificateEntityCopyWithImpl(this._self, this._then);

  final ParticipantCertificateEntity _self;
  final $Res Function(ParticipantCertificateEntity) _then;

/// Create a copy of ParticipantCertificateEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? available = null,Object? issued = null,Object? requirementMode = null,Object? scoreThreshold = freezed,Object? certificateNumber = freezed,Object? issuedAt = freezed,Object? artifactUrl = freezed,Object? renderedContent = freezed,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,issued: null == issued ? _self.issued : issued // ignore: cast_nullable_to_non_nullable
as bool,requirementMode: null == requirementMode ? _self.requirementMode : requirementMode // ignore: cast_nullable_to_non_nullable
as String,scoreThreshold: freezed == scoreThreshold ? _self.scoreThreshold : scoreThreshold // ignore: cast_nullable_to_non_nullable
as int?,certificateNumber: freezed == certificateNumber ? _self.certificateNumber : certificateNumber // ignore: cast_nullable_to_non_nullable
as String?,issuedAt: freezed == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as String?,artifactUrl: freezed == artifactUrl ? _self.artifactUrl : artifactUrl // ignore: cast_nullable_to_non_nullable
as String?,renderedContent: freezed == renderedContent ? _self.renderedContent : renderedContent // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ParticipantCertificateEntity].
extension ParticipantCertificateEntityPatterns on ParticipantCertificateEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ParticipantCertificateEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ParticipantCertificateEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ParticipantCertificateEntity value)  $default,){
final _that = this;
switch (_that) {
case _ParticipantCertificateEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ParticipantCertificateEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ParticipantCertificateEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int eventId,  bool available,  bool issued,  String requirementMode,  int? scoreThreshold,  String? certificateNumber,  String? issuedAt,  String? artifactUrl,  String? renderedContent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ParticipantCertificateEntity() when $default != null:
return $default(_that.eventId,_that.available,_that.issued,_that.requirementMode,_that.scoreThreshold,_that.certificateNumber,_that.issuedAt,_that.artifactUrl,_that.renderedContent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int eventId,  bool available,  bool issued,  String requirementMode,  int? scoreThreshold,  String? certificateNumber,  String? issuedAt,  String? artifactUrl,  String? renderedContent)  $default,) {final _that = this;
switch (_that) {
case _ParticipantCertificateEntity():
return $default(_that.eventId,_that.available,_that.issued,_that.requirementMode,_that.scoreThreshold,_that.certificateNumber,_that.issuedAt,_that.artifactUrl,_that.renderedContent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int eventId,  bool available,  bool issued,  String requirementMode,  int? scoreThreshold,  String? certificateNumber,  String? issuedAt,  String? artifactUrl,  String? renderedContent)?  $default,) {final _that = this;
switch (_that) {
case _ParticipantCertificateEntity() when $default != null:
return $default(_that.eventId,_that.available,_that.issued,_that.requirementMode,_that.scoreThreshold,_that.certificateNumber,_that.issuedAt,_that.artifactUrl,_that.renderedContent);case _:
  return null;

}
}

}

/// @nodoc


class _ParticipantCertificateEntity implements ParticipantCertificateEntity {
  const _ParticipantCertificateEntity({required this.eventId, required this.available, required this.issued, required this.requirementMode, required this.scoreThreshold, required this.certificateNumber, required this.issuedAt, required this.artifactUrl, required this.renderedContent});
  

@override final  int eventId;
@override final  bool available;
@override final  bool issued;
@override final  String requirementMode;
@override final  int? scoreThreshold;
@override final  String? certificateNumber;
@override final  String? issuedAt;
@override final  String? artifactUrl;
@override final  String? renderedContent;

/// Create a copy of ParticipantCertificateEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParticipantCertificateEntityCopyWith<_ParticipantCertificateEntity> get copyWith => __$ParticipantCertificateEntityCopyWithImpl<_ParticipantCertificateEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParticipantCertificateEntity&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.available, available) || other.available == available)&&(identical(other.issued, issued) || other.issued == issued)&&(identical(other.requirementMode, requirementMode) || other.requirementMode == requirementMode)&&(identical(other.scoreThreshold, scoreThreshold) || other.scoreThreshold == scoreThreshold)&&(identical(other.certificateNumber, certificateNumber) || other.certificateNumber == certificateNumber)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt)&&(identical(other.artifactUrl, artifactUrl) || other.artifactUrl == artifactUrl)&&(identical(other.renderedContent, renderedContent) || other.renderedContent == renderedContent));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,available,issued,requirementMode,scoreThreshold,certificateNumber,issuedAt,artifactUrl,renderedContent);

@override
String toString() {
  return 'ParticipantCertificateEntity(eventId: $eventId, available: $available, issued: $issued, requirementMode: $requirementMode, scoreThreshold: $scoreThreshold, certificateNumber: $certificateNumber, issuedAt: $issuedAt, artifactUrl: $artifactUrl, renderedContent: $renderedContent)';
}


}

/// @nodoc
abstract mixin class _$ParticipantCertificateEntityCopyWith<$Res> implements $ParticipantCertificateEntityCopyWith<$Res> {
  factory _$ParticipantCertificateEntityCopyWith(_ParticipantCertificateEntity value, $Res Function(_ParticipantCertificateEntity) _then) = __$ParticipantCertificateEntityCopyWithImpl;
@override @useResult
$Res call({
 int eventId, bool available, bool issued, String requirementMode, int? scoreThreshold, String? certificateNumber, String? issuedAt, String? artifactUrl, String? renderedContent
});




}
/// @nodoc
class __$ParticipantCertificateEntityCopyWithImpl<$Res>
    implements _$ParticipantCertificateEntityCopyWith<$Res> {
  __$ParticipantCertificateEntityCopyWithImpl(this._self, this._then);

  final _ParticipantCertificateEntity _self;
  final $Res Function(_ParticipantCertificateEntity) _then;

/// Create a copy of ParticipantCertificateEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? available = null,Object? issued = null,Object? requirementMode = null,Object? scoreThreshold = freezed,Object? certificateNumber = freezed,Object? issuedAt = freezed,Object? artifactUrl = freezed,Object? renderedContent = freezed,}) {
  return _then(_ParticipantCertificateEntity(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,issued: null == issued ? _self.issued : issued // ignore: cast_nullable_to_non_nullable
as bool,requirementMode: null == requirementMode ? _self.requirementMode : requirementMode // ignore: cast_nullable_to_non_nullable
as String,scoreThreshold: freezed == scoreThreshold ? _self.scoreThreshold : scoreThreshold // ignore: cast_nullable_to_non_nullable
as int?,certificateNumber: freezed == certificateNumber ? _self.certificateNumber : certificateNumber // ignore: cast_nullable_to_non_nullable
as String?,issuedAt: freezed == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as String?,artifactUrl: freezed == artifactUrl ? _self.artifactUrl : artifactUrl // ignore: cast_nullable_to_non_nullable
as String?,renderedContent: freezed == renderedContent ? _self.renderedContent : renderedContent // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
