// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'language_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LanguageEvent {

 AppLanguage get language;
/// Create a copy of LanguageEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LanguageEventCopyWith<LanguageEvent> get copyWith => _$LanguageEventCopyWithImpl<LanguageEvent>(this as LanguageEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LanguageEvent&&(identical(other.language, language) || other.language == language));
}


@override
int get hashCode => Object.hash(runtimeType,language);

@override
String toString() {
  return 'LanguageEvent(language: $language)';
}


}

/// @nodoc
abstract mixin class $LanguageEventCopyWith<$Res>  {
  factory $LanguageEventCopyWith(LanguageEvent value, $Res Function(LanguageEvent) _then) = _$LanguageEventCopyWithImpl;
@useResult
$Res call({
 AppLanguage language
});




}
/// @nodoc
class _$LanguageEventCopyWithImpl<$Res>
    implements $LanguageEventCopyWith<$Res> {
  _$LanguageEventCopyWithImpl(this._self, this._then);

  final LanguageEvent _self;
  final $Res Function(LanguageEvent) _then;

/// Create a copy of LanguageEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? language = null,}) {
  return _then(_self.copyWith(
language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as AppLanguage,
  ));
}

}


/// Adds pattern-matching-related methods to [LanguageEvent].
extension LanguageEventPatterns on LanguageEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LanguageSelected value)?  selected,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LanguageSelected() when selected != null:
return selected(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LanguageSelected value)  selected,}){
final _that = this;
switch (_that) {
case LanguageSelected():
return selected(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LanguageSelected value)?  selected,}){
final _that = this;
switch (_that) {
case LanguageSelected() when selected != null:
return selected(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( AppLanguage language)?  selected,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LanguageSelected() when selected != null:
return selected(_that.language);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( AppLanguage language)  selected,}) {final _that = this;
switch (_that) {
case LanguageSelected():
return selected(_that.language);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( AppLanguage language)?  selected,}) {final _that = this;
switch (_that) {
case LanguageSelected() when selected != null:
return selected(_that.language);case _:
  return null;

}
}

}

/// @nodoc


class LanguageSelected implements LanguageEvent {
  const LanguageSelected(this.language);
  

@override final  AppLanguage language;

/// Create a copy of LanguageEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LanguageSelectedCopyWith<LanguageSelected> get copyWith => _$LanguageSelectedCopyWithImpl<LanguageSelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LanguageSelected&&(identical(other.language, language) || other.language == language));
}


@override
int get hashCode => Object.hash(runtimeType,language);

@override
String toString() {
  return 'LanguageEvent.selected(language: $language)';
}


}

/// @nodoc
abstract mixin class $LanguageSelectedCopyWith<$Res> implements $LanguageEventCopyWith<$Res> {
  factory $LanguageSelectedCopyWith(LanguageSelected value, $Res Function(LanguageSelected) _then) = _$LanguageSelectedCopyWithImpl;
@override @useResult
$Res call({
 AppLanguage language
});




}
/// @nodoc
class _$LanguageSelectedCopyWithImpl<$Res>
    implements $LanguageSelectedCopyWith<$Res> {
  _$LanguageSelectedCopyWithImpl(this._self, this._then);

  final LanguageSelected _self;
  final $Res Function(LanguageSelected) _then;

/// Create a copy of LanguageEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? language = null,}) {
  return _then(LanguageSelected(
null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as AppLanguage,
  ));
}


}

/// @nodoc
mixin _$LanguageState {

 AppLanguage? get selectedLanguage;
/// Create a copy of LanguageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LanguageStateCopyWith<LanguageState> get copyWith => _$LanguageStateCopyWithImpl<LanguageState>(this as LanguageState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LanguageState&&(identical(other.selectedLanguage, selectedLanguage) || other.selectedLanguage == selectedLanguage));
}


@override
int get hashCode => Object.hash(runtimeType,selectedLanguage);

@override
String toString() {
  return 'LanguageState(selectedLanguage: $selectedLanguage)';
}


}

/// @nodoc
abstract mixin class $LanguageStateCopyWith<$Res>  {
  factory $LanguageStateCopyWith(LanguageState value, $Res Function(LanguageState) _then) = _$LanguageStateCopyWithImpl;
@useResult
$Res call({
 AppLanguage? selectedLanguage
});




}
/// @nodoc
class _$LanguageStateCopyWithImpl<$Res>
    implements $LanguageStateCopyWith<$Res> {
  _$LanguageStateCopyWithImpl(this._self, this._then);

  final LanguageState _self;
  final $Res Function(LanguageState) _then;

/// Create a copy of LanguageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedLanguage = freezed,}) {
  return _then(_self.copyWith(
selectedLanguage: freezed == selectedLanguage ? _self.selectedLanguage : selectedLanguage // ignore: cast_nullable_to_non_nullable
as AppLanguage?,
  ));
}

}


/// Adds pattern-matching-related methods to [LanguageState].
extension LanguageStatePatterns on LanguageState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LanguageState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LanguageState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LanguageState value)  $default,){
final _that = this;
switch (_that) {
case _LanguageState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LanguageState value)?  $default,){
final _that = this;
switch (_that) {
case _LanguageState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AppLanguage? selectedLanguage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LanguageState() when $default != null:
return $default(_that.selectedLanguage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AppLanguage? selectedLanguage)  $default,) {final _that = this;
switch (_that) {
case _LanguageState():
return $default(_that.selectedLanguage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AppLanguage? selectedLanguage)?  $default,) {final _that = this;
switch (_that) {
case _LanguageState() when $default != null:
return $default(_that.selectedLanguage);case _:
  return null;

}
}

}

/// @nodoc


class _LanguageState extends LanguageState {
  const _LanguageState({required this.selectedLanguage}): super._();
  

@override final  AppLanguage? selectedLanguage;

/// Create a copy of LanguageState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LanguageStateCopyWith<_LanguageState> get copyWith => __$LanguageStateCopyWithImpl<_LanguageState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LanguageState&&(identical(other.selectedLanguage, selectedLanguage) || other.selectedLanguage == selectedLanguage));
}


@override
int get hashCode => Object.hash(runtimeType,selectedLanguage);

@override
String toString() {
  return 'LanguageState(selectedLanguage: $selectedLanguage)';
}


}

/// @nodoc
abstract mixin class _$LanguageStateCopyWith<$Res> implements $LanguageStateCopyWith<$Res> {
  factory _$LanguageStateCopyWith(_LanguageState value, $Res Function(_LanguageState) _then) = __$LanguageStateCopyWithImpl;
@override @useResult
$Res call({
 AppLanguage? selectedLanguage
});




}
/// @nodoc
class __$LanguageStateCopyWithImpl<$Res>
    implements _$LanguageStateCopyWith<$Res> {
  __$LanguageStateCopyWithImpl(this._self, this._then);

  final _LanguageState _self;
  final $Res Function(_LanguageState) _then;

/// Create a copy of LanguageState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedLanguage = freezed,}) {
  return _then(_LanguageState(
selectedLanguage: freezed == selectedLanguage ? _self.selectedLanguage : selectedLanguage // ignore: cast_nullable_to_non_nullable
as AppLanguage?,
  ));
}


}

// dart format on
