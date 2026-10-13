// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'technicals.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TechnicalIndicators implements DiagnosticableTreeMixin {

 double? get sma20; double? get sma50; double? get sma200; double? get rsi; double? get macd; double? get macdSignal; double? get macdHistogram; double? get week52High; double? get week52Low;/// Percent of the way from the 52-week low to the high.
 double? get week52Position;/// Today's volume over the 20-day average.
 double? get volumeRatio;
/// Create a copy of TechnicalIndicators
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TechnicalIndicatorsCopyWith<TechnicalIndicators> get copyWith => _$TechnicalIndicatorsCopyWithImpl<TechnicalIndicators>(this as TechnicalIndicators, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  final _this = this as TechnicalIndicators;
  properties
    ..add(DiagnosticsProperty('type', 'TechnicalIndicators'))
    ..add(DiagnosticsProperty('sma20', _this.sma20))..add(DiagnosticsProperty('sma50', _this.sma50))..add(DiagnosticsProperty('sma200', _this.sma200))..add(DiagnosticsProperty('rsi', _this.rsi))..add(DiagnosticsProperty('macd', _this.macd))..add(DiagnosticsProperty('macdSignal', _this.macdSignal))..add(DiagnosticsProperty('macdHistogram', _this.macdHistogram))..add(DiagnosticsProperty('week52High', _this.week52High))..add(DiagnosticsProperty('week52Low', _this.week52Low))..add(DiagnosticsProperty('week52Position', _this.week52Position))..add(DiagnosticsProperty('volumeRatio', _this.volumeRatio));
}

@override
bool operator ==(Object other) {
  final _this = this as TechnicalIndicators;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TechnicalIndicators&&(identical(other.sma20, _this.sma20) || other.sma20 == _this.sma20)&&(identical(other.sma50, _this.sma50) || other.sma50 == _this.sma50)&&(identical(other.sma200, _this.sma200) || other.sma200 == _this.sma200)&&(identical(other.rsi, _this.rsi) || other.rsi == _this.rsi)&&(identical(other.macd, _this.macd) || other.macd == _this.macd)&&(identical(other.macdSignal, _this.macdSignal) || other.macdSignal == _this.macdSignal)&&(identical(other.macdHistogram, _this.macdHistogram) || other.macdHistogram == _this.macdHistogram)&&(identical(other.week52High, _this.week52High) || other.week52High == _this.week52High)&&(identical(other.week52Low, _this.week52Low) || other.week52Low == _this.week52Low)&&(identical(other.week52Position, _this.week52Position) || other.week52Position == _this.week52Position)&&(identical(other.volumeRatio, _this.volumeRatio) || other.volumeRatio == _this.volumeRatio));
}


@override
int get hashCode {
  final _this = this as TechnicalIndicators;
  return Object.hash(runtimeType,_this.sma20,_this.sma50,_this.sma200,_this.rsi,_this.macd,_this.macdSignal,_this.macdHistogram,_this.week52High,_this.week52Low,_this.week52Position,_this.volumeRatio);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  final _this = this as TechnicalIndicators;
  return 'TechnicalIndicators(sma20: ${_this.sma20}, sma50: ${_this.sma50}, sma200: ${_this.sma200}, rsi: ${_this.rsi}, macd: ${_this.macd}, macdSignal: ${_this.macdSignal}, macdHistogram: ${_this.macdHistogram}, week52High: ${_this.week52High}, week52Low: ${_this.week52Low}, week52Position: ${_this.week52Position}, volumeRatio: ${_this.volumeRatio})';
}


}

/// @nodoc
abstract mixin class $TechnicalIndicatorsCopyWith<$Res>  {
  factory $TechnicalIndicatorsCopyWith(TechnicalIndicators value, $Res Function(TechnicalIndicators) _then) = _$TechnicalIndicatorsCopyWithImpl;
@useResult
$Res call({
 double? sma20, double? sma50, double? sma200, double? rsi, double? macd, double? macdSignal, double? macdHistogram, double? week52High, double? week52Low, double? week52Position, double? volumeRatio
});




}
/// @nodoc
class _$TechnicalIndicatorsCopyWithImpl<$Res>
    implements $TechnicalIndicatorsCopyWith<$Res> {
  _$TechnicalIndicatorsCopyWithImpl(this._self, this._then);

  final TechnicalIndicators _self;
  final $Res Function(TechnicalIndicators) _then;

/// Create a copy of TechnicalIndicators
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sma20 = freezed,Object? sma50 = freezed,Object? sma200 = freezed,Object? rsi = freezed,Object? macd = freezed,Object? macdSignal = freezed,Object? macdHistogram = freezed,Object? week52High = freezed,Object? week52Low = freezed,Object? week52Position = freezed,Object? volumeRatio = freezed,}) {
  return _then(TechnicalIndicators(
sma20: freezed == sma20 ? _self.sma20 : sma20 // ignore: cast_nullable_to_non_nullable
as double?,sma50: freezed == sma50 ? _self.sma50 : sma50 // ignore: cast_nullable_to_non_nullable
as double?,sma200: freezed == sma200 ? _self.sma200 : sma200 // ignore: cast_nullable_to_non_nullable
as double?,rsi: freezed == rsi ? _self.rsi : rsi // ignore: cast_nullable_to_non_nullable
as double?,macd: freezed == macd ? _self.macd : macd // ignore: cast_nullable_to_non_nullable
as double?,macdSignal: freezed == macdSignal ? _self.macdSignal : macdSignal // ignore: cast_nullable_to_non_nullable
as double?,macdHistogram: freezed == macdHistogram ? _self.macdHistogram : macdHistogram // ignore: cast_nullable_to_non_nullable
as double?,week52High: freezed == week52High ? _self.week52High : week52High // ignore: cast_nullable_to_non_nullable
as double?,week52Low: freezed == week52Low ? _self.week52Low : week52Low // ignore: cast_nullable_to_non_nullable
as double?,week52Position: freezed == week52Position ? _self.week52Position : week52Position // ignore: cast_nullable_to_non_nullable
as double?,volumeRatio: freezed == volumeRatio ? _self.volumeRatio : volumeRatio // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [TechnicalIndicators].
extension TechnicalIndicatorsPatterns on TechnicalIndicators {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TechnicalIndicators value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TechnicalIndicators() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TechnicalIndicators value)  $default,){
final _that = this;
switch (_that) {
case _TechnicalIndicators():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TechnicalIndicators value)?  $default,){
final _that = this;
switch (_that) {
case _TechnicalIndicators() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? sma20,  double? sma50,  double? sma200,  double? rsi,  double? macd,  double? macdSignal,  double? macdHistogram,  double? week52High,  double? week52Low,  double? week52Position,  double? volumeRatio)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TechnicalIndicators() when $default != null:
return $default(_that.sma20,_that.sma50,_that.sma200,_that.rsi,_that.macd,_that.macdSignal,_that.macdHistogram,_that.week52High,_that.week52Low,_that.week52Position,_that.volumeRatio);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? sma20,  double? sma50,  double? sma200,  double? rsi,  double? macd,  double? macdSignal,  double? macdHistogram,  double? week52High,  double? week52Low,  double? week52Position,  double? volumeRatio)  $default,) {final _that = this;
switch (_that) {
case _TechnicalIndicators():
return $default(_that.sma20,_that.sma50,_that.sma200,_that.rsi,_that.macd,_that.macdSignal,_that.macdHistogram,_that.week52High,_that.week52Low,_that.week52Position,_that.volumeRatio);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? sma20,  double? sma50,  double? sma200,  double? rsi,  double? macd,  double? macdSignal,  double? macdHistogram,  double? week52High,  double? week52Low,  double? week52Position,  double? volumeRatio)?  $default,) {final _that = this;
switch (_that) {
case _TechnicalIndicators() when $default != null:
return $default(_that.sma20,_that.sma50,_that.sma200,_that.rsi,_that.macd,_that.macdSignal,_that.macdHistogram,_that.week52High,_that.week52Low,_that.week52Position,_that.volumeRatio);case _:
  return null;

}
}

}

/// @nodoc


class _TechnicalIndicators with DiagnosticableTreeMixin implements TechnicalIndicators {
  const _TechnicalIndicators({this.sma20, this.sma50, this.sma200, this.rsi, this.macd, this.macdSignal, this.macdHistogram, this.week52High, this.week52Low, this.week52Position, this.volumeRatio});
  

@override final  double? sma20;
@override final  double? sma50;
@override final  double? sma200;
@override final  double? rsi;
@override final  double? macd;
@override final  double? macdSignal;
@override final  double? macdHistogram;
@override final  double? week52High;
@override final  double? week52Low;
/// Percent of the way from the 52-week low to the high.
@override final  double? week52Position;
/// Today's volume over the 20-day average.
@override final  double? volumeRatio;

/// Create a copy of TechnicalIndicators
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TechnicalIndicatorsCopyWith<_TechnicalIndicators> get copyWith => __$TechnicalIndicatorsCopyWithImpl<_TechnicalIndicators>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
    ..add(DiagnosticsProperty('type', 'TechnicalIndicators'))
    ..add(DiagnosticsProperty('sma20', sma20))..add(DiagnosticsProperty('sma50', sma50))..add(DiagnosticsProperty('sma200', sma200))..add(DiagnosticsProperty('rsi', rsi))..add(DiagnosticsProperty('macd', macd))..add(DiagnosticsProperty('macdSignal', macdSignal))..add(DiagnosticsProperty('macdHistogram', macdHistogram))..add(DiagnosticsProperty('week52High', week52High))..add(DiagnosticsProperty('week52Low', week52Low))..add(DiagnosticsProperty('week52Position', week52Position))..add(DiagnosticsProperty('volumeRatio', volumeRatio));
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TechnicalIndicators&&(identical(other.sma20, sma20) || other.sma20 == sma20)&&(identical(other.sma50, sma50) || other.sma50 == sma50)&&(identical(other.sma200, sma200) || other.sma200 == sma200)&&(identical(other.rsi, rsi) || other.rsi == rsi)&&(identical(other.macd, macd) || other.macd == macd)&&(identical(other.macdSignal, macdSignal) || other.macdSignal == macdSignal)&&(identical(other.macdHistogram, macdHistogram) || other.macdHistogram == macdHistogram)&&(identical(other.week52High, week52High) || other.week52High == week52High)&&(identical(other.week52Low, week52Low) || other.week52Low == week52Low)&&(identical(other.week52Position, week52Position) || other.week52Position == week52Position)&&(identical(other.volumeRatio, volumeRatio) || other.volumeRatio == volumeRatio));
}


@override
int get hashCode {
    return Object.hash(runtimeType,sma20,sma50,sma200,rsi,macd,macdSignal,macdHistogram,week52High,week52Low,week52Position,volumeRatio);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
    return 'TechnicalIndicators(sma20: $sma20, sma50: $sma50, sma200: $sma200, rsi: $rsi, macd: $macd, macdSignal: $macdSignal, macdHistogram: $macdHistogram, week52High: $week52High, week52Low: $week52Low, week52Position: $week52Position, volumeRatio: $volumeRatio)';
}


}

/// @nodoc
abstract mixin class _$TechnicalIndicatorsCopyWith<$Res> implements $TechnicalIndicatorsCopyWith<$Res> {
  factory _$TechnicalIndicatorsCopyWith(_TechnicalIndicators value, $Res Function(_TechnicalIndicators) _then) = __$TechnicalIndicatorsCopyWithImpl;
@override @useResult
$Res call({
 double? sma20, double? sma50, double? sma200, double? rsi, double? macd, double? macdSignal, double? macdHistogram, double? week52High, double? week52Low, double? week52Position, double? volumeRatio
});




}
/// @nodoc
class __$TechnicalIndicatorsCopyWithImpl<$Res>
    implements _$TechnicalIndicatorsCopyWith<$Res> {
  __$TechnicalIndicatorsCopyWithImpl(this._self, this._then);

  final _TechnicalIndicators _self;
  final $Res Function(_TechnicalIndicators) _then;

/// Create a copy of TechnicalIndicators
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sma20 = freezed,Object? sma50 = freezed,Object? sma200 = freezed,Object? rsi = freezed,Object? macd = freezed,Object? macdSignal = freezed,Object? macdHistogram = freezed,Object? week52High = freezed,Object? week52Low = freezed,Object? week52Position = freezed,Object? volumeRatio = freezed,}) {
  return _then(_TechnicalIndicators(
sma20: freezed == sma20 ? _self.sma20 : sma20 // ignore: cast_nullable_to_non_nullable
as double?,sma50: freezed == sma50 ? _self.sma50 : sma50 // ignore: cast_nullable_to_non_nullable
as double?,sma200: freezed == sma200 ? _self.sma200 : sma200 // ignore: cast_nullable_to_non_nullable
as double?,rsi: freezed == rsi ? _self.rsi : rsi // ignore: cast_nullable_to_non_nullable
as double?,macd: freezed == macd ? _self.macd : macd // ignore: cast_nullable_to_non_nullable
as double?,macdSignal: freezed == macdSignal ? _self.macdSignal : macdSignal // ignore: cast_nullable_to_non_nullable
as double?,macdHistogram: freezed == macdHistogram ? _self.macdHistogram : macdHistogram // ignore: cast_nullable_to_non_nullable
as double?,week52High: freezed == week52High ? _self.week52High : week52High // ignore: cast_nullable_to_non_nullable
as double?,week52Low: freezed == week52Low ? _self.week52Low : week52Low // ignore: cast_nullable_to_non_nullable
as double?,week52Position: freezed == week52Position ? _self.week52Position : week52Position // ignore: cast_nullable_to_non_nullable
as double?,volumeRatio: freezed == volumeRatio ? _self.volumeRatio : volumeRatio // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

/// @nodoc
mixin _$TechnicalSignal implements DiagnosticableTreeMixin {

 String get name; SignalStatus get status;/// Already formatted by the server: `₹2,410.50`, `1.4x avg`.
 String get value; String get label;
/// Create a copy of TechnicalSignal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TechnicalSignalCopyWith<TechnicalSignal> get copyWith => _$TechnicalSignalCopyWithImpl<TechnicalSignal>(this as TechnicalSignal, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  final _this = this as TechnicalSignal;
  properties
    ..add(DiagnosticsProperty('type', 'TechnicalSignal'))
    ..add(DiagnosticsProperty('name', _this.name))..add(DiagnosticsProperty('status', _this.status))..add(DiagnosticsProperty('value', _this.value))..add(DiagnosticsProperty('label', _this.label));
}

@override
bool operator ==(Object other) {
  final _this = this as TechnicalSignal;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TechnicalSignal&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.value, _this.value) || other.value == _this.value)&&(identical(other.label, _this.label) || other.label == _this.label));
}


@override
int get hashCode {
  final _this = this as TechnicalSignal;
  return Object.hash(runtimeType,_this.name,_this.status,_this.value,_this.label);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  final _this = this as TechnicalSignal;
  return 'TechnicalSignal(name: ${_this.name}, status: ${_this.status}, value: ${_this.value}, label: ${_this.label})';
}


}

/// @nodoc
abstract mixin class $TechnicalSignalCopyWith<$Res>  {
  factory $TechnicalSignalCopyWith(TechnicalSignal value, $Res Function(TechnicalSignal) _then) = _$TechnicalSignalCopyWithImpl;
@useResult
$Res call({
 String name, SignalStatus status, String value, String label
});




}
/// @nodoc
class _$TechnicalSignalCopyWithImpl<$Res>
    implements $TechnicalSignalCopyWith<$Res> {
  _$TechnicalSignalCopyWithImpl(this._self, this._then);

  final TechnicalSignal _self;
  final $Res Function(TechnicalSignal) _then;

/// Create a copy of TechnicalSignal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? status = null,Object? value = null,Object? label = null,}) {
  return _then(TechnicalSignal(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SignalStatus,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TechnicalSignal].
extension TechnicalSignalPatterns on TechnicalSignal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TechnicalSignal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TechnicalSignal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TechnicalSignal value)  $default,){
final _that = this;
switch (_that) {
case _TechnicalSignal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TechnicalSignal value)?  $default,){
final _that = this;
switch (_that) {
case _TechnicalSignal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  SignalStatus status,  String value,  String label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TechnicalSignal() when $default != null:
return $default(_that.name,_that.status,_that.value,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  SignalStatus status,  String value,  String label)  $default,) {final _that = this;
switch (_that) {
case _TechnicalSignal():
return $default(_that.name,_that.status,_that.value,_that.label);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  SignalStatus status,  String value,  String label)?  $default,) {final _that = this;
switch (_that) {
case _TechnicalSignal() when $default != null:
return $default(_that.name,_that.status,_that.value,_that.label);case _:
  return null;

}
}

}

/// @nodoc


class _TechnicalSignal with DiagnosticableTreeMixin implements TechnicalSignal {
  const _TechnicalSignal({required this.name, required this.status, required this.value, required this.label});
  

@override final  String name;
@override final  SignalStatus status;
/// Already formatted by the server: `₹2,410.50`, `1.4x avg`.
@override final  String value;
@override final  String label;

/// Create a copy of TechnicalSignal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TechnicalSignalCopyWith<_TechnicalSignal> get copyWith => __$TechnicalSignalCopyWithImpl<_TechnicalSignal>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
    ..add(DiagnosticsProperty('type', 'TechnicalSignal'))
    ..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('status', status))..add(DiagnosticsProperty('value', value))..add(DiagnosticsProperty('label', label));
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TechnicalSignal&&(identical(other.name, name) || other.name == name)&&(identical(other.status, status) || other.status == status)&&(identical(other.value, value) || other.value == value)&&(identical(other.label, label) || other.label == label));
}


@override
int get hashCode {
    return Object.hash(runtimeType,name,status,value,label);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
    return 'TechnicalSignal(name: $name, status: $status, value: $value, label: $label)';
}


}

/// @nodoc
abstract mixin class _$TechnicalSignalCopyWith<$Res> implements $TechnicalSignalCopyWith<$Res> {
  factory _$TechnicalSignalCopyWith(_TechnicalSignal value, $Res Function(_TechnicalSignal) _then) = __$TechnicalSignalCopyWithImpl;
@override @useResult
$Res call({
 String name, SignalStatus status, String value, String label
});




}
/// @nodoc
class __$TechnicalSignalCopyWithImpl<$Res>
    implements _$TechnicalSignalCopyWith<$Res> {
  __$TechnicalSignalCopyWithImpl(this._self, this._then);

  final _TechnicalSignal _self;
  final $Res Function(_TechnicalSignal) _then;

/// Create a copy of TechnicalSignal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? status = null,Object? value = null,Object? label = null,}) {
  return _then(_TechnicalSignal(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SignalStatus,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$PivotLevels implements DiagnosticableTreeMixin {

 double? get pivot; double? get r1; double? get r2; double? get s1; double? get s2;
/// Create a copy of PivotLevels
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PivotLevelsCopyWith<PivotLevels> get copyWith => _$PivotLevelsCopyWithImpl<PivotLevels>(this as PivotLevels, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  final _this = this as PivotLevels;
  properties
    ..add(DiagnosticsProperty('type', 'PivotLevels'))
    ..add(DiagnosticsProperty('pivot', _this.pivot))..add(DiagnosticsProperty('r1', _this.r1))..add(DiagnosticsProperty('r2', _this.r2))..add(DiagnosticsProperty('s1', _this.s1))..add(DiagnosticsProperty('s2', _this.s2));
}

@override
bool operator ==(Object other) {
  final _this = this as PivotLevels;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PivotLevels&&(identical(other.pivot, _this.pivot) || other.pivot == _this.pivot)&&(identical(other.r1, _this.r1) || other.r1 == _this.r1)&&(identical(other.r2, _this.r2) || other.r2 == _this.r2)&&(identical(other.s1, _this.s1) || other.s1 == _this.s1)&&(identical(other.s2, _this.s2) || other.s2 == _this.s2));
}


@override
int get hashCode {
  final _this = this as PivotLevels;
  return Object.hash(runtimeType,_this.pivot,_this.r1,_this.r2,_this.s1,_this.s2);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  final _this = this as PivotLevels;
  return 'PivotLevels(pivot: ${_this.pivot}, r1: ${_this.r1}, r2: ${_this.r2}, s1: ${_this.s1}, s2: ${_this.s2})';
}


}

/// @nodoc
abstract mixin class $PivotLevelsCopyWith<$Res>  {
  factory $PivotLevelsCopyWith(PivotLevels value, $Res Function(PivotLevels) _then) = _$PivotLevelsCopyWithImpl;
@useResult
$Res call({
 double? pivot, double? r1, double? r2, double? s1, double? s2
});




}
/// @nodoc
class _$PivotLevelsCopyWithImpl<$Res>
    implements $PivotLevelsCopyWith<$Res> {
  _$PivotLevelsCopyWithImpl(this._self, this._then);

  final PivotLevels _self;
  final $Res Function(PivotLevels) _then;

/// Create a copy of PivotLevels
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pivot = freezed,Object? r1 = freezed,Object? r2 = freezed,Object? s1 = freezed,Object? s2 = freezed,}) {
  return _then(PivotLevels(
pivot: freezed == pivot ? _self.pivot : pivot // ignore: cast_nullable_to_non_nullable
as double?,r1: freezed == r1 ? _self.r1 : r1 // ignore: cast_nullable_to_non_nullable
as double?,r2: freezed == r2 ? _self.r2 : r2 // ignore: cast_nullable_to_non_nullable
as double?,s1: freezed == s1 ? _self.s1 : s1 // ignore: cast_nullable_to_non_nullable
as double?,s2: freezed == s2 ? _self.s2 : s2 // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [PivotLevels].
extension PivotLevelsPatterns on PivotLevels {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PivotLevels value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PivotLevels() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PivotLevels value)  $default,){
final _that = this;
switch (_that) {
case _PivotLevels():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PivotLevels value)?  $default,){
final _that = this;
switch (_that) {
case _PivotLevels() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? pivot,  double? r1,  double? r2,  double? s1,  double? s2)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PivotLevels() when $default != null:
return $default(_that.pivot,_that.r1,_that.r2,_that.s1,_that.s2);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? pivot,  double? r1,  double? r2,  double? s1,  double? s2)  $default,) {final _that = this;
switch (_that) {
case _PivotLevels():
return $default(_that.pivot,_that.r1,_that.r2,_that.s1,_that.s2);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? pivot,  double? r1,  double? r2,  double? s1,  double? s2)?  $default,) {final _that = this;
switch (_that) {
case _PivotLevels() when $default != null:
return $default(_that.pivot,_that.r1,_that.r2,_that.s1,_that.s2);case _:
  return null;

}
}

}

/// @nodoc


class _PivotLevels extends PivotLevels with DiagnosticableTreeMixin {
  const _PivotLevels({this.pivot, this.r1, this.r2, this.s1, this.s2}): super._();
  

@override final  double? pivot;
@override final  double? r1;
@override final  double? r2;
@override final  double? s1;
@override final  double? s2;

/// Create a copy of PivotLevels
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PivotLevelsCopyWith<_PivotLevels> get copyWith => __$PivotLevelsCopyWithImpl<_PivotLevels>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
    ..add(DiagnosticsProperty('type', 'PivotLevels'))
    ..add(DiagnosticsProperty('pivot', pivot))..add(DiagnosticsProperty('r1', r1))..add(DiagnosticsProperty('r2', r2))..add(DiagnosticsProperty('s1', s1))..add(DiagnosticsProperty('s2', s2));
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PivotLevels&&(identical(other.pivot, pivot) || other.pivot == pivot)&&(identical(other.r1, r1) || other.r1 == r1)&&(identical(other.r2, r2) || other.r2 == r2)&&(identical(other.s1, s1) || other.s1 == s1)&&(identical(other.s2, s2) || other.s2 == s2));
}


@override
int get hashCode {
    return Object.hash(runtimeType,pivot,r1,r2,s1,s2);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
    return 'PivotLevels(pivot: $pivot, r1: $r1, r2: $r2, s1: $s1, s2: $s2)';
}


}

/// @nodoc
abstract mixin class _$PivotLevelsCopyWith<$Res> implements $PivotLevelsCopyWith<$Res> {
  factory _$PivotLevelsCopyWith(_PivotLevels value, $Res Function(_PivotLevels) _then) = __$PivotLevelsCopyWithImpl;
@override @useResult
$Res call({
 double? pivot, double? r1, double? r2, double? s1, double? s2
});




}
/// @nodoc
class __$PivotLevelsCopyWithImpl<$Res>
    implements _$PivotLevelsCopyWith<$Res> {
  __$PivotLevelsCopyWithImpl(this._self, this._then);

  final _PivotLevels _self;
  final $Res Function(_PivotLevels) _then;

/// Create a copy of PivotLevels
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pivot = freezed,Object? r1 = freezed,Object? r2 = freezed,Object? s1 = freezed,Object? s2 = freezed,}) {
  return _then(_PivotLevels(
pivot: freezed == pivot ? _self.pivot : pivot // ignore: cast_nullable_to_non_nullable
as double?,r1: freezed == r1 ? _self.r1 : r1 // ignore: cast_nullable_to_non_nullable
as double?,r2: freezed == r2 ? _self.r2 : r2 // ignore: cast_nullable_to_non_nullable
as double?,s1: freezed == s1 ? _self.s1 : s1 // ignore: cast_nullable_to_non_nullable
as double?,s2: freezed == s2 ? _self.s2 : s2 // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

/// @nodoc
mixin _$Technicals implements DiagnosticableTreeMixin {

 String get symbol;/// The last close, which during market hours is today's live bar.
 double get currentPrice; TechnicalIndicators get indicators; List<TechnicalSignal> get signals; PivotLevels get levels; PriceHistory get history;
/// Create a copy of Technicals
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TechnicalsCopyWith<Technicals> get copyWith => _$TechnicalsCopyWithImpl<Technicals>(this as Technicals, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  final _this = this as Technicals;
  properties
    ..add(DiagnosticsProperty('type', 'Technicals'))
    ..add(DiagnosticsProperty('symbol', _this.symbol))..add(DiagnosticsProperty('currentPrice', _this.currentPrice))..add(DiagnosticsProperty('indicators', _this.indicators))..add(DiagnosticsProperty('signals', _this.signals))..add(DiagnosticsProperty('levels', _this.levels))..add(DiagnosticsProperty('history', _this.history));
}

@override
bool operator ==(Object other) {
  final _this = this as Technicals;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Technicals&&(identical(other.symbol, _this.symbol) || other.symbol == _this.symbol)&&(identical(other.currentPrice, _this.currentPrice) || other.currentPrice == _this.currentPrice)&&(identical(other.indicators, _this.indicators) || other.indicators == _this.indicators)&&const DeepCollectionEquality().equals(other.signals, _this.signals)&&(identical(other.levels, _this.levels) || other.levels == _this.levels)&&(identical(other.history, _this.history) || other.history == _this.history));
}


@override
int get hashCode {
  final _this = this as Technicals;
  return Object.hash(runtimeType,_this.symbol,_this.currentPrice,_this.indicators,const DeepCollectionEquality().hash(_this.signals),_this.levels,_this.history);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  final _this = this as Technicals;
  return 'Technicals(symbol: ${_this.symbol}, currentPrice: ${_this.currentPrice}, indicators: ${_this.indicators}, signals: ${_this.signals}, levels: ${_this.levels}, history: ${_this.history})';
}


}

/// @nodoc
abstract mixin class $TechnicalsCopyWith<$Res>  {
  factory $TechnicalsCopyWith(Technicals value, $Res Function(Technicals) _then) = _$TechnicalsCopyWithImpl;
@useResult
$Res call({
 String symbol, double currentPrice, TechnicalIndicators indicators, List<TechnicalSignal> signals, PivotLevels levels, PriceHistory history
});


$TechnicalIndicatorsCopyWith<$Res> get indicators;$PivotLevelsCopyWith<$Res> get levels;

}
/// @nodoc
class _$TechnicalsCopyWithImpl<$Res>
    implements $TechnicalsCopyWith<$Res> {
  _$TechnicalsCopyWithImpl(this._self, this._then);

  final Technicals _self;
  final $Res Function(Technicals) _then;

/// Create a copy of Technicals
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? currentPrice = null,Object? indicators = null,Object? signals = null,Object? levels = null,Object? history = null,}) {
  return _then(Technicals(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,currentPrice: null == currentPrice ? _self.currentPrice : currentPrice // ignore: cast_nullable_to_non_nullable
as double,indicators: null == indicators ? _self.indicators : indicators // ignore: cast_nullable_to_non_nullable
as TechnicalIndicators,signals: null == signals ? _self.signals : signals // ignore: cast_nullable_to_non_nullable
as List<TechnicalSignal>,levels: null == levels ? _self.levels : levels // ignore: cast_nullable_to_non_nullable
as PivotLevels,history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as PriceHistory,
  ));
}
/// Create a copy of Technicals
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TechnicalIndicatorsCopyWith<$Res> get indicators {
  
  return $TechnicalIndicatorsCopyWith<$Res>(_self.indicators, (value) {
    return _then(_self.copyWith(indicators: value));
  });
}/// Create a copy of Technicals
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PivotLevelsCopyWith<$Res> get levels {
  
  return $PivotLevelsCopyWith<$Res>(_self.levels, (value) {
    return _then(_self.copyWith(levels: value));
  });
}
}


/// Adds pattern-matching-related methods to [Technicals].
extension TechnicalsPatterns on Technicals {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Technicals value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Technicals() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Technicals value)  $default,){
final _that = this;
switch (_that) {
case _Technicals():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Technicals value)?  $default,){
final _that = this;
switch (_that) {
case _Technicals() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  double currentPrice,  TechnicalIndicators indicators,  List<TechnicalSignal> signals,  PivotLevels levels,  PriceHistory history)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Technicals() when $default != null:
return $default(_that.symbol,_that.currentPrice,_that.indicators,_that.signals,_that.levels,_that.history);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  double currentPrice,  TechnicalIndicators indicators,  List<TechnicalSignal> signals,  PivotLevels levels,  PriceHistory history)  $default,) {final _that = this;
switch (_that) {
case _Technicals():
return $default(_that.symbol,_that.currentPrice,_that.indicators,_that.signals,_that.levels,_that.history);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  double currentPrice,  TechnicalIndicators indicators,  List<TechnicalSignal> signals,  PivotLevels levels,  PriceHistory history)?  $default,) {final _that = this;
switch (_that) {
case _Technicals() when $default != null:
return $default(_that.symbol,_that.currentPrice,_that.indicators,_that.signals,_that.levels,_that.history);case _:
  return null;

}
}

}

/// @nodoc


class _Technicals with DiagnosticableTreeMixin implements Technicals {
  const _Technicals({required this.symbol, required this.currentPrice, required this.indicators, required  List<TechnicalSignal> signals, required this.levels, required this.history}): _signals = signals;
  

@override final  String symbol;
/// The last close, which during market hours is today's live bar.
@override final  double currentPrice;
@override final  TechnicalIndicators indicators;
 final  List<TechnicalSignal> _signals;
@override List<TechnicalSignal> get signals {
  if (_signals is EqualUnmodifiableListView) return _signals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_signals);
}

@override final  PivotLevels levels;
@override final  PriceHistory history;

/// Create a copy of Technicals
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TechnicalsCopyWith<_Technicals> get copyWith => __$TechnicalsCopyWithImpl<_Technicals>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
    ..add(DiagnosticsProperty('type', 'Technicals'))
    ..add(DiagnosticsProperty('symbol', symbol))..add(DiagnosticsProperty('currentPrice', currentPrice))..add(DiagnosticsProperty('indicators', indicators))..add(DiagnosticsProperty('signals', signals))..add(DiagnosticsProperty('levels', levels))..add(DiagnosticsProperty('history', history));
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Technicals&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.currentPrice, currentPrice) || other.currentPrice == currentPrice)&&(identical(other.indicators, indicators) || other.indicators == indicators)&&const DeepCollectionEquality().equals(other.signals, _signals)&&(identical(other.levels, levels) || other.levels == levels)&&(identical(other.history, history) || other.history == history));
}


@override
int get hashCode {
    return Object.hash(runtimeType,symbol,currentPrice,indicators,const DeepCollectionEquality().hash(_signals),levels,history);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
    return 'Technicals(symbol: $symbol, currentPrice: $currentPrice, indicators: $indicators, signals: $signals, levels: $levels, history: $history)';
}


}

/// @nodoc
abstract mixin class _$TechnicalsCopyWith<$Res> implements $TechnicalsCopyWith<$Res> {
  factory _$TechnicalsCopyWith(_Technicals value, $Res Function(_Technicals) _then) = __$TechnicalsCopyWithImpl;
@override @useResult
$Res call({
 String symbol, double currentPrice, TechnicalIndicators indicators, List<TechnicalSignal> signals, PivotLevels levels, PriceHistory history
});


@override $TechnicalIndicatorsCopyWith<$Res> get indicators;@override $PivotLevelsCopyWith<$Res> get levels;

}
/// @nodoc
class __$TechnicalsCopyWithImpl<$Res>
    implements _$TechnicalsCopyWith<$Res> {
  __$TechnicalsCopyWithImpl(this._self, this._then);

  final _Technicals _self;
  final $Res Function(_Technicals) _then;

/// Create a copy of Technicals
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? currentPrice = null,Object? indicators = null,Object? signals = null,Object? levels = null,Object? history = null,}) {
  return _then(_Technicals(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,currentPrice: null == currentPrice ? _self.currentPrice : currentPrice // ignore: cast_nullable_to_non_nullable
as double,indicators: null == indicators ? _self.indicators : indicators // ignore: cast_nullable_to_non_nullable
as TechnicalIndicators,signals: null == signals ? _self._signals : signals // ignore: cast_nullable_to_non_nullable
as List<TechnicalSignal>,levels: null == levels ? _self.levels : levels // ignore: cast_nullable_to_non_nullable
as PivotLevels,history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as PriceHistory,
  ));
}

/// Create a copy of Technicals
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TechnicalIndicatorsCopyWith<$Res> get indicators {
  
  return $TechnicalIndicatorsCopyWith<$Res>(_self.indicators, (value) {
    return _then(_self.copyWith(indicators: value));
  });
}/// Create a copy of Technicals
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PivotLevelsCopyWith<$Res> get levels {
  
  return $PivotLevelsCopyWith<$Res>(_self.levels, (value) {
    return _then(_self.copyWith(levels: value));
  });
}
}

// dart format on
