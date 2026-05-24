// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qr_scanner_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QrScannerEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QrScannerEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QrScannerEvent()';
}


}

/// @nodoc
class $QrScannerEventCopyWith<$Res>  {
$QrScannerEventCopyWith(QrScannerEvent _, $Res Function(QrScannerEvent) __);
}


/// Adds pattern-matching-related methods to [QrScannerEvent].
extension QrScannerEventPatterns on QrScannerEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( QrScannerDetected value)?  detected,TResult Function( QrScannerReset value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case QrScannerDetected() when detected != null:
return detected(_that);case QrScannerReset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( QrScannerDetected value)  detected,required TResult Function( QrScannerReset value)  reset,}){
final _that = this;
switch (_that) {
case QrScannerDetected():
return detected(_that);case QrScannerReset():
return reset(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( QrScannerDetected value)?  detected,TResult? Function( QrScannerReset value)?  reset,}){
final _that = this;
switch (_that) {
case QrScannerDetected() when detected != null:
return detected(_that);case QrScannerReset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String rawValue)?  detected,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case QrScannerDetected() when detected != null:
return detected(_that.rawValue);case QrScannerReset() when reset != null:
return reset();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String rawValue)  detected,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case QrScannerDetected():
return detected(_that.rawValue);case QrScannerReset():
return reset();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String rawValue)?  detected,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case QrScannerDetected() when detected != null:
return detected(_that.rawValue);case QrScannerReset() when reset != null:
return reset();case _:
  return null;

}
}

}

/// @nodoc


class QrScannerDetected implements QrScannerEvent {
  const QrScannerDetected(this.rawValue);
  

 final  String rawValue;

/// Create a copy of QrScannerEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QrScannerDetectedCopyWith<QrScannerDetected> get copyWith => _$QrScannerDetectedCopyWithImpl<QrScannerDetected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QrScannerDetected&&(identical(other.rawValue, rawValue) || other.rawValue == rawValue));
}


@override
int get hashCode => Object.hash(runtimeType,rawValue);

@override
String toString() {
  return 'QrScannerEvent.detected(rawValue: $rawValue)';
}


}

/// @nodoc
abstract mixin class $QrScannerDetectedCopyWith<$Res> implements $QrScannerEventCopyWith<$Res> {
  factory $QrScannerDetectedCopyWith(QrScannerDetected value, $Res Function(QrScannerDetected) _then) = _$QrScannerDetectedCopyWithImpl;
@useResult
$Res call({
 String rawValue
});




}
/// @nodoc
class _$QrScannerDetectedCopyWithImpl<$Res>
    implements $QrScannerDetectedCopyWith<$Res> {
  _$QrScannerDetectedCopyWithImpl(this._self, this._then);

  final QrScannerDetected _self;
  final $Res Function(QrScannerDetected) _then;

/// Create a copy of QrScannerEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? rawValue = null,}) {
  return _then(QrScannerDetected(
null == rawValue ? _self.rawValue : rawValue // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class QrScannerReset implements QrScannerEvent {
  const QrScannerReset();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QrScannerReset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QrScannerEvent.reset()';
}


}




/// @nodoc
mixin _$QrScannerState {

 QrScannerStatus get status; int? get questId; int? get eventId; String? get scanSessionId; String? get errorMessage;
/// Create a copy of QrScannerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QrScannerStateCopyWith<QrScannerState> get copyWith => _$QrScannerStateCopyWithImpl<QrScannerState>(this as QrScannerState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QrScannerState&&(identical(other.status, status) || other.status == status)&&(identical(other.questId, questId) || other.questId == questId)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.scanSessionId, scanSessionId) || other.scanSessionId == scanSessionId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,questId,eventId,scanSessionId,errorMessage);

@override
String toString() {
  return 'QrScannerState(status: $status, questId: $questId, eventId: $eventId, scanSessionId: $scanSessionId, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $QrScannerStateCopyWith<$Res>  {
  factory $QrScannerStateCopyWith(QrScannerState value, $Res Function(QrScannerState) _then) = _$QrScannerStateCopyWithImpl;
@useResult
$Res call({
 QrScannerStatus status, int? questId, int? eventId, String? scanSessionId, String? errorMessage
});




}
/// @nodoc
class _$QrScannerStateCopyWithImpl<$Res>
    implements $QrScannerStateCopyWith<$Res> {
  _$QrScannerStateCopyWithImpl(this._self, this._then);

  final QrScannerState _self;
  final $Res Function(QrScannerState) _then;

/// Create a copy of QrScannerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? questId = freezed,Object? eventId = freezed,Object? scanSessionId = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as QrScannerStatus,questId: freezed == questId ? _self.questId : questId // ignore: cast_nullable_to_non_nullable
as int?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int?,scanSessionId: freezed == scanSessionId ? _self.scanSessionId : scanSessionId // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [QrScannerState].
extension QrScannerStatePatterns on QrScannerState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QrScannerState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QrScannerState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QrScannerState value)  $default,){
final _that = this;
switch (_that) {
case _QrScannerState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QrScannerState value)?  $default,){
final _that = this;
switch (_that) {
case _QrScannerState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( QrScannerStatus status,  int? questId,  int? eventId,  String? scanSessionId,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QrScannerState() when $default != null:
return $default(_that.status,_that.questId,_that.eventId,_that.scanSessionId,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( QrScannerStatus status,  int? questId,  int? eventId,  String? scanSessionId,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _QrScannerState():
return $default(_that.status,_that.questId,_that.eventId,_that.scanSessionId,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( QrScannerStatus status,  int? questId,  int? eventId,  String? scanSessionId,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _QrScannerState() when $default != null:
return $default(_that.status,_that.questId,_that.eventId,_that.scanSessionId,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _QrScannerState implements QrScannerState {
  const _QrScannerState({this.status = QrScannerStatus.idle, this.questId, this.eventId, this.scanSessionId, this.errorMessage});
  

@override@JsonKey() final  QrScannerStatus status;
@override final  int? questId;
@override final  int? eventId;
@override final  String? scanSessionId;
@override final  String? errorMessage;

/// Create a copy of QrScannerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QrScannerStateCopyWith<_QrScannerState> get copyWith => __$QrScannerStateCopyWithImpl<_QrScannerState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QrScannerState&&(identical(other.status, status) || other.status == status)&&(identical(other.questId, questId) || other.questId == questId)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.scanSessionId, scanSessionId) || other.scanSessionId == scanSessionId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,questId,eventId,scanSessionId,errorMessage);

@override
String toString() {
  return 'QrScannerState(status: $status, questId: $questId, eventId: $eventId, scanSessionId: $scanSessionId, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$QrScannerStateCopyWith<$Res> implements $QrScannerStateCopyWith<$Res> {
  factory _$QrScannerStateCopyWith(_QrScannerState value, $Res Function(_QrScannerState) _then) = __$QrScannerStateCopyWithImpl;
@override @useResult
$Res call({
 QrScannerStatus status, int? questId, int? eventId, String? scanSessionId, String? errorMessage
});




}
/// @nodoc
class __$QrScannerStateCopyWithImpl<$Res>
    implements _$QrScannerStateCopyWith<$Res> {
  __$QrScannerStateCopyWithImpl(this._self, this._then);

  final _QrScannerState _self;
  final $Res Function(_QrScannerState) _then;

/// Create a copy of QrScannerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? questId = freezed,Object? eventId = freezed,Object? scanSessionId = freezed,Object? errorMessage = freezed,}) {
  return _then(_QrScannerState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as QrScannerStatus,questId: freezed == questId ? _self.questId : questId // ignore: cast_nullable_to_non_nullable
as int?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int?,scanSessionId: freezed == scanSessionId ? _self.scanSessionId : scanSessionId // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
