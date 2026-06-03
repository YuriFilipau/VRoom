// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ar_session_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ArSessionEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArSessionEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ArSessionEvent()';
}


}

/// @nodoc
class $ArSessionEventCopyWith<$Res>  {
$ArSessionEventCopyWith(ArSessionEvent _, $Res Function(ArSessionEvent) __);
}


/// Adds pattern-matching-related methods to [ArSessionEvent].
extension ArSessionEventPatterns on ArSessionEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ArSessionLoadRequested value)?  loadRequested,TResult Function( ArSessionAssetSelected value)?  assetSelected,TResult Function( ArSessionPlacementSelected value)?  placementSelected,TResult Function( ArSessionPlacementUpserted value)?  placementUpserted,TResult Function( ArSessionPlacementScaleChanged value)?  placementScaleChanged,TResult Function( ArSessionPlacementRemoved value)?  placementRemoved,TResult Function( ArSessionFinishAnchorAdded value)?  finishAnchorAdded,TResult Function( ArSessionFinishAnchorRemoved value)?  finishAnchorRemoved,TResult Function( ArSessionSceneAnchorUpdated value)?  sceneAnchorUpdated,TResult Function( ArSessionSaveRequested value)?  saveRequested,TResult Function( ArSessionAnchorReached value)?  anchorReached,TResult Function( ArSessionAnchorReachResultConsumed value)?  anchorReachResultConsumed,TResult Function( ArSessionSnackbarConsumed value)?  snackbarConsumed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ArSessionLoadRequested() when loadRequested != null:
return loadRequested(_that);case ArSessionAssetSelected() when assetSelected != null:
return assetSelected(_that);case ArSessionPlacementSelected() when placementSelected != null:
return placementSelected(_that);case ArSessionPlacementUpserted() when placementUpserted != null:
return placementUpserted(_that);case ArSessionPlacementScaleChanged() when placementScaleChanged != null:
return placementScaleChanged(_that);case ArSessionPlacementRemoved() when placementRemoved != null:
return placementRemoved(_that);case ArSessionFinishAnchorAdded() when finishAnchorAdded != null:
return finishAnchorAdded(_that);case ArSessionFinishAnchorRemoved() when finishAnchorRemoved != null:
return finishAnchorRemoved(_that);case ArSessionSceneAnchorUpdated() when sceneAnchorUpdated != null:
return sceneAnchorUpdated(_that);case ArSessionSaveRequested() when saveRequested != null:
return saveRequested(_that);case ArSessionAnchorReached() when anchorReached != null:
return anchorReached(_that);case ArSessionAnchorReachResultConsumed() when anchorReachResultConsumed != null:
return anchorReachResultConsumed(_that);case ArSessionSnackbarConsumed() when snackbarConsumed != null:
return snackbarConsumed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ArSessionLoadRequested value)  loadRequested,required TResult Function( ArSessionAssetSelected value)  assetSelected,required TResult Function( ArSessionPlacementSelected value)  placementSelected,required TResult Function( ArSessionPlacementUpserted value)  placementUpserted,required TResult Function( ArSessionPlacementScaleChanged value)  placementScaleChanged,required TResult Function( ArSessionPlacementRemoved value)  placementRemoved,required TResult Function( ArSessionFinishAnchorAdded value)  finishAnchorAdded,required TResult Function( ArSessionFinishAnchorRemoved value)  finishAnchorRemoved,required TResult Function( ArSessionSceneAnchorUpdated value)  sceneAnchorUpdated,required TResult Function( ArSessionSaveRequested value)  saveRequested,required TResult Function( ArSessionAnchorReached value)  anchorReached,required TResult Function( ArSessionAnchorReachResultConsumed value)  anchorReachResultConsumed,required TResult Function( ArSessionSnackbarConsumed value)  snackbarConsumed,}){
final _that = this;
switch (_that) {
case ArSessionLoadRequested():
return loadRequested(_that);case ArSessionAssetSelected():
return assetSelected(_that);case ArSessionPlacementSelected():
return placementSelected(_that);case ArSessionPlacementUpserted():
return placementUpserted(_that);case ArSessionPlacementScaleChanged():
return placementScaleChanged(_that);case ArSessionPlacementRemoved():
return placementRemoved(_that);case ArSessionFinishAnchorAdded():
return finishAnchorAdded(_that);case ArSessionFinishAnchorRemoved():
return finishAnchorRemoved(_that);case ArSessionSceneAnchorUpdated():
return sceneAnchorUpdated(_that);case ArSessionSaveRequested():
return saveRequested(_that);case ArSessionAnchorReached():
return anchorReached(_that);case ArSessionAnchorReachResultConsumed():
return anchorReachResultConsumed(_that);case ArSessionSnackbarConsumed():
return snackbarConsumed(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ArSessionLoadRequested value)?  loadRequested,TResult? Function( ArSessionAssetSelected value)?  assetSelected,TResult? Function( ArSessionPlacementSelected value)?  placementSelected,TResult? Function( ArSessionPlacementUpserted value)?  placementUpserted,TResult? Function( ArSessionPlacementScaleChanged value)?  placementScaleChanged,TResult? Function( ArSessionPlacementRemoved value)?  placementRemoved,TResult? Function( ArSessionFinishAnchorAdded value)?  finishAnchorAdded,TResult? Function( ArSessionFinishAnchorRemoved value)?  finishAnchorRemoved,TResult? Function( ArSessionSceneAnchorUpdated value)?  sceneAnchorUpdated,TResult? Function( ArSessionSaveRequested value)?  saveRequested,TResult? Function( ArSessionAnchorReached value)?  anchorReached,TResult? Function( ArSessionAnchorReachResultConsumed value)?  anchorReachResultConsumed,TResult? Function( ArSessionSnackbarConsumed value)?  snackbarConsumed,}){
final _that = this;
switch (_that) {
case ArSessionLoadRequested() when loadRequested != null:
return loadRequested(_that);case ArSessionAssetSelected() when assetSelected != null:
return assetSelected(_that);case ArSessionPlacementSelected() when placementSelected != null:
return placementSelected(_that);case ArSessionPlacementUpserted() when placementUpserted != null:
return placementUpserted(_that);case ArSessionPlacementScaleChanged() when placementScaleChanged != null:
return placementScaleChanged(_that);case ArSessionPlacementRemoved() when placementRemoved != null:
return placementRemoved(_that);case ArSessionFinishAnchorAdded() when finishAnchorAdded != null:
return finishAnchorAdded(_that);case ArSessionFinishAnchorRemoved() when finishAnchorRemoved != null:
return finishAnchorRemoved(_that);case ArSessionSceneAnchorUpdated() when sceneAnchorUpdated != null:
return sceneAnchorUpdated(_that);case ArSessionSaveRequested() when saveRequested != null:
return saveRequested(_that);case ArSessionAnchorReached() when anchorReached != null:
return anchorReached(_that);case ArSessionAnchorReachResultConsumed() when anchorReachResultConsumed != null:
return anchorReachResultConsumed(_that);case ArSessionSnackbarConsumed() when snackbarConsumed != null:
return snackbarConsumed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int questId,  ArSessionMode mode)?  loadRequested,TResult Function( int assetId)?  assetSelected,TResult Function( String? placementId)?  placementSelected,TResult Function( ArAssetPlacementEntity placement)?  placementUpserted,TResult Function( String placementId,  double scale)?  placementScaleChanged,TResult Function( String placementId)?  placementRemoved,TResult Function()?  finishAnchorAdded,TResult Function()?  finishAnchorRemoved,TResult Function( String? anchorName,  String? cloudAnchorId,  List<double>? anchorTransform,  int? ttl,  bool clearCloudAnchorId,  bool clearAnchorTransform,  bool clearAnchorName,  bool clearTtl)?  sceneAnchorUpdated,TResult Function()?  saveRequested,TResult Function( String anchorId,  String? sessionId,  String? interactionType,  int? answerIndex)?  anchorReached,TResult Function()?  anchorReachResultConsumed,TResult Function()?  snackbarConsumed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ArSessionLoadRequested() when loadRequested != null:
return loadRequested(_that.questId,_that.mode);case ArSessionAssetSelected() when assetSelected != null:
return assetSelected(_that.assetId);case ArSessionPlacementSelected() when placementSelected != null:
return placementSelected(_that.placementId);case ArSessionPlacementUpserted() when placementUpserted != null:
return placementUpserted(_that.placement);case ArSessionPlacementScaleChanged() when placementScaleChanged != null:
return placementScaleChanged(_that.placementId,_that.scale);case ArSessionPlacementRemoved() when placementRemoved != null:
return placementRemoved(_that.placementId);case ArSessionFinishAnchorAdded() when finishAnchorAdded != null:
return finishAnchorAdded();case ArSessionFinishAnchorRemoved() when finishAnchorRemoved != null:
return finishAnchorRemoved();case ArSessionSceneAnchorUpdated() when sceneAnchorUpdated != null:
return sceneAnchorUpdated(_that.anchorName,_that.cloudAnchorId,_that.anchorTransform,_that.ttl,_that.clearCloudAnchorId,_that.clearAnchorTransform,_that.clearAnchorName,_that.clearTtl);case ArSessionSaveRequested() when saveRequested != null:
return saveRequested();case ArSessionAnchorReached() when anchorReached != null:
return anchorReached(_that.anchorId,_that.sessionId,_that.interactionType,_that.answerIndex);case ArSessionAnchorReachResultConsumed() when anchorReachResultConsumed != null:
return anchorReachResultConsumed();case ArSessionSnackbarConsumed() when snackbarConsumed != null:
return snackbarConsumed();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int questId,  ArSessionMode mode)  loadRequested,required TResult Function( int assetId)  assetSelected,required TResult Function( String? placementId)  placementSelected,required TResult Function( ArAssetPlacementEntity placement)  placementUpserted,required TResult Function( String placementId,  double scale)  placementScaleChanged,required TResult Function( String placementId)  placementRemoved,required TResult Function()  finishAnchorAdded,required TResult Function()  finishAnchorRemoved,required TResult Function( String? anchorName,  String? cloudAnchorId,  List<double>? anchorTransform,  int? ttl,  bool clearCloudAnchorId,  bool clearAnchorTransform,  bool clearAnchorName,  bool clearTtl)  sceneAnchorUpdated,required TResult Function()  saveRequested,required TResult Function( String anchorId,  String? sessionId,  String? interactionType,  int? answerIndex)  anchorReached,required TResult Function()  anchorReachResultConsumed,required TResult Function()  snackbarConsumed,}) {final _that = this;
switch (_that) {
case ArSessionLoadRequested():
return loadRequested(_that.questId,_that.mode);case ArSessionAssetSelected():
return assetSelected(_that.assetId);case ArSessionPlacementSelected():
return placementSelected(_that.placementId);case ArSessionPlacementUpserted():
return placementUpserted(_that.placement);case ArSessionPlacementScaleChanged():
return placementScaleChanged(_that.placementId,_that.scale);case ArSessionPlacementRemoved():
return placementRemoved(_that.placementId);case ArSessionFinishAnchorAdded():
return finishAnchorAdded();case ArSessionFinishAnchorRemoved():
return finishAnchorRemoved();case ArSessionSceneAnchorUpdated():
return sceneAnchorUpdated(_that.anchorName,_that.cloudAnchorId,_that.anchorTransform,_that.ttl,_that.clearCloudAnchorId,_that.clearAnchorTransform,_that.clearAnchorName,_that.clearTtl);case ArSessionSaveRequested():
return saveRequested();case ArSessionAnchorReached():
return anchorReached(_that.anchorId,_that.sessionId,_that.interactionType,_that.answerIndex);case ArSessionAnchorReachResultConsumed():
return anchorReachResultConsumed();case ArSessionSnackbarConsumed():
return snackbarConsumed();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int questId,  ArSessionMode mode)?  loadRequested,TResult? Function( int assetId)?  assetSelected,TResult? Function( String? placementId)?  placementSelected,TResult? Function( ArAssetPlacementEntity placement)?  placementUpserted,TResult? Function( String placementId,  double scale)?  placementScaleChanged,TResult? Function( String placementId)?  placementRemoved,TResult? Function()?  finishAnchorAdded,TResult? Function()?  finishAnchorRemoved,TResult? Function( String? anchorName,  String? cloudAnchorId,  List<double>? anchorTransform,  int? ttl,  bool clearCloudAnchorId,  bool clearAnchorTransform,  bool clearAnchorName,  bool clearTtl)?  sceneAnchorUpdated,TResult? Function()?  saveRequested,TResult? Function( String anchorId,  String? sessionId,  String? interactionType,  int? answerIndex)?  anchorReached,TResult? Function()?  anchorReachResultConsumed,TResult? Function()?  snackbarConsumed,}) {final _that = this;
switch (_that) {
case ArSessionLoadRequested() when loadRequested != null:
return loadRequested(_that.questId,_that.mode);case ArSessionAssetSelected() when assetSelected != null:
return assetSelected(_that.assetId);case ArSessionPlacementSelected() when placementSelected != null:
return placementSelected(_that.placementId);case ArSessionPlacementUpserted() when placementUpserted != null:
return placementUpserted(_that.placement);case ArSessionPlacementScaleChanged() when placementScaleChanged != null:
return placementScaleChanged(_that.placementId,_that.scale);case ArSessionPlacementRemoved() when placementRemoved != null:
return placementRemoved(_that.placementId);case ArSessionFinishAnchorAdded() when finishAnchorAdded != null:
return finishAnchorAdded();case ArSessionFinishAnchorRemoved() when finishAnchorRemoved != null:
return finishAnchorRemoved();case ArSessionSceneAnchorUpdated() when sceneAnchorUpdated != null:
return sceneAnchorUpdated(_that.anchorName,_that.cloudAnchorId,_that.anchorTransform,_that.ttl,_that.clearCloudAnchorId,_that.clearAnchorTransform,_that.clearAnchorName,_that.clearTtl);case ArSessionSaveRequested() when saveRequested != null:
return saveRequested();case ArSessionAnchorReached() when anchorReached != null:
return anchorReached(_that.anchorId,_that.sessionId,_that.interactionType,_that.answerIndex);case ArSessionAnchorReachResultConsumed() when anchorReachResultConsumed != null:
return anchorReachResultConsumed();case ArSessionSnackbarConsumed() when snackbarConsumed != null:
return snackbarConsumed();case _:
  return null;

}
}

}

/// @nodoc


class ArSessionLoadRequested implements ArSessionEvent {
  const ArSessionLoadRequested({required this.questId, required this.mode});
  

 final  int questId;
 final  ArSessionMode mode;

/// Create a copy of ArSessionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArSessionLoadRequestedCopyWith<ArSessionLoadRequested> get copyWith => _$ArSessionLoadRequestedCopyWithImpl<ArSessionLoadRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArSessionLoadRequested&&(identical(other.questId, questId) || other.questId == questId)&&(identical(other.mode, mode) || other.mode == mode));
}


@override
int get hashCode => Object.hash(runtimeType,questId,mode);

@override
String toString() {
  return 'ArSessionEvent.loadRequested(questId: $questId, mode: $mode)';
}


}

/// @nodoc
abstract mixin class $ArSessionLoadRequestedCopyWith<$Res> implements $ArSessionEventCopyWith<$Res> {
  factory $ArSessionLoadRequestedCopyWith(ArSessionLoadRequested value, $Res Function(ArSessionLoadRequested) _then) = _$ArSessionLoadRequestedCopyWithImpl;
@useResult
$Res call({
 int questId, ArSessionMode mode
});




}
/// @nodoc
class _$ArSessionLoadRequestedCopyWithImpl<$Res>
    implements $ArSessionLoadRequestedCopyWith<$Res> {
  _$ArSessionLoadRequestedCopyWithImpl(this._self, this._then);

  final ArSessionLoadRequested _self;
  final $Res Function(ArSessionLoadRequested) _then;

/// Create a copy of ArSessionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? questId = null,Object? mode = null,}) {
  return _then(ArSessionLoadRequested(
questId: null == questId ? _self.questId : questId // ignore: cast_nullable_to_non_nullable
as int,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as ArSessionMode,
  ));
}


}

/// @nodoc


class ArSessionAssetSelected implements ArSessionEvent {
  const ArSessionAssetSelected(this.assetId);
  

 final  int assetId;

/// Create a copy of ArSessionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArSessionAssetSelectedCopyWith<ArSessionAssetSelected> get copyWith => _$ArSessionAssetSelectedCopyWithImpl<ArSessionAssetSelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArSessionAssetSelected&&(identical(other.assetId, assetId) || other.assetId == assetId));
}


@override
int get hashCode => Object.hash(runtimeType,assetId);

@override
String toString() {
  return 'ArSessionEvent.assetSelected(assetId: $assetId)';
}


}

/// @nodoc
abstract mixin class $ArSessionAssetSelectedCopyWith<$Res> implements $ArSessionEventCopyWith<$Res> {
  factory $ArSessionAssetSelectedCopyWith(ArSessionAssetSelected value, $Res Function(ArSessionAssetSelected) _then) = _$ArSessionAssetSelectedCopyWithImpl;
@useResult
$Res call({
 int assetId
});




}
/// @nodoc
class _$ArSessionAssetSelectedCopyWithImpl<$Res>
    implements $ArSessionAssetSelectedCopyWith<$Res> {
  _$ArSessionAssetSelectedCopyWithImpl(this._self, this._then);

  final ArSessionAssetSelected _self;
  final $Res Function(ArSessionAssetSelected) _then;

/// Create a copy of ArSessionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? assetId = null,}) {
  return _then(ArSessionAssetSelected(
null == assetId ? _self.assetId : assetId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class ArSessionPlacementSelected implements ArSessionEvent {
  const ArSessionPlacementSelected(this.placementId);
  

 final  String? placementId;

/// Create a copy of ArSessionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArSessionPlacementSelectedCopyWith<ArSessionPlacementSelected> get copyWith => _$ArSessionPlacementSelectedCopyWithImpl<ArSessionPlacementSelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArSessionPlacementSelected&&(identical(other.placementId, placementId) || other.placementId == placementId));
}


@override
int get hashCode => Object.hash(runtimeType,placementId);

@override
String toString() {
  return 'ArSessionEvent.placementSelected(placementId: $placementId)';
}


}

/// @nodoc
abstract mixin class $ArSessionPlacementSelectedCopyWith<$Res> implements $ArSessionEventCopyWith<$Res> {
  factory $ArSessionPlacementSelectedCopyWith(ArSessionPlacementSelected value, $Res Function(ArSessionPlacementSelected) _then) = _$ArSessionPlacementSelectedCopyWithImpl;
@useResult
$Res call({
 String? placementId
});




}
/// @nodoc
class _$ArSessionPlacementSelectedCopyWithImpl<$Res>
    implements $ArSessionPlacementSelectedCopyWith<$Res> {
  _$ArSessionPlacementSelectedCopyWithImpl(this._self, this._then);

  final ArSessionPlacementSelected _self;
  final $Res Function(ArSessionPlacementSelected) _then;

/// Create a copy of ArSessionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? placementId = freezed,}) {
  return _then(ArSessionPlacementSelected(
freezed == placementId ? _self.placementId : placementId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ArSessionPlacementUpserted implements ArSessionEvent {
  const ArSessionPlacementUpserted(this.placement);
  

 final  ArAssetPlacementEntity placement;

/// Create a copy of ArSessionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArSessionPlacementUpsertedCopyWith<ArSessionPlacementUpserted> get copyWith => _$ArSessionPlacementUpsertedCopyWithImpl<ArSessionPlacementUpserted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArSessionPlacementUpserted&&(identical(other.placement, placement) || other.placement == placement));
}


@override
int get hashCode => Object.hash(runtimeType,placement);

@override
String toString() {
  return 'ArSessionEvent.placementUpserted(placement: $placement)';
}


}

/// @nodoc
abstract mixin class $ArSessionPlacementUpsertedCopyWith<$Res> implements $ArSessionEventCopyWith<$Res> {
  factory $ArSessionPlacementUpsertedCopyWith(ArSessionPlacementUpserted value, $Res Function(ArSessionPlacementUpserted) _then) = _$ArSessionPlacementUpsertedCopyWithImpl;
@useResult
$Res call({
 ArAssetPlacementEntity placement
});


$ArAssetPlacementEntityCopyWith<$Res> get placement;

}
/// @nodoc
class _$ArSessionPlacementUpsertedCopyWithImpl<$Res>
    implements $ArSessionPlacementUpsertedCopyWith<$Res> {
  _$ArSessionPlacementUpsertedCopyWithImpl(this._self, this._then);

  final ArSessionPlacementUpserted _self;
  final $Res Function(ArSessionPlacementUpserted) _then;

/// Create a copy of ArSessionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? placement = null,}) {
  return _then(ArSessionPlacementUpserted(
null == placement ? _self.placement : placement // ignore: cast_nullable_to_non_nullable
as ArAssetPlacementEntity,
  ));
}

/// Create a copy of ArSessionEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArAssetPlacementEntityCopyWith<$Res> get placement {
  
  return $ArAssetPlacementEntityCopyWith<$Res>(_self.placement, (value) {
    return _then(_self.copyWith(placement: value));
  });
}
}

/// @nodoc


class ArSessionPlacementScaleChanged implements ArSessionEvent {
  const ArSessionPlacementScaleChanged({required this.placementId, required this.scale});
  

 final  String placementId;
 final  double scale;

/// Create a copy of ArSessionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArSessionPlacementScaleChangedCopyWith<ArSessionPlacementScaleChanged> get copyWith => _$ArSessionPlacementScaleChangedCopyWithImpl<ArSessionPlacementScaleChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArSessionPlacementScaleChanged&&(identical(other.placementId, placementId) || other.placementId == placementId)&&(identical(other.scale, scale) || other.scale == scale));
}


@override
int get hashCode => Object.hash(runtimeType,placementId,scale);

@override
String toString() {
  return 'ArSessionEvent.placementScaleChanged(placementId: $placementId, scale: $scale)';
}


}

/// @nodoc
abstract mixin class $ArSessionPlacementScaleChangedCopyWith<$Res> implements $ArSessionEventCopyWith<$Res> {
  factory $ArSessionPlacementScaleChangedCopyWith(ArSessionPlacementScaleChanged value, $Res Function(ArSessionPlacementScaleChanged) _then) = _$ArSessionPlacementScaleChangedCopyWithImpl;
@useResult
$Res call({
 String placementId, double scale
});




}
/// @nodoc
class _$ArSessionPlacementScaleChangedCopyWithImpl<$Res>
    implements $ArSessionPlacementScaleChangedCopyWith<$Res> {
  _$ArSessionPlacementScaleChangedCopyWithImpl(this._self, this._then);

  final ArSessionPlacementScaleChanged _self;
  final $Res Function(ArSessionPlacementScaleChanged) _then;

/// Create a copy of ArSessionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? placementId = null,Object? scale = null,}) {
  return _then(ArSessionPlacementScaleChanged(
placementId: null == placementId ? _self.placementId : placementId // ignore: cast_nullable_to_non_nullable
as String,scale: null == scale ? _self.scale : scale // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc


class ArSessionPlacementRemoved implements ArSessionEvent {
  const ArSessionPlacementRemoved(this.placementId);
  

 final  String placementId;

/// Create a copy of ArSessionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArSessionPlacementRemovedCopyWith<ArSessionPlacementRemoved> get copyWith => _$ArSessionPlacementRemovedCopyWithImpl<ArSessionPlacementRemoved>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArSessionPlacementRemoved&&(identical(other.placementId, placementId) || other.placementId == placementId));
}


@override
int get hashCode => Object.hash(runtimeType,placementId);

@override
String toString() {
  return 'ArSessionEvent.placementRemoved(placementId: $placementId)';
}


}

/// @nodoc
abstract mixin class $ArSessionPlacementRemovedCopyWith<$Res> implements $ArSessionEventCopyWith<$Res> {
  factory $ArSessionPlacementRemovedCopyWith(ArSessionPlacementRemoved value, $Res Function(ArSessionPlacementRemoved) _then) = _$ArSessionPlacementRemovedCopyWithImpl;
@useResult
$Res call({
 String placementId
});




}
/// @nodoc
class _$ArSessionPlacementRemovedCopyWithImpl<$Res>
    implements $ArSessionPlacementRemovedCopyWith<$Res> {
  _$ArSessionPlacementRemovedCopyWithImpl(this._self, this._then);

  final ArSessionPlacementRemoved _self;
  final $Res Function(ArSessionPlacementRemoved) _then;

/// Create a copy of ArSessionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? placementId = null,}) {
  return _then(ArSessionPlacementRemoved(
null == placementId ? _self.placementId : placementId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ArSessionFinishAnchorAdded implements ArSessionEvent {
  const ArSessionFinishAnchorAdded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArSessionFinishAnchorAdded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ArSessionEvent.finishAnchorAdded()';
}


}




/// @nodoc


class ArSessionFinishAnchorRemoved implements ArSessionEvent {
  const ArSessionFinishAnchorRemoved();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArSessionFinishAnchorRemoved);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ArSessionEvent.finishAnchorRemoved()';
}


}




/// @nodoc


class ArSessionSceneAnchorUpdated implements ArSessionEvent {
  const ArSessionSceneAnchorUpdated({this.anchorName, this.cloudAnchorId, final  List<double>? anchorTransform, this.ttl, this.clearCloudAnchorId = false, this.clearAnchorTransform = false, this.clearAnchorName = false, this.clearTtl = false}): _anchorTransform = anchorTransform;
  

 final  String? anchorName;
 final  String? cloudAnchorId;
 final  List<double>? _anchorTransform;
 List<double>? get anchorTransform {
  final value = _anchorTransform;
  if (value == null) return null;
  if (_anchorTransform is EqualUnmodifiableListView) return _anchorTransform;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  int? ttl;
@JsonKey() final  bool clearCloudAnchorId;
@JsonKey() final  bool clearAnchorTransform;
@JsonKey() final  bool clearAnchorName;
@JsonKey() final  bool clearTtl;

/// Create a copy of ArSessionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArSessionSceneAnchorUpdatedCopyWith<ArSessionSceneAnchorUpdated> get copyWith => _$ArSessionSceneAnchorUpdatedCopyWithImpl<ArSessionSceneAnchorUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArSessionSceneAnchorUpdated&&(identical(other.anchorName, anchorName) || other.anchorName == anchorName)&&(identical(other.cloudAnchorId, cloudAnchorId) || other.cloudAnchorId == cloudAnchorId)&&const DeepCollectionEquality().equals(other._anchorTransform, _anchorTransform)&&(identical(other.ttl, ttl) || other.ttl == ttl)&&(identical(other.clearCloudAnchorId, clearCloudAnchorId) || other.clearCloudAnchorId == clearCloudAnchorId)&&(identical(other.clearAnchorTransform, clearAnchorTransform) || other.clearAnchorTransform == clearAnchorTransform)&&(identical(other.clearAnchorName, clearAnchorName) || other.clearAnchorName == clearAnchorName)&&(identical(other.clearTtl, clearTtl) || other.clearTtl == clearTtl));
}


@override
int get hashCode => Object.hash(runtimeType,anchorName,cloudAnchorId,const DeepCollectionEquality().hash(_anchorTransform),ttl,clearCloudAnchorId,clearAnchorTransform,clearAnchorName,clearTtl);

@override
String toString() {
  return 'ArSessionEvent.sceneAnchorUpdated(anchorName: $anchorName, cloudAnchorId: $cloudAnchorId, anchorTransform: $anchorTransform, ttl: $ttl, clearCloudAnchorId: $clearCloudAnchorId, clearAnchorTransform: $clearAnchorTransform, clearAnchorName: $clearAnchorName, clearTtl: $clearTtl)';
}


}

/// @nodoc
abstract mixin class $ArSessionSceneAnchorUpdatedCopyWith<$Res> implements $ArSessionEventCopyWith<$Res> {
  factory $ArSessionSceneAnchorUpdatedCopyWith(ArSessionSceneAnchorUpdated value, $Res Function(ArSessionSceneAnchorUpdated) _then) = _$ArSessionSceneAnchorUpdatedCopyWithImpl;
@useResult
$Res call({
 String? anchorName, String? cloudAnchorId, List<double>? anchorTransform, int? ttl, bool clearCloudAnchorId, bool clearAnchorTransform, bool clearAnchorName, bool clearTtl
});




}
/// @nodoc
class _$ArSessionSceneAnchorUpdatedCopyWithImpl<$Res>
    implements $ArSessionSceneAnchorUpdatedCopyWith<$Res> {
  _$ArSessionSceneAnchorUpdatedCopyWithImpl(this._self, this._then);

  final ArSessionSceneAnchorUpdated _self;
  final $Res Function(ArSessionSceneAnchorUpdated) _then;

/// Create a copy of ArSessionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? anchorName = freezed,Object? cloudAnchorId = freezed,Object? anchorTransform = freezed,Object? ttl = freezed,Object? clearCloudAnchorId = null,Object? clearAnchorTransform = null,Object? clearAnchorName = null,Object? clearTtl = null,}) {
  return _then(ArSessionSceneAnchorUpdated(
anchorName: freezed == anchorName ? _self.anchorName : anchorName // ignore: cast_nullable_to_non_nullable
as String?,cloudAnchorId: freezed == cloudAnchorId ? _self.cloudAnchorId : cloudAnchorId // ignore: cast_nullable_to_non_nullable
as String?,anchorTransform: freezed == anchorTransform ? _self._anchorTransform : anchorTransform // ignore: cast_nullable_to_non_nullable
as List<double>?,ttl: freezed == ttl ? _self.ttl : ttl // ignore: cast_nullable_to_non_nullable
as int?,clearCloudAnchorId: null == clearCloudAnchorId ? _self.clearCloudAnchorId : clearCloudAnchorId // ignore: cast_nullable_to_non_nullable
as bool,clearAnchorTransform: null == clearAnchorTransform ? _self.clearAnchorTransform : clearAnchorTransform // ignore: cast_nullable_to_non_nullable
as bool,clearAnchorName: null == clearAnchorName ? _self.clearAnchorName : clearAnchorName // ignore: cast_nullable_to_non_nullable
as bool,clearTtl: null == clearTtl ? _self.clearTtl : clearTtl // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class ArSessionSaveRequested implements ArSessionEvent {
  const ArSessionSaveRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArSessionSaveRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ArSessionEvent.saveRequested()';
}


}




/// @nodoc


class ArSessionAnchorReached implements ArSessionEvent {
  const ArSessionAnchorReached({required this.anchorId, this.sessionId, this.interactionType, this.answerIndex});
  

 final  String anchorId;
 final  String? sessionId;
 final  String? interactionType;
 final  int? answerIndex;

/// Create a copy of ArSessionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArSessionAnchorReachedCopyWith<ArSessionAnchorReached> get copyWith => _$ArSessionAnchorReachedCopyWithImpl<ArSessionAnchorReached>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArSessionAnchorReached&&(identical(other.anchorId, anchorId) || other.anchorId == anchorId)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.interactionType, interactionType) || other.interactionType == interactionType)&&(identical(other.answerIndex, answerIndex) || other.answerIndex == answerIndex));
}


@override
int get hashCode => Object.hash(runtimeType,anchorId,sessionId,interactionType,answerIndex);

@override
String toString() {
  return 'ArSessionEvent.anchorReached(anchorId: $anchorId, sessionId: $sessionId, interactionType: $interactionType, answerIndex: $answerIndex)';
}


}

/// @nodoc
abstract mixin class $ArSessionAnchorReachedCopyWith<$Res> implements $ArSessionEventCopyWith<$Res> {
  factory $ArSessionAnchorReachedCopyWith(ArSessionAnchorReached value, $Res Function(ArSessionAnchorReached) _then) = _$ArSessionAnchorReachedCopyWithImpl;
@useResult
$Res call({
 String anchorId, String? sessionId, String? interactionType, int? answerIndex
});




}
/// @nodoc
class _$ArSessionAnchorReachedCopyWithImpl<$Res>
    implements $ArSessionAnchorReachedCopyWith<$Res> {
  _$ArSessionAnchorReachedCopyWithImpl(this._self, this._then);

  final ArSessionAnchorReached _self;
  final $Res Function(ArSessionAnchorReached) _then;

/// Create a copy of ArSessionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? anchorId = null,Object? sessionId = freezed,Object? interactionType = freezed,Object? answerIndex = freezed,}) {
  return _then(ArSessionAnchorReached(
anchorId: null == anchorId ? _self.anchorId : anchorId // ignore: cast_nullable_to_non_nullable
as String,sessionId: freezed == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String?,interactionType: freezed == interactionType ? _self.interactionType : interactionType // ignore: cast_nullable_to_non_nullable
as String?,answerIndex: freezed == answerIndex ? _self.answerIndex : answerIndex // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class ArSessionAnchorReachResultConsumed implements ArSessionEvent {
  const ArSessionAnchorReachResultConsumed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArSessionAnchorReachResultConsumed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ArSessionEvent.anchorReachResultConsumed()';
}


}




/// @nodoc


class ArSessionSnackbarConsumed implements ArSessionEvent {
  const ArSessionSnackbarConsumed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArSessionSnackbarConsumed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ArSessionEvent.snackbarConsumed()';
}


}




/// @nodoc
mixin _$ArSessionState {

 ArSessionStatus get status; ArSessionMode get mode; String get sceneId; int get questId; int get eventId; String get eventTitle; List<ArAssetEntity> get assets; List<ArAssetPlacementEntity> get placements; int? get version; String? get updatedAt; int? get createdBy; bool get isPublished; bool get hasTest; ArSceneRootAnchorEntity? get rootAnchor; String? get arcoreToken; int? get selectedAssetId; String? get selectedPlacementId; int? get interactiveProgressCompleted; int? get interactiveProgressTotal; ArAnchorReachResultEntity? get anchorReachResult; String? get message;
/// Create a copy of ArSessionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArSessionStateCopyWith<ArSessionState> get copyWith => _$ArSessionStateCopyWithImpl<ArSessionState>(this as ArSessionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArSessionState&&(identical(other.status, status) || other.status == status)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.sceneId, sceneId) || other.sceneId == sceneId)&&(identical(other.questId, questId) || other.questId == questId)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.eventTitle, eventTitle) || other.eventTitle == eventTitle)&&const DeepCollectionEquality().equals(other.assets, assets)&&const DeepCollectionEquality().equals(other.placements, placements)&&(identical(other.version, version) || other.version == version)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.isPublished, isPublished) || other.isPublished == isPublished)&&(identical(other.hasTest, hasTest) || other.hasTest == hasTest)&&(identical(other.rootAnchor, rootAnchor) || other.rootAnchor == rootAnchor)&&(identical(other.arcoreToken, arcoreToken) || other.arcoreToken == arcoreToken)&&(identical(other.selectedAssetId, selectedAssetId) || other.selectedAssetId == selectedAssetId)&&(identical(other.selectedPlacementId, selectedPlacementId) || other.selectedPlacementId == selectedPlacementId)&&(identical(other.interactiveProgressCompleted, interactiveProgressCompleted) || other.interactiveProgressCompleted == interactiveProgressCompleted)&&(identical(other.interactiveProgressTotal, interactiveProgressTotal) || other.interactiveProgressTotal == interactiveProgressTotal)&&(identical(other.anchorReachResult, anchorReachResult) || other.anchorReachResult == anchorReachResult)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hashAll([runtimeType,status,mode,sceneId,questId,eventId,eventTitle,const DeepCollectionEquality().hash(assets),const DeepCollectionEquality().hash(placements),version,updatedAt,createdBy,isPublished,hasTest,rootAnchor,arcoreToken,selectedAssetId,selectedPlacementId,interactiveProgressCompleted,interactiveProgressTotal,anchorReachResult,message]);

@override
String toString() {
  return 'ArSessionState(status: $status, mode: $mode, sceneId: $sceneId, questId: $questId, eventId: $eventId, eventTitle: $eventTitle, assets: $assets, placements: $placements, version: $version, updatedAt: $updatedAt, createdBy: $createdBy, isPublished: $isPublished, hasTest: $hasTest, rootAnchor: $rootAnchor, arcoreToken: $arcoreToken, selectedAssetId: $selectedAssetId, selectedPlacementId: $selectedPlacementId, interactiveProgressCompleted: $interactiveProgressCompleted, interactiveProgressTotal: $interactiveProgressTotal, anchorReachResult: $anchorReachResult, message: $message)';
}


}

/// @nodoc
abstract mixin class $ArSessionStateCopyWith<$Res>  {
  factory $ArSessionStateCopyWith(ArSessionState value, $Res Function(ArSessionState) _then) = _$ArSessionStateCopyWithImpl;
@useResult
$Res call({
 ArSessionStatus status, ArSessionMode mode, String sceneId, int questId, int eventId, String eventTitle, List<ArAssetEntity> assets, List<ArAssetPlacementEntity> placements, int? version, String? updatedAt, int? createdBy, bool isPublished, bool hasTest, ArSceneRootAnchorEntity? rootAnchor, String? arcoreToken, int? selectedAssetId, String? selectedPlacementId, int? interactiveProgressCompleted, int? interactiveProgressTotal, ArAnchorReachResultEntity? anchorReachResult, String? message
});


$ArSceneRootAnchorEntityCopyWith<$Res>? get rootAnchor;$ArAnchorReachResultEntityCopyWith<$Res>? get anchorReachResult;

}
/// @nodoc
class _$ArSessionStateCopyWithImpl<$Res>
    implements $ArSessionStateCopyWith<$Res> {
  _$ArSessionStateCopyWithImpl(this._self, this._then);

  final ArSessionState _self;
  final $Res Function(ArSessionState) _then;

/// Create a copy of ArSessionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? mode = null,Object? sceneId = null,Object? questId = null,Object? eventId = null,Object? eventTitle = null,Object? assets = null,Object? placements = null,Object? version = freezed,Object? updatedAt = freezed,Object? createdBy = freezed,Object? isPublished = null,Object? hasTest = null,Object? rootAnchor = freezed,Object? arcoreToken = freezed,Object? selectedAssetId = freezed,Object? selectedPlacementId = freezed,Object? interactiveProgressCompleted = freezed,Object? interactiveProgressTotal = freezed,Object? anchorReachResult = freezed,Object? message = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ArSessionStatus,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as ArSessionMode,sceneId: null == sceneId ? _self.sceneId : sceneId // ignore: cast_nullable_to_non_nullable
as String,questId: null == questId ? _self.questId : questId // ignore: cast_nullable_to_non_nullable
as int,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int,eventTitle: null == eventTitle ? _self.eventTitle : eventTitle // ignore: cast_nullable_to_non_nullable
as String,assets: null == assets ? _self.assets : assets // ignore: cast_nullable_to_non_nullable
as List<ArAssetEntity>,placements: null == placements ? _self.placements : placements // ignore: cast_nullable_to_non_nullable
as List<ArAssetPlacementEntity>,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as int?,isPublished: null == isPublished ? _self.isPublished : isPublished // ignore: cast_nullable_to_non_nullable
as bool,hasTest: null == hasTest ? _self.hasTest : hasTest // ignore: cast_nullable_to_non_nullable
as bool,rootAnchor: freezed == rootAnchor ? _self.rootAnchor : rootAnchor // ignore: cast_nullable_to_non_nullable
as ArSceneRootAnchorEntity?,arcoreToken: freezed == arcoreToken ? _self.arcoreToken : arcoreToken // ignore: cast_nullable_to_non_nullable
as String?,selectedAssetId: freezed == selectedAssetId ? _self.selectedAssetId : selectedAssetId // ignore: cast_nullable_to_non_nullable
as int?,selectedPlacementId: freezed == selectedPlacementId ? _self.selectedPlacementId : selectedPlacementId // ignore: cast_nullable_to_non_nullable
as String?,interactiveProgressCompleted: freezed == interactiveProgressCompleted ? _self.interactiveProgressCompleted : interactiveProgressCompleted // ignore: cast_nullable_to_non_nullable
as int?,interactiveProgressTotal: freezed == interactiveProgressTotal ? _self.interactiveProgressTotal : interactiveProgressTotal // ignore: cast_nullable_to_non_nullable
as int?,anchorReachResult: freezed == anchorReachResult ? _self.anchorReachResult : anchorReachResult // ignore: cast_nullable_to_non_nullable
as ArAnchorReachResultEntity?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ArSessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArSceneRootAnchorEntityCopyWith<$Res>? get rootAnchor {
    if (_self.rootAnchor == null) {
    return null;
  }

  return $ArSceneRootAnchorEntityCopyWith<$Res>(_self.rootAnchor!, (value) {
    return _then(_self.copyWith(rootAnchor: value));
  });
}/// Create a copy of ArSessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArAnchorReachResultEntityCopyWith<$Res>? get anchorReachResult {
    if (_self.anchorReachResult == null) {
    return null;
  }

  return $ArAnchorReachResultEntityCopyWith<$Res>(_self.anchorReachResult!, (value) {
    return _then(_self.copyWith(anchorReachResult: value));
  });
}
}


/// Adds pattern-matching-related methods to [ArSessionState].
extension ArSessionStatePatterns on ArSessionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArSessionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArSessionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArSessionState value)  $default,){
final _that = this;
switch (_that) {
case _ArSessionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArSessionState value)?  $default,){
final _that = this;
switch (_that) {
case _ArSessionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ArSessionStatus status,  ArSessionMode mode,  String sceneId,  int questId,  int eventId,  String eventTitle,  List<ArAssetEntity> assets,  List<ArAssetPlacementEntity> placements,  int? version,  String? updatedAt,  int? createdBy,  bool isPublished,  bool hasTest,  ArSceneRootAnchorEntity? rootAnchor,  String? arcoreToken,  int? selectedAssetId,  String? selectedPlacementId,  int? interactiveProgressCompleted,  int? interactiveProgressTotal,  ArAnchorReachResultEntity? anchorReachResult,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArSessionState() when $default != null:
return $default(_that.status,_that.mode,_that.sceneId,_that.questId,_that.eventId,_that.eventTitle,_that.assets,_that.placements,_that.version,_that.updatedAt,_that.createdBy,_that.isPublished,_that.hasTest,_that.rootAnchor,_that.arcoreToken,_that.selectedAssetId,_that.selectedPlacementId,_that.interactiveProgressCompleted,_that.interactiveProgressTotal,_that.anchorReachResult,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ArSessionStatus status,  ArSessionMode mode,  String sceneId,  int questId,  int eventId,  String eventTitle,  List<ArAssetEntity> assets,  List<ArAssetPlacementEntity> placements,  int? version,  String? updatedAt,  int? createdBy,  bool isPublished,  bool hasTest,  ArSceneRootAnchorEntity? rootAnchor,  String? arcoreToken,  int? selectedAssetId,  String? selectedPlacementId,  int? interactiveProgressCompleted,  int? interactiveProgressTotal,  ArAnchorReachResultEntity? anchorReachResult,  String? message)  $default,) {final _that = this;
switch (_that) {
case _ArSessionState():
return $default(_that.status,_that.mode,_that.sceneId,_that.questId,_that.eventId,_that.eventTitle,_that.assets,_that.placements,_that.version,_that.updatedAt,_that.createdBy,_that.isPublished,_that.hasTest,_that.rootAnchor,_that.arcoreToken,_that.selectedAssetId,_that.selectedPlacementId,_that.interactiveProgressCompleted,_that.interactiveProgressTotal,_that.anchorReachResult,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ArSessionStatus status,  ArSessionMode mode,  String sceneId,  int questId,  int eventId,  String eventTitle,  List<ArAssetEntity> assets,  List<ArAssetPlacementEntity> placements,  int? version,  String? updatedAt,  int? createdBy,  bool isPublished,  bool hasTest,  ArSceneRootAnchorEntity? rootAnchor,  String? arcoreToken,  int? selectedAssetId,  String? selectedPlacementId,  int? interactiveProgressCompleted,  int? interactiveProgressTotal,  ArAnchorReachResultEntity? anchorReachResult,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _ArSessionState() when $default != null:
return $default(_that.status,_that.mode,_that.sceneId,_that.questId,_that.eventId,_that.eventTitle,_that.assets,_that.placements,_that.version,_that.updatedAt,_that.createdBy,_that.isPublished,_that.hasTest,_that.rootAnchor,_that.arcoreToken,_that.selectedAssetId,_that.selectedPlacementId,_that.interactiveProgressCompleted,_that.interactiveProgressTotal,_that.anchorReachResult,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _ArSessionState extends ArSessionState {
  const _ArSessionState({this.status = ArSessionStatus.initial, this.mode = ArSessionMode.user, this.sceneId = '', this.questId = 0, this.eventId = 0, this.eventTitle = '', final  List<ArAssetEntity> assets = const [], final  List<ArAssetPlacementEntity> placements = const [], this.version, this.updatedAt, this.createdBy, this.isPublished = false, this.hasTest = false, this.rootAnchor, this.arcoreToken, this.selectedAssetId, this.selectedPlacementId, this.interactiveProgressCompleted, this.interactiveProgressTotal, this.anchorReachResult, this.message}): _assets = assets,_placements = placements,super._();
  

@override@JsonKey() final  ArSessionStatus status;
@override@JsonKey() final  ArSessionMode mode;
@override@JsonKey() final  String sceneId;
@override@JsonKey() final  int questId;
@override@JsonKey() final  int eventId;
@override@JsonKey() final  String eventTitle;
 final  List<ArAssetEntity> _assets;
@override@JsonKey() List<ArAssetEntity> get assets {
  if (_assets is EqualUnmodifiableListView) return _assets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_assets);
}

 final  List<ArAssetPlacementEntity> _placements;
@override@JsonKey() List<ArAssetPlacementEntity> get placements {
  if (_placements is EqualUnmodifiableListView) return _placements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_placements);
}

@override final  int? version;
@override final  String? updatedAt;
@override final  int? createdBy;
@override@JsonKey() final  bool isPublished;
@override@JsonKey() final  bool hasTest;
@override final  ArSceneRootAnchorEntity? rootAnchor;
@override final  String? arcoreToken;
@override final  int? selectedAssetId;
@override final  String? selectedPlacementId;
@override final  int? interactiveProgressCompleted;
@override final  int? interactiveProgressTotal;
@override final  ArAnchorReachResultEntity? anchorReachResult;
@override final  String? message;

/// Create a copy of ArSessionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArSessionStateCopyWith<_ArSessionState> get copyWith => __$ArSessionStateCopyWithImpl<_ArSessionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArSessionState&&(identical(other.status, status) || other.status == status)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.sceneId, sceneId) || other.sceneId == sceneId)&&(identical(other.questId, questId) || other.questId == questId)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.eventTitle, eventTitle) || other.eventTitle == eventTitle)&&const DeepCollectionEquality().equals(other._assets, _assets)&&const DeepCollectionEquality().equals(other._placements, _placements)&&(identical(other.version, version) || other.version == version)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.isPublished, isPublished) || other.isPublished == isPublished)&&(identical(other.hasTest, hasTest) || other.hasTest == hasTest)&&(identical(other.rootAnchor, rootAnchor) || other.rootAnchor == rootAnchor)&&(identical(other.arcoreToken, arcoreToken) || other.arcoreToken == arcoreToken)&&(identical(other.selectedAssetId, selectedAssetId) || other.selectedAssetId == selectedAssetId)&&(identical(other.selectedPlacementId, selectedPlacementId) || other.selectedPlacementId == selectedPlacementId)&&(identical(other.interactiveProgressCompleted, interactiveProgressCompleted) || other.interactiveProgressCompleted == interactiveProgressCompleted)&&(identical(other.interactiveProgressTotal, interactiveProgressTotal) || other.interactiveProgressTotal == interactiveProgressTotal)&&(identical(other.anchorReachResult, anchorReachResult) || other.anchorReachResult == anchorReachResult)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hashAll([runtimeType,status,mode,sceneId,questId,eventId,eventTitle,const DeepCollectionEquality().hash(_assets),const DeepCollectionEquality().hash(_placements),version,updatedAt,createdBy,isPublished,hasTest,rootAnchor,arcoreToken,selectedAssetId,selectedPlacementId,interactiveProgressCompleted,interactiveProgressTotal,anchorReachResult,message]);

@override
String toString() {
  return 'ArSessionState(status: $status, mode: $mode, sceneId: $sceneId, questId: $questId, eventId: $eventId, eventTitle: $eventTitle, assets: $assets, placements: $placements, version: $version, updatedAt: $updatedAt, createdBy: $createdBy, isPublished: $isPublished, hasTest: $hasTest, rootAnchor: $rootAnchor, arcoreToken: $arcoreToken, selectedAssetId: $selectedAssetId, selectedPlacementId: $selectedPlacementId, interactiveProgressCompleted: $interactiveProgressCompleted, interactiveProgressTotal: $interactiveProgressTotal, anchorReachResult: $anchorReachResult, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ArSessionStateCopyWith<$Res> implements $ArSessionStateCopyWith<$Res> {
  factory _$ArSessionStateCopyWith(_ArSessionState value, $Res Function(_ArSessionState) _then) = __$ArSessionStateCopyWithImpl;
@override @useResult
$Res call({
 ArSessionStatus status, ArSessionMode mode, String sceneId, int questId, int eventId, String eventTitle, List<ArAssetEntity> assets, List<ArAssetPlacementEntity> placements, int? version, String? updatedAt, int? createdBy, bool isPublished, bool hasTest, ArSceneRootAnchorEntity? rootAnchor, String? arcoreToken, int? selectedAssetId, String? selectedPlacementId, int? interactiveProgressCompleted, int? interactiveProgressTotal, ArAnchorReachResultEntity? anchorReachResult, String? message
});


@override $ArSceneRootAnchorEntityCopyWith<$Res>? get rootAnchor;@override $ArAnchorReachResultEntityCopyWith<$Res>? get anchorReachResult;

}
/// @nodoc
class __$ArSessionStateCopyWithImpl<$Res>
    implements _$ArSessionStateCopyWith<$Res> {
  __$ArSessionStateCopyWithImpl(this._self, this._then);

  final _ArSessionState _self;
  final $Res Function(_ArSessionState) _then;

/// Create a copy of ArSessionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? mode = null,Object? sceneId = null,Object? questId = null,Object? eventId = null,Object? eventTitle = null,Object? assets = null,Object? placements = null,Object? version = freezed,Object? updatedAt = freezed,Object? createdBy = freezed,Object? isPublished = null,Object? hasTest = null,Object? rootAnchor = freezed,Object? arcoreToken = freezed,Object? selectedAssetId = freezed,Object? selectedPlacementId = freezed,Object? interactiveProgressCompleted = freezed,Object? interactiveProgressTotal = freezed,Object? anchorReachResult = freezed,Object? message = freezed,}) {
  return _then(_ArSessionState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ArSessionStatus,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as ArSessionMode,sceneId: null == sceneId ? _self.sceneId : sceneId // ignore: cast_nullable_to_non_nullable
as String,questId: null == questId ? _self.questId : questId // ignore: cast_nullable_to_non_nullable
as int,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int,eventTitle: null == eventTitle ? _self.eventTitle : eventTitle // ignore: cast_nullable_to_non_nullable
as String,assets: null == assets ? _self._assets : assets // ignore: cast_nullable_to_non_nullable
as List<ArAssetEntity>,placements: null == placements ? _self._placements : placements // ignore: cast_nullable_to_non_nullable
as List<ArAssetPlacementEntity>,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as int?,isPublished: null == isPublished ? _self.isPublished : isPublished // ignore: cast_nullable_to_non_nullable
as bool,hasTest: null == hasTest ? _self.hasTest : hasTest // ignore: cast_nullable_to_non_nullable
as bool,rootAnchor: freezed == rootAnchor ? _self.rootAnchor : rootAnchor // ignore: cast_nullable_to_non_nullable
as ArSceneRootAnchorEntity?,arcoreToken: freezed == arcoreToken ? _self.arcoreToken : arcoreToken // ignore: cast_nullable_to_non_nullable
as String?,selectedAssetId: freezed == selectedAssetId ? _self.selectedAssetId : selectedAssetId // ignore: cast_nullable_to_non_nullable
as int?,selectedPlacementId: freezed == selectedPlacementId ? _self.selectedPlacementId : selectedPlacementId // ignore: cast_nullable_to_non_nullable
as String?,interactiveProgressCompleted: freezed == interactiveProgressCompleted ? _self.interactiveProgressCompleted : interactiveProgressCompleted // ignore: cast_nullable_to_non_nullable
as int?,interactiveProgressTotal: freezed == interactiveProgressTotal ? _self.interactiveProgressTotal : interactiveProgressTotal // ignore: cast_nullable_to_non_nullable
as int?,anchorReachResult: freezed == anchorReachResult ? _self.anchorReachResult : anchorReachResult // ignore: cast_nullable_to_non_nullable
as ArAnchorReachResultEntity?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ArSessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArSceneRootAnchorEntityCopyWith<$Res>? get rootAnchor {
    if (_self.rootAnchor == null) {
    return null;
  }

  return $ArSceneRootAnchorEntityCopyWith<$Res>(_self.rootAnchor!, (value) {
    return _then(_self.copyWith(rootAnchor: value));
  });
}/// Create a copy of ArSessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArAnchorReachResultEntityCopyWith<$Res>? get anchorReachResult {
    if (_self.anchorReachResult == null) {
    return null;
  }

  return $ArAnchorReachResultEntityCopyWith<$Res>(_self.anchorReachResult!, (value) {
    return _then(_self.copyWith(anchorReachResult: value));
  });
}
}

// dart format on
