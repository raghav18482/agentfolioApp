// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fundamentals.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Valuation {

 double? get peRatio; double? get forwardPe; double? get pbRatio; double? get evEbitda; double? get pegRatio;/// Percent, e.g. 1.2 for 1.2%.
 double? get dividendYield; double? get trailingEps;
/// Create a copy of Valuation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ValuationCopyWith<Valuation> get copyWith => _$ValuationCopyWithImpl<Valuation>(this as Valuation, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Valuation;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Valuation&&(identical(other.peRatio, _this.peRatio) || other.peRatio == _this.peRatio)&&(identical(other.forwardPe, _this.forwardPe) || other.forwardPe == _this.forwardPe)&&(identical(other.pbRatio, _this.pbRatio) || other.pbRatio == _this.pbRatio)&&(identical(other.evEbitda, _this.evEbitda) || other.evEbitda == _this.evEbitda)&&(identical(other.pegRatio, _this.pegRatio) || other.pegRatio == _this.pegRatio)&&(identical(other.dividendYield, _this.dividendYield) || other.dividendYield == _this.dividendYield)&&(identical(other.trailingEps, _this.trailingEps) || other.trailingEps == _this.trailingEps));
}


@override
int get hashCode {
  final _this = this as Valuation;
  return Object.hash(runtimeType,_this.peRatio,_this.forwardPe,_this.pbRatio,_this.evEbitda,_this.pegRatio,_this.dividendYield,_this.trailingEps);
}

@override
String toString() {
  final _this = this as Valuation;
  return 'Valuation(peRatio: ${_this.peRatio}, forwardPe: ${_this.forwardPe}, pbRatio: ${_this.pbRatio}, evEbitda: ${_this.evEbitda}, pegRatio: ${_this.pegRatio}, dividendYield: ${_this.dividendYield}, trailingEps: ${_this.trailingEps})';
}


}

/// @nodoc
abstract mixin class $ValuationCopyWith<$Res>  {
  factory $ValuationCopyWith(Valuation value, $Res Function(Valuation) _then) = _$ValuationCopyWithImpl;
@useResult
$Res call({
 double? peRatio, double? forwardPe, double? pbRatio, double? evEbitda, double? pegRatio, double? dividendYield, double? trailingEps
});




}
/// @nodoc
class _$ValuationCopyWithImpl<$Res>
    implements $ValuationCopyWith<$Res> {
  _$ValuationCopyWithImpl(this._self, this._then);

  final Valuation _self;
  final $Res Function(Valuation) _then;

/// Create a copy of Valuation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? peRatio = freezed,Object? forwardPe = freezed,Object? pbRatio = freezed,Object? evEbitda = freezed,Object? pegRatio = freezed,Object? dividendYield = freezed,Object? trailingEps = freezed,}) {
  return _then(Valuation(
peRatio: freezed == peRatio ? _self.peRatio : peRatio // ignore: cast_nullable_to_non_nullable
as double?,forwardPe: freezed == forwardPe ? _self.forwardPe : forwardPe // ignore: cast_nullable_to_non_nullable
as double?,pbRatio: freezed == pbRatio ? _self.pbRatio : pbRatio // ignore: cast_nullable_to_non_nullable
as double?,evEbitda: freezed == evEbitda ? _self.evEbitda : evEbitda // ignore: cast_nullable_to_non_nullable
as double?,pegRatio: freezed == pegRatio ? _self.pegRatio : pegRatio // ignore: cast_nullable_to_non_nullable
as double?,dividendYield: freezed == dividendYield ? _self.dividendYield : dividendYield // ignore: cast_nullable_to_non_nullable
as double?,trailingEps: freezed == trailingEps ? _self.trailingEps : trailingEps // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [Valuation].
extension ValuationPatterns on Valuation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Valuation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Valuation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Valuation value)  $default,){
final _that = this;
switch (_that) {
case _Valuation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Valuation value)?  $default,){
final _that = this;
switch (_that) {
case _Valuation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? peRatio,  double? forwardPe,  double? pbRatio,  double? evEbitda,  double? pegRatio,  double? dividendYield,  double? trailingEps)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Valuation() when $default != null:
return $default(_that.peRatio,_that.forwardPe,_that.pbRatio,_that.evEbitda,_that.pegRatio,_that.dividendYield,_that.trailingEps);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? peRatio,  double? forwardPe,  double? pbRatio,  double? evEbitda,  double? pegRatio,  double? dividendYield,  double? trailingEps)  $default,) {final _that = this;
switch (_that) {
case _Valuation():
return $default(_that.peRatio,_that.forwardPe,_that.pbRatio,_that.evEbitda,_that.pegRatio,_that.dividendYield,_that.trailingEps);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? peRatio,  double? forwardPe,  double? pbRatio,  double? evEbitda,  double? pegRatio,  double? dividendYield,  double? trailingEps)?  $default,) {final _that = this;
switch (_that) {
case _Valuation() when $default != null:
return $default(_that.peRatio,_that.forwardPe,_that.pbRatio,_that.evEbitda,_that.pegRatio,_that.dividendYield,_that.trailingEps);case _:
  return null;

}
}

}

/// @nodoc


class _Valuation implements Valuation {
  const _Valuation({this.peRatio, this.forwardPe, this.pbRatio, this.evEbitda, this.pegRatio, this.dividendYield, this.trailingEps});
  

@override final  double? peRatio;
@override final  double? forwardPe;
@override final  double? pbRatio;
@override final  double? evEbitda;
@override final  double? pegRatio;
/// Percent, e.g. 1.2 for 1.2%.
@override final  double? dividendYield;
@override final  double? trailingEps;

/// Create a copy of Valuation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ValuationCopyWith<_Valuation> get copyWith => __$ValuationCopyWithImpl<_Valuation>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Valuation&&(identical(other.peRatio, peRatio) || other.peRatio == peRatio)&&(identical(other.forwardPe, forwardPe) || other.forwardPe == forwardPe)&&(identical(other.pbRatio, pbRatio) || other.pbRatio == pbRatio)&&(identical(other.evEbitda, evEbitda) || other.evEbitda == evEbitda)&&(identical(other.pegRatio, pegRatio) || other.pegRatio == pegRatio)&&(identical(other.dividendYield, dividendYield) || other.dividendYield == dividendYield)&&(identical(other.trailingEps, trailingEps) || other.trailingEps == trailingEps));
}


@override
int get hashCode {
    return Object.hash(runtimeType,peRatio,forwardPe,pbRatio,evEbitda,pegRatio,dividendYield,trailingEps);
}

@override
String toString() {
    return 'Valuation(peRatio: $peRatio, forwardPe: $forwardPe, pbRatio: $pbRatio, evEbitda: $evEbitda, pegRatio: $pegRatio, dividendYield: $dividendYield, trailingEps: $trailingEps)';
}


}

/// @nodoc
abstract mixin class _$ValuationCopyWith<$Res> implements $ValuationCopyWith<$Res> {
  factory _$ValuationCopyWith(_Valuation value, $Res Function(_Valuation) _then) = __$ValuationCopyWithImpl;
@override @useResult
$Res call({
 double? peRatio, double? forwardPe, double? pbRatio, double? evEbitda, double? pegRatio, double? dividendYield, double? trailingEps
});




}
/// @nodoc
class __$ValuationCopyWithImpl<$Res>
    implements _$ValuationCopyWith<$Res> {
  __$ValuationCopyWithImpl(this._self, this._then);

  final _Valuation _self;
  final $Res Function(_Valuation) _then;

/// Create a copy of Valuation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? peRatio = freezed,Object? forwardPe = freezed,Object? pbRatio = freezed,Object? evEbitda = freezed,Object? pegRatio = freezed,Object? dividendYield = freezed,Object? trailingEps = freezed,}) {
  return _then(_Valuation(
peRatio: freezed == peRatio ? _self.peRatio : peRatio // ignore: cast_nullable_to_non_nullable
as double?,forwardPe: freezed == forwardPe ? _self.forwardPe : forwardPe // ignore: cast_nullable_to_non_nullable
as double?,pbRatio: freezed == pbRatio ? _self.pbRatio : pbRatio // ignore: cast_nullable_to_non_nullable
as double?,evEbitda: freezed == evEbitda ? _self.evEbitda : evEbitda // ignore: cast_nullable_to_non_nullable
as double?,pegRatio: freezed == pegRatio ? _self.pegRatio : pegRatio // ignore: cast_nullable_to_non_nullable
as double?,dividendYield: freezed == dividendYield ? _self.dividendYield : dividendYield // ignore: cast_nullable_to_non_nullable
as double?,trailingEps: freezed == trailingEps ? _self.trailingEps : trailingEps // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

/// @nodoc
mixin _$FinancialHealth {

 double? get roe; double? get roce; double? get debtToEquity;/// Rupees.
 double? get freeCashFlow; double? get profitMargin; double? get operatingMargin; double? get revenueGrowth; double? get earningsGrowth; double? get promoterHolding;
/// Create a copy of FinancialHealth
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FinancialHealthCopyWith<FinancialHealth> get copyWith => _$FinancialHealthCopyWithImpl<FinancialHealth>(this as FinancialHealth, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as FinancialHealth;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FinancialHealth&&(identical(other.roe, _this.roe) || other.roe == _this.roe)&&(identical(other.roce, _this.roce) || other.roce == _this.roce)&&(identical(other.debtToEquity, _this.debtToEquity) || other.debtToEquity == _this.debtToEquity)&&(identical(other.freeCashFlow, _this.freeCashFlow) || other.freeCashFlow == _this.freeCashFlow)&&(identical(other.profitMargin, _this.profitMargin) || other.profitMargin == _this.profitMargin)&&(identical(other.operatingMargin, _this.operatingMargin) || other.operatingMargin == _this.operatingMargin)&&(identical(other.revenueGrowth, _this.revenueGrowth) || other.revenueGrowth == _this.revenueGrowth)&&(identical(other.earningsGrowth, _this.earningsGrowth) || other.earningsGrowth == _this.earningsGrowth)&&(identical(other.promoterHolding, _this.promoterHolding) || other.promoterHolding == _this.promoterHolding));
}


@override
int get hashCode {
  final _this = this as FinancialHealth;
  return Object.hash(runtimeType,_this.roe,_this.roce,_this.debtToEquity,_this.freeCashFlow,_this.profitMargin,_this.operatingMargin,_this.revenueGrowth,_this.earningsGrowth,_this.promoterHolding);
}

@override
String toString() {
  final _this = this as FinancialHealth;
  return 'FinancialHealth(roe: ${_this.roe}, roce: ${_this.roce}, debtToEquity: ${_this.debtToEquity}, freeCashFlow: ${_this.freeCashFlow}, profitMargin: ${_this.profitMargin}, operatingMargin: ${_this.operatingMargin}, revenueGrowth: ${_this.revenueGrowth}, earningsGrowth: ${_this.earningsGrowth}, promoterHolding: ${_this.promoterHolding})';
}


}

/// @nodoc
abstract mixin class $FinancialHealthCopyWith<$Res>  {
  factory $FinancialHealthCopyWith(FinancialHealth value, $Res Function(FinancialHealth) _then) = _$FinancialHealthCopyWithImpl;
@useResult
$Res call({
 double? roe, double? roce, double? debtToEquity, double? freeCashFlow, double? profitMargin, double? operatingMargin, double? revenueGrowth, double? earningsGrowth, double? promoterHolding
});




}
/// @nodoc
class _$FinancialHealthCopyWithImpl<$Res>
    implements $FinancialHealthCopyWith<$Res> {
  _$FinancialHealthCopyWithImpl(this._self, this._then);

  final FinancialHealth _self;
  final $Res Function(FinancialHealth) _then;

/// Create a copy of FinancialHealth
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? roe = freezed,Object? roce = freezed,Object? debtToEquity = freezed,Object? freeCashFlow = freezed,Object? profitMargin = freezed,Object? operatingMargin = freezed,Object? revenueGrowth = freezed,Object? earningsGrowth = freezed,Object? promoterHolding = freezed,}) {
  return _then(FinancialHealth(
roe: freezed == roe ? _self.roe : roe // ignore: cast_nullable_to_non_nullable
as double?,roce: freezed == roce ? _self.roce : roce // ignore: cast_nullable_to_non_nullable
as double?,debtToEquity: freezed == debtToEquity ? _self.debtToEquity : debtToEquity // ignore: cast_nullable_to_non_nullable
as double?,freeCashFlow: freezed == freeCashFlow ? _self.freeCashFlow : freeCashFlow // ignore: cast_nullable_to_non_nullable
as double?,profitMargin: freezed == profitMargin ? _self.profitMargin : profitMargin // ignore: cast_nullable_to_non_nullable
as double?,operatingMargin: freezed == operatingMargin ? _self.operatingMargin : operatingMargin // ignore: cast_nullable_to_non_nullable
as double?,revenueGrowth: freezed == revenueGrowth ? _self.revenueGrowth : revenueGrowth // ignore: cast_nullable_to_non_nullable
as double?,earningsGrowth: freezed == earningsGrowth ? _self.earningsGrowth : earningsGrowth // ignore: cast_nullable_to_non_nullable
as double?,promoterHolding: freezed == promoterHolding ? _self.promoterHolding : promoterHolding // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [FinancialHealth].
extension FinancialHealthPatterns on FinancialHealth {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FinancialHealth value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FinancialHealth() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FinancialHealth value)  $default,){
final _that = this;
switch (_that) {
case _FinancialHealth():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FinancialHealth value)?  $default,){
final _that = this;
switch (_that) {
case _FinancialHealth() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? roe,  double? roce,  double? debtToEquity,  double? freeCashFlow,  double? profitMargin,  double? operatingMargin,  double? revenueGrowth,  double? earningsGrowth,  double? promoterHolding)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FinancialHealth() when $default != null:
return $default(_that.roe,_that.roce,_that.debtToEquity,_that.freeCashFlow,_that.profitMargin,_that.operatingMargin,_that.revenueGrowth,_that.earningsGrowth,_that.promoterHolding);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? roe,  double? roce,  double? debtToEquity,  double? freeCashFlow,  double? profitMargin,  double? operatingMargin,  double? revenueGrowth,  double? earningsGrowth,  double? promoterHolding)  $default,) {final _that = this;
switch (_that) {
case _FinancialHealth():
return $default(_that.roe,_that.roce,_that.debtToEquity,_that.freeCashFlow,_that.profitMargin,_that.operatingMargin,_that.revenueGrowth,_that.earningsGrowth,_that.promoterHolding);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? roe,  double? roce,  double? debtToEquity,  double? freeCashFlow,  double? profitMargin,  double? operatingMargin,  double? revenueGrowth,  double? earningsGrowth,  double? promoterHolding)?  $default,) {final _that = this;
switch (_that) {
case _FinancialHealth() when $default != null:
return $default(_that.roe,_that.roce,_that.debtToEquity,_that.freeCashFlow,_that.profitMargin,_that.operatingMargin,_that.revenueGrowth,_that.earningsGrowth,_that.promoterHolding);case _:
  return null;

}
}

}

/// @nodoc


class _FinancialHealth implements FinancialHealth {
  const _FinancialHealth({this.roe, this.roce, this.debtToEquity, this.freeCashFlow, this.profitMargin, this.operatingMargin, this.revenueGrowth, this.earningsGrowth, this.promoterHolding});
  

@override final  double? roe;
@override final  double? roce;
@override final  double? debtToEquity;
/// Rupees.
@override final  double? freeCashFlow;
@override final  double? profitMargin;
@override final  double? operatingMargin;
@override final  double? revenueGrowth;
@override final  double? earningsGrowth;
@override final  double? promoterHolding;

/// Create a copy of FinancialHealth
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FinancialHealthCopyWith<_FinancialHealth> get copyWith => __$FinancialHealthCopyWithImpl<_FinancialHealth>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FinancialHealth&&(identical(other.roe, roe) || other.roe == roe)&&(identical(other.roce, roce) || other.roce == roce)&&(identical(other.debtToEquity, debtToEquity) || other.debtToEquity == debtToEquity)&&(identical(other.freeCashFlow, freeCashFlow) || other.freeCashFlow == freeCashFlow)&&(identical(other.profitMargin, profitMargin) || other.profitMargin == profitMargin)&&(identical(other.operatingMargin, operatingMargin) || other.operatingMargin == operatingMargin)&&(identical(other.revenueGrowth, revenueGrowth) || other.revenueGrowth == revenueGrowth)&&(identical(other.earningsGrowth, earningsGrowth) || other.earningsGrowth == earningsGrowth)&&(identical(other.promoterHolding, promoterHolding) || other.promoterHolding == promoterHolding));
}


@override
int get hashCode {
    return Object.hash(runtimeType,roe,roce,debtToEquity,freeCashFlow,profitMargin,operatingMargin,revenueGrowth,earningsGrowth,promoterHolding);
}

@override
String toString() {
    return 'FinancialHealth(roe: $roe, roce: $roce, debtToEquity: $debtToEquity, freeCashFlow: $freeCashFlow, profitMargin: $profitMargin, operatingMargin: $operatingMargin, revenueGrowth: $revenueGrowth, earningsGrowth: $earningsGrowth, promoterHolding: $promoterHolding)';
}


}

/// @nodoc
abstract mixin class _$FinancialHealthCopyWith<$Res> implements $FinancialHealthCopyWith<$Res> {
  factory _$FinancialHealthCopyWith(_FinancialHealth value, $Res Function(_FinancialHealth) _then) = __$FinancialHealthCopyWithImpl;
@override @useResult
$Res call({
 double? roe, double? roce, double? debtToEquity, double? freeCashFlow, double? profitMargin, double? operatingMargin, double? revenueGrowth, double? earningsGrowth, double? promoterHolding
});




}
/// @nodoc
class __$FinancialHealthCopyWithImpl<$Res>
    implements _$FinancialHealthCopyWith<$Res> {
  __$FinancialHealthCopyWithImpl(this._self, this._then);

  final _FinancialHealth _self;
  final $Res Function(_FinancialHealth) _then;

/// Create a copy of FinancialHealth
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? roe = freezed,Object? roce = freezed,Object? debtToEquity = freezed,Object? freeCashFlow = freezed,Object? profitMargin = freezed,Object? operatingMargin = freezed,Object? revenueGrowth = freezed,Object? earningsGrowth = freezed,Object? promoterHolding = freezed,}) {
  return _then(_FinancialHealth(
roe: freezed == roe ? _self.roe : roe // ignore: cast_nullable_to_non_nullable
as double?,roce: freezed == roce ? _self.roce : roce // ignore: cast_nullable_to_non_nullable
as double?,debtToEquity: freezed == debtToEquity ? _self.debtToEquity : debtToEquity // ignore: cast_nullable_to_non_nullable
as double?,freeCashFlow: freezed == freeCashFlow ? _self.freeCashFlow : freeCashFlow // ignore: cast_nullable_to_non_nullable
as double?,profitMargin: freezed == profitMargin ? _self.profitMargin : profitMargin // ignore: cast_nullable_to_non_nullable
as double?,operatingMargin: freezed == operatingMargin ? _self.operatingMargin : operatingMargin // ignore: cast_nullable_to_non_nullable
as double?,revenueGrowth: freezed == revenueGrowth ? _self.revenueGrowth : revenueGrowth // ignore: cast_nullable_to_non_nullable
as double?,earningsGrowth: freezed == earningsGrowth ? _self.earningsGrowth : earningsGrowth // ignore: cast_nullable_to_non_nullable
as double?,promoterHolding: freezed == promoterHolding ? _self.promoterHolding : promoterHolding // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

/// @nodoc
mixin _$TrendPoint {

 String get year; double get value;
/// Create a copy of TrendPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrendPointCopyWith<TrendPoint> get copyWith => _$TrendPointCopyWithImpl<TrendPoint>(this as TrendPoint, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TrendPoint;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrendPoint&&(identical(other.year, _this.year) || other.year == _this.year)&&(identical(other.value, _this.value) || other.value == _this.value));
}


@override
int get hashCode {
  final _this = this as TrendPoint;
  return Object.hash(runtimeType,_this.year,_this.value);
}

@override
String toString() {
  final _this = this as TrendPoint;
  return 'TrendPoint(year: ${_this.year}, value: ${_this.value})';
}


}

/// @nodoc
abstract mixin class $TrendPointCopyWith<$Res>  {
  factory $TrendPointCopyWith(TrendPoint value, $Res Function(TrendPoint) _then) = _$TrendPointCopyWithImpl;
@useResult
$Res call({
 String year, double value
});




}
/// @nodoc
class _$TrendPointCopyWithImpl<$Res>
    implements $TrendPointCopyWith<$Res> {
  _$TrendPointCopyWithImpl(this._self, this._then);

  final TrendPoint _self;
  final $Res Function(TrendPoint) _then;

/// Create a copy of TrendPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? year = null,Object? value = null,}) {
  return _then(TrendPoint(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [TrendPoint].
extension TrendPointPatterns on TrendPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrendPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrendPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrendPoint value)  $default,){
final _that = this;
switch (_that) {
case _TrendPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrendPoint value)?  $default,){
final _that = this;
switch (_that) {
case _TrendPoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String year,  double value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrendPoint() when $default != null:
return $default(_that.year,_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String year,  double value)  $default,) {final _that = this;
switch (_that) {
case _TrendPoint():
return $default(_that.year,_that.value);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String year,  double value)?  $default,) {final _that = this;
switch (_that) {
case _TrendPoint() when $default != null:
return $default(_that.year,_that.value);case _:
  return null;

}
}

}

/// @nodoc


class _TrendPoint implements TrendPoint {
  const _TrendPoint({required this.year, required this.value});
  

@override final  String year;
@override final  double value;

/// Create a copy of TrendPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrendPointCopyWith<_TrendPoint> get copyWith => __$TrendPointCopyWithImpl<_TrendPoint>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrendPoint&&(identical(other.year, year) || other.year == year)&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode {
    return Object.hash(runtimeType,year,value);
}

@override
String toString() {
    return 'TrendPoint(year: $year, value: $value)';
}


}

/// @nodoc
abstract mixin class _$TrendPointCopyWith<$Res> implements $TrendPointCopyWith<$Res> {
  factory _$TrendPointCopyWith(_TrendPoint value, $Res Function(_TrendPoint) _then) = __$TrendPointCopyWithImpl;
@override @useResult
$Res call({
 String year, double value
});




}
/// @nodoc
class __$TrendPointCopyWithImpl<$Res>
    implements _$TrendPointCopyWith<$Res> {
  __$TrendPointCopyWithImpl(this._self, this._then);

  final _TrendPoint _self;
  final $Res Function(_TrendPoint) _then;

/// Create a copy of TrendPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? year = null,Object? value = null,}) {
  return _then(_TrendPoint(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$ScoreMetric {

 String get key; String get label;/// The value as the server formats it, e.g. `24.1x`.
 String get display; Verdict get verdict; String get note; double? get value;
/// Create a copy of ScoreMetric
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScoreMetricCopyWith<ScoreMetric> get copyWith => _$ScoreMetricCopyWithImpl<ScoreMetric>(this as ScoreMetric, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ScoreMetric;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScoreMetric&&(identical(other.key, _this.key) || other.key == _this.key)&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.display, _this.display) || other.display == _this.display)&&(identical(other.verdict, _this.verdict) || other.verdict == _this.verdict)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.value, _this.value) || other.value == _this.value));
}


@override
int get hashCode {
  final _this = this as ScoreMetric;
  return Object.hash(runtimeType,_this.key,_this.label,_this.display,_this.verdict,_this.note,_this.value);
}

@override
String toString() {
  final _this = this as ScoreMetric;
  return 'ScoreMetric(key: ${_this.key}, label: ${_this.label}, display: ${_this.display}, verdict: ${_this.verdict}, note: ${_this.note}, value: ${_this.value})';
}


}

/// @nodoc
abstract mixin class $ScoreMetricCopyWith<$Res>  {
  factory $ScoreMetricCopyWith(ScoreMetric value, $Res Function(ScoreMetric) _then) = _$ScoreMetricCopyWithImpl;
@useResult
$Res call({
 String key, String label, String display, Verdict verdict, String note, double? value
});




}
/// @nodoc
class _$ScoreMetricCopyWithImpl<$Res>
    implements $ScoreMetricCopyWith<$Res> {
  _$ScoreMetricCopyWithImpl(this._self, this._then);

  final ScoreMetric _self;
  final $Res Function(ScoreMetric) _then;

/// Create a copy of ScoreMetric
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? label = null,Object? display = null,Object? verdict = null,Object? note = null,Object? value = freezed,}) {
  return _then(ScoreMetric(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,display: null == display ? _self.display : display // ignore: cast_nullable_to_non_nullable
as String,verdict: null == verdict ? _self.verdict : verdict // ignore: cast_nullable_to_non_nullable
as Verdict,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [ScoreMetric].
extension ScoreMetricPatterns on ScoreMetric {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScoreMetric value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScoreMetric() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScoreMetric value)  $default,){
final _that = this;
switch (_that) {
case _ScoreMetric():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScoreMetric value)?  $default,){
final _that = this;
switch (_that) {
case _ScoreMetric() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  String label,  String display,  Verdict verdict,  String note,  double? value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScoreMetric() when $default != null:
return $default(_that.key,_that.label,_that.display,_that.verdict,_that.note,_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  String label,  String display,  Verdict verdict,  String note,  double? value)  $default,) {final _that = this;
switch (_that) {
case _ScoreMetric():
return $default(_that.key,_that.label,_that.display,_that.verdict,_that.note,_that.value);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  String label,  String display,  Verdict verdict,  String note,  double? value)?  $default,) {final _that = this;
switch (_that) {
case _ScoreMetric() when $default != null:
return $default(_that.key,_that.label,_that.display,_that.verdict,_that.note,_that.value);case _:
  return null;

}
}

}

/// @nodoc


class _ScoreMetric implements ScoreMetric {
  const _ScoreMetric({required this.key, required this.label, required this.display, required this.verdict, required this.note, this.value});
  

@override final  String key;
@override final  String label;
/// The value as the server formats it, e.g. `24.1x`.
@override final  String display;
@override final  Verdict verdict;
@override final  String note;
@override final  double? value;

/// Create a copy of ScoreMetric
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScoreMetricCopyWith<_ScoreMetric> get copyWith => __$ScoreMetricCopyWithImpl<_ScoreMetric>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScoreMetric&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label)&&(identical(other.display, display) || other.display == display)&&(identical(other.verdict, verdict) || other.verdict == verdict)&&(identical(other.note, note) || other.note == note)&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode {
    return Object.hash(runtimeType,key,label,display,verdict,note,value);
}

@override
String toString() {
    return 'ScoreMetric(key: $key, label: $label, display: $display, verdict: $verdict, note: $note, value: $value)';
}


}

/// @nodoc
abstract mixin class _$ScoreMetricCopyWith<$Res> implements $ScoreMetricCopyWith<$Res> {
  factory _$ScoreMetricCopyWith(_ScoreMetric value, $Res Function(_ScoreMetric) _then) = __$ScoreMetricCopyWithImpl;
@override @useResult
$Res call({
 String key, String label, String display, Verdict verdict, String note, double? value
});




}
/// @nodoc
class __$ScoreMetricCopyWithImpl<$Res>
    implements _$ScoreMetricCopyWith<$Res> {
  __$ScoreMetricCopyWithImpl(this._self, this._then);

  final _ScoreMetric _self;
  final $Res Function(_ScoreMetric) _then;

/// Create a copy of ScoreMetric
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? label = null,Object? display = null,Object? verdict = null,Object? note = null,Object? value = freezed,}) {
  return _then(_ScoreMetric(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,display: null == display ? _self.display : display // ignore: cast_nullable_to_non_nullable
as String,verdict: null == verdict ? _self.verdict : verdict // ignore: cast_nullable_to_non_nullable
as Verdict,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

/// @nodoc
mixin _$ScorePillar {

 String get key; String get label; String get tagline; double get max; List<ScoreMetric> get metrics;/// Null when nothing in the pillar could be measured for this stock.
 double? get score;
/// Create a copy of ScorePillar
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScorePillarCopyWith<ScorePillar> get copyWith => _$ScorePillarCopyWithImpl<ScorePillar>(this as ScorePillar, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ScorePillar;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScorePillar&&(identical(other.key, _this.key) || other.key == _this.key)&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.tagline, _this.tagline) || other.tagline == _this.tagline)&&(identical(other.max, _this.max) || other.max == _this.max)&&const DeepCollectionEquality().equals(other.metrics, _this.metrics)&&(identical(other.score, _this.score) || other.score == _this.score));
}


@override
int get hashCode {
  final _this = this as ScorePillar;
  return Object.hash(runtimeType,_this.key,_this.label,_this.tagline,_this.max,const DeepCollectionEquality().hash(_this.metrics),_this.score);
}

@override
String toString() {
  final _this = this as ScorePillar;
  return 'ScorePillar(key: ${_this.key}, label: ${_this.label}, tagline: ${_this.tagline}, max: ${_this.max}, metrics: ${_this.metrics}, score: ${_this.score})';
}


}

/// @nodoc
abstract mixin class $ScorePillarCopyWith<$Res>  {
  factory $ScorePillarCopyWith(ScorePillar value, $Res Function(ScorePillar) _then) = _$ScorePillarCopyWithImpl;
@useResult
$Res call({
 String key, String label, String tagline, double max, List<ScoreMetric> metrics, double? score
});




}
/// @nodoc
class _$ScorePillarCopyWithImpl<$Res>
    implements $ScorePillarCopyWith<$Res> {
  _$ScorePillarCopyWithImpl(this._self, this._then);

  final ScorePillar _self;
  final $Res Function(ScorePillar) _then;

/// Create a copy of ScorePillar
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? label = null,Object? tagline = null,Object? max = null,Object? metrics = null,Object? score = freezed,}) {
  return _then(ScorePillar(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,tagline: null == tagline ? _self.tagline : tagline // ignore: cast_nullable_to_non_nullable
as String,max: null == max ? _self.max : max // ignore: cast_nullable_to_non_nullable
as double,metrics: null == metrics ? _self.metrics : metrics // ignore: cast_nullable_to_non_nullable
as List<ScoreMetric>,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [ScorePillar].
extension ScorePillarPatterns on ScorePillar {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScorePillar value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScorePillar() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScorePillar value)  $default,){
final _that = this;
switch (_that) {
case _ScorePillar():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScorePillar value)?  $default,){
final _that = this;
switch (_that) {
case _ScorePillar() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  String label,  String tagline,  double max,  List<ScoreMetric> metrics,  double? score)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScorePillar() when $default != null:
return $default(_that.key,_that.label,_that.tagline,_that.max,_that.metrics,_that.score);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  String label,  String tagline,  double max,  List<ScoreMetric> metrics,  double? score)  $default,) {final _that = this;
switch (_that) {
case _ScorePillar():
return $default(_that.key,_that.label,_that.tagline,_that.max,_that.metrics,_that.score);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  String label,  String tagline,  double max,  List<ScoreMetric> metrics,  double? score)?  $default,) {final _that = this;
switch (_that) {
case _ScorePillar() when $default != null:
return $default(_that.key,_that.label,_that.tagline,_that.max,_that.metrics,_that.score);case _:
  return null;

}
}

}

/// @nodoc


class _ScorePillar extends ScorePillar {
  const _ScorePillar({required this.key, required this.label, required this.tagline, required this.max, required  List<ScoreMetric> metrics, this.score}): _metrics = metrics,super._();
  

@override final  String key;
@override final  String label;
@override final  String tagline;
@override final  double max;
 final  List<ScoreMetric> _metrics;
@override List<ScoreMetric> get metrics {
  if (_metrics is EqualUnmodifiableListView) return _metrics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_metrics);
}

/// Null when nothing in the pillar could be measured for this stock.
@override final  double? score;

/// Create a copy of ScorePillar
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScorePillarCopyWith<_ScorePillar> get copyWith => __$ScorePillarCopyWithImpl<_ScorePillar>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScorePillar&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label)&&(identical(other.tagline, tagline) || other.tagline == tagline)&&(identical(other.max, max) || other.max == max)&&const DeepCollectionEquality().equals(other.metrics, _metrics)&&(identical(other.score, score) || other.score == score));
}


@override
int get hashCode {
    return Object.hash(runtimeType,key,label,tagline,max,const DeepCollectionEquality().hash(_metrics),score);
}

@override
String toString() {
    return 'ScorePillar(key: $key, label: $label, tagline: $tagline, max: $max, metrics: $metrics, score: $score)';
}


}

/// @nodoc
abstract mixin class _$ScorePillarCopyWith<$Res> implements $ScorePillarCopyWith<$Res> {
  factory _$ScorePillarCopyWith(_ScorePillar value, $Res Function(_ScorePillar) _then) = __$ScorePillarCopyWithImpl;
@override @useResult
$Res call({
 String key, String label, String tagline, double max, List<ScoreMetric> metrics, double? score
});




}
/// @nodoc
class __$ScorePillarCopyWithImpl<$Res>
    implements _$ScorePillarCopyWith<$Res> {
  __$ScorePillarCopyWithImpl(this._self, this._then);

  final _ScorePillar _self;
  final $Res Function(_ScorePillar) _then;

/// Create a copy of ScorePillar
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? label = null,Object? tagline = null,Object? max = null,Object? metrics = null,Object? score = freezed,}) {
  return _then(_ScorePillar(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,tagline: null == tagline ? _self.tagline : tagline // ignore: cast_nullable_to_non_nullable
as String,max: null == max ? _self.max : max // ignore: cast_nullable_to_non_nullable
as double,metrics: null == metrics ? _self._metrics : metrics // ignore: cast_nullable_to_non_nullable
as List<ScoreMetric>,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

/// @nodoc
mixin _$FundamentalScore {

 String get label; ScoreConfidence get confidence; int get metricsUsed; int get metricsTotal; List<ScorePillar> get pillars; List<String> get strengths; List<String> get concerns;/// Metric keys left out because they do not apply to this kind of
/// company, e.g. debt-to-equity for a bank.
 List<String> get excluded; double? get total; String? get grade; String? get note;
/// Create a copy of FundamentalScore
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FundamentalScoreCopyWith<FundamentalScore> get copyWith => _$FundamentalScoreCopyWithImpl<FundamentalScore>(this as FundamentalScore, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as FundamentalScore;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FundamentalScore&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.confidence, _this.confidence) || other.confidence == _this.confidence)&&(identical(other.metricsUsed, _this.metricsUsed) || other.metricsUsed == _this.metricsUsed)&&(identical(other.metricsTotal, _this.metricsTotal) || other.metricsTotal == _this.metricsTotal)&&const DeepCollectionEquality().equals(other.pillars, _this.pillars)&&const DeepCollectionEquality().equals(other.strengths, _this.strengths)&&const DeepCollectionEquality().equals(other.concerns, _this.concerns)&&const DeepCollectionEquality().equals(other.excluded, _this.excluded)&&(identical(other.total, _this.total) || other.total == _this.total)&&(identical(other.grade, _this.grade) || other.grade == _this.grade)&&(identical(other.note, _this.note) || other.note == _this.note));
}


@override
int get hashCode {
  final _this = this as FundamentalScore;
  return Object.hash(runtimeType,_this.label,_this.confidence,_this.metricsUsed,_this.metricsTotal,const DeepCollectionEquality().hash(_this.pillars),const DeepCollectionEquality().hash(_this.strengths),const DeepCollectionEquality().hash(_this.concerns),const DeepCollectionEquality().hash(_this.excluded),_this.total,_this.grade,_this.note);
}

@override
String toString() {
  final _this = this as FundamentalScore;
  return 'FundamentalScore(label: ${_this.label}, confidence: ${_this.confidence}, metricsUsed: ${_this.metricsUsed}, metricsTotal: ${_this.metricsTotal}, pillars: ${_this.pillars}, strengths: ${_this.strengths}, concerns: ${_this.concerns}, excluded: ${_this.excluded}, total: ${_this.total}, grade: ${_this.grade}, note: ${_this.note})';
}


}

/// @nodoc
abstract mixin class $FundamentalScoreCopyWith<$Res>  {
  factory $FundamentalScoreCopyWith(FundamentalScore value, $Res Function(FundamentalScore) _then) = _$FundamentalScoreCopyWithImpl;
@useResult
$Res call({
 String label, ScoreConfidence confidence, int metricsUsed, int metricsTotal, List<ScorePillar> pillars, List<String> strengths, List<String> concerns, List<String> excluded, double? total, String? grade, String? note
});




}
/// @nodoc
class _$FundamentalScoreCopyWithImpl<$Res>
    implements $FundamentalScoreCopyWith<$Res> {
  _$FundamentalScoreCopyWithImpl(this._self, this._then);

  final FundamentalScore _self;
  final $Res Function(FundamentalScore) _then;

/// Create a copy of FundamentalScore
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? confidence = null,Object? metricsUsed = null,Object? metricsTotal = null,Object? pillars = null,Object? strengths = null,Object? concerns = null,Object? excluded = null,Object? total = freezed,Object? grade = freezed,Object? note = freezed,}) {
  return _then(FundamentalScore(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as ScoreConfidence,metricsUsed: null == metricsUsed ? _self.metricsUsed : metricsUsed // ignore: cast_nullable_to_non_nullable
as int,metricsTotal: null == metricsTotal ? _self.metricsTotal : metricsTotal // ignore: cast_nullable_to_non_nullable
as int,pillars: null == pillars ? _self.pillars : pillars // ignore: cast_nullable_to_non_nullable
as List<ScorePillar>,strengths: null == strengths ? _self.strengths : strengths // ignore: cast_nullable_to_non_nullable
as List<String>,concerns: null == concerns ? _self.concerns : concerns // ignore: cast_nullable_to_non_nullable
as List<String>,excluded: null == excluded ? _self.excluded : excluded // ignore: cast_nullable_to_non_nullable
as List<String>,total: freezed == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double?,grade: freezed == grade ? _self.grade : grade // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FundamentalScore].
extension FundamentalScorePatterns on FundamentalScore {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FundamentalScore value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FundamentalScore() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FundamentalScore value)  $default,){
final _that = this;
switch (_that) {
case _FundamentalScore():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FundamentalScore value)?  $default,){
final _that = this;
switch (_that) {
case _FundamentalScore() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  ScoreConfidence confidence,  int metricsUsed,  int metricsTotal,  List<ScorePillar> pillars,  List<String> strengths,  List<String> concerns,  List<String> excluded,  double? total,  String? grade,  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FundamentalScore() when $default != null:
return $default(_that.label,_that.confidence,_that.metricsUsed,_that.metricsTotal,_that.pillars,_that.strengths,_that.concerns,_that.excluded,_that.total,_that.grade,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  ScoreConfidence confidence,  int metricsUsed,  int metricsTotal,  List<ScorePillar> pillars,  List<String> strengths,  List<String> concerns,  List<String> excluded,  double? total,  String? grade,  String? note)  $default,) {final _that = this;
switch (_that) {
case _FundamentalScore():
return $default(_that.label,_that.confidence,_that.metricsUsed,_that.metricsTotal,_that.pillars,_that.strengths,_that.concerns,_that.excluded,_that.total,_that.grade,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  ScoreConfidence confidence,  int metricsUsed,  int metricsTotal,  List<ScorePillar> pillars,  List<String> strengths,  List<String> concerns,  List<String> excluded,  double? total,  String? grade,  String? note)?  $default,) {final _that = this;
switch (_that) {
case _FundamentalScore() when $default != null:
return $default(_that.label,_that.confidence,_that.metricsUsed,_that.metricsTotal,_that.pillars,_that.strengths,_that.concerns,_that.excluded,_that.total,_that.grade,_that.note);case _:
  return null;

}
}

}

/// @nodoc


class _FundamentalScore extends FundamentalScore {
  const _FundamentalScore({required this.label, required this.confidence, required this.metricsUsed, required this.metricsTotal, required  List<ScorePillar> pillars, required  List<String> strengths, required  List<String> concerns, required  List<String> excluded, this.total, this.grade, this.note}): _pillars = pillars,_strengths = strengths,_concerns = concerns,_excluded = excluded,super._();
  

@override final  String label;
@override final  ScoreConfidence confidence;
@override final  int metricsUsed;
@override final  int metricsTotal;
 final  List<ScorePillar> _pillars;
@override List<ScorePillar> get pillars {
  if (_pillars is EqualUnmodifiableListView) return _pillars;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pillars);
}

 final  List<String> _strengths;
@override List<String> get strengths {
  if (_strengths is EqualUnmodifiableListView) return _strengths;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_strengths);
}

 final  List<String> _concerns;
@override List<String> get concerns {
  if (_concerns is EqualUnmodifiableListView) return _concerns;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_concerns);
}

/// Metric keys left out because they do not apply to this kind of
/// company, e.g. debt-to-equity for a bank.
 final  List<String> _excluded;
/// Metric keys left out because they do not apply to this kind of
/// company, e.g. debt-to-equity for a bank.
@override List<String> get excluded {
  if (_excluded is EqualUnmodifiableListView) return _excluded;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_excluded);
}

@override final  double? total;
@override final  String? grade;
@override final  String? note;

/// Create a copy of FundamentalScore
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FundamentalScoreCopyWith<_FundamentalScore> get copyWith => __$FundamentalScoreCopyWithImpl<_FundamentalScore>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FundamentalScore&&(identical(other.label, label) || other.label == label)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.metricsUsed, metricsUsed) || other.metricsUsed == metricsUsed)&&(identical(other.metricsTotal, metricsTotal) || other.metricsTotal == metricsTotal)&&const DeepCollectionEquality().equals(other.pillars, _pillars)&&const DeepCollectionEquality().equals(other.strengths, _strengths)&&const DeepCollectionEquality().equals(other.concerns, _concerns)&&const DeepCollectionEquality().equals(other.excluded, _excluded)&&(identical(other.total, total) || other.total == total)&&(identical(other.grade, grade) || other.grade == grade)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode {
    return Object.hash(runtimeType,label,confidence,metricsUsed,metricsTotal,const DeepCollectionEquality().hash(_pillars),const DeepCollectionEquality().hash(_strengths),const DeepCollectionEquality().hash(_concerns),const DeepCollectionEquality().hash(_excluded),total,grade,note);
}

@override
String toString() {
    return 'FundamentalScore(label: $label, confidence: $confidence, metricsUsed: $metricsUsed, metricsTotal: $metricsTotal, pillars: $pillars, strengths: $strengths, concerns: $concerns, excluded: $excluded, total: $total, grade: $grade, note: $note)';
}


}

/// @nodoc
abstract mixin class _$FundamentalScoreCopyWith<$Res> implements $FundamentalScoreCopyWith<$Res> {
  factory _$FundamentalScoreCopyWith(_FundamentalScore value, $Res Function(_FundamentalScore) _then) = __$FundamentalScoreCopyWithImpl;
@override @useResult
$Res call({
 String label, ScoreConfidence confidence, int metricsUsed, int metricsTotal, List<ScorePillar> pillars, List<String> strengths, List<String> concerns, List<String> excluded, double? total, String? grade, String? note
});




}
/// @nodoc
class __$FundamentalScoreCopyWithImpl<$Res>
    implements _$FundamentalScoreCopyWith<$Res> {
  __$FundamentalScoreCopyWithImpl(this._self, this._then);

  final _FundamentalScore _self;
  final $Res Function(_FundamentalScore) _then;

/// Create a copy of FundamentalScore
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? confidence = null,Object? metricsUsed = null,Object? metricsTotal = null,Object? pillars = null,Object? strengths = null,Object? concerns = null,Object? excluded = null,Object? total = freezed,Object? grade = freezed,Object? note = freezed,}) {
  return _then(_FundamentalScore(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as ScoreConfidence,metricsUsed: null == metricsUsed ? _self.metricsUsed : metricsUsed // ignore: cast_nullable_to_non_nullable
as int,metricsTotal: null == metricsTotal ? _self.metricsTotal : metricsTotal // ignore: cast_nullable_to_non_nullable
as int,pillars: null == pillars ? _self._pillars : pillars // ignore: cast_nullable_to_non_nullable
as List<ScorePillar>,strengths: null == strengths ? _self._strengths : strengths // ignore: cast_nullable_to_non_nullable
as List<String>,concerns: null == concerns ? _self._concerns : concerns // ignore: cast_nullable_to_non_nullable
as List<String>,excluded: null == excluded ? _self._excluded : excluded // ignore: cast_nullable_to_non_nullable
as List<String>,total: freezed == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double?,grade: freezed == grade ? _self.grade : grade // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$Fundamentals {

 String get symbol; Valuation get valuation; FinancialHealth get health; List<TrendPoint> get revenueTrend; List<TrendPoint> get profitTrend; FundamentalScore? get score; String? get sector; String? get industry;
/// Create a copy of Fundamentals
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FundamentalsCopyWith<Fundamentals> get copyWith => _$FundamentalsCopyWithImpl<Fundamentals>(this as Fundamentals, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Fundamentals;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Fundamentals&&(identical(other.symbol, _this.symbol) || other.symbol == _this.symbol)&&(identical(other.valuation, _this.valuation) || other.valuation == _this.valuation)&&(identical(other.health, _this.health) || other.health == _this.health)&&const DeepCollectionEquality().equals(other.revenueTrend, _this.revenueTrend)&&const DeepCollectionEquality().equals(other.profitTrend, _this.profitTrend)&&(identical(other.score, _this.score) || other.score == _this.score)&&(identical(other.sector, _this.sector) || other.sector == _this.sector)&&(identical(other.industry, _this.industry) || other.industry == _this.industry));
}


@override
int get hashCode {
  final _this = this as Fundamentals;
  return Object.hash(runtimeType,_this.symbol,_this.valuation,_this.health,const DeepCollectionEquality().hash(_this.revenueTrend),const DeepCollectionEquality().hash(_this.profitTrend),_this.score,_this.sector,_this.industry);
}

@override
String toString() {
  final _this = this as Fundamentals;
  return 'Fundamentals(symbol: ${_this.symbol}, valuation: ${_this.valuation}, health: ${_this.health}, revenueTrend: ${_this.revenueTrend}, profitTrend: ${_this.profitTrend}, score: ${_this.score}, sector: ${_this.sector}, industry: ${_this.industry})';
}


}

/// @nodoc
abstract mixin class $FundamentalsCopyWith<$Res>  {
  factory $FundamentalsCopyWith(Fundamentals value, $Res Function(Fundamentals) _then) = _$FundamentalsCopyWithImpl;
@useResult
$Res call({
 String symbol, Valuation valuation, FinancialHealth health, List<TrendPoint> revenueTrend, List<TrendPoint> profitTrend, FundamentalScore? score, String? sector, String? industry
});


$ValuationCopyWith<$Res> get valuation;$FinancialHealthCopyWith<$Res> get health;$FundamentalScoreCopyWith<$Res>? get score;

}
/// @nodoc
class _$FundamentalsCopyWithImpl<$Res>
    implements $FundamentalsCopyWith<$Res> {
  _$FundamentalsCopyWithImpl(this._self, this._then);

  final Fundamentals _self;
  final $Res Function(Fundamentals) _then;

/// Create a copy of Fundamentals
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? valuation = null,Object? health = null,Object? revenueTrend = null,Object? profitTrend = null,Object? score = freezed,Object? sector = freezed,Object? industry = freezed,}) {
  return _then(Fundamentals(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,valuation: null == valuation ? _self.valuation : valuation // ignore: cast_nullable_to_non_nullable
as Valuation,health: null == health ? _self.health : health // ignore: cast_nullable_to_non_nullable
as FinancialHealth,revenueTrend: null == revenueTrend ? _self.revenueTrend : revenueTrend // ignore: cast_nullable_to_non_nullable
as List<TrendPoint>,profitTrend: null == profitTrend ? _self.profitTrend : profitTrend // ignore: cast_nullable_to_non_nullable
as List<TrendPoint>,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as FundamentalScore?,sector: freezed == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as String?,industry: freezed == industry ? _self.industry : industry // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of Fundamentals
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ValuationCopyWith<$Res> get valuation {
  
  return $ValuationCopyWith<$Res>(_self.valuation, (value) {
    return _then(_self.copyWith(valuation: value));
  });
}/// Create a copy of Fundamentals
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialHealthCopyWith<$Res> get health {
  
  return $FinancialHealthCopyWith<$Res>(_self.health, (value) {
    return _then(_self.copyWith(health: value));
  });
}/// Create a copy of Fundamentals
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FundamentalScoreCopyWith<$Res>? get score {
    if (_self.score == null) {
    return null;
  }

  return $FundamentalScoreCopyWith<$Res>(_self.score!, (value) {
    return _then(_self.copyWith(score: value));
  });
}
}


/// Adds pattern-matching-related methods to [Fundamentals].
extension FundamentalsPatterns on Fundamentals {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Fundamentals value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Fundamentals() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Fundamentals value)  $default,){
final _that = this;
switch (_that) {
case _Fundamentals():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Fundamentals value)?  $default,){
final _that = this;
switch (_that) {
case _Fundamentals() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  Valuation valuation,  FinancialHealth health,  List<TrendPoint> revenueTrend,  List<TrendPoint> profitTrend,  FundamentalScore? score,  String? sector,  String? industry)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Fundamentals() when $default != null:
return $default(_that.symbol,_that.valuation,_that.health,_that.revenueTrend,_that.profitTrend,_that.score,_that.sector,_that.industry);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  Valuation valuation,  FinancialHealth health,  List<TrendPoint> revenueTrend,  List<TrendPoint> profitTrend,  FundamentalScore? score,  String? sector,  String? industry)  $default,) {final _that = this;
switch (_that) {
case _Fundamentals():
return $default(_that.symbol,_that.valuation,_that.health,_that.revenueTrend,_that.profitTrend,_that.score,_that.sector,_that.industry);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  Valuation valuation,  FinancialHealth health,  List<TrendPoint> revenueTrend,  List<TrendPoint> profitTrend,  FundamentalScore? score,  String? sector,  String? industry)?  $default,) {final _that = this;
switch (_that) {
case _Fundamentals() when $default != null:
return $default(_that.symbol,_that.valuation,_that.health,_that.revenueTrend,_that.profitTrend,_that.score,_that.sector,_that.industry);case _:
  return null;

}
}

}

/// @nodoc


class _Fundamentals implements Fundamentals {
  const _Fundamentals({required this.symbol, required this.valuation, required this.health, required  List<TrendPoint> revenueTrend, required  List<TrendPoint> profitTrend, this.score, this.sector, this.industry}): _revenueTrend = revenueTrend,_profitTrend = profitTrend;
  

@override final  String symbol;
@override final  Valuation valuation;
@override final  FinancialHealth health;
 final  List<TrendPoint> _revenueTrend;
@override List<TrendPoint> get revenueTrend {
  if (_revenueTrend is EqualUnmodifiableListView) return _revenueTrend;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_revenueTrend);
}

 final  List<TrendPoint> _profitTrend;
@override List<TrendPoint> get profitTrend {
  if (_profitTrend is EqualUnmodifiableListView) return _profitTrend;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_profitTrend);
}

@override final  FundamentalScore? score;
@override final  String? sector;
@override final  String? industry;

/// Create a copy of Fundamentals
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FundamentalsCopyWith<_Fundamentals> get copyWith => __$FundamentalsCopyWithImpl<_Fundamentals>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Fundamentals&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.valuation, valuation) || other.valuation == valuation)&&(identical(other.health, health) || other.health == health)&&const DeepCollectionEquality().equals(other.revenueTrend, _revenueTrend)&&const DeepCollectionEquality().equals(other.profitTrend, _profitTrend)&&(identical(other.score, score) || other.score == score)&&(identical(other.sector, sector) || other.sector == sector)&&(identical(other.industry, industry) || other.industry == industry));
}


@override
int get hashCode {
    return Object.hash(runtimeType,symbol,valuation,health,const DeepCollectionEquality().hash(_revenueTrend),const DeepCollectionEquality().hash(_profitTrend),score,sector,industry);
}

@override
String toString() {
    return 'Fundamentals(symbol: $symbol, valuation: $valuation, health: $health, revenueTrend: $revenueTrend, profitTrend: $profitTrend, score: $score, sector: $sector, industry: $industry)';
}


}

/// @nodoc
abstract mixin class _$FundamentalsCopyWith<$Res> implements $FundamentalsCopyWith<$Res> {
  factory _$FundamentalsCopyWith(_Fundamentals value, $Res Function(_Fundamentals) _then) = __$FundamentalsCopyWithImpl;
@override @useResult
$Res call({
 String symbol, Valuation valuation, FinancialHealth health, List<TrendPoint> revenueTrend, List<TrendPoint> profitTrend, FundamentalScore? score, String? sector, String? industry
});


@override $ValuationCopyWith<$Res> get valuation;@override $FinancialHealthCopyWith<$Res> get health;@override $FundamentalScoreCopyWith<$Res>? get score;

}
/// @nodoc
class __$FundamentalsCopyWithImpl<$Res>
    implements _$FundamentalsCopyWith<$Res> {
  __$FundamentalsCopyWithImpl(this._self, this._then);

  final _Fundamentals _self;
  final $Res Function(_Fundamentals) _then;

/// Create a copy of Fundamentals
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? valuation = null,Object? health = null,Object? revenueTrend = null,Object? profitTrend = null,Object? score = freezed,Object? sector = freezed,Object? industry = freezed,}) {
  return _then(_Fundamentals(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,valuation: null == valuation ? _self.valuation : valuation // ignore: cast_nullable_to_non_nullable
as Valuation,health: null == health ? _self.health : health // ignore: cast_nullable_to_non_nullable
as FinancialHealth,revenueTrend: null == revenueTrend ? _self._revenueTrend : revenueTrend // ignore: cast_nullable_to_non_nullable
as List<TrendPoint>,profitTrend: null == profitTrend ? _self._profitTrend : profitTrend // ignore: cast_nullable_to_non_nullable
as List<TrendPoint>,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as FundamentalScore?,sector: freezed == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as String?,industry: freezed == industry ? _self.industry : industry // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of Fundamentals
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ValuationCopyWith<$Res> get valuation {
  
  return $ValuationCopyWith<$Res>(_self.valuation, (value) {
    return _then(_self.copyWith(valuation: value));
  });
}/// Create a copy of Fundamentals
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialHealthCopyWith<$Res> get health {
  
  return $FinancialHealthCopyWith<$Res>(_self.health, (value) {
    return _then(_self.copyWith(health: value));
  });
}/// Create a copy of Fundamentals
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FundamentalScoreCopyWith<$Res>? get score {
    if (_self.score == null) {
    return null;
  }

  return $FundamentalScoreCopyWith<$Res>(_self.score!, (value) {
    return _then(_self.copyWith(score: value));
  });
}
}

/// @nodoc
mixin _$AiSummary {

 String get markdown;/// The server answered from its own cache rather than generating anew.
 bool get cached; DateTime get receivedAt;
/// Create a copy of AiSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiSummaryCopyWith<AiSummary> get copyWith => _$AiSummaryCopyWithImpl<AiSummary>(this as AiSummary, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AiSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiSummary&&(identical(other.markdown, _this.markdown) || other.markdown == _this.markdown)&&(identical(other.cached, _this.cached) || other.cached == _this.cached)&&(identical(other.receivedAt, _this.receivedAt) || other.receivedAt == _this.receivedAt));
}


@override
int get hashCode {
  final _this = this as AiSummary;
  return Object.hash(runtimeType,_this.markdown,_this.cached,_this.receivedAt);
}

@override
String toString() {
  final _this = this as AiSummary;
  return 'AiSummary(markdown: ${_this.markdown}, cached: ${_this.cached}, receivedAt: ${_this.receivedAt})';
}


}

/// @nodoc
abstract mixin class $AiSummaryCopyWith<$Res>  {
  factory $AiSummaryCopyWith(AiSummary value, $Res Function(AiSummary) _then) = _$AiSummaryCopyWithImpl;
@useResult
$Res call({
 String markdown, bool cached, DateTime receivedAt
});




}
/// @nodoc
class _$AiSummaryCopyWithImpl<$Res>
    implements $AiSummaryCopyWith<$Res> {
  _$AiSummaryCopyWithImpl(this._self, this._then);

  final AiSummary _self;
  final $Res Function(AiSummary) _then;

/// Create a copy of AiSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? markdown = null,Object? cached = null,Object? receivedAt = null,}) {
  return _then(AiSummary(
markdown: null == markdown ? _self.markdown : markdown // ignore: cast_nullable_to_non_nullable
as String,cached: null == cached ? _self.cached : cached // ignore: cast_nullable_to_non_nullable
as bool,receivedAt: null == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [AiSummary].
extension AiSummaryPatterns on AiSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiSummary value)  $default,){
final _that = this;
switch (_that) {
case _AiSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiSummary value)?  $default,){
final _that = this;
switch (_that) {
case _AiSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String markdown,  bool cached,  DateTime receivedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiSummary() when $default != null:
return $default(_that.markdown,_that.cached,_that.receivedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String markdown,  bool cached,  DateTime receivedAt)  $default,) {final _that = this;
switch (_that) {
case _AiSummary():
return $default(_that.markdown,_that.cached,_that.receivedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String markdown,  bool cached,  DateTime receivedAt)?  $default,) {final _that = this;
switch (_that) {
case _AiSummary() when $default != null:
return $default(_that.markdown,_that.cached,_that.receivedAt);case _:
  return null;

}
}

}

/// @nodoc


class _AiSummary implements AiSummary {
  const _AiSummary({required this.markdown, required this.cached, required this.receivedAt});
  

@override final  String markdown;
/// The server answered from its own cache rather than generating anew.
@override final  bool cached;
@override final  DateTime receivedAt;

/// Create a copy of AiSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiSummaryCopyWith<_AiSummary> get copyWith => __$AiSummaryCopyWithImpl<_AiSummary>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiSummary&&(identical(other.markdown, markdown) || other.markdown == markdown)&&(identical(other.cached, cached) || other.cached == cached)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,markdown,cached,receivedAt);
}

@override
String toString() {
    return 'AiSummary(markdown: $markdown, cached: $cached, receivedAt: $receivedAt)';
}


}

/// @nodoc
abstract mixin class _$AiSummaryCopyWith<$Res> implements $AiSummaryCopyWith<$Res> {
  factory _$AiSummaryCopyWith(_AiSummary value, $Res Function(_AiSummary) _then) = __$AiSummaryCopyWithImpl;
@override @useResult
$Res call({
 String markdown, bool cached, DateTime receivedAt
});




}
/// @nodoc
class __$AiSummaryCopyWithImpl<$Res>
    implements _$AiSummaryCopyWith<$Res> {
  __$AiSummaryCopyWithImpl(this._self, this._then);

  final _AiSummary _self;
  final $Res Function(_AiSummary) _then;

/// Create a copy of AiSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? markdown = null,Object? cached = null,Object? receivedAt = null,}) {
  return _then(_AiSummary(
markdown: null == markdown ? _self.markdown : markdown // ignore: cast_nullable_to_non_nullable
as String,cached: null == cached ? _self.cached : cached // ignore: cast_nullable_to_non_nullable
as bool,receivedAt: null == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
