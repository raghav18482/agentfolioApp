// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prediction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HorizonCall {

 Direction get direction;/// How sure the engine is of [direction], 0–1. Not a calibrated
/// probability for the rule-based engine.
 double get confidence; double get score; double? get probabilityUp; bool? get calibrated;
/// Create a copy of HorizonCall
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HorizonCallCopyWith<HorizonCall> get copyWith => _$HorizonCallCopyWithImpl<HorizonCall>(this as HorizonCall, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as HorizonCall;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HorizonCall&&(identical(other.direction, _this.direction) || other.direction == _this.direction)&&(identical(other.confidence, _this.confidence) || other.confidence == _this.confidence)&&(identical(other.score, _this.score) || other.score == _this.score)&&(identical(other.probabilityUp, _this.probabilityUp) || other.probabilityUp == _this.probabilityUp)&&(identical(other.calibrated, _this.calibrated) || other.calibrated == _this.calibrated));
}


@override
int get hashCode {
  final _this = this as HorizonCall;
  return Object.hash(runtimeType,_this.direction,_this.confidence,_this.score,_this.probabilityUp,_this.calibrated);
}

@override
String toString() {
  final _this = this as HorizonCall;
  return 'HorizonCall(direction: ${_this.direction}, confidence: ${_this.confidence}, score: ${_this.score}, probabilityUp: ${_this.probabilityUp}, calibrated: ${_this.calibrated})';
}


}

/// @nodoc
abstract mixin class $HorizonCallCopyWith<$Res>  {
  factory $HorizonCallCopyWith(HorizonCall value, $Res Function(HorizonCall) _then) = _$HorizonCallCopyWithImpl;
@useResult
$Res call({
 Direction direction, double confidence, double score, double? probabilityUp, bool? calibrated
});




}
/// @nodoc
class _$HorizonCallCopyWithImpl<$Res>
    implements $HorizonCallCopyWith<$Res> {
  _$HorizonCallCopyWithImpl(this._self, this._then);

  final HorizonCall _self;
  final $Res Function(HorizonCall) _then;

/// Create a copy of HorizonCall
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? direction = null,Object? confidence = null,Object? score = null,Object? probabilityUp = freezed,Object? calibrated = freezed,}) {
  return _then(HorizonCall(
direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as Direction,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,probabilityUp: freezed == probabilityUp ? _self.probabilityUp : probabilityUp // ignore: cast_nullable_to_non_nullable
as double?,calibrated: freezed == calibrated ? _self.calibrated : calibrated // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [HorizonCall].
extension HorizonCallPatterns on HorizonCall {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HorizonCall value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HorizonCall() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HorizonCall value)  $default,){
final _that = this;
switch (_that) {
case _HorizonCall():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HorizonCall value)?  $default,){
final _that = this;
switch (_that) {
case _HorizonCall() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Direction direction,  double confidence,  double score,  double? probabilityUp,  bool? calibrated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HorizonCall() when $default != null:
return $default(_that.direction,_that.confidence,_that.score,_that.probabilityUp,_that.calibrated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Direction direction,  double confidence,  double score,  double? probabilityUp,  bool? calibrated)  $default,) {final _that = this;
switch (_that) {
case _HorizonCall():
return $default(_that.direction,_that.confidence,_that.score,_that.probabilityUp,_that.calibrated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Direction direction,  double confidence,  double score,  double? probabilityUp,  bool? calibrated)?  $default,) {final _that = this;
switch (_that) {
case _HorizonCall() when $default != null:
return $default(_that.direction,_that.confidence,_that.score,_that.probabilityUp,_that.calibrated);case _:
  return null;

}
}

}

/// @nodoc


class _HorizonCall implements HorizonCall {
  const _HorizonCall({required this.direction, required this.confidence, required this.score, this.probabilityUp, this.calibrated});
  

@override final  Direction direction;
/// How sure the engine is of [direction], 0–1. Not a calibrated
/// probability for the rule-based engine.
@override final  double confidence;
@override final  double score;
@override final  double? probabilityUp;
@override final  bool? calibrated;

/// Create a copy of HorizonCall
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HorizonCallCopyWith<_HorizonCall> get copyWith => __$HorizonCallCopyWithImpl<_HorizonCall>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HorizonCall&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.score, score) || other.score == score)&&(identical(other.probabilityUp, probabilityUp) || other.probabilityUp == probabilityUp)&&(identical(other.calibrated, calibrated) || other.calibrated == calibrated));
}


@override
int get hashCode {
    return Object.hash(runtimeType,direction,confidence,score,probabilityUp,calibrated);
}

@override
String toString() {
    return 'HorizonCall(direction: $direction, confidence: $confidence, score: $score, probabilityUp: $probabilityUp, calibrated: $calibrated)';
}


}

/// @nodoc
abstract mixin class _$HorizonCallCopyWith<$Res> implements $HorizonCallCopyWith<$Res> {
  factory _$HorizonCallCopyWith(_HorizonCall value, $Res Function(_HorizonCall) _then) = __$HorizonCallCopyWithImpl;
@override @useResult
$Res call({
 Direction direction, double confidence, double score, double? probabilityUp, bool? calibrated
});




}
/// @nodoc
class __$HorizonCallCopyWithImpl<$Res>
    implements _$HorizonCallCopyWith<$Res> {
  __$HorizonCallCopyWithImpl(this._self, this._then);

  final _HorizonCall _self;
  final $Res Function(_HorizonCall) _then;

/// Create a copy of HorizonCall
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? direction = null,Object? confidence = null,Object? score = null,Object? probabilityUp = freezed,Object? calibrated = freezed,}) {
  return _then(_HorizonCall(
direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as Direction,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,probabilityUp: freezed == probabilityUp ? _self.probabilityUp : probabilityUp // ignore: cast_nullable_to_non_nullable
as double?,calibrated: freezed == calibrated ? _self.calibrated : calibrated // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

/// @nodoc
mixin _$PredictionSignal {

 String get feature; double? get value;
/// Create a copy of PredictionSignal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PredictionSignalCopyWith<PredictionSignal> get copyWith => _$PredictionSignalCopyWithImpl<PredictionSignal>(this as PredictionSignal, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PredictionSignal;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PredictionSignal&&(identical(other.feature, _this.feature) || other.feature == _this.feature)&&(identical(other.value, _this.value) || other.value == _this.value));
}


@override
int get hashCode {
  final _this = this as PredictionSignal;
  return Object.hash(runtimeType,_this.feature,_this.value);
}

@override
String toString() {
  final _this = this as PredictionSignal;
  return 'PredictionSignal(feature: ${_this.feature}, value: ${_this.value})';
}


}

/// @nodoc
abstract mixin class $PredictionSignalCopyWith<$Res>  {
  factory $PredictionSignalCopyWith(PredictionSignal value, $Res Function(PredictionSignal) _then) = _$PredictionSignalCopyWithImpl;
@useResult
$Res call({
 String feature, double? value
});




}
/// @nodoc
class _$PredictionSignalCopyWithImpl<$Res>
    implements $PredictionSignalCopyWith<$Res> {
  _$PredictionSignalCopyWithImpl(this._self, this._then);

  final PredictionSignal _self;
  final $Res Function(PredictionSignal) _then;

/// Create a copy of PredictionSignal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? feature = null,Object? value = freezed,}) {
  return _then(PredictionSignal(
feature: null == feature ? _self.feature : feature // ignore: cast_nullable_to_non_nullable
as String,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [PredictionSignal].
extension PredictionSignalPatterns on PredictionSignal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PredictionSignal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PredictionSignal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PredictionSignal value)  $default,){
final _that = this;
switch (_that) {
case _PredictionSignal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PredictionSignal value)?  $default,){
final _that = this;
switch (_that) {
case _PredictionSignal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String feature,  double? value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PredictionSignal() when $default != null:
return $default(_that.feature,_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String feature,  double? value)  $default,) {final _that = this;
switch (_that) {
case _PredictionSignal():
return $default(_that.feature,_that.value);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String feature,  double? value)?  $default,) {final _that = this;
switch (_that) {
case _PredictionSignal() when $default != null:
return $default(_that.feature,_that.value);case _:
  return null;

}
}

}

/// @nodoc


class _PredictionSignal implements PredictionSignal {
  const _PredictionSignal({required this.feature, this.value});
  

@override final  String feature;
@override final  double? value;

/// Create a copy of PredictionSignal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PredictionSignalCopyWith<_PredictionSignal> get copyWith => __$PredictionSignalCopyWithImpl<_PredictionSignal>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PredictionSignal&&(identical(other.feature, feature) || other.feature == feature)&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode {
    return Object.hash(runtimeType,feature,value);
}

@override
String toString() {
    return 'PredictionSignal(feature: $feature, value: $value)';
}


}

/// @nodoc
abstract mixin class _$PredictionSignalCopyWith<$Res> implements $PredictionSignalCopyWith<$Res> {
  factory _$PredictionSignalCopyWith(_PredictionSignal value, $Res Function(_PredictionSignal) _then) = __$PredictionSignalCopyWithImpl;
@override @useResult
$Res call({
 String feature, double? value
});




}
/// @nodoc
class __$PredictionSignalCopyWithImpl<$Res>
    implements _$PredictionSignalCopyWith<$Res> {
  __$PredictionSignalCopyWithImpl(this._self, this._then);

  final _PredictionSignal _self;
  final $Res Function(_PredictionSignal) _then;

/// Create a copy of PredictionSignal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? feature = null,Object? value = freezed,}) {
  return _then(_PredictionSignal(
feature: null == feature ? _self.feature : feature // ignore: cast_nullable_to_non_nullable
as String,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

/// @nodoc
mixin _$Prediction {

 String get symbol; Map<Horizon, HorizonCall> get calls; Outlook get outlook; double get overallScore;/// `heuristic` when no trained model is registered: a rule-based score.
 String get modelType; List<PredictionSignal> get bullishSignals; List<PredictionSignal> get bearishSignals; String? get modelVersion; bool? get calibrated;/// The server's own caveat, shown verbatim.
 String? get disclaimer;
/// Create a copy of Prediction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PredictionCopyWith<Prediction> get copyWith => _$PredictionCopyWithImpl<Prediction>(this as Prediction, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Prediction;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Prediction&&(identical(other.symbol, _this.symbol) || other.symbol == _this.symbol)&&const DeepCollectionEquality().equals(other.calls, _this.calls)&&(identical(other.outlook, _this.outlook) || other.outlook == _this.outlook)&&(identical(other.overallScore, _this.overallScore) || other.overallScore == _this.overallScore)&&(identical(other.modelType, _this.modelType) || other.modelType == _this.modelType)&&const DeepCollectionEquality().equals(other.bullishSignals, _this.bullishSignals)&&const DeepCollectionEquality().equals(other.bearishSignals, _this.bearishSignals)&&(identical(other.modelVersion, _this.modelVersion) || other.modelVersion == _this.modelVersion)&&(identical(other.calibrated, _this.calibrated) || other.calibrated == _this.calibrated)&&(identical(other.disclaimer, _this.disclaimer) || other.disclaimer == _this.disclaimer));
}


@override
int get hashCode {
  final _this = this as Prediction;
  return Object.hash(runtimeType,_this.symbol,const DeepCollectionEquality().hash(_this.calls),_this.outlook,_this.overallScore,_this.modelType,const DeepCollectionEquality().hash(_this.bullishSignals),const DeepCollectionEquality().hash(_this.bearishSignals),_this.modelVersion,_this.calibrated,_this.disclaimer);
}

@override
String toString() {
  final _this = this as Prediction;
  return 'Prediction(symbol: ${_this.symbol}, calls: ${_this.calls}, outlook: ${_this.outlook}, overallScore: ${_this.overallScore}, modelType: ${_this.modelType}, bullishSignals: ${_this.bullishSignals}, bearishSignals: ${_this.bearishSignals}, modelVersion: ${_this.modelVersion}, calibrated: ${_this.calibrated}, disclaimer: ${_this.disclaimer})';
}


}

/// @nodoc
abstract mixin class $PredictionCopyWith<$Res>  {
  factory $PredictionCopyWith(Prediction value, $Res Function(Prediction) _then) = _$PredictionCopyWithImpl;
@useResult
$Res call({
 String symbol, Map<Horizon, HorizonCall> calls, Outlook outlook, double overallScore, String modelType, List<PredictionSignal> bullishSignals, List<PredictionSignal> bearishSignals, String? modelVersion, bool? calibrated, String? disclaimer
});




}
/// @nodoc
class _$PredictionCopyWithImpl<$Res>
    implements $PredictionCopyWith<$Res> {
  _$PredictionCopyWithImpl(this._self, this._then);

  final Prediction _self;
  final $Res Function(Prediction) _then;

/// Create a copy of Prediction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? calls = null,Object? outlook = null,Object? overallScore = null,Object? modelType = null,Object? bullishSignals = null,Object? bearishSignals = null,Object? modelVersion = freezed,Object? calibrated = freezed,Object? disclaimer = freezed,}) {
  return _then(Prediction(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,calls: null == calls ? _self.calls : calls // ignore: cast_nullable_to_non_nullable
as Map<Horizon, HorizonCall>,outlook: null == outlook ? _self.outlook : outlook // ignore: cast_nullable_to_non_nullable
as Outlook,overallScore: null == overallScore ? _self.overallScore : overallScore // ignore: cast_nullable_to_non_nullable
as double,modelType: null == modelType ? _self.modelType : modelType // ignore: cast_nullable_to_non_nullable
as String,bullishSignals: null == bullishSignals ? _self.bullishSignals : bullishSignals // ignore: cast_nullable_to_non_nullable
as List<PredictionSignal>,bearishSignals: null == bearishSignals ? _self.bearishSignals : bearishSignals // ignore: cast_nullable_to_non_nullable
as List<PredictionSignal>,modelVersion: freezed == modelVersion ? _self.modelVersion : modelVersion // ignore: cast_nullable_to_non_nullable
as String?,calibrated: freezed == calibrated ? _self.calibrated : calibrated // ignore: cast_nullable_to_non_nullable
as bool?,disclaimer: freezed == disclaimer ? _self.disclaimer : disclaimer // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Prediction].
extension PredictionPatterns on Prediction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Prediction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Prediction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Prediction value)  $default,){
final _that = this;
switch (_that) {
case _Prediction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Prediction value)?  $default,){
final _that = this;
switch (_that) {
case _Prediction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  Map<Horizon, HorizonCall> calls,  Outlook outlook,  double overallScore,  String modelType,  List<PredictionSignal> bullishSignals,  List<PredictionSignal> bearishSignals,  String? modelVersion,  bool? calibrated,  String? disclaimer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Prediction() when $default != null:
return $default(_that.symbol,_that.calls,_that.outlook,_that.overallScore,_that.modelType,_that.bullishSignals,_that.bearishSignals,_that.modelVersion,_that.calibrated,_that.disclaimer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  Map<Horizon, HorizonCall> calls,  Outlook outlook,  double overallScore,  String modelType,  List<PredictionSignal> bullishSignals,  List<PredictionSignal> bearishSignals,  String? modelVersion,  bool? calibrated,  String? disclaimer)  $default,) {final _that = this;
switch (_that) {
case _Prediction():
return $default(_that.symbol,_that.calls,_that.outlook,_that.overallScore,_that.modelType,_that.bullishSignals,_that.bearishSignals,_that.modelVersion,_that.calibrated,_that.disclaimer);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  Map<Horizon, HorizonCall> calls,  Outlook outlook,  double overallScore,  String modelType,  List<PredictionSignal> bullishSignals,  List<PredictionSignal> bearishSignals,  String? modelVersion,  bool? calibrated,  String? disclaimer)?  $default,) {final _that = this;
switch (_that) {
case _Prediction() when $default != null:
return $default(_that.symbol,_that.calls,_that.outlook,_that.overallScore,_that.modelType,_that.bullishSignals,_that.bearishSignals,_that.modelVersion,_that.calibrated,_that.disclaimer);case _:
  return null;

}
}

}

/// @nodoc


class _Prediction extends Prediction {
  const _Prediction({required this.symbol, required  Map<Horizon, HorizonCall> calls, required this.outlook, required this.overallScore, required this.modelType, required  List<PredictionSignal> bullishSignals, required  List<PredictionSignal> bearishSignals, this.modelVersion, this.calibrated, this.disclaimer}): _calls = calls,_bullishSignals = bullishSignals,_bearishSignals = bearishSignals,super._();
  

@override final  String symbol;
 final  Map<Horizon, HorizonCall> _calls;
@override Map<Horizon, HorizonCall> get calls {
  if (_calls is EqualUnmodifiableMapView) return _calls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_calls);
}

@override final  Outlook outlook;
@override final  double overallScore;
/// `heuristic` when no trained model is registered: a rule-based score.
@override final  String modelType;
 final  List<PredictionSignal> _bullishSignals;
@override List<PredictionSignal> get bullishSignals {
  if (_bullishSignals is EqualUnmodifiableListView) return _bullishSignals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bullishSignals);
}

 final  List<PredictionSignal> _bearishSignals;
@override List<PredictionSignal> get bearishSignals {
  if (_bearishSignals is EqualUnmodifiableListView) return _bearishSignals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bearishSignals);
}

@override final  String? modelVersion;
@override final  bool? calibrated;
/// The server's own caveat, shown verbatim.
@override final  String? disclaimer;

/// Create a copy of Prediction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PredictionCopyWith<_Prediction> get copyWith => __$PredictionCopyWithImpl<_Prediction>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Prediction&&(identical(other.symbol, symbol) || other.symbol == symbol)&&const DeepCollectionEquality().equals(other.calls, _calls)&&(identical(other.outlook, outlook) || other.outlook == outlook)&&(identical(other.overallScore, overallScore) || other.overallScore == overallScore)&&(identical(other.modelType, modelType) || other.modelType == modelType)&&const DeepCollectionEquality().equals(other.bullishSignals, _bullishSignals)&&const DeepCollectionEquality().equals(other.bearishSignals, _bearishSignals)&&(identical(other.modelVersion, modelVersion) || other.modelVersion == modelVersion)&&(identical(other.calibrated, calibrated) || other.calibrated == calibrated)&&(identical(other.disclaimer, disclaimer) || other.disclaimer == disclaimer));
}


@override
int get hashCode {
    return Object.hash(runtimeType,symbol,const DeepCollectionEquality().hash(_calls),outlook,overallScore,modelType,const DeepCollectionEquality().hash(_bullishSignals),const DeepCollectionEquality().hash(_bearishSignals),modelVersion,calibrated,disclaimer);
}

@override
String toString() {
    return 'Prediction(symbol: $symbol, calls: $calls, outlook: $outlook, overallScore: $overallScore, modelType: $modelType, bullishSignals: $bullishSignals, bearishSignals: $bearishSignals, modelVersion: $modelVersion, calibrated: $calibrated, disclaimer: $disclaimer)';
}


}

/// @nodoc
abstract mixin class _$PredictionCopyWith<$Res> implements $PredictionCopyWith<$Res> {
  factory _$PredictionCopyWith(_Prediction value, $Res Function(_Prediction) _then) = __$PredictionCopyWithImpl;
@override @useResult
$Res call({
 String symbol, Map<Horizon, HorizonCall> calls, Outlook outlook, double overallScore, String modelType, List<PredictionSignal> bullishSignals, List<PredictionSignal> bearishSignals, String? modelVersion, bool? calibrated, String? disclaimer
});




}
/// @nodoc
class __$PredictionCopyWithImpl<$Res>
    implements _$PredictionCopyWith<$Res> {
  __$PredictionCopyWithImpl(this._self, this._then);

  final _Prediction _self;
  final $Res Function(_Prediction) _then;

/// Create a copy of Prediction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? calls = null,Object? outlook = null,Object? overallScore = null,Object? modelType = null,Object? bullishSignals = null,Object? bearishSignals = null,Object? modelVersion = freezed,Object? calibrated = freezed,Object? disclaimer = freezed,}) {
  return _then(_Prediction(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,calls: null == calls ? _self._calls : calls // ignore: cast_nullable_to_non_nullable
as Map<Horizon, HorizonCall>,outlook: null == outlook ? _self.outlook : outlook // ignore: cast_nullable_to_non_nullable
as Outlook,overallScore: null == overallScore ? _self.overallScore : overallScore // ignore: cast_nullable_to_non_nullable
as double,modelType: null == modelType ? _self.modelType : modelType // ignore: cast_nullable_to_non_nullable
as String,bullishSignals: null == bullishSignals ? _self._bullishSignals : bullishSignals // ignore: cast_nullable_to_non_nullable
as List<PredictionSignal>,bearishSignals: null == bearishSignals ? _self._bearishSignals : bearishSignals // ignore: cast_nullable_to_non_nullable
as List<PredictionSignal>,modelVersion: freezed == modelVersion ? _self.modelVersion : modelVersion // ignore: cast_nullable_to_non_nullable
as String?,calibrated: freezed == calibrated ? _self.calibrated : calibrated // ignore: cast_nullable_to_non_nullable
as bool?,disclaimer: freezed == disclaimer ? _self.disclaimer : disclaimer // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
