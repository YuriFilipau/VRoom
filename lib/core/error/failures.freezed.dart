// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Failure {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Failure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure()';
}


}

/// @nodoc
class $FailureCopyWith<$Res>  {
$FailureCopyWith(Failure _, $Res Function(Failure) __);
}


/// Adds pattern-matching-related methods to [Failure].
extension FailurePatterns on Failure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ServerFailure value)?  server,TResult Function( NetworkFailure value)?  network,TResult Function( CacheFailure value)?  cache,TResult Function( UnauthorizedFailure value)?  unauthorized,TResult Function( ValidationFailure value)?  validation,TResult Function( EmailAlreadyInUseFailure value)?  emailAlreadyInUse,TResult Function( WeakPasswordFailure value)?  weakPassword,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ServerFailure() when server != null:
return server(_that);case NetworkFailure() when network != null:
return network(_that);case CacheFailure() when cache != null:
return cache(_that);case UnauthorizedFailure() when unauthorized != null:
return unauthorized(_that);case ValidationFailure() when validation != null:
return validation(_that);case EmailAlreadyInUseFailure() when emailAlreadyInUse != null:
return emailAlreadyInUse(_that);case WeakPasswordFailure() when weakPassword != null:
return weakPassword(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ServerFailure value)  server,required TResult Function( NetworkFailure value)  network,required TResult Function( CacheFailure value)  cache,required TResult Function( UnauthorizedFailure value)  unauthorized,required TResult Function( ValidationFailure value)  validation,required TResult Function( EmailAlreadyInUseFailure value)  emailAlreadyInUse,required TResult Function( WeakPasswordFailure value)  weakPassword,}){
final _that = this;
switch (_that) {
case ServerFailure():
return server(_that);case NetworkFailure():
return network(_that);case CacheFailure():
return cache(_that);case UnauthorizedFailure():
return unauthorized(_that);case ValidationFailure():
return validation(_that);case EmailAlreadyInUseFailure():
return emailAlreadyInUse(_that);case WeakPasswordFailure():
return weakPassword(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ServerFailure value)?  server,TResult? Function( NetworkFailure value)?  network,TResult? Function( CacheFailure value)?  cache,TResult? Function( UnauthorizedFailure value)?  unauthorized,TResult? Function( ValidationFailure value)?  validation,TResult? Function( EmailAlreadyInUseFailure value)?  emailAlreadyInUse,TResult? Function( WeakPasswordFailure value)?  weakPassword,}){
final _that = this;
switch (_that) {
case ServerFailure() when server != null:
return server(_that);case NetworkFailure() when network != null:
return network(_that);case CacheFailure() when cache != null:
return cache(_that);case UnauthorizedFailure() when unauthorized != null:
return unauthorized(_that);case ValidationFailure() when validation != null:
return validation(_that);case EmailAlreadyInUseFailure() when emailAlreadyInUse != null:
return emailAlreadyInUse(_that);case WeakPasswordFailure() when weakPassword != null:
return weakPassword(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String message)?  server,TResult Function()?  network,TResult Function()?  cache,TResult Function()?  unauthorized,TResult Function( String message,  Map<String, String>? fieldErrors)?  validation,TResult Function()?  emailAlreadyInUse,TResult Function( String message)?  weakPassword,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ServerFailure() when server != null:
return server(_that.message);case NetworkFailure() when network != null:
return network();case CacheFailure() when cache != null:
return cache();case UnauthorizedFailure() when unauthorized != null:
return unauthorized();case ValidationFailure() when validation != null:
return validation(_that.message,_that.fieldErrors);case EmailAlreadyInUseFailure() when emailAlreadyInUse != null:
return emailAlreadyInUse();case WeakPasswordFailure() when weakPassword != null:
return weakPassword(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String message)  server,required TResult Function()  network,required TResult Function()  cache,required TResult Function()  unauthorized,required TResult Function( String message,  Map<String, String>? fieldErrors)  validation,required TResult Function()  emailAlreadyInUse,required TResult Function( String message)  weakPassword,}) {final _that = this;
switch (_that) {
case ServerFailure():
return server(_that.message);case NetworkFailure():
return network();case CacheFailure():
return cache();case UnauthorizedFailure():
return unauthorized();case ValidationFailure():
return validation(_that.message,_that.fieldErrors);case EmailAlreadyInUseFailure():
return emailAlreadyInUse();case WeakPasswordFailure():
return weakPassword(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String message)?  server,TResult? Function()?  network,TResult? Function()?  cache,TResult? Function()?  unauthorized,TResult? Function( String message,  Map<String, String>? fieldErrors)?  validation,TResult? Function()?  emailAlreadyInUse,TResult? Function( String message)?  weakPassword,}) {final _that = this;
switch (_that) {
case ServerFailure() when server != null:
return server(_that.message);case NetworkFailure() when network != null:
return network();case CacheFailure() when cache != null:
return cache();case UnauthorizedFailure() when unauthorized != null:
return unauthorized();case ValidationFailure() when validation != null:
return validation(_that.message,_that.fieldErrors);case EmailAlreadyInUseFailure() when emailAlreadyInUse != null:
return emailAlreadyInUse();case WeakPasswordFailure() when weakPassword != null:
return weakPassword(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ServerFailure implements Failure {
  const ServerFailure(this.message);
  

 final  String message;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerFailureCopyWith<ServerFailure> get copyWith => _$ServerFailureCopyWithImpl<ServerFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'Failure.server(message: $message)';
}


}

/// @nodoc
abstract mixin class $ServerFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $ServerFailureCopyWith(ServerFailure value, $Res Function(ServerFailure) _then) = _$ServerFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ServerFailureCopyWithImpl<$Res>
    implements $ServerFailureCopyWith<$Res> {
  _$ServerFailureCopyWithImpl(this._self, this._then);

  final ServerFailure _self;
  final $Res Function(ServerFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ServerFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class NetworkFailure implements Failure {
  const NetworkFailure();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.network()';
}


}




/// @nodoc


class CacheFailure implements Failure {
  const CacheFailure();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CacheFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.cache()';
}


}




/// @nodoc


class UnauthorizedFailure implements Failure {
  const UnauthorizedFailure();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnauthorizedFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.unauthorized()';
}


}




/// @nodoc


class ValidationFailure implements Failure {
  const ValidationFailure(this.message, final  Map<String, String>? fieldErrors): _fieldErrors = fieldErrors;
  

 final  String message;
 final  Map<String, String>? _fieldErrors;
 Map<String, String>? get fieldErrors {
  final value = _fieldErrors;
  if (value == null) return null;
  if (_fieldErrors is EqualUnmodifiableMapView) return _fieldErrors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ValidationFailureCopyWith<ValidationFailure> get copyWith => _$ValidationFailureCopyWithImpl<ValidationFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ValidationFailure&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other._fieldErrors, _fieldErrors));
}


@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(_fieldErrors));

@override
String toString() {
  return 'Failure.validation(message: $message, fieldErrors: $fieldErrors)';
}


}

/// @nodoc
abstract mixin class $ValidationFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $ValidationFailureCopyWith(ValidationFailure value, $Res Function(ValidationFailure) _then) = _$ValidationFailureCopyWithImpl;
@useResult
$Res call({
 String message, Map<String, String>? fieldErrors
});




}
/// @nodoc
class _$ValidationFailureCopyWithImpl<$Res>
    implements $ValidationFailureCopyWith<$Res> {
  _$ValidationFailureCopyWithImpl(this._self, this._then);

  final ValidationFailure _self;
  final $Res Function(ValidationFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? fieldErrors = freezed,}) {
  return _then(ValidationFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,freezed == fieldErrors ? _self._fieldErrors : fieldErrors // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,
  ));
}


}

/// @nodoc


class EmailAlreadyInUseFailure implements Failure {
  const EmailAlreadyInUseFailure();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailAlreadyInUseFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.emailAlreadyInUse()';
}


}




/// @nodoc


class WeakPasswordFailure implements Failure {
  const WeakPasswordFailure(this.message);
  

 final  String message;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeakPasswordFailureCopyWith<WeakPasswordFailure> get copyWith => _$WeakPasswordFailureCopyWithImpl<WeakPasswordFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeakPasswordFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'Failure.weakPassword(message: $message)';
}


}

/// @nodoc
abstract mixin class $WeakPasswordFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $WeakPasswordFailureCopyWith(WeakPasswordFailure value, $Res Function(WeakPasswordFailure) _then) = _$WeakPasswordFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$WeakPasswordFailureCopyWithImpl<$Res>
    implements $WeakPasswordFailureCopyWith<$Res> {
  _$WeakPasswordFailureCopyWithImpl(this._self, this._then);

  final WeakPasswordFailure _self;
  final $Res Function(WeakPasswordFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(WeakPasswordFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
