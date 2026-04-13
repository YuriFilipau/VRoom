// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_quest_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserQuest {

 int get id; String get title;@JsonKey(name: 'image_url') String get imageUrl;@JsonKey(name: 'progress_percent') int get progressPercent;
/// Create a copy of UserQuest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserQuestCopyWith<UserQuest> get copyWith => _$UserQuestCopyWithImpl<UserQuest>(this as UserQuest, _$identity);

  /// Serializes this UserQuest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserQuest&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.progressPercent, progressPercent) || other.progressPercent == progressPercent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,imageUrl,progressPercent);

@override
String toString() {
  return 'UserQuest(id: $id, title: $title, imageUrl: $imageUrl, progressPercent: $progressPercent)';
}


}

/// @nodoc
abstract mixin class $UserQuestCopyWith<$Res>  {
  factory $UserQuestCopyWith(UserQuest value, $Res Function(UserQuest) _then) = _$UserQuestCopyWithImpl;
@useResult
$Res call({
 int id, String title,@JsonKey(name: 'image_url') String imageUrl,@JsonKey(name: 'progress_percent') int progressPercent
});




}
/// @nodoc
class _$UserQuestCopyWithImpl<$Res>
    implements $UserQuestCopyWith<$Res> {
  _$UserQuestCopyWithImpl(this._self, this._then);

  final UserQuest _self;
  final $Res Function(UserQuest) _then;

/// Create a copy of UserQuest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? imageUrl = null,Object? progressPercent = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,progressPercent: null == progressPercent ? _self.progressPercent : progressPercent // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [UserQuest].
extension UserQuestPatterns on UserQuest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserQuest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserQuest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserQuest value)  $default,){
final _that = this;
switch (_that) {
case _UserQuest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserQuest value)?  $default,){
final _that = this;
switch (_that) {
case _UserQuest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title, @JsonKey(name: 'image_url')  String imageUrl, @JsonKey(name: 'progress_percent')  int progressPercent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserQuest() when $default != null:
return $default(_that.id,_that.title,_that.imageUrl,_that.progressPercent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title, @JsonKey(name: 'image_url')  String imageUrl, @JsonKey(name: 'progress_percent')  int progressPercent)  $default,) {final _that = this;
switch (_that) {
case _UserQuest():
return $default(_that.id,_that.title,_that.imageUrl,_that.progressPercent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title, @JsonKey(name: 'image_url')  String imageUrl, @JsonKey(name: 'progress_percent')  int progressPercent)?  $default,) {final _that = this;
switch (_that) {
case _UserQuest() when $default != null:
return $default(_that.id,_that.title,_that.imageUrl,_that.progressPercent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserQuest extends UserQuest {
  const _UserQuest({required this.id, required this.title, @JsonKey(name: 'image_url') required this.imageUrl, @JsonKey(name: 'progress_percent') required this.progressPercent}): super._();
  factory _UserQuest.fromJson(Map<String, dynamic> json) => _$UserQuestFromJson(json);

@override final  int id;
@override final  String title;
@override@JsonKey(name: 'image_url') final  String imageUrl;
@override@JsonKey(name: 'progress_percent') final  int progressPercent;

/// Create a copy of UserQuest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserQuestCopyWith<_UserQuest> get copyWith => __$UserQuestCopyWithImpl<_UserQuest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserQuestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserQuest&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.progressPercent, progressPercent) || other.progressPercent == progressPercent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,imageUrl,progressPercent);

@override
String toString() {
  return 'UserQuest(id: $id, title: $title, imageUrl: $imageUrl, progressPercent: $progressPercent)';
}


}

/// @nodoc
abstract mixin class _$UserQuestCopyWith<$Res> implements $UserQuestCopyWith<$Res> {
  factory _$UserQuestCopyWith(_UserQuest value, $Res Function(_UserQuest) _then) = __$UserQuestCopyWithImpl;
@override @useResult
$Res call({
 int id, String title,@JsonKey(name: 'image_url') String imageUrl,@JsonKey(name: 'progress_percent') int progressPercent
});




}
/// @nodoc
class __$UserQuestCopyWithImpl<$Res>
    implements _$UserQuestCopyWith<$Res> {
  __$UserQuestCopyWithImpl(this._self, this._then);

  final _UserQuest _self;
  final $Res Function(_UserQuest) _then;

/// Create a copy of UserQuest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? imageUrl = null,Object? progressPercent = null,}) {
  return _then(_UserQuest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,progressPercent: null == progressPercent ? _self.progressPercent : progressPercent // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
