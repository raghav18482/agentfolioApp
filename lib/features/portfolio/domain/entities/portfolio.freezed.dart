// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'portfolio.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Holding {

/// The broker's trading symbol, e.g. `RELIANCE-EQ`.
 String get symbol;/// The broker's own instrument id, for live prices. Broker-specific.
 String get brokerToken; int get quantity; double get averagePrice; double get lastPrice; double get invested; double get currentValue; double get pnl; double get pnlPercent;
/// Create a copy of Holding
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HoldingCopyWith<Holding> get copyWith => _$HoldingCopyWithImpl<Holding>(this as Holding, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Holding;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Holding&&(identical(other.symbol, _this.symbol) || other.symbol == _this.symbol)&&(identical(other.brokerToken, _this.brokerToken) || other.brokerToken == _this.brokerToken)&&(identical(other.quantity, _this.quantity) || other.quantity == _this.quantity)&&(identical(other.averagePrice, _this.averagePrice) || other.averagePrice == _this.averagePrice)&&(identical(other.lastPrice, _this.lastPrice) || other.lastPrice == _this.lastPrice)&&(identical(other.invested, _this.invested) || other.invested == _this.invested)&&(identical(other.currentValue, _this.currentValue) || other.currentValue == _this.currentValue)&&(identical(other.pnl, _this.pnl) || other.pnl == _this.pnl)&&(identical(other.pnlPercent, _this.pnlPercent) || other.pnlPercent == _this.pnlPercent));
}


@override
int get hashCode {
  final _this = this as Holding;
  return Object.hash(runtimeType,_this.symbol,_this.brokerToken,_this.quantity,_this.averagePrice,_this.lastPrice,_this.invested,_this.currentValue,_this.pnl,_this.pnlPercent);
}

@override
String toString() {
  final _this = this as Holding;
  return 'Holding(symbol: ${_this.symbol}, brokerToken: ${_this.brokerToken}, quantity: ${_this.quantity}, averagePrice: ${_this.averagePrice}, lastPrice: ${_this.lastPrice}, invested: ${_this.invested}, currentValue: ${_this.currentValue}, pnl: ${_this.pnl}, pnlPercent: ${_this.pnlPercent})';
}


}

/// @nodoc
abstract mixin class $HoldingCopyWith<$Res>  {
  factory $HoldingCopyWith(Holding value, $Res Function(Holding) _then) = _$HoldingCopyWithImpl;
@useResult
$Res call({
 String symbol, String brokerToken, int quantity, double averagePrice, double lastPrice, double invested, double currentValue, double pnl, double pnlPercent
});




}
/// @nodoc
class _$HoldingCopyWithImpl<$Res>
    implements $HoldingCopyWith<$Res> {
  _$HoldingCopyWithImpl(this._self, this._then);

  final Holding _self;
  final $Res Function(Holding) _then;

/// Create a copy of Holding
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? brokerToken = null,Object? quantity = null,Object? averagePrice = null,Object? lastPrice = null,Object? invested = null,Object? currentValue = null,Object? pnl = null,Object? pnlPercent = null,}) {
  return _then(Holding(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,brokerToken: null == brokerToken ? _self.brokerToken : brokerToken // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,averagePrice: null == averagePrice ? _self.averagePrice : averagePrice // ignore: cast_nullable_to_non_nullable
as double,lastPrice: null == lastPrice ? _self.lastPrice : lastPrice // ignore: cast_nullable_to_non_nullable
as double,invested: null == invested ? _self.invested : invested // ignore: cast_nullable_to_non_nullable
as double,currentValue: null == currentValue ? _self.currentValue : currentValue // ignore: cast_nullable_to_non_nullable
as double,pnl: null == pnl ? _self.pnl : pnl // ignore: cast_nullable_to_non_nullable
as double,pnlPercent: null == pnlPercent ? _self.pnlPercent : pnlPercent // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [Holding].
extension HoldingPatterns on Holding {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Holding value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Holding() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Holding value)  $default,){
final _that = this;
switch (_that) {
case _Holding():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Holding value)?  $default,){
final _that = this;
switch (_that) {
case _Holding() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  String brokerToken,  int quantity,  double averagePrice,  double lastPrice,  double invested,  double currentValue,  double pnl,  double pnlPercent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Holding() when $default != null:
return $default(_that.symbol,_that.brokerToken,_that.quantity,_that.averagePrice,_that.lastPrice,_that.invested,_that.currentValue,_that.pnl,_that.pnlPercent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  String brokerToken,  int quantity,  double averagePrice,  double lastPrice,  double invested,  double currentValue,  double pnl,  double pnlPercent)  $default,) {final _that = this;
switch (_that) {
case _Holding():
return $default(_that.symbol,_that.brokerToken,_that.quantity,_that.averagePrice,_that.lastPrice,_that.invested,_that.currentValue,_that.pnl,_that.pnlPercent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  String brokerToken,  int quantity,  double averagePrice,  double lastPrice,  double invested,  double currentValue,  double pnl,  double pnlPercent)?  $default,) {final _that = this;
switch (_that) {
case _Holding() when $default != null:
return $default(_that.symbol,_that.brokerToken,_that.quantity,_that.averagePrice,_that.lastPrice,_that.invested,_that.currentValue,_that.pnl,_that.pnlPercent);case _:
  return null;

}
}

}

/// @nodoc


class _Holding extends Holding {
  const _Holding({required this.symbol, required this.brokerToken, required this.quantity, required this.averagePrice, required this.lastPrice, required this.invested, required this.currentValue, required this.pnl, required this.pnlPercent}): super._();
  

/// The broker's trading symbol, e.g. `RELIANCE-EQ`.
@override final  String symbol;
/// The broker's own instrument id, for live prices. Broker-specific.
@override final  String brokerToken;
@override final  int quantity;
@override final  double averagePrice;
@override final  double lastPrice;
@override final  double invested;
@override final  double currentValue;
@override final  double pnl;
@override final  double pnlPercent;

/// Create a copy of Holding
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HoldingCopyWith<_Holding> get copyWith => __$HoldingCopyWithImpl<_Holding>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Holding&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.brokerToken, brokerToken) || other.brokerToken == brokerToken)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.averagePrice, averagePrice) || other.averagePrice == averagePrice)&&(identical(other.lastPrice, lastPrice) || other.lastPrice == lastPrice)&&(identical(other.invested, invested) || other.invested == invested)&&(identical(other.currentValue, currentValue) || other.currentValue == currentValue)&&(identical(other.pnl, pnl) || other.pnl == pnl)&&(identical(other.pnlPercent, pnlPercent) || other.pnlPercent == pnlPercent));
}


@override
int get hashCode {
    return Object.hash(runtimeType,symbol,brokerToken,quantity,averagePrice,lastPrice,invested,currentValue,pnl,pnlPercent);
}

@override
String toString() {
    return 'Holding(symbol: $symbol, brokerToken: $brokerToken, quantity: $quantity, averagePrice: $averagePrice, lastPrice: $lastPrice, invested: $invested, currentValue: $currentValue, pnl: $pnl, pnlPercent: $pnlPercent)';
}


}

/// @nodoc
abstract mixin class _$HoldingCopyWith<$Res> implements $HoldingCopyWith<$Res> {
  factory _$HoldingCopyWith(_Holding value, $Res Function(_Holding) _then) = __$HoldingCopyWithImpl;
@override @useResult
$Res call({
 String symbol, String brokerToken, int quantity, double averagePrice, double lastPrice, double invested, double currentValue, double pnl, double pnlPercent
});




}
/// @nodoc
class __$HoldingCopyWithImpl<$Res>
    implements _$HoldingCopyWith<$Res> {
  __$HoldingCopyWithImpl(this._self, this._then);

  final _Holding _self;
  final $Res Function(_Holding) _then;

/// Create a copy of Holding
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? brokerToken = null,Object? quantity = null,Object? averagePrice = null,Object? lastPrice = null,Object? invested = null,Object? currentValue = null,Object? pnl = null,Object? pnlPercent = null,}) {
  return _then(_Holding(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,brokerToken: null == brokerToken ? _self.brokerToken : brokerToken // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,averagePrice: null == averagePrice ? _self.averagePrice : averagePrice // ignore: cast_nullable_to_non_nullable
as double,lastPrice: null == lastPrice ? _self.lastPrice : lastPrice // ignore: cast_nullable_to_non_nullable
as double,invested: null == invested ? _self.invested : invested // ignore: cast_nullable_to_non_nullable
as double,currentValue: null == currentValue ? _self.currentValue : currentValue // ignore: cast_nullable_to_non_nullable
as double,pnl: null == pnl ? _self.pnl : pnl // ignore: cast_nullable_to_non_nullable
as double,pnlPercent: null == pnlPercent ? _self.pnlPercent : pnlPercent // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$PortfolioSummary {

 double? get totalInvested; double? get currentValue; double? get overallPnl; double? get overallPnlPercent;/// Today's P&L across open positions. Absent when there are none today,
/// which is a real zero.
 double? get dayPnl;
/// Create a copy of PortfolioSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PortfolioSummaryCopyWith<PortfolioSummary> get copyWith => _$PortfolioSummaryCopyWithImpl<PortfolioSummary>(this as PortfolioSummary, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PortfolioSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PortfolioSummary&&(identical(other.totalInvested, _this.totalInvested) || other.totalInvested == _this.totalInvested)&&(identical(other.currentValue, _this.currentValue) || other.currentValue == _this.currentValue)&&(identical(other.overallPnl, _this.overallPnl) || other.overallPnl == _this.overallPnl)&&(identical(other.overallPnlPercent, _this.overallPnlPercent) || other.overallPnlPercent == _this.overallPnlPercent)&&(identical(other.dayPnl, _this.dayPnl) || other.dayPnl == _this.dayPnl));
}


@override
int get hashCode {
  final _this = this as PortfolioSummary;
  return Object.hash(runtimeType,_this.totalInvested,_this.currentValue,_this.overallPnl,_this.overallPnlPercent,_this.dayPnl);
}

@override
String toString() {
  final _this = this as PortfolioSummary;
  return 'PortfolioSummary(totalInvested: ${_this.totalInvested}, currentValue: ${_this.currentValue}, overallPnl: ${_this.overallPnl}, overallPnlPercent: ${_this.overallPnlPercent}, dayPnl: ${_this.dayPnl})';
}


}

/// @nodoc
abstract mixin class $PortfolioSummaryCopyWith<$Res>  {
  factory $PortfolioSummaryCopyWith(PortfolioSummary value, $Res Function(PortfolioSummary) _then) = _$PortfolioSummaryCopyWithImpl;
@useResult
$Res call({
 double? totalInvested, double? currentValue, double? overallPnl, double? overallPnlPercent, double? dayPnl
});




}
/// @nodoc
class _$PortfolioSummaryCopyWithImpl<$Res>
    implements $PortfolioSummaryCopyWith<$Res> {
  _$PortfolioSummaryCopyWithImpl(this._self, this._then);

  final PortfolioSummary _self;
  final $Res Function(PortfolioSummary) _then;

/// Create a copy of PortfolioSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalInvested = freezed,Object? currentValue = freezed,Object? overallPnl = freezed,Object? overallPnlPercent = freezed,Object? dayPnl = freezed,}) {
  return _then(PortfolioSummary(
totalInvested: freezed == totalInvested ? _self.totalInvested : totalInvested // ignore: cast_nullable_to_non_nullable
as double?,currentValue: freezed == currentValue ? _self.currentValue : currentValue // ignore: cast_nullable_to_non_nullable
as double?,overallPnl: freezed == overallPnl ? _self.overallPnl : overallPnl // ignore: cast_nullable_to_non_nullable
as double?,overallPnlPercent: freezed == overallPnlPercent ? _self.overallPnlPercent : overallPnlPercent // ignore: cast_nullable_to_non_nullable
as double?,dayPnl: freezed == dayPnl ? _self.dayPnl : dayPnl // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [PortfolioSummary].
extension PortfolioSummaryPatterns on PortfolioSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PortfolioSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PortfolioSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PortfolioSummary value)  $default,){
final _that = this;
switch (_that) {
case _PortfolioSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PortfolioSummary value)?  $default,){
final _that = this;
switch (_that) {
case _PortfolioSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? totalInvested,  double? currentValue,  double? overallPnl,  double? overallPnlPercent,  double? dayPnl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PortfolioSummary() when $default != null:
return $default(_that.totalInvested,_that.currentValue,_that.overallPnl,_that.overallPnlPercent,_that.dayPnl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? totalInvested,  double? currentValue,  double? overallPnl,  double? overallPnlPercent,  double? dayPnl)  $default,) {final _that = this;
switch (_that) {
case _PortfolioSummary():
return $default(_that.totalInvested,_that.currentValue,_that.overallPnl,_that.overallPnlPercent,_that.dayPnl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? totalInvested,  double? currentValue,  double? overallPnl,  double? overallPnlPercent,  double? dayPnl)?  $default,) {final _that = this;
switch (_that) {
case _PortfolioSummary() when $default != null:
return $default(_that.totalInvested,_that.currentValue,_that.overallPnl,_that.overallPnlPercent,_that.dayPnl);case _:
  return null;

}
}

}

/// @nodoc


class _PortfolioSummary implements PortfolioSummary {
  const _PortfolioSummary({this.totalInvested, this.currentValue, this.overallPnl, this.overallPnlPercent, this.dayPnl});
  

@override final  double? totalInvested;
@override final  double? currentValue;
@override final  double? overallPnl;
@override final  double? overallPnlPercent;
/// Today's P&L across open positions. Absent when there are none today,
/// which is a real zero.
@override final  double? dayPnl;

/// Create a copy of PortfolioSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PortfolioSummaryCopyWith<_PortfolioSummary> get copyWith => __$PortfolioSummaryCopyWithImpl<_PortfolioSummary>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PortfolioSummary&&(identical(other.totalInvested, totalInvested) || other.totalInvested == totalInvested)&&(identical(other.currentValue, currentValue) || other.currentValue == currentValue)&&(identical(other.overallPnl, overallPnl) || other.overallPnl == overallPnl)&&(identical(other.overallPnlPercent, overallPnlPercent) || other.overallPnlPercent == overallPnlPercent)&&(identical(other.dayPnl, dayPnl) || other.dayPnl == dayPnl));
}


@override
int get hashCode {
    return Object.hash(runtimeType,totalInvested,currentValue,overallPnl,overallPnlPercent,dayPnl);
}

@override
String toString() {
    return 'PortfolioSummary(totalInvested: $totalInvested, currentValue: $currentValue, overallPnl: $overallPnl, overallPnlPercent: $overallPnlPercent, dayPnl: $dayPnl)';
}


}

/// @nodoc
abstract mixin class _$PortfolioSummaryCopyWith<$Res> implements $PortfolioSummaryCopyWith<$Res> {
  factory _$PortfolioSummaryCopyWith(_PortfolioSummary value, $Res Function(_PortfolioSummary) _then) = __$PortfolioSummaryCopyWithImpl;
@override @useResult
$Res call({
 double? totalInvested, double? currentValue, double? overallPnl, double? overallPnlPercent, double? dayPnl
});




}
/// @nodoc
class __$PortfolioSummaryCopyWithImpl<$Res>
    implements _$PortfolioSummaryCopyWith<$Res> {
  __$PortfolioSummaryCopyWithImpl(this._self, this._then);

  final _PortfolioSummary _self;
  final $Res Function(_PortfolioSummary) _then;

/// Create a copy of PortfolioSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalInvested = freezed,Object? currentValue = freezed,Object? overallPnl = freezed,Object? overallPnlPercent = freezed,Object? dayPnl = freezed,}) {
  return _then(_PortfolioSummary(
totalInvested: freezed == totalInvested ? _self.totalInvested : totalInvested // ignore: cast_nullable_to_non_nullable
as double?,currentValue: freezed == currentValue ? _self.currentValue : currentValue // ignore: cast_nullable_to_non_nullable
as double?,overallPnl: freezed == overallPnl ? _self.overallPnl : overallPnl // ignore: cast_nullable_to_non_nullable
as double?,overallPnlPercent: freezed == overallPnlPercent ? _self.overallPnlPercent : overallPnlPercent // ignore: cast_nullable_to_non_nullable
as double?,dayPnl: freezed == dayPnl ? _self.dayPnl : dayPnl // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

/// @nodoc
mixin _$Funds {

 double? get availableCash; double? get net;
/// Create a copy of Funds
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FundsCopyWith<Funds> get copyWith => _$FundsCopyWithImpl<Funds>(this as Funds, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Funds;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Funds&&(identical(other.availableCash, _this.availableCash) || other.availableCash == _this.availableCash)&&(identical(other.net, _this.net) || other.net == _this.net));
}


@override
int get hashCode {
  final _this = this as Funds;
  return Object.hash(runtimeType,_this.availableCash,_this.net);
}

@override
String toString() {
  final _this = this as Funds;
  return 'Funds(availableCash: ${_this.availableCash}, net: ${_this.net})';
}


}

/// @nodoc
abstract mixin class $FundsCopyWith<$Res>  {
  factory $FundsCopyWith(Funds value, $Res Function(Funds) _then) = _$FundsCopyWithImpl;
@useResult
$Res call({
 double? availableCash, double? net
});




}
/// @nodoc
class _$FundsCopyWithImpl<$Res>
    implements $FundsCopyWith<$Res> {
  _$FundsCopyWithImpl(this._self, this._then);

  final Funds _self;
  final $Res Function(Funds) _then;

/// Create a copy of Funds
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? availableCash = freezed,Object? net = freezed,}) {
  return _then(Funds(
availableCash: freezed == availableCash ? _self.availableCash : availableCash // ignore: cast_nullable_to_non_nullable
as double?,net: freezed == net ? _self.net : net // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [Funds].
extension FundsPatterns on Funds {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Funds value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Funds() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Funds value)  $default,){
final _that = this;
switch (_that) {
case _Funds():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Funds value)?  $default,){
final _that = this;
switch (_that) {
case _Funds() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? availableCash,  double? net)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Funds() when $default != null:
return $default(_that.availableCash,_that.net);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? availableCash,  double? net)  $default,) {final _that = this;
switch (_that) {
case _Funds():
return $default(_that.availableCash,_that.net);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? availableCash,  double? net)?  $default,) {final _that = this;
switch (_that) {
case _Funds() when $default != null:
return $default(_that.availableCash,_that.net);case _:
  return null;

}
}

}

/// @nodoc


class _Funds implements Funds {
  const _Funds({this.availableCash, this.net});
  

@override final  double? availableCash;
@override final  double? net;

/// Create a copy of Funds
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FundsCopyWith<_Funds> get copyWith => __$FundsCopyWithImpl<_Funds>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Funds&&(identical(other.availableCash, availableCash) || other.availableCash == availableCash)&&(identical(other.net, net) || other.net == net));
}


@override
int get hashCode {
    return Object.hash(runtimeType,availableCash,net);
}

@override
String toString() {
    return 'Funds(availableCash: $availableCash, net: $net)';
}


}

/// @nodoc
abstract mixin class _$FundsCopyWith<$Res> implements $FundsCopyWith<$Res> {
  factory _$FundsCopyWith(_Funds value, $Res Function(_Funds) _then) = __$FundsCopyWithImpl;
@override @useResult
$Res call({
 double? availableCash, double? net
});




}
/// @nodoc
class __$FundsCopyWithImpl<$Res>
    implements _$FundsCopyWith<$Res> {
  __$FundsCopyWithImpl(this._self, this._then);

  final _Funds _self;
  final $Res Function(_Funds) _then;

/// Create a copy of Funds
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? availableCash = freezed,Object? net = freezed,}) {
  return _then(_Funds(
availableCash: freezed == availableCash ? _self.availableCash : availableCash // ignore: cast_nullable_to_non_nullable
as double?,net: freezed == net ? _self.net : net // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

/// @nodoc
mixin _$PortfolioSnapshot {

 List<Holding> get holdings; PortfolioSummary get summary; Funds get funds; DateTime get fetchedAt;
/// Create a copy of PortfolioSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PortfolioSnapshotCopyWith<PortfolioSnapshot> get copyWith => _$PortfolioSnapshotCopyWithImpl<PortfolioSnapshot>(this as PortfolioSnapshot, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PortfolioSnapshot;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PortfolioSnapshot&&const DeepCollectionEquality().equals(other.holdings, _this.holdings)&&(identical(other.summary, _this.summary) || other.summary == _this.summary)&&(identical(other.funds, _this.funds) || other.funds == _this.funds)&&(identical(other.fetchedAt, _this.fetchedAt) || other.fetchedAt == _this.fetchedAt));
}


@override
int get hashCode {
  final _this = this as PortfolioSnapshot;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.holdings),_this.summary,_this.funds,_this.fetchedAt);
}

@override
String toString() {
  final _this = this as PortfolioSnapshot;
  return 'PortfolioSnapshot(holdings: ${_this.holdings}, summary: ${_this.summary}, funds: ${_this.funds}, fetchedAt: ${_this.fetchedAt})';
}


}

/// @nodoc
abstract mixin class $PortfolioSnapshotCopyWith<$Res>  {
  factory $PortfolioSnapshotCopyWith(PortfolioSnapshot value, $Res Function(PortfolioSnapshot) _then) = _$PortfolioSnapshotCopyWithImpl;
@useResult
$Res call({
 List<Holding> holdings, PortfolioSummary summary, Funds funds, DateTime fetchedAt
});


$PortfolioSummaryCopyWith<$Res> get summary;$FundsCopyWith<$Res> get funds;

}
/// @nodoc
class _$PortfolioSnapshotCopyWithImpl<$Res>
    implements $PortfolioSnapshotCopyWith<$Res> {
  _$PortfolioSnapshotCopyWithImpl(this._self, this._then);

  final PortfolioSnapshot _self;
  final $Res Function(PortfolioSnapshot) _then;

/// Create a copy of PortfolioSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? holdings = null,Object? summary = null,Object? funds = null,Object? fetchedAt = null,}) {
  return _then(PortfolioSnapshot(
holdings: null == holdings ? _self.holdings : holdings // ignore: cast_nullable_to_non_nullable
as List<Holding>,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as PortfolioSummary,funds: null == funds ? _self.funds : funds // ignore: cast_nullable_to_non_nullable
as Funds,fetchedAt: null == fetchedAt ? _self.fetchedAt : fetchedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of PortfolioSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PortfolioSummaryCopyWith<$Res> get summary {
  
  return $PortfolioSummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of PortfolioSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FundsCopyWith<$Res> get funds {
  
  return $FundsCopyWith<$Res>(_self.funds, (value) {
    return _then(_self.copyWith(funds: value));
  });
}
}


/// Adds pattern-matching-related methods to [PortfolioSnapshot].
extension PortfolioSnapshotPatterns on PortfolioSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PortfolioSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PortfolioSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PortfolioSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _PortfolioSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PortfolioSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _PortfolioSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Holding> holdings,  PortfolioSummary summary,  Funds funds,  DateTime fetchedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PortfolioSnapshot() when $default != null:
return $default(_that.holdings,_that.summary,_that.funds,_that.fetchedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Holding> holdings,  PortfolioSummary summary,  Funds funds,  DateTime fetchedAt)  $default,) {final _that = this;
switch (_that) {
case _PortfolioSnapshot():
return $default(_that.holdings,_that.summary,_that.funds,_that.fetchedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Holding> holdings,  PortfolioSummary summary,  Funds funds,  DateTime fetchedAt)?  $default,) {final _that = this;
switch (_that) {
case _PortfolioSnapshot() when $default != null:
return $default(_that.holdings,_that.summary,_that.funds,_that.fetchedAt);case _:
  return null;

}
}

}

/// @nodoc


class _PortfolioSnapshot implements PortfolioSnapshot {
  const _PortfolioSnapshot({required  List<Holding> holdings, required this.summary, required this.funds, required this.fetchedAt}): _holdings = holdings;
  

 final  List<Holding> _holdings;
@override List<Holding> get holdings {
  if (_holdings is EqualUnmodifiableListView) return _holdings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_holdings);
}

@override final  PortfolioSummary summary;
@override final  Funds funds;
@override final  DateTime fetchedAt;

/// Create a copy of PortfolioSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PortfolioSnapshotCopyWith<_PortfolioSnapshot> get copyWith => __$PortfolioSnapshotCopyWithImpl<_PortfolioSnapshot>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PortfolioSnapshot&&const DeepCollectionEquality().equals(other.holdings, _holdings)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.funds, funds) || other.funds == funds)&&(identical(other.fetchedAt, fetchedAt) || other.fetchedAt == fetchedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_holdings),summary,funds,fetchedAt);
}

@override
String toString() {
    return 'PortfolioSnapshot(holdings: $holdings, summary: $summary, funds: $funds, fetchedAt: $fetchedAt)';
}


}

/// @nodoc
abstract mixin class _$PortfolioSnapshotCopyWith<$Res> implements $PortfolioSnapshotCopyWith<$Res> {
  factory _$PortfolioSnapshotCopyWith(_PortfolioSnapshot value, $Res Function(_PortfolioSnapshot) _then) = __$PortfolioSnapshotCopyWithImpl;
@override @useResult
$Res call({
 List<Holding> holdings, PortfolioSummary summary, Funds funds, DateTime fetchedAt
});


@override $PortfolioSummaryCopyWith<$Res> get summary;@override $FundsCopyWith<$Res> get funds;

}
/// @nodoc
class __$PortfolioSnapshotCopyWithImpl<$Res>
    implements _$PortfolioSnapshotCopyWith<$Res> {
  __$PortfolioSnapshotCopyWithImpl(this._self, this._then);

  final _PortfolioSnapshot _self;
  final $Res Function(_PortfolioSnapshot) _then;

/// Create a copy of PortfolioSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? holdings = null,Object? summary = null,Object? funds = null,Object? fetchedAt = null,}) {
  return _then(_PortfolioSnapshot(
holdings: null == holdings ? _self._holdings : holdings // ignore: cast_nullable_to_non_nullable
as List<Holding>,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as PortfolioSummary,funds: null == funds ? _self.funds : funds // ignore: cast_nullable_to_non_nullable
as Funds,fetchedAt: null == fetchedAt ? _self.fetchedAt : fetchedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of PortfolioSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PortfolioSummaryCopyWith<$Res> get summary {
  
  return $PortfolioSummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of PortfolioSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FundsCopyWith<$Res> get funds {
  
  return $FundsCopyWith<$Res>(_self.funds, (value) {
    return _then(_self.copyWith(funds: value));
  });
}
}

/// @nodoc
mixin _$Position {

 String get symbol; String get product; int get netQuantity; double get buyAverage; double get sellAverage; double get lastPrice; double get pnl;
/// Create a copy of Position
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PositionCopyWith<Position> get copyWith => _$PositionCopyWithImpl<Position>(this as Position, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Position;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Position&&(identical(other.symbol, _this.symbol) || other.symbol == _this.symbol)&&(identical(other.product, _this.product) || other.product == _this.product)&&(identical(other.netQuantity, _this.netQuantity) || other.netQuantity == _this.netQuantity)&&(identical(other.buyAverage, _this.buyAverage) || other.buyAverage == _this.buyAverage)&&(identical(other.sellAverage, _this.sellAverage) || other.sellAverage == _this.sellAverage)&&(identical(other.lastPrice, _this.lastPrice) || other.lastPrice == _this.lastPrice)&&(identical(other.pnl, _this.pnl) || other.pnl == _this.pnl));
}


@override
int get hashCode {
  final _this = this as Position;
  return Object.hash(runtimeType,_this.symbol,_this.product,_this.netQuantity,_this.buyAverage,_this.sellAverage,_this.lastPrice,_this.pnl);
}

@override
String toString() {
  final _this = this as Position;
  return 'Position(symbol: ${_this.symbol}, product: ${_this.product}, netQuantity: ${_this.netQuantity}, buyAverage: ${_this.buyAverage}, sellAverage: ${_this.sellAverage}, lastPrice: ${_this.lastPrice}, pnl: ${_this.pnl})';
}


}

/// @nodoc
abstract mixin class $PositionCopyWith<$Res>  {
  factory $PositionCopyWith(Position value, $Res Function(Position) _then) = _$PositionCopyWithImpl;
@useResult
$Res call({
 String symbol, String product, int netQuantity, double buyAverage, double sellAverage, double lastPrice, double pnl
});




}
/// @nodoc
class _$PositionCopyWithImpl<$Res>
    implements $PositionCopyWith<$Res> {
  _$PositionCopyWithImpl(this._self, this._then);

  final Position _self;
  final $Res Function(Position) _then;

/// Create a copy of Position
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? product = null,Object? netQuantity = null,Object? buyAverage = null,Object? sellAverage = null,Object? lastPrice = null,Object? pnl = null,}) {
  return _then(Position(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,product: null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as String,netQuantity: null == netQuantity ? _self.netQuantity : netQuantity // ignore: cast_nullable_to_non_nullable
as int,buyAverage: null == buyAverage ? _self.buyAverage : buyAverage // ignore: cast_nullable_to_non_nullable
as double,sellAverage: null == sellAverage ? _self.sellAverage : sellAverage // ignore: cast_nullable_to_non_nullable
as double,lastPrice: null == lastPrice ? _self.lastPrice : lastPrice // ignore: cast_nullable_to_non_nullable
as double,pnl: null == pnl ? _self.pnl : pnl // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [Position].
extension PositionPatterns on Position {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Position value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Position() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Position value)  $default,){
final _that = this;
switch (_that) {
case _Position():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Position value)?  $default,){
final _that = this;
switch (_that) {
case _Position() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  String product,  int netQuantity,  double buyAverage,  double sellAverage,  double lastPrice,  double pnl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Position() when $default != null:
return $default(_that.symbol,_that.product,_that.netQuantity,_that.buyAverage,_that.sellAverage,_that.lastPrice,_that.pnl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  String product,  int netQuantity,  double buyAverage,  double sellAverage,  double lastPrice,  double pnl)  $default,) {final _that = this;
switch (_that) {
case _Position():
return $default(_that.symbol,_that.product,_that.netQuantity,_that.buyAverage,_that.sellAverage,_that.lastPrice,_that.pnl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  String product,  int netQuantity,  double buyAverage,  double sellAverage,  double lastPrice,  double pnl)?  $default,) {final _that = this;
switch (_that) {
case _Position() when $default != null:
return $default(_that.symbol,_that.product,_that.netQuantity,_that.buyAverage,_that.sellAverage,_that.lastPrice,_that.pnl);case _:
  return null;

}
}

}

/// @nodoc


class _Position extends Position {
  const _Position({required this.symbol, required this.product, required this.netQuantity, required this.buyAverage, required this.sellAverage, required this.lastPrice, required this.pnl}): super._();
  

@override final  String symbol;
@override final  String product;
@override final  int netQuantity;
@override final  double buyAverage;
@override final  double sellAverage;
@override final  double lastPrice;
@override final  double pnl;

/// Create a copy of Position
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PositionCopyWith<_Position> get copyWith => __$PositionCopyWithImpl<_Position>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Position&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.product, product) || other.product == product)&&(identical(other.netQuantity, netQuantity) || other.netQuantity == netQuantity)&&(identical(other.buyAverage, buyAverage) || other.buyAverage == buyAverage)&&(identical(other.sellAverage, sellAverage) || other.sellAverage == sellAverage)&&(identical(other.lastPrice, lastPrice) || other.lastPrice == lastPrice)&&(identical(other.pnl, pnl) || other.pnl == pnl));
}


@override
int get hashCode {
    return Object.hash(runtimeType,symbol,product,netQuantity,buyAverage,sellAverage,lastPrice,pnl);
}

@override
String toString() {
    return 'Position(symbol: $symbol, product: $product, netQuantity: $netQuantity, buyAverage: $buyAverage, sellAverage: $sellAverage, lastPrice: $lastPrice, pnl: $pnl)';
}


}

/// @nodoc
abstract mixin class _$PositionCopyWith<$Res> implements $PositionCopyWith<$Res> {
  factory _$PositionCopyWith(_Position value, $Res Function(_Position) _then) = __$PositionCopyWithImpl;
@override @useResult
$Res call({
 String symbol, String product, int netQuantity, double buyAverage, double sellAverage, double lastPrice, double pnl
});




}
/// @nodoc
class __$PositionCopyWithImpl<$Res>
    implements _$PositionCopyWith<$Res> {
  __$PositionCopyWithImpl(this._self, this._then);

  final _Position _self;
  final $Res Function(_Position) _then;

/// Create a copy of Position
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? product = null,Object? netQuantity = null,Object? buyAverage = null,Object? sellAverage = null,Object? lastPrice = null,Object? pnl = null,}) {
  return _then(_Position(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,product: null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as String,netQuantity: null == netQuantity ? _self.netQuantity : netQuantity // ignore: cast_nullable_to_non_nullable
as int,buyAverage: null == buyAverage ? _self.buyAverage : buyAverage // ignore: cast_nullable_to_non_nullable
as double,sellAverage: null == sellAverage ? _self.sellAverage : sellAverage // ignore: cast_nullable_to_non_nullable
as double,lastPrice: null == lastPrice ? _self.lastPrice : lastPrice // ignore: cast_nullable_to_non_nullable
as double,pnl: null == pnl ? _self.pnl : pnl // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$Positions {

 List<Position> get positions; double get totalPnl;
/// Create a copy of Positions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PositionsCopyWith<Positions> get copyWith => _$PositionsCopyWithImpl<Positions>(this as Positions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Positions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Positions&&const DeepCollectionEquality().equals(other.positions, _this.positions)&&(identical(other.totalPnl, _this.totalPnl) || other.totalPnl == _this.totalPnl));
}


@override
int get hashCode {
  final _this = this as Positions;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.positions),_this.totalPnl);
}

@override
String toString() {
  final _this = this as Positions;
  return 'Positions(positions: ${_this.positions}, totalPnl: ${_this.totalPnl})';
}


}

/// @nodoc
abstract mixin class $PositionsCopyWith<$Res>  {
  factory $PositionsCopyWith(Positions value, $Res Function(Positions) _then) = _$PositionsCopyWithImpl;
@useResult
$Res call({
 List<Position> positions, double totalPnl
});




}
/// @nodoc
class _$PositionsCopyWithImpl<$Res>
    implements $PositionsCopyWith<$Res> {
  _$PositionsCopyWithImpl(this._self, this._then);

  final Positions _self;
  final $Res Function(Positions) _then;

/// Create a copy of Positions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? positions = null,Object? totalPnl = null,}) {
  return _then(Positions(
positions: null == positions ? _self.positions : positions // ignore: cast_nullable_to_non_nullable
as List<Position>,totalPnl: null == totalPnl ? _self.totalPnl : totalPnl // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [Positions].
extension PositionsPatterns on Positions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Positions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Positions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Positions value)  $default,){
final _that = this;
switch (_that) {
case _Positions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Positions value)?  $default,){
final _that = this;
switch (_that) {
case _Positions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Position> positions,  double totalPnl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Positions() when $default != null:
return $default(_that.positions,_that.totalPnl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Position> positions,  double totalPnl)  $default,) {final _that = this;
switch (_that) {
case _Positions():
return $default(_that.positions,_that.totalPnl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Position> positions,  double totalPnl)?  $default,) {final _that = this;
switch (_that) {
case _Positions() when $default != null:
return $default(_that.positions,_that.totalPnl);case _:
  return null;

}
}

}

/// @nodoc


class _Positions implements Positions {
  const _Positions({required  List<Position> positions, required this.totalPnl}): _positions = positions;
  

 final  List<Position> _positions;
@override List<Position> get positions {
  if (_positions is EqualUnmodifiableListView) return _positions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_positions);
}

@override final  double totalPnl;

/// Create a copy of Positions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PositionsCopyWith<_Positions> get copyWith => __$PositionsCopyWithImpl<_Positions>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Positions&&const DeepCollectionEquality().equals(other.positions, _positions)&&(identical(other.totalPnl, totalPnl) || other.totalPnl == totalPnl));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_positions),totalPnl);
}

@override
String toString() {
    return 'Positions(positions: $positions, totalPnl: $totalPnl)';
}


}

/// @nodoc
abstract mixin class _$PositionsCopyWith<$Res> implements $PositionsCopyWith<$Res> {
  factory _$PositionsCopyWith(_Positions value, $Res Function(_Positions) _then) = __$PositionsCopyWithImpl;
@override @useResult
$Res call({
 List<Position> positions, double totalPnl
});




}
/// @nodoc
class __$PositionsCopyWithImpl<$Res>
    implements _$PositionsCopyWith<$Res> {
  __$PositionsCopyWithImpl(this._self, this._then);

  final _Positions _self;
  final $Res Function(_Positions) _then;

/// Create a copy of Positions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? positions = null,Object? totalPnl = null,}) {
  return _then(_Positions(
positions: null == positions ? _self._positions : positions // ignore: cast_nullable_to_non_nullable
as List<Position>,totalPnl: null == totalPnl ? _self.totalPnl : totalPnl // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$Order {

 String get orderId; String get symbol; OrderSide get side; int get quantity; double get price;/// The broker's own wording, shown as-is.
 String get status; String get time;
/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderCopyWith<Order> get copyWith => _$OrderCopyWithImpl<Order>(this as Order, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Order;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Order&&(identical(other.orderId, _this.orderId) || other.orderId == _this.orderId)&&(identical(other.symbol, _this.symbol) || other.symbol == _this.symbol)&&(identical(other.side, _this.side) || other.side == _this.side)&&(identical(other.quantity, _this.quantity) || other.quantity == _this.quantity)&&(identical(other.price, _this.price) || other.price == _this.price)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.time, _this.time) || other.time == _this.time));
}


@override
int get hashCode {
  final _this = this as Order;
  return Object.hash(runtimeType,_this.orderId,_this.symbol,_this.side,_this.quantity,_this.price,_this.status,_this.time);
}

@override
String toString() {
  final _this = this as Order;
  return 'Order(orderId: ${_this.orderId}, symbol: ${_this.symbol}, side: ${_this.side}, quantity: ${_this.quantity}, price: ${_this.price}, status: ${_this.status}, time: ${_this.time})';
}


}

/// @nodoc
abstract mixin class $OrderCopyWith<$Res>  {
  factory $OrderCopyWith(Order value, $Res Function(Order) _then) = _$OrderCopyWithImpl;
@useResult
$Res call({
 String orderId, String symbol, OrderSide side, int quantity, double price, String status, String time
});




}
/// @nodoc
class _$OrderCopyWithImpl<$Res>
    implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._self, this._then);

  final Order _self;
  final $Res Function(Order) _then;

/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? orderId = null,Object? symbol = null,Object? side = null,Object? quantity = null,Object? price = null,Object? status = null,Object? time = null,}) {
  return _then(Order(
orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,side: null == side ? _self.side : side // ignore: cast_nullable_to_non_nullable
as OrderSide,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Order].
extension OrderPatterns on Order {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Order value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Order() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Order value)  $default,){
final _that = this;
switch (_that) {
case _Order():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Order value)?  $default,){
final _that = this;
switch (_that) {
case _Order() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String orderId,  String symbol,  OrderSide side,  int quantity,  double price,  String status,  String time)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Order() when $default != null:
return $default(_that.orderId,_that.symbol,_that.side,_that.quantity,_that.price,_that.status,_that.time);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String orderId,  String symbol,  OrderSide side,  int quantity,  double price,  String status,  String time)  $default,) {final _that = this;
switch (_that) {
case _Order():
return $default(_that.orderId,_that.symbol,_that.side,_that.quantity,_that.price,_that.status,_that.time);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String orderId,  String symbol,  OrderSide side,  int quantity,  double price,  String status,  String time)?  $default,) {final _that = this;
switch (_that) {
case _Order() when $default != null:
return $default(_that.orderId,_that.symbol,_that.side,_that.quantity,_that.price,_that.status,_that.time);case _:
  return null;

}
}

}

/// @nodoc


class _Order extends Order {
  const _Order({required this.orderId, required this.symbol, required this.side, required this.quantity, required this.price, required this.status, required this.time}): super._();
  

@override final  String orderId;
@override final  String symbol;
@override final  OrderSide side;
@override final  int quantity;
@override final  double price;
/// The broker's own wording, shown as-is.
@override final  String status;
@override final  String time;

/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderCopyWith<_Order> get copyWith => __$OrderCopyWithImpl<_Order>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Order&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.side, side) || other.side == side)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.price, price) || other.price == price)&&(identical(other.status, status) || other.status == status)&&(identical(other.time, time) || other.time == time));
}


@override
int get hashCode {
    return Object.hash(runtimeType,orderId,symbol,side,quantity,price,status,time);
}

@override
String toString() {
    return 'Order(orderId: $orderId, symbol: $symbol, side: $side, quantity: $quantity, price: $price, status: $status, time: $time)';
}


}

/// @nodoc
abstract mixin class _$OrderCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$OrderCopyWith(_Order value, $Res Function(_Order) _then) = __$OrderCopyWithImpl;
@override @useResult
$Res call({
 String orderId, String symbol, OrderSide side, int quantity, double price, String status, String time
});




}
/// @nodoc
class __$OrderCopyWithImpl<$Res>
    implements _$OrderCopyWith<$Res> {
  __$OrderCopyWithImpl(this._self, this._then);

  final _Order _self;
  final $Res Function(_Order) _then;

/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? orderId = null,Object? symbol = null,Object? side = null,Object? quantity = null,Object? price = null,Object? status = null,Object? time = null,}) {
  return _then(_Order(
orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,side: null == side ? _self.side : side // ignore: cast_nullable_to_non_nullable
as OrderSide,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$Trade {

 String get tradeId; String get orderId; String get symbol; OrderSide get side; int get quantity; double get price; String get time; String get exchange; String get product;
/// Create a copy of Trade
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TradeCopyWith<Trade> get copyWith => _$TradeCopyWithImpl<Trade>(this as Trade, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Trade;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Trade&&(identical(other.tradeId, _this.tradeId) || other.tradeId == _this.tradeId)&&(identical(other.orderId, _this.orderId) || other.orderId == _this.orderId)&&(identical(other.symbol, _this.symbol) || other.symbol == _this.symbol)&&(identical(other.side, _this.side) || other.side == _this.side)&&(identical(other.quantity, _this.quantity) || other.quantity == _this.quantity)&&(identical(other.price, _this.price) || other.price == _this.price)&&(identical(other.time, _this.time) || other.time == _this.time)&&(identical(other.exchange, _this.exchange) || other.exchange == _this.exchange)&&(identical(other.product, _this.product) || other.product == _this.product));
}


@override
int get hashCode {
  final _this = this as Trade;
  return Object.hash(runtimeType,_this.tradeId,_this.orderId,_this.symbol,_this.side,_this.quantity,_this.price,_this.time,_this.exchange,_this.product);
}

@override
String toString() {
  final _this = this as Trade;
  return 'Trade(tradeId: ${_this.tradeId}, orderId: ${_this.orderId}, symbol: ${_this.symbol}, side: ${_this.side}, quantity: ${_this.quantity}, price: ${_this.price}, time: ${_this.time}, exchange: ${_this.exchange}, product: ${_this.product})';
}


}

/// @nodoc
abstract mixin class $TradeCopyWith<$Res>  {
  factory $TradeCopyWith(Trade value, $Res Function(Trade) _then) = _$TradeCopyWithImpl;
@useResult
$Res call({
 String tradeId, String orderId, String symbol, OrderSide side, int quantity, double price, String time, String exchange, String product
});




}
/// @nodoc
class _$TradeCopyWithImpl<$Res>
    implements $TradeCopyWith<$Res> {
  _$TradeCopyWithImpl(this._self, this._then);

  final Trade _self;
  final $Res Function(Trade) _then;

/// Create a copy of Trade
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tradeId = null,Object? orderId = null,Object? symbol = null,Object? side = null,Object? quantity = null,Object? price = null,Object? time = null,Object? exchange = null,Object? product = null,}) {
  return _then(Trade(
tradeId: null == tradeId ? _self.tradeId : tradeId // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,side: null == side ? _self.side : side // ignore: cast_nullable_to_non_nullable
as OrderSide,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,exchange: null == exchange ? _self.exchange : exchange // ignore: cast_nullable_to_non_nullable
as String,product: null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Trade].
extension TradePatterns on Trade {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Trade value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Trade() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Trade value)  $default,){
final _that = this;
switch (_that) {
case _Trade():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Trade value)?  $default,){
final _that = this;
switch (_that) {
case _Trade() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tradeId,  String orderId,  String symbol,  OrderSide side,  int quantity,  double price,  String time,  String exchange,  String product)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Trade() when $default != null:
return $default(_that.tradeId,_that.orderId,_that.symbol,_that.side,_that.quantity,_that.price,_that.time,_that.exchange,_that.product);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tradeId,  String orderId,  String symbol,  OrderSide side,  int quantity,  double price,  String time,  String exchange,  String product)  $default,) {final _that = this;
switch (_that) {
case _Trade():
return $default(_that.tradeId,_that.orderId,_that.symbol,_that.side,_that.quantity,_that.price,_that.time,_that.exchange,_that.product);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tradeId,  String orderId,  String symbol,  OrderSide side,  int quantity,  double price,  String time,  String exchange,  String product)?  $default,) {final _that = this;
switch (_that) {
case _Trade() when $default != null:
return $default(_that.tradeId,_that.orderId,_that.symbol,_that.side,_that.quantity,_that.price,_that.time,_that.exchange,_that.product);case _:
  return null;

}
}

}

/// @nodoc


class _Trade extends Trade {
  const _Trade({required this.tradeId, required this.orderId, required this.symbol, required this.side, required this.quantity, required this.price, required this.time, required this.exchange, required this.product}): super._();
  

@override final  String tradeId;
@override final  String orderId;
@override final  String symbol;
@override final  OrderSide side;
@override final  int quantity;
@override final  double price;
@override final  String time;
@override final  String exchange;
@override final  String product;

/// Create a copy of Trade
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TradeCopyWith<_Trade> get copyWith => __$TradeCopyWithImpl<_Trade>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Trade&&(identical(other.tradeId, tradeId) || other.tradeId == tradeId)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.side, side) || other.side == side)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.price, price) || other.price == price)&&(identical(other.time, time) || other.time == time)&&(identical(other.exchange, exchange) || other.exchange == exchange)&&(identical(other.product, product) || other.product == product));
}


@override
int get hashCode {
    return Object.hash(runtimeType,tradeId,orderId,symbol,side,quantity,price,time,exchange,product);
}

@override
String toString() {
    return 'Trade(tradeId: $tradeId, orderId: $orderId, symbol: $symbol, side: $side, quantity: $quantity, price: $price, time: $time, exchange: $exchange, product: $product)';
}


}

/// @nodoc
abstract mixin class _$TradeCopyWith<$Res> implements $TradeCopyWith<$Res> {
  factory _$TradeCopyWith(_Trade value, $Res Function(_Trade) _then) = __$TradeCopyWithImpl;
@override @useResult
$Res call({
 String tradeId, String orderId, String symbol, OrderSide side, int quantity, double price, String time, String exchange, String product
});




}
/// @nodoc
class __$TradeCopyWithImpl<$Res>
    implements _$TradeCopyWith<$Res> {
  __$TradeCopyWithImpl(this._self, this._then);

  final _Trade _self;
  final $Res Function(_Trade) _then;

/// Create a copy of Trade
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tradeId = null,Object? orderId = null,Object? symbol = null,Object? side = null,Object? quantity = null,Object? price = null,Object? time = null,Object? exchange = null,Object? product = null,}) {
  return _then(_Trade(
tradeId: null == tradeId ? _self.tradeId : tradeId // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,side: null == side ? _self.side : side // ignore: cast_nullable_to_non_nullable
as OrderSide,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,exchange: null == exchange ? _self.exchange : exchange // ignore: cast_nullable_to_non_nullable
as String,product: null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$BenchmarkComparison {

 double get beta;/// Mean daily excess return beyond what beta explains, as a fraction.
 double get alpha; double get rSquared; List<DateTime> get dates;/// Cumulative return to each date, in percent.
 List<double> get niftyCumulative; List<double> get portfolioCumulative; List<({double beta, String symbol,})> get stockBetas; int get daysUsed;
/// Create a copy of BenchmarkComparison
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BenchmarkComparisonCopyWith<BenchmarkComparison> get copyWith => _$BenchmarkComparisonCopyWithImpl<BenchmarkComparison>(this as BenchmarkComparison, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BenchmarkComparison;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BenchmarkComparison&&(identical(other.beta, _this.beta) || other.beta == _this.beta)&&(identical(other.alpha, _this.alpha) || other.alpha == _this.alpha)&&(identical(other.rSquared, _this.rSquared) || other.rSquared == _this.rSquared)&&const DeepCollectionEquality().equals(other.dates, _this.dates)&&const DeepCollectionEquality().equals(other.niftyCumulative, _this.niftyCumulative)&&const DeepCollectionEquality().equals(other.portfolioCumulative, _this.portfolioCumulative)&&const DeepCollectionEquality().equals(other.stockBetas, _this.stockBetas)&&(identical(other.daysUsed, _this.daysUsed) || other.daysUsed == _this.daysUsed));
}


@override
int get hashCode {
  final _this = this as BenchmarkComparison;
  return Object.hash(runtimeType,_this.beta,_this.alpha,_this.rSquared,const DeepCollectionEquality().hash(_this.dates),const DeepCollectionEquality().hash(_this.niftyCumulative),const DeepCollectionEquality().hash(_this.portfolioCumulative),const DeepCollectionEquality().hash(_this.stockBetas),_this.daysUsed);
}

@override
String toString() {
  final _this = this as BenchmarkComparison;
  return 'BenchmarkComparison(beta: ${_this.beta}, alpha: ${_this.alpha}, rSquared: ${_this.rSquared}, dates: ${_this.dates}, niftyCumulative: ${_this.niftyCumulative}, portfolioCumulative: ${_this.portfolioCumulative}, stockBetas: ${_this.stockBetas}, daysUsed: ${_this.daysUsed})';
}


}

/// @nodoc
abstract mixin class $BenchmarkComparisonCopyWith<$Res>  {
  factory $BenchmarkComparisonCopyWith(BenchmarkComparison value, $Res Function(BenchmarkComparison) _then) = _$BenchmarkComparisonCopyWithImpl;
@useResult
$Res call({
 double beta, double alpha, double rSquared, List<DateTime> dates, List<double> niftyCumulative, List<double> portfolioCumulative, List<({double beta, String symbol,})> stockBetas, int daysUsed
});




}
/// @nodoc
class _$BenchmarkComparisonCopyWithImpl<$Res>
    implements $BenchmarkComparisonCopyWith<$Res> {
  _$BenchmarkComparisonCopyWithImpl(this._self, this._then);

  final BenchmarkComparison _self;
  final $Res Function(BenchmarkComparison) _then;

/// Create a copy of BenchmarkComparison
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? beta = null,Object? alpha = null,Object? rSquared = null,Object? dates = null,Object? niftyCumulative = null,Object? portfolioCumulative = null,Object? stockBetas = null,Object? daysUsed = null,}) {
  return _then(BenchmarkComparison(
beta: null == beta ? _self.beta : beta // ignore: cast_nullable_to_non_nullable
as double,alpha: null == alpha ? _self.alpha : alpha // ignore: cast_nullable_to_non_nullable
as double,rSquared: null == rSquared ? _self.rSquared : rSquared // ignore: cast_nullable_to_non_nullable
as double,dates: null == dates ? _self.dates : dates // ignore: cast_nullable_to_non_nullable
as List<DateTime>,niftyCumulative: null == niftyCumulative ? _self.niftyCumulative : niftyCumulative // ignore: cast_nullable_to_non_nullable
as List<double>,portfolioCumulative: null == portfolioCumulative ? _self.portfolioCumulative : portfolioCumulative // ignore: cast_nullable_to_non_nullable
as List<double>,stockBetas: null == stockBetas ? _self.stockBetas : stockBetas // ignore: cast_nullable_to_non_nullable
as List<({double beta, String symbol,})>,daysUsed: null == daysUsed ? _self.daysUsed : daysUsed // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BenchmarkComparison].
extension BenchmarkComparisonPatterns on BenchmarkComparison {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BenchmarkComparison value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BenchmarkComparison() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BenchmarkComparison value)  $default,){
final _that = this;
switch (_that) {
case _BenchmarkComparison():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BenchmarkComparison value)?  $default,){
final _that = this;
switch (_that) {
case _BenchmarkComparison() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double beta,  double alpha,  double rSquared,  List<DateTime> dates,  List<double> niftyCumulative,  List<double> portfolioCumulative,  List<({double beta, String symbol,})> stockBetas,  int daysUsed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BenchmarkComparison() when $default != null:
return $default(_that.beta,_that.alpha,_that.rSquared,_that.dates,_that.niftyCumulative,_that.portfolioCumulative,_that.stockBetas,_that.daysUsed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double beta,  double alpha,  double rSquared,  List<DateTime> dates,  List<double> niftyCumulative,  List<double> portfolioCumulative,  List<({double beta, String symbol,})> stockBetas,  int daysUsed)  $default,) {final _that = this;
switch (_that) {
case _BenchmarkComparison():
return $default(_that.beta,_that.alpha,_that.rSquared,_that.dates,_that.niftyCumulative,_that.portfolioCumulative,_that.stockBetas,_that.daysUsed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double beta,  double alpha,  double rSquared,  List<DateTime> dates,  List<double> niftyCumulative,  List<double> portfolioCumulative,  List<({double beta, String symbol,})> stockBetas,  int daysUsed)?  $default,) {final _that = this;
switch (_that) {
case _BenchmarkComparison() when $default != null:
return $default(_that.beta,_that.alpha,_that.rSquared,_that.dates,_that.niftyCumulative,_that.portfolioCumulative,_that.stockBetas,_that.daysUsed);case _:
  return null;

}
}

}

/// @nodoc


class _BenchmarkComparison implements BenchmarkComparison {
  const _BenchmarkComparison({required this.beta, required this.alpha, required this.rSquared, required  List<DateTime> dates, required  List<double> niftyCumulative, required  List<double> portfolioCumulative, required  List<({double beta, String symbol,})> stockBetas, required this.daysUsed}): _dates = dates,_niftyCumulative = niftyCumulative,_portfolioCumulative = portfolioCumulative,_stockBetas = stockBetas;
  

@override final  double beta;
/// Mean daily excess return beyond what beta explains, as a fraction.
@override final  double alpha;
@override final  double rSquared;
 final  List<DateTime> _dates;
@override List<DateTime> get dates {
  if (_dates is EqualUnmodifiableListView) return _dates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dates);
}

/// Cumulative return to each date, in percent.
 final  List<double> _niftyCumulative;
/// Cumulative return to each date, in percent.
@override List<double> get niftyCumulative {
  if (_niftyCumulative is EqualUnmodifiableListView) return _niftyCumulative;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_niftyCumulative);
}

 final  List<double> _portfolioCumulative;
@override List<double> get portfolioCumulative {
  if (_portfolioCumulative is EqualUnmodifiableListView) return _portfolioCumulative;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_portfolioCumulative);
}

 final  List<({double beta, String symbol,})> _stockBetas;
@override List<({double beta, String symbol,})> get stockBetas {
  if (_stockBetas is EqualUnmodifiableListView) return _stockBetas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stockBetas);
}

@override final  int daysUsed;

/// Create a copy of BenchmarkComparison
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BenchmarkComparisonCopyWith<_BenchmarkComparison> get copyWith => __$BenchmarkComparisonCopyWithImpl<_BenchmarkComparison>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BenchmarkComparison&&(identical(other.beta, beta) || other.beta == beta)&&(identical(other.alpha, alpha) || other.alpha == alpha)&&(identical(other.rSquared, rSquared) || other.rSquared == rSquared)&&const DeepCollectionEquality().equals(other.dates, _dates)&&const DeepCollectionEquality().equals(other.niftyCumulative, _niftyCumulative)&&const DeepCollectionEquality().equals(other.portfolioCumulative, _portfolioCumulative)&&const DeepCollectionEquality().equals(other.stockBetas, _stockBetas)&&(identical(other.daysUsed, daysUsed) || other.daysUsed == daysUsed));
}


@override
int get hashCode {
    return Object.hash(runtimeType,beta,alpha,rSquared,const DeepCollectionEquality().hash(_dates),const DeepCollectionEquality().hash(_niftyCumulative),const DeepCollectionEquality().hash(_portfolioCumulative),const DeepCollectionEquality().hash(_stockBetas),daysUsed);
}

@override
String toString() {
    return 'BenchmarkComparison(beta: $beta, alpha: $alpha, rSquared: $rSquared, dates: $dates, niftyCumulative: $niftyCumulative, portfolioCumulative: $portfolioCumulative, stockBetas: $stockBetas, daysUsed: $daysUsed)';
}


}

/// @nodoc
abstract mixin class _$BenchmarkComparisonCopyWith<$Res> implements $BenchmarkComparisonCopyWith<$Res> {
  factory _$BenchmarkComparisonCopyWith(_BenchmarkComparison value, $Res Function(_BenchmarkComparison) _then) = __$BenchmarkComparisonCopyWithImpl;
@override @useResult
$Res call({
 double beta, double alpha, double rSquared, List<DateTime> dates, List<double> niftyCumulative, List<double> portfolioCumulative, List<({double beta, String symbol,})> stockBetas, int daysUsed
});




}
/// @nodoc
class __$BenchmarkComparisonCopyWithImpl<$Res>
    implements _$BenchmarkComparisonCopyWith<$Res> {
  __$BenchmarkComparisonCopyWithImpl(this._self, this._then);

  final _BenchmarkComparison _self;
  final $Res Function(_BenchmarkComparison) _then;

/// Create a copy of BenchmarkComparison
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? beta = null,Object? alpha = null,Object? rSquared = null,Object? dates = null,Object? niftyCumulative = null,Object? portfolioCumulative = null,Object? stockBetas = null,Object? daysUsed = null,}) {
  return _then(_BenchmarkComparison(
beta: null == beta ? _self.beta : beta // ignore: cast_nullable_to_non_nullable
as double,alpha: null == alpha ? _self.alpha : alpha // ignore: cast_nullable_to_non_nullable
as double,rSquared: null == rSquared ? _self.rSquared : rSquared // ignore: cast_nullable_to_non_nullable
as double,dates: null == dates ? _self._dates : dates // ignore: cast_nullable_to_non_nullable
as List<DateTime>,niftyCumulative: null == niftyCumulative ? _self._niftyCumulative : niftyCumulative // ignore: cast_nullable_to_non_nullable
as List<double>,portfolioCumulative: null == portfolioCumulative ? _self._portfolioCumulative : portfolioCumulative // ignore: cast_nullable_to_non_nullable
as List<double>,stockBetas: null == stockBetas ? _self._stockBetas : stockBetas // ignore: cast_nullable_to_non_nullable
as List<({double beta, String symbol,})>,daysUsed: null == daysUsed ? _self.daysUsed : daysUsed // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
