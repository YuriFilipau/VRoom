// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quest_test_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QuestTestEntity {

 int get id; int get questId; String get title; String get description; int get passingScore; int get maxScore; int get maxAttempts; int get cooldownSeconds; bool get shuffleQuestions; bool get shuffleOptions; List<QuestTestQuestionEntity> get questions;
/// Create a copy of QuestTestEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestTestEntityCopyWith<QuestTestEntity> get copyWith => _$QuestTestEntityCopyWithImpl<QuestTestEntity>(this as QuestTestEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestTestEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.questId, questId) || other.questId == questId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.passingScore, passingScore) || other.passingScore == passingScore)&&(identical(other.maxScore, maxScore) || other.maxScore == maxScore)&&(identical(other.maxAttempts, maxAttempts) || other.maxAttempts == maxAttempts)&&(identical(other.cooldownSeconds, cooldownSeconds) || other.cooldownSeconds == cooldownSeconds)&&(identical(other.shuffleQuestions, shuffleQuestions) || other.shuffleQuestions == shuffleQuestions)&&(identical(other.shuffleOptions, shuffleOptions) || other.shuffleOptions == shuffleOptions)&&const DeepCollectionEquality().equals(other.questions, questions));
}


@override
int get hashCode => Object.hash(runtimeType,id,questId,title,description,passingScore,maxScore,maxAttempts,cooldownSeconds,shuffleQuestions,shuffleOptions,const DeepCollectionEquality().hash(questions));

@override
String toString() {
  return 'QuestTestEntity(id: $id, questId: $questId, title: $title, description: $description, passingScore: $passingScore, maxScore: $maxScore, maxAttempts: $maxAttempts, cooldownSeconds: $cooldownSeconds, shuffleQuestions: $shuffleQuestions, shuffleOptions: $shuffleOptions, questions: $questions)';
}


}

/// @nodoc
abstract mixin class $QuestTestEntityCopyWith<$Res>  {
  factory $QuestTestEntityCopyWith(QuestTestEntity value, $Res Function(QuestTestEntity) _then) = _$QuestTestEntityCopyWithImpl;
@useResult
$Res call({
 int id, int questId, String title, String description, int passingScore, int maxScore, int maxAttempts, int cooldownSeconds, bool shuffleQuestions, bool shuffleOptions, List<QuestTestQuestionEntity> questions
});




}
/// @nodoc
class _$QuestTestEntityCopyWithImpl<$Res>
    implements $QuestTestEntityCopyWith<$Res> {
  _$QuestTestEntityCopyWithImpl(this._self, this._then);

  final QuestTestEntity _self;
  final $Res Function(QuestTestEntity) _then;

/// Create a copy of QuestTestEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? questId = null,Object? title = null,Object? description = null,Object? passingScore = null,Object? maxScore = null,Object? maxAttempts = null,Object? cooldownSeconds = null,Object? shuffleQuestions = null,Object? shuffleOptions = null,Object? questions = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,questId: null == questId ? _self.questId : questId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,passingScore: null == passingScore ? _self.passingScore : passingScore // ignore: cast_nullable_to_non_nullable
as int,maxScore: null == maxScore ? _self.maxScore : maxScore // ignore: cast_nullable_to_non_nullable
as int,maxAttempts: null == maxAttempts ? _self.maxAttempts : maxAttempts // ignore: cast_nullable_to_non_nullable
as int,cooldownSeconds: null == cooldownSeconds ? _self.cooldownSeconds : cooldownSeconds // ignore: cast_nullable_to_non_nullable
as int,shuffleQuestions: null == shuffleQuestions ? _self.shuffleQuestions : shuffleQuestions // ignore: cast_nullable_to_non_nullable
as bool,shuffleOptions: null == shuffleOptions ? _self.shuffleOptions : shuffleOptions // ignore: cast_nullable_to_non_nullable
as bool,questions: null == questions ? _self.questions : questions // ignore: cast_nullable_to_non_nullable
as List<QuestTestQuestionEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [QuestTestEntity].
extension QuestTestEntityPatterns on QuestTestEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestTestEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestTestEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestTestEntity value)  $default,){
final _that = this;
switch (_that) {
case _QuestTestEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestTestEntity value)?  $default,){
final _that = this;
switch (_that) {
case _QuestTestEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int questId,  String title,  String description,  int passingScore,  int maxScore,  int maxAttempts,  int cooldownSeconds,  bool shuffleQuestions,  bool shuffleOptions,  List<QuestTestQuestionEntity> questions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestTestEntity() when $default != null:
return $default(_that.id,_that.questId,_that.title,_that.description,_that.passingScore,_that.maxScore,_that.maxAttempts,_that.cooldownSeconds,_that.shuffleQuestions,_that.shuffleOptions,_that.questions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int questId,  String title,  String description,  int passingScore,  int maxScore,  int maxAttempts,  int cooldownSeconds,  bool shuffleQuestions,  bool shuffleOptions,  List<QuestTestQuestionEntity> questions)  $default,) {final _that = this;
switch (_that) {
case _QuestTestEntity():
return $default(_that.id,_that.questId,_that.title,_that.description,_that.passingScore,_that.maxScore,_that.maxAttempts,_that.cooldownSeconds,_that.shuffleQuestions,_that.shuffleOptions,_that.questions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int questId,  String title,  String description,  int passingScore,  int maxScore,  int maxAttempts,  int cooldownSeconds,  bool shuffleQuestions,  bool shuffleOptions,  List<QuestTestQuestionEntity> questions)?  $default,) {final _that = this;
switch (_that) {
case _QuestTestEntity() when $default != null:
return $default(_that.id,_that.questId,_that.title,_that.description,_that.passingScore,_that.maxScore,_that.maxAttempts,_that.cooldownSeconds,_that.shuffleQuestions,_that.shuffleOptions,_that.questions);case _:
  return null;

}
}

}

/// @nodoc


class _QuestTestEntity implements QuestTestEntity {
  const _QuestTestEntity({required this.id, required this.questId, required this.title, required this.description, required this.passingScore, required this.maxScore, required this.maxAttempts, required this.cooldownSeconds, required this.shuffleQuestions, required this.shuffleOptions, required final  List<QuestTestQuestionEntity> questions}): _questions = questions;
  

@override final  int id;
@override final  int questId;
@override final  String title;
@override final  String description;
@override final  int passingScore;
@override final  int maxScore;
@override final  int maxAttempts;
@override final  int cooldownSeconds;
@override final  bool shuffleQuestions;
@override final  bool shuffleOptions;
 final  List<QuestTestQuestionEntity> _questions;
@override List<QuestTestQuestionEntity> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}


/// Create a copy of QuestTestEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestTestEntityCopyWith<_QuestTestEntity> get copyWith => __$QuestTestEntityCopyWithImpl<_QuestTestEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestTestEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.questId, questId) || other.questId == questId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.passingScore, passingScore) || other.passingScore == passingScore)&&(identical(other.maxScore, maxScore) || other.maxScore == maxScore)&&(identical(other.maxAttempts, maxAttempts) || other.maxAttempts == maxAttempts)&&(identical(other.cooldownSeconds, cooldownSeconds) || other.cooldownSeconds == cooldownSeconds)&&(identical(other.shuffleQuestions, shuffleQuestions) || other.shuffleQuestions == shuffleQuestions)&&(identical(other.shuffleOptions, shuffleOptions) || other.shuffleOptions == shuffleOptions)&&const DeepCollectionEquality().equals(other._questions, _questions));
}


@override
int get hashCode => Object.hash(runtimeType,id,questId,title,description,passingScore,maxScore,maxAttempts,cooldownSeconds,shuffleQuestions,shuffleOptions,const DeepCollectionEquality().hash(_questions));

@override
String toString() {
  return 'QuestTestEntity(id: $id, questId: $questId, title: $title, description: $description, passingScore: $passingScore, maxScore: $maxScore, maxAttempts: $maxAttempts, cooldownSeconds: $cooldownSeconds, shuffleQuestions: $shuffleQuestions, shuffleOptions: $shuffleOptions, questions: $questions)';
}


}

/// @nodoc
abstract mixin class _$QuestTestEntityCopyWith<$Res> implements $QuestTestEntityCopyWith<$Res> {
  factory _$QuestTestEntityCopyWith(_QuestTestEntity value, $Res Function(_QuestTestEntity) _then) = __$QuestTestEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, int questId, String title, String description, int passingScore, int maxScore, int maxAttempts, int cooldownSeconds, bool shuffleQuestions, bool shuffleOptions, List<QuestTestQuestionEntity> questions
});




}
/// @nodoc
class __$QuestTestEntityCopyWithImpl<$Res>
    implements _$QuestTestEntityCopyWith<$Res> {
  __$QuestTestEntityCopyWithImpl(this._self, this._then);

  final _QuestTestEntity _self;
  final $Res Function(_QuestTestEntity) _then;

/// Create a copy of QuestTestEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? questId = null,Object? title = null,Object? description = null,Object? passingScore = null,Object? maxScore = null,Object? maxAttempts = null,Object? cooldownSeconds = null,Object? shuffleQuestions = null,Object? shuffleOptions = null,Object? questions = null,}) {
  return _then(_QuestTestEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,questId: null == questId ? _self.questId : questId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,passingScore: null == passingScore ? _self.passingScore : passingScore // ignore: cast_nullable_to_non_nullable
as int,maxScore: null == maxScore ? _self.maxScore : maxScore // ignore: cast_nullable_to_non_nullable
as int,maxAttempts: null == maxAttempts ? _self.maxAttempts : maxAttempts // ignore: cast_nullable_to_non_nullable
as int,cooldownSeconds: null == cooldownSeconds ? _self.cooldownSeconds : cooldownSeconds // ignore: cast_nullable_to_non_nullable
as int,shuffleQuestions: null == shuffleQuestions ? _self.shuffleQuestions : shuffleQuestions // ignore: cast_nullable_to_non_nullable
as bool,shuffleOptions: null == shuffleOptions ? _self.shuffleOptions : shuffleOptions // ignore: cast_nullable_to_non_nullable
as bool,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<QuestTestQuestionEntity>,
  ));
}


}

/// @nodoc
mixin _$QuestTestQuestionEntity {

 int get id; QuestTestQuestionType get type; String get text; int get points; int get orderIndex; List<QuestTestOptionEntity> get options;
/// Create a copy of QuestTestQuestionEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestTestQuestionEntityCopyWith<QuestTestQuestionEntity> get copyWith => _$QuestTestQuestionEntityCopyWithImpl<QuestTestQuestionEntity>(this as QuestTestQuestionEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestTestQuestionEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.text, text) || other.text == text)&&(identical(other.points, points) || other.points == points)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex)&&const DeepCollectionEquality().equals(other.options, options));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,text,points,orderIndex,const DeepCollectionEquality().hash(options));

@override
String toString() {
  return 'QuestTestQuestionEntity(id: $id, type: $type, text: $text, points: $points, orderIndex: $orderIndex, options: $options)';
}


}

/// @nodoc
abstract mixin class $QuestTestQuestionEntityCopyWith<$Res>  {
  factory $QuestTestQuestionEntityCopyWith(QuestTestQuestionEntity value, $Res Function(QuestTestQuestionEntity) _then) = _$QuestTestQuestionEntityCopyWithImpl;
@useResult
$Res call({
 int id, QuestTestQuestionType type, String text, int points, int orderIndex, List<QuestTestOptionEntity> options
});




}
/// @nodoc
class _$QuestTestQuestionEntityCopyWithImpl<$Res>
    implements $QuestTestQuestionEntityCopyWith<$Res> {
  _$QuestTestQuestionEntityCopyWithImpl(this._self, this._then);

  final QuestTestQuestionEntity _self;
  final $Res Function(QuestTestQuestionEntity) _then;

/// Create a copy of QuestTestQuestionEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? text = null,Object? points = null,Object? orderIndex = null,Object? options = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as QuestTestQuestionType,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<QuestTestOptionEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [QuestTestQuestionEntity].
extension QuestTestQuestionEntityPatterns on QuestTestQuestionEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestTestQuestionEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestTestQuestionEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestTestQuestionEntity value)  $default,){
final _that = this;
switch (_that) {
case _QuestTestQuestionEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestTestQuestionEntity value)?  $default,){
final _that = this;
switch (_that) {
case _QuestTestQuestionEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  QuestTestQuestionType type,  String text,  int points,  int orderIndex,  List<QuestTestOptionEntity> options)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestTestQuestionEntity() when $default != null:
return $default(_that.id,_that.type,_that.text,_that.points,_that.orderIndex,_that.options);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  QuestTestQuestionType type,  String text,  int points,  int orderIndex,  List<QuestTestOptionEntity> options)  $default,) {final _that = this;
switch (_that) {
case _QuestTestQuestionEntity():
return $default(_that.id,_that.type,_that.text,_that.points,_that.orderIndex,_that.options);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  QuestTestQuestionType type,  String text,  int points,  int orderIndex,  List<QuestTestOptionEntity> options)?  $default,) {final _that = this;
switch (_that) {
case _QuestTestQuestionEntity() when $default != null:
return $default(_that.id,_that.type,_that.text,_that.points,_that.orderIndex,_that.options);case _:
  return null;

}
}

}

/// @nodoc


class _QuestTestQuestionEntity implements QuestTestQuestionEntity {
  const _QuestTestQuestionEntity({required this.id, required this.type, required this.text, required this.points, required this.orderIndex, required final  List<QuestTestOptionEntity> options}): _options = options;
  

@override final  int id;
@override final  QuestTestQuestionType type;
@override final  String text;
@override final  int points;
@override final  int orderIndex;
 final  List<QuestTestOptionEntity> _options;
@override List<QuestTestOptionEntity> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}


/// Create a copy of QuestTestQuestionEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestTestQuestionEntityCopyWith<_QuestTestQuestionEntity> get copyWith => __$QuestTestQuestionEntityCopyWithImpl<_QuestTestQuestionEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestTestQuestionEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.text, text) || other.text == text)&&(identical(other.points, points) || other.points == points)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex)&&const DeepCollectionEquality().equals(other._options, _options));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,text,points,orderIndex,const DeepCollectionEquality().hash(_options));

@override
String toString() {
  return 'QuestTestQuestionEntity(id: $id, type: $type, text: $text, points: $points, orderIndex: $orderIndex, options: $options)';
}


}

/// @nodoc
abstract mixin class _$QuestTestQuestionEntityCopyWith<$Res> implements $QuestTestQuestionEntityCopyWith<$Res> {
  factory _$QuestTestQuestionEntityCopyWith(_QuestTestQuestionEntity value, $Res Function(_QuestTestQuestionEntity) _then) = __$QuestTestQuestionEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, QuestTestQuestionType type, String text, int points, int orderIndex, List<QuestTestOptionEntity> options
});




}
/// @nodoc
class __$QuestTestQuestionEntityCopyWithImpl<$Res>
    implements _$QuestTestQuestionEntityCopyWith<$Res> {
  __$QuestTestQuestionEntityCopyWithImpl(this._self, this._then);

  final _QuestTestQuestionEntity _self;
  final $Res Function(_QuestTestQuestionEntity) _then;

/// Create a copy of QuestTestQuestionEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? text = null,Object? points = null,Object? orderIndex = null,Object? options = null,}) {
  return _then(_QuestTestQuestionEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as QuestTestQuestionType,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<QuestTestOptionEntity>,
  ));
}


}

/// @nodoc
mixin _$QuestTestOptionEntity {

 int get id; String get text; int get orderIndex;
/// Create a copy of QuestTestOptionEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestTestOptionEntityCopyWith<QuestTestOptionEntity> get copyWith => _$QuestTestOptionEntityCopyWithImpl<QuestTestOptionEntity>(this as QuestTestOptionEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestTestOptionEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex));
}


@override
int get hashCode => Object.hash(runtimeType,id,text,orderIndex);

@override
String toString() {
  return 'QuestTestOptionEntity(id: $id, text: $text, orderIndex: $orderIndex)';
}


}

/// @nodoc
abstract mixin class $QuestTestOptionEntityCopyWith<$Res>  {
  factory $QuestTestOptionEntityCopyWith(QuestTestOptionEntity value, $Res Function(QuestTestOptionEntity) _then) = _$QuestTestOptionEntityCopyWithImpl;
@useResult
$Res call({
 int id, String text, int orderIndex
});




}
/// @nodoc
class _$QuestTestOptionEntityCopyWithImpl<$Res>
    implements $QuestTestOptionEntityCopyWith<$Res> {
  _$QuestTestOptionEntityCopyWithImpl(this._self, this._then);

  final QuestTestOptionEntity _self;
  final $Res Function(QuestTestOptionEntity) _then;

/// Create a copy of QuestTestOptionEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? text = null,Object? orderIndex = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [QuestTestOptionEntity].
extension QuestTestOptionEntityPatterns on QuestTestOptionEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestTestOptionEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestTestOptionEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestTestOptionEntity value)  $default,){
final _that = this;
switch (_that) {
case _QuestTestOptionEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestTestOptionEntity value)?  $default,){
final _that = this;
switch (_that) {
case _QuestTestOptionEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String text,  int orderIndex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestTestOptionEntity() when $default != null:
return $default(_that.id,_that.text,_that.orderIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String text,  int orderIndex)  $default,) {final _that = this;
switch (_that) {
case _QuestTestOptionEntity():
return $default(_that.id,_that.text,_that.orderIndex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String text,  int orderIndex)?  $default,) {final _that = this;
switch (_that) {
case _QuestTestOptionEntity() when $default != null:
return $default(_that.id,_that.text,_that.orderIndex);case _:
  return null;

}
}

}

/// @nodoc


class _QuestTestOptionEntity implements QuestTestOptionEntity {
  const _QuestTestOptionEntity({required this.id, required this.text, required this.orderIndex});
  

@override final  int id;
@override final  String text;
@override final  int orderIndex;

/// Create a copy of QuestTestOptionEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestTestOptionEntityCopyWith<_QuestTestOptionEntity> get copyWith => __$QuestTestOptionEntityCopyWithImpl<_QuestTestOptionEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestTestOptionEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex));
}


@override
int get hashCode => Object.hash(runtimeType,id,text,orderIndex);

@override
String toString() {
  return 'QuestTestOptionEntity(id: $id, text: $text, orderIndex: $orderIndex)';
}


}

/// @nodoc
abstract mixin class _$QuestTestOptionEntityCopyWith<$Res> implements $QuestTestOptionEntityCopyWith<$Res> {
  factory _$QuestTestOptionEntityCopyWith(_QuestTestOptionEntity value, $Res Function(_QuestTestOptionEntity) _then) = __$QuestTestOptionEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String text, int orderIndex
});




}
/// @nodoc
class __$QuestTestOptionEntityCopyWithImpl<$Res>
    implements _$QuestTestOptionEntityCopyWith<$Res> {
  __$QuestTestOptionEntityCopyWithImpl(this._self, this._then);

  final _QuestTestOptionEntity _self;
  final $Res Function(_QuestTestOptionEntity) _then;

/// Create a copy of QuestTestOptionEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? text = null,Object? orderIndex = null,}) {
  return _then(_QuestTestOptionEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$QuestTestAnswerEntity {

 int get questionId; List<int> get optionIds;
/// Create a copy of QuestTestAnswerEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestTestAnswerEntityCopyWith<QuestTestAnswerEntity> get copyWith => _$QuestTestAnswerEntityCopyWithImpl<QuestTestAnswerEntity>(this as QuestTestAnswerEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestTestAnswerEntity&&(identical(other.questionId, questionId) || other.questionId == questionId)&&const DeepCollectionEquality().equals(other.optionIds, optionIds));
}


@override
int get hashCode => Object.hash(runtimeType,questionId,const DeepCollectionEquality().hash(optionIds));

@override
String toString() {
  return 'QuestTestAnswerEntity(questionId: $questionId, optionIds: $optionIds)';
}


}

/// @nodoc
abstract mixin class $QuestTestAnswerEntityCopyWith<$Res>  {
  factory $QuestTestAnswerEntityCopyWith(QuestTestAnswerEntity value, $Res Function(QuestTestAnswerEntity) _then) = _$QuestTestAnswerEntityCopyWithImpl;
@useResult
$Res call({
 int questionId, List<int> optionIds
});




}
/// @nodoc
class _$QuestTestAnswerEntityCopyWithImpl<$Res>
    implements $QuestTestAnswerEntityCopyWith<$Res> {
  _$QuestTestAnswerEntityCopyWithImpl(this._self, this._then);

  final QuestTestAnswerEntity _self;
  final $Res Function(QuestTestAnswerEntity) _then;

/// Create a copy of QuestTestAnswerEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? questionId = null,Object? optionIds = null,}) {
  return _then(_self.copyWith(
questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as int,optionIds: null == optionIds ? _self.optionIds : optionIds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [QuestTestAnswerEntity].
extension QuestTestAnswerEntityPatterns on QuestTestAnswerEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestTestAnswerEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestTestAnswerEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestTestAnswerEntity value)  $default,){
final _that = this;
switch (_that) {
case _QuestTestAnswerEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestTestAnswerEntity value)?  $default,){
final _that = this;
switch (_that) {
case _QuestTestAnswerEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int questionId,  List<int> optionIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestTestAnswerEntity() when $default != null:
return $default(_that.questionId,_that.optionIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int questionId,  List<int> optionIds)  $default,) {final _that = this;
switch (_that) {
case _QuestTestAnswerEntity():
return $default(_that.questionId,_that.optionIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int questionId,  List<int> optionIds)?  $default,) {final _that = this;
switch (_that) {
case _QuestTestAnswerEntity() when $default != null:
return $default(_that.questionId,_that.optionIds);case _:
  return null;

}
}

}

/// @nodoc


class _QuestTestAnswerEntity implements QuestTestAnswerEntity {
  const _QuestTestAnswerEntity({required this.questionId, required final  List<int> optionIds}): _optionIds = optionIds;
  

@override final  int questionId;
 final  List<int> _optionIds;
@override List<int> get optionIds {
  if (_optionIds is EqualUnmodifiableListView) return _optionIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_optionIds);
}


/// Create a copy of QuestTestAnswerEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestTestAnswerEntityCopyWith<_QuestTestAnswerEntity> get copyWith => __$QuestTestAnswerEntityCopyWithImpl<_QuestTestAnswerEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestTestAnswerEntity&&(identical(other.questionId, questionId) || other.questionId == questionId)&&const DeepCollectionEquality().equals(other._optionIds, _optionIds));
}


@override
int get hashCode => Object.hash(runtimeType,questionId,const DeepCollectionEquality().hash(_optionIds));

@override
String toString() {
  return 'QuestTestAnswerEntity(questionId: $questionId, optionIds: $optionIds)';
}


}

/// @nodoc
abstract mixin class _$QuestTestAnswerEntityCopyWith<$Res> implements $QuestTestAnswerEntityCopyWith<$Res> {
  factory _$QuestTestAnswerEntityCopyWith(_QuestTestAnswerEntity value, $Res Function(_QuestTestAnswerEntity) _then) = __$QuestTestAnswerEntityCopyWithImpl;
@override @useResult
$Res call({
 int questionId, List<int> optionIds
});




}
/// @nodoc
class __$QuestTestAnswerEntityCopyWithImpl<$Res>
    implements _$QuestTestAnswerEntityCopyWith<$Res> {
  __$QuestTestAnswerEntityCopyWithImpl(this._self, this._then);

  final _QuestTestAnswerEntity _self;
  final $Res Function(_QuestTestAnswerEntity) _then;

/// Create a copy of QuestTestAnswerEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? questionId = null,Object? optionIds = null,}) {
  return _then(_QuestTestAnswerEntity(
questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as int,optionIds: null == optionIds ? _self._optionIds : optionIds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

/// @nodoc
mixin _$QuestTestResultEntity {

 int get id; int get score; bool get isPassed; String get createdAt;
/// Create a copy of QuestTestResultEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestTestResultEntityCopyWith<QuestTestResultEntity> get copyWith => _$QuestTestResultEntityCopyWithImpl<QuestTestResultEntity>(this as QuestTestResultEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestTestResultEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.score, score) || other.score == score)&&(identical(other.isPassed, isPassed) || other.isPassed == isPassed)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,score,isPassed,createdAt);

@override
String toString() {
  return 'QuestTestResultEntity(id: $id, score: $score, isPassed: $isPassed, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $QuestTestResultEntityCopyWith<$Res>  {
  factory $QuestTestResultEntityCopyWith(QuestTestResultEntity value, $Res Function(QuestTestResultEntity) _then) = _$QuestTestResultEntityCopyWithImpl;
@useResult
$Res call({
 int id, int score, bool isPassed, String createdAt
});




}
/// @nodoc
class _$QuestTestResultEntityCopyWithImpl<$Res>
    implements $QuestTestResultEntityCopyWith<$Res> {
  _$QuestTestResultEntityCopyWithImpl(this._self, this._then);

  final QuestTestResultEntity _self;
  final $Res Function(QuestTestResultEntity) _then;

/// Create a copy of QuestTestResultEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? score = null,Object? isPassed = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,isPassed: null == isPassed ? _self.isPassed : isPassed // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [QuestTestResultEntity].
extension QuestTestResultEntityPatterns on QuestTestResultEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestTestResultEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestTestResultEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestTestResultEntity value)  $default,){
final _that = this;
switch (_that) {
case _QuestTestResultEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestTestResultEntity value)?  $default,){
final _that = this;
switch (_that) {
case _QuestTestResultEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int score,  bool isPassed,  String createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestTestResultEntity() when $default != null:
return $default(_that.id,_that.score,_that.isPassed,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int score,  bool isPassed,  String createdAt)  $default,) {final _that = this;
switch (_that) {
case _QuestTestResultEntity():
return $default(_that.id,_that.score,_that.isPassed,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int score,  bool isPassed,  String createdAt)?  $default,) {final _that = this;
switch (_that) {
case _QuestTestResultEntity() when $default != null:
return $default(_that.id,_that.score,_that.isPassed,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _QuestTestResultEntity implements QuestTestResultEntity {
  const _QuestTestResultEntity({required this.id, required this.score, required this.isPassed, required this.createdAt});
  

@override final  int id;
@override final  int score;
@override final  bool isPassed;
@override final  String createdAt;

/// Create a copy of QuestTestResultEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestTestResultEntityCopyWith<_QuestTestResultEntity> get copyWith => __$QuestTestResultEntityCopyWithImpl<_QuestTestResultEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestTestResultEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.score, score) || other.score == score)&&(identical(other.isPassed, isPassed) || other.isPassed == isPassed)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,score,isPassed,createdAt);

@override
String toString() {
  return 'QuestTestResultEntity(id: $id, score: $score, isPassed: $isPassed, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$QuestTestResultEntityCopyWith<$Res> implements $QuestTestResultEntityCopyWith<$Res> {
  factory _$QuestTestResultEntityCopyWith(_QuestTestResultEntity value, $Res Function(_QuestTestResultEntity) _then) = __$QuestTestResultEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, int score, bool isPassed, String createdAt
});




}
/// @nodoc
class __$QuestTestResultEntityCopyWithImpl<$Res>
    implements _$QuestTestResultEntityCopyWith<$Res> {
  __$QuestTestResultEntityCopyWithImpl(this._self, this._then);

  final _QuestTestResultEntity _self;
  final $Res Function(_QuestTestResultEntity) _then;

/// Create a copy of QuestTestResultEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? score = null,Object? isPassed = null,Object? createdAt = null,}) {
  return _then(_QuestTestResultEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,isPassed: null == isPassed ? _self.isPassed : isPassed // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
