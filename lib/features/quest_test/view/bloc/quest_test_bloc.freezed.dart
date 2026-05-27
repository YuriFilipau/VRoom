// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quest_test_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QuestTestEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestTestEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QuestTestEvent()';
}


}

/// @nodoc
class $QuestTestEventCopyWith<$Res>  {
$QuestTestEventCopyWith(QuestTestEvent _, $Res Function(QuestTestEvent) __);
}


/// Adds pattern-matching-related methods to [QuestTestEvent].
extension QuestTestEventPatterns on QuestTestEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( QuestTestLoadRequested value)?  loadRequested,TResult Function( QuestTestOptionToggled value)?  optionToggled,TResult Function( QuestTestSubmitRequested value)?  submitRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case QuestTestLoadRequested() when loadRequested != null:
return loadRequested(_that);case QuestTestOptionToggled() when optionToggled != null:
return optionToggled(_that);case QuestTestSubmitRequested() when submitRequested != null:
return submitRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( QuestTestLoadRequested value)  loadRequested,required TResult Function( QuestTestOptionToggled value)  optionToggled,required TResult Function( QuestTestSubmitRequested value)  submitRequested,}){
final _that = this;
switch (_that) {
case QuestTestLoadRequested():
return loadRequested(_that);case QuestTestOptionToggled():
return optionToggled(_that);case QuestTestSubmitRequested():
return submitRequested(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( QuestTestLoadRequested value)?  loadRequested,TResult? Function( QuestTestOptionToggled value)?  optionToggled,TResult? Function( QuestTestSubmitRequested value)?  submitRequested,}){
final _that = this;
switch (_that) {
case QuestTestLoadRequested() when loadRequested != null:
return loadRequested(_that);case QuestTestOptionToggled() when optionToggled != null:
return optionToggled(_that);case QuestTestSubmitRequested() when submitRequested != null:
return submitRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int questId)?  loadRequested,TResult Function( int questionId,  int optionId)?  optionToggled,TResult Function()?  submitRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case QuestTestLoadRequested() when loadRequested != null:
return loadRequested(_that.questId);case QuestTestOptionToggled() when optionToggled != null:
return optionToggled(_that.questionId,_that.optionId);case QuestTestSubmitRequested() when submitRequested != null:
return submitRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int questId)  loadRequested,required TResult Function( int questionId,  int optionId)  optionToggled,required TResult Function()  submitRequested,}) {final _that = this;
switch (_that) {
case QuestTestLoadRequested():
return loadRequested(_that.questId);case QuestTestOptionToggled():
return optionToggled(_that.questionId,_that.optionId);case QuestTestSubmitRequested():
return submitRequested();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int questId)?  loadRequested,TResult? Function( int questionId,  int optionId)?  optionToggled,TResult? Function()?  submitRequested,}) {final _that = this;
switch (_that) {
case QuestTestLoadRequested() when loadRequested != null:
return loadRequested(_that.questId);case QuestTestOptionToggled() when optionToggled != null:
return optionToggled(_that.questionId,_that.optionId);case QuestTestSubmitRequested() when submitRequested != null:
return submitRequested();case _:
  return null;

}
}

}

/// @nodoc


class QuestTestLoadRequested implements QuestTestEvent {
  const QuestTestLoadRequested(this.questId);
  

 final  int questId;

/// Create a copy of QuestTestEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestTestLoadRequestedCopyWith<QuestTestLoadRequested> get copyWith => _$QuestTestLoadRequestedCopyWithImpl<QuestTestLoadRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestTestLoadRequested&&(identical(other.questId, questId) || other.questId == questId));
}


@override
int get hashCode => Object.hash(runtimeType,questId);

@override
String toString() {
  return 'QuestTestEvent.loadRequested(questId: $questId)';
}


}

/// @nodoc
abstract mixin class $QuestTestLoadRequestedCopyWith<$Res> implements $QuestTestEventCopyWith<$Res> {
  factory $QuestTestLoadRequestedCopyWith(QuestTestLoadRequested value, $Res Function(QuestTestLoadRequested) _then) = _$QuestTestLoadRequestedCopyWithImpl;
@useResult
$Res call({
 int questId
});




}
/// @nodoc
class _$QuestTestLoadRequestedCopyWithImpl<$Res>
    implements $QuestTestLoadRequestedCopyWith<$Res> {
  _$QuestTestLoadRequestedCopyWithImpl(this._self, this._then);

  final QuestTestLoadRequested _self;
  final $Res Function(QuestTestLoadRequested) _then;

/// Create a copy of QuestTestEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? questId = null,}) {
  return _then(QuestTestLoadRequested(
null == questId ? _self.questId : questId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class QuestTestOptionToggled implements QuestTestEvent {
  const QuestTestOptionToggled({required this.questionId, required this.optionId});
  

 final  int questionId;
 final  int optionId;

/// Create a copy of QuestTestEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestTestOptionToggledCopyWith<QuestTestOptionToggled> get copyWith => _$QuestTestOptionToggledCopyWithImpl<QuestTestOptionToggled>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestTestOptionToggled&&(identical(other.questionId, questionId) || other.questionId == questionId)&&(identical(other.optionId, optionId) || other.optionId == optionId));
}


@override
int get hashCode => Object.hash(runtimeType,questionId,optionId);

@override
String toString() {
  return 'QuestTestEvent.optionToggled(questionId: $questionId, optionId: $optionId)';
}


}

/// @nodoc
abstract mixin class $QuestTestOptionToggledCopyWith<$Res> implements $QuestTestEventCopyWith<$Res> {
  factory $QuestTestOptionToggledCopyWith(QuestTestOptionToggled value, $Res Function(QuestTestOptionToggled) _then) = _$QuestTestOptionToggledCopyWithImpl;
@useResult
$Res call({
 int questionId, int optionId
});




}
/// @nodoc
class _$QuestTestOptionToggledCopyWithImpl<$Res>
    implements $QuestTestOptionToggledCopyWith<$Res> {
  _$QuestTestOptionToggledCopyWithImpl(this._self, this._then);

  final QuestTestOptionToggled _self;
  final $Res Function(QuestTestOptionToggled) _then;

/// Create a copy of QuestTestEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? questionId = null,Object? optionId = null,}) {
  return _then(QuestTestOptionToggled(
questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as int,optionId: null == optionId ? _self.optionId : optionId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class QuestTestSubmitRequested implements QuestTestEvent {
  const QuestTestSubmitRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestTestSubmitRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QuestTestEvent.submitRequested()';
}


}




/// @nodoc
mixin _$QuestTestState {

 QuestTestStatus get status; int get questId; QuestTestEntity? get test; QuestTestResultEntity? get latestResult; Map<int, List<int>> get selectedAnswers; String? get message;
/// Create a copy of QuestTestState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestTestStateCopyWith<QuestTestState> get copyWith => _$QuestTestStateCopyWithImpl<QuestTestState>(this as QuestTestState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestTestState&&(identical(other.status, status) || other.status == status)&&(identical(other.questId, questId) || other.questId == questId)&&(identical(other.test, test) || other.test == test)&&(identical(other.latestResult, latestResult) || other.latestResult == latestResult)&&const DeepCollectionEquality().equals(other.selectedAnswers, selectedAnswers)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,status,questId,test,latestResult,const DeepCollectionEquality().hash(selectedAnswers),message);

@override
String toString() {
  return 'QuestTestState(status: $status, questId: $questId, test: $test, latestResult: $latestResult, selectedAnswers: $selectedAnswers, message: $message)';
}


}

/// @nodoc
abstract mixin class $QuestTestStateCopyWith<$Res>  {
  factory $QuestTestStateCopyWith(QuestTestState value, $Res Function(QuestTestState) _then) = _$QuestTestStateCopyWithImpl;
@useResult
$Res call({
 QuestTestStatus status, int questId, QuestTestEntity? test, QuestTestResultEntity? latestResult, Map<int, List<int>> selectedAnswers, String? message
});


$QuestTestEntityCopyWith<$Res>? get test;$QuestTestResultEntityCopyWith<$Res>? get latestResult;

}
/// @nodoc
class _$QuestTestStateCopyWithImpl<$Res>
    implements $QuestTestStateCopyWith<$Res> {
  _$QuestTestStateCopyWithImpl(this._self, this._then);

  final QuestTestState _self;
  final $Res Function(QuestTestState) _then;

/// Create a copy of QuestTestState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? questId = null,Object? test = freezed,Object? latestResult = freezed,Object? selectedAnswers = null,Object? message = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as QuestTestStatus,questId: null == questId ? _self.questId : questId // ignore: cast_nullable_to_non_nullable
as int,test: freezed == test ? _self.test : test // ignore: cast_nullable_to_non_nullable
as QuestTestEntity?,latestResult: freezed == latestResult ? _self.latestResult : latestResult // ignore: cast_nullable_to_non_nullable
as QuestTestResultEntity?,selectedAnswers: null == selectedAnswers ? _self.selectedAnswers : selectedAnswers // ignore: cast_nullable_to_non_nullable
as Map<int, List<int>>,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of QuestTestState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuestTestEntityCopyWith<$Res>? get test {
    if (_self.test == null) {
    return null;
  }

  return $QuestTestEntityCopyWith<$Res>(_self.test!, (value) {
    return _then(_self.copyWith(test: value));
  });
}/// Create a copy of QuestTestState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuestTestResultEntityCopyWith<$Res>? get latestResult {
    if (_self.latestResult == null) {
    return null;
  }

  return $QuestTestResultEntityCopyWith<$Res>(_self.latestResult!, (value) {
    return _then(_self.copyWith(latestResult: value));
  });
}
}


/// Adds pattern-matching-related methods to [QuestTestState].
extension QuestTestStatePatterns on QuestTestState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestTestState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestTestState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestTestState value)  $default,){
final _that = this;
switch (_that) {
case _QuestTestState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestTestState value)?  $default,){
final _that = this;
switch (_that) {
case _QuestTestState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( QuestTestStatus status,  int questId,  QuestTestEntity? test,  QuestTestResultEntity? latestResult,  Map<int, List<int>> selectedAnswers,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestTestState() when $default != null:
return $default(_that.status,_that.questId,_that.test,_that.latestResult,_that.selectedAnswers,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( QuestTestStatus status,  int questId,  QuestTestEntity? test,  QuestTestResultEntity? latestResult,  Map<int, List<int>> selectedAnswers,  String? message)  $default,) {final _that = this;
switch (_that) {
case _QuestTestState():
return $default(_that.status,_that.questId,_that.test,_that.latestResult,_that.selectedAnswers,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( QuestTestStatus status,  int questId,  QuestTestEntity? test,  QuestTestResultEntity? latestResult,  Map<int, List<int>> selectedAnswers,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _QuestTestState() when $default != null:
return $default(_that.status,_that.questId,_that.test,_that.latestResult,_that.selectedAnswers,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _QuestTestState extends QuestTestState {
  const _QuestTestState({this.status = QuestTestStatus.initial, this.questId = 0, this.test, this.latestResult, final  Map<int, List<int>> selectedAnswers = const {}, this.message}): _selectedAnswers = selectedAnswers,super._();
  

@override@JsonKey() final  QuestTestStatus status;
@override@JsonKey() final  int questId;
@override final  QuestTestEntity? test;
@override final  QuestTestResultEntity? latestResult;
 final  Map<int, List<int>> _selectedAnswers;
@override@JsonKey() Map<int, List<int>> get selectedAnswers {
  if (_selectedAnswers is EqualUnmodifiableMapView) return _selectedAnswers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_selectedAnswers);
}

@override final  String? message;

/// Create a copy of QuestTestState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestTestStateCopyWith<_QuestTestState> get copyWith => __$QuestTestStateCopyWithImpl<_QuestTestState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestTestState&&(identical(other.status, status) || other.status == status)&&(identical(other.questId, questId) || other.questId == questId)&&(identical(other.test, test) || other.test == test)&&(identical(other.latestResult, latestResult) || other.latestResult == latestResult)&&const DeepCollectionEquality().equals(other._selectedAnswers, _selectedAnswers)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,status,questId,test,latestResult,const DeepCollectionEquality().hash(_selectedAnswers),message);

@override
String toString() {
  return 'QuestTestState(status: $status, questId: $questId, test: $test, latestResult: $latestResult, selectedAnswers: $selectedAnswers, message: $message)';
}


}

/// @nodoc
abstract mixin class _$QuestTestStateCopyWith<$Res> implements $QuestTestStateCopyWith<$Res> {
  factory _$QuestTestStateCopyWith(_QuestTestState value, $Res Function(_QuestTestState) _then) = __$QuestTestStateCopyWithImpl;
@override @useResult
$Res call({
 QuestTestStatus status, int questId, QuestTestEntity? test, QuestTestResultEntity? latestResult, Map<int, List<int>> selectedAnswers, String? message
});


@override $QuestTestEntityCopyWith<$Res>? get test;@override $QuestTestResultEntityCopyWith<$Res>? get latestResult;

}
/// @nodoc
class __$QuestTestStateCopyWithImpl<$Res>
    implements _$QuestTestStateCopyWith<$Res> {
  __$QuestTestStateCopyWithImpl(this._self, this._then);

  final _QuestTestState _self;
  final $Res Function(_QuestTestState) _then;

/// Create a copy of QuestTestState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? questId = null,Object? test = freezed,Object? latestResult = freezed,Object? selectedAnswers = null,Object? message = freezed,}) {
  return _then(_QuestTestState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as QuestTestStatus,questId: null == questId ? _self.questId : questId // ignore: cast_nullable_to_non_nullable
as int,test: freezed == test ? _self.test : test // ignore: cast_nullable_to_non_nullable
as QuestTestEntity?,latestResult: freezed == latestResult ? _self.latestResult : latestResult // ignore: cast_nullable_to_non_nullable
as QuestTestResultEntity?,selectedAnswers: null == selectedAnswers ? _self._selectedAnswers : selectedAnswers // ignore: cast_nullable_to_non_nullable
as Map<int, List<int>>,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of QuestTestState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuestTestEntityCopyWith<$Res>? get test {
    if (_self.test == null) {
    return null;
  }

  return $QuestTestEntityCopyWith<$Res>(_self.test!, (value) {
    return _then(_self.copyWith(test: value));
  });
}/// Create a copy of QuestTestState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuestTestResultEntityCopyWith<$Res>? get latestResult {
    if (_self.latestResult == null) {
    return null;
  }

  return $QuestTestResultEntityCopyWith<$Res>(_self.latestResult!, (value) {
    return _then(_self.copyWith(latestResult: value));
  });
}
}

// dart format on
