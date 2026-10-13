// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trading.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RiskProfile {

 int get age; InvestmentGoal get goal; int get horizonYears; RiskTolerance get tolerance; String get taxBracket; double get maxOrderValue; double get maxPositionPercent; int get maxDailyTrades; Set<ProductType> get products;
/// Create a copy of RiskProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RiskProfileCopyWith<RiskProfile> get copyWith => _$RiskProfileCopyWithImpl<RiskProfile>(this as RiskProfile, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RiskProfile;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RiskProfile&&(identical(other.age, _this.age) || other.age == _this.age)&&(identical(other.goal, _this.goal) || other.goal == _this.goal)&&(identical(other.horizonYears, _this.horizonYears) || other.horizonYears == _this.horizonYears)&&(identical(other.tolerance, _this.tolerance) || other.tolerance == _this.tolerance)&&(identical(other.taxBracket, _this.taxBracket) || other.taxBracket == _this.taxBracket)&&(identical(other.maxOrderValue, _this.maxOrderValue) || other.maxOrderValue == _this.maxOrderValue)&&(identical(other.maxPositionPercent, _this.maxPositionPercent) || other.maxPositionPercent == _this.maxPositionPercent)&&(identical(other.maxDailyTrades, _this.maxDailyTrades) || other.maxDailyTrades == _this.maxDailyTrades)&&const DeepCollectionEquality().equals(other.products, _this.products));
}


@override
int get hashCode {
  final _this = this as RiskProfile;
  return Object.hash(runtimeType,_this.age,_this.goal,_this.horizonYears,_this.tolerance,_this.taxBracket,_this.maxOrderValue,_this.maxPositionPercent,_this.maxDailyTrades,const DeepCollectionEquality().hash(_this.products));
}

@override
String toString() {
  final _this = this as RiskProfile;
  return 'RiskProfile(age: ${_this.age}, goal: ${_this.goal}, horizonYears: ${_this.horizonYears}, tolerance: ${_this.tolerance}, taxBracket: ${_this.taxBracket}, maxOrderValue: ${_this.maxOrderValue}, maxPositionPercent: ${_this.maxPositionPercent}, maxDailyTrades: ${_this.maxDailyTrades}, products: ${_this.products})';
}


}

/// @nodoc
abstract mixin class $RiskProfileCopyWith<$Res>  {
  factory $RiskProfileCopyWith(RiskProfile value, $Res Function(RiskProfile) _then) = _$RiskProfileCopyWithImpl;
@useResult
$Res call({
 int age, InvestmentGoal goal, int horizonYears, RiskTolerance tolerance, String taxBracket, double maxOrderValue, double maxPositionPercent, int maxDailyTrades, Set<ProductType> products
});




}
/// @nodoc
class _$RiskProfileCopyWithImpl<$Res>
    implements $RiskProfileCopyWith<$Res> {
  _$RiskProfileCopyWithImpl(this._self, this._then);

  final RiskProfile _self;
  final $Res Function(RiskProfile) _then;

/// Create a copy of RiskProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? age = null,Object? goal = null,Object? horizonYears = null,Object? tolerance = null,Object? taxBracket = null,Object? maxOrderValue = null,Object? maxPositionPercent = null,Object? maxDailyTrades = null,Object? products = null,}) {
  return _then(RiskProfile(
age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int,goal: null == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as InvestmentGoal,horizonYears: null == horizonYears ? _self.horizonYears : horizonYears // ignore: cast_nullable_to_non_nullable
as int,tolerance: null == tolerance ? _self.tolerance : tolerance // ignore: cast_nullable_to_non_nullable
as RiskTolerance,taxBracket: null == taxBracket ? _self.taxBracket : taxBracket // ignore: cast_nullable_to_non_nullable
as String,maxOrderValue: null == maxOrderValue ? _self.maxOrderValue : maxOrderValue // ignore: cast_nullable_to_non_nullable
as double,maxPositionPercent: null == maxPositionPercent ? _self.maxPositionPercent : maxPositionPercent // ignore: cast_nullable_to_non_nullable
as double,maxDailyTrades: null == maxDailyTrades ? _self.maxDailyTrades : maxDailyTrades // ignore: cast_nullable_to_non_nullable
as int,products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as Set<ProductType>,
  ));
}

}


/// Adds pattern-matching-related methods to [RiskProfile].
extension RiskProfilePatterns on RiskProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RiskProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RiskProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RiskProfile value)  $default,){
final _that = this;
switch (_that) {
case _RiskProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RiskProfile value)?  $default,){
final _that = this;
switch (_that) {
case _RiskProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int age,  InvestmentGoal goal,  int horizonYears,  RiskTolerance tolerance,  String taxBracket,  double maxOrderValue,  double maxPositionPercent,  int maxDailyTrades,  Set<ProductType> products)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RiskProfile() when $default != null:
return $default(_that.age,_that.goal,_that.horizonYears,_that.tolerance,_that.taxBracket,_that.maxOrderValue,_that.maxPositionPercent,_that.maxDailyTrades,_that.products);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int age,  InvestmentGoal goal,  int horizonYears,  RiskTolerance tolerance,  String taxBracket,  double maxOrderValue,  double maxPositionPercent,  int maxDailyTrades,  Set<ProductType> products)  $default,) {final _that = this;
switch (_that) {
case _RiskProfile():
return $default(_that.age,_that.goal,_that.horizonYears,_that.tolerance,_that.taxBracket,_that.maxOrderValue,_that.maxPositionPercent,_that.maxDailyTrades,_that.products);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int age,  InvestmentGoal goal,  int horizonYears,  RiskTolerance tolerance,  String taxBracket,  double maxOrderValue,  double maxPositionPercent,  int maxDailyTrades,  Set<ProductType> products)?  $default,) {final _that = this;
switch (_that) {
case _RiskProfile() when $default != null:
return $default(_that.age,_that.goal,_that.horizonYears,_that.tolerance,_that.taxBracket,_that.maxOrderValue,_that.maxPositionPercent,_that.maxDailyTrades,_that.products);case _:
  return null;

}
}

}

/// @nodoc


class _RiskProfile implements RiskProfile {
  const _RiskProfile({required this.age, required this.goal, required this.horizonYears, required this.tolerance, required this.taxBracket, required this.maxOrderValue, required this.maxPositionPercent, required this.maxDailyTrades, required  Set<ProductType> products}): _products = products;
  

@override final  int age;
@override final  InvestmentGoal goal;
@override final  int horizonYears;
@override final  RiskTolerance tolerance;
@override final  String taxBracket;
@override final  double maxOrderValue;
@override final  double maxPositionPercent;
@override final  int maxDailyTrades;
 final  Set<ProductType> _products;
@override Set<ProductType> get products {
  if (_products is EqualUnmodifiableSetView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_products);
}


/// Create a copy of RiskProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RiskProfileCopyWith<_RiskProfile> get copyWith => __$RiskProfileCopyWithImpl<_RiskProfile>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RiskProfile&&(identical(other.age, age) || other.age == age)&&(identical(other.goal, goal) || other.goal == goal)&&(identical(other.horizonYears, horizonYears) || other.horizonYears == horizonYears)&&(identical(other.tolerance, tolerance) || other.tolerance == tolerance)&&(identical(other.taxBracket, taxBracket) || other.taxBracket == taxBracket)&&(identical(other.maxOrderValue, maxOrderValue) || other.maxOrderValue == maxOrderValue)&&(identical(other.maxPositionPercent, maxPositionPercent) || other.maxPositionPercent == maxPositionPercent)&&(identical(other.maxDailyTrades, maxDailyTrades) || other.maxDailyTrades == maxDailyTrades)&&const DeepCollectionEquality().equals(other.products, _products));
}


@override
int get hashCode {
    return Object.hash(runtimeType,age,goal,horizonYears,tolerance,taxBracket,maxOrderValue,maxPositionPercent,maxDailyTrades,const DeepCollectionEquality().hash(_products));
}

@override
String toString() {
    return 'RiskProfile(age: $age, goal: $goal, horizonYears: $horizonYears, tolerance: $tolerance, taxBracket: $taxBracket, maxOrderValue: $maxOrderValue, maxPositionPercent: $maxPositionPercent, maxDailyTrades: $maxDailyTrades, products: $products)';
}


}

/// @nodoc
abstract mixin class _$RiskProfileCopyWith<$Res> implements $RiskProfileCopyWith<$Res> {
  factory _$RiskProfileCopyWith(_RiskProfile value, $Res Function(_RiskProfile) _then) = __$RiskProfileCopyWithImpl;
@override @useResult
$Res call({
 int age, InvestmentGoal goal, int horizonYears, RiskTolerance tolerance, String taxBracket, double maxOrderValue, double maxPositionPercent, int maxDailyTrades, Set<ProductType> products
});




}
/// @nodoc
class __$RiskProfileCopyWithImpl<$Res>
    implements _$RiskProfileCopyWith<$Res> {
  __$RiskProfileCopyWithImpl(this._self, this._then);

  final _RiskProfile _self;
  final $Res Function(_RiskProfile) _then;

/// Create a copy of RiskProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? age = null,Object? goal = null,Object? horizonYears = null,Object? tolerance = null,Object? taxBracket = null,Object? maxOrderValue = null,Object? maxPositionPercent = null,Object? maxDailyTrades = null,Object? products = null,}) {
  return _then(_RiskProfile(
age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int,goal: null == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as InvestmentGoal,horizonYears: null == horizonYears ? _self.horizonYears : horizonYears // ignore: cast_nullable_to_non_nullable
as int,tolerance: null == tolerance ? _self.tolerance : tolerance // ignore: cast_nullable_to_non_nullable
as RiskTolerance,taxBracket: null == taxBracket ? _self.taxBracket : taxBracket // ignore: cast_nullable_to_non_nullable
as String,maxOrderValue: null == maxOrderValue ? _self.maxOrderValue : maxOrderValue // ignore: cast_nullable_to_non_nullable
as double,maxPositionPercent: null == maxPositionPercent ? _self.maxPositionPercent : maxPositionPercent // ignore: cast_nullable_to_non_nullable
as double,maxDailyTrades: null == maxDailyTrades ? _self.maxDailyTrades : maxDailyTrades // ignore: cast_nullable_to_non_nullable
as int,products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as Set<ProductType>,
  ));
}


}

/// @nodoc
mixin _$ProposedOrder {

 String get symbol; TradeSide get side; int get quantity;/// Null for a market order.
 double? get price; double? get triggerPrice; String get orderType; String get product; String get exchange; String? get symbolToken;
/// Create a copy of ProposedOrder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProposedOrderCopyWith<ProposedOrder> get copyWith => _$ProposedOrderCopyWithImpl<ProposedOrder>(this as ProposedOrder, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ProposedOrder;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProposedOrder&&(identical(other.symbol, _this.symbol) || other.symbol == _this.symbol)&&(identical(other.side, _this.side) || other.side == _this.side)&&(identical(other.quantity, _this.quantity) || other.quantity == _this.quantity)&&(identical(other.price, _this.price) || other.price == _this.price)&&(identical(other.triggerPrice, _this.triggerPrice) || other.triggerPrice == _this.triggerPrice)&&(identical(other.orderType, _this.orderType) || other.orderType == _this.orderType)&&(identical(other.product, _this.product) || other.product == _this.product)&&(identical(other.exchange, _this.exchange) || other.exchange == _this.exchange)&&(identical(other.symbolToken, _this.symbolToken) || other.symbolToken == _this.symbolToken));
}


@override
int get hashCode {
  final _this = this as ProposedOrder;
  return Object.hash(runtimeType,_this.symbol,_this.side,_this.quantity,_this.price,_this.triggerPrice,_this.orderType,_this.product,_this.exchange,_this.symbolToken);
}

@override
String toString() {
  final _this = this as ProposedOrder;
  return 'ProposedOrder(symbol: ${_this.symbol}, side: ${_this.side}, quantity: ${_this.quantity}, price: ${_this.price}, triggerPrice: ${_this.triggerPrice}, orderType: ${_this.orderType}, product: ${_this.product}, exchange: ${_this.exchange}, symbolToken: ${_this.symbolToken})';
}


}

/// @nodoc
abstract mixin class $ProposedOrderCopyWith<$Res>  {
  factory $ProposedOrderCopyWith(ProposedOrder value, $Res Function(ProposedOrder) _then) = _$ProposedOrderCopyWithImpl;
@useResult
$Res call({
 String symbol, TradeSide side, int quantity, double? price, double? triggerPrice, String orderType, String product, String exchange, String? symbolToken
});




}
/// @nodoc
class _$ProposedOrderCopyWithImpl<$Res>
    implements $ProposedOrderCopyWith<$Res> {
  _$ProposedOrderCopyWithImpl(this._self, this._then);

  final ProposedOrder _self;
  final $Res Function(ProposedOrder) _then;

/// Create a copy of ProposedOrder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? side = null,Object? quantity = null,Object? price = freezed,Object? triggerPrice = freezed,Object? orderType = null,Object? product = null,Object? exchange = null,Object? symbolToken = freezed,}) {
  return _then(ProposedOrder(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,side: null == side ? _self.side : side // ignore: cast_nullable_to_non_nullable
as TradeSide,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,triggerPrice: freezed == triggerPrice ? _self.triggerPrice : triggerPrice // ignore: cast_nullable_to_non_nullable
as double?,orderType: null == orderType ? _self.orderType : orderType // ignore: cast_nullable_to_non_nullable
as String,product: null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as String,exchange: null == exchange ? _self.exchange : exchange // ignore: cast_nullable_to_non_nullable
as String,symbolToken: freezed == symbolToken ? _self.symbolToken : symbolToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProposedOrder].
extension ProposedOrderPatterns on ProposedOrder {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProposedOrder value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProposedOrder() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProposedOrder value)  $default,){
final _that = this;
switch (_that) {
case _ProposedOrder():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProposedOrder value)?  $default,){
final _that = this;
switch (_that) {
case _ProposedOrder() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  TradeSide side,  int quantity,  double? price,  double? triggerPrice,  String orderType,  String product,  String exchange,  String? symbolToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProposedOrder() when $default != null:
return $default(_that.symbol,_that.side,_that.quantity,_that.price,_that.triggerPrice,_that.orderType,_that.product,_that.exchange,_that.symbolToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  TradeSide side,  int quantity,  double? price,  double? triggerPrice,  String orderType,  String product,  String exchange,  String? symbolToken)  $default,) {final _that = this;
switch (_that) {
case _ProposedOrder():
return $default(_that.symbol,_that.side,_that.quantity,_that.price,_that.triggerPrice,_that.orderType,_that.product,_that.exchange,_that.symbolToken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  TradeSide side,  int quantity,  double? price,  double? triggerPrice,  String orderType,  String product,  String exchange,  String? symbolToken)?  $default,) {final _that = this;
switch (_that) {
case _ProposedOrder() when $default != null:
return $default(_that.symbol,_that.side,_that.quantity,_that.price,_that.triggerPrice,_that.orderType,_that.product,_that.exchange,_that.symbolToken);case _:
  return null;

}
}

}

/// @nodoc


class _ProposedOrder implements ProposedOrder {
  const _ProposedOrder({required this.symbol, required this.side, required this.quantity, this.price, this.triggerPrice, this.orderType = '', this.product = '', this.exchange = 'NSE', this.symbolToken});
  

@override final  String symbol;
@override final  TradeSide side;
@override final  int quantity;
/// Null for a market order.
@override final  double? price;
@override final  double? triggerPrice;
@override@JsonKey() final  String orderType;
@override@JsonKey() final  String product;
@override@JsonKey() final  String exchange;
@override final  String? symbolToken;

/// Create a copy of ProposedOrder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProposedOrderCopyWith<_ProposedOrder> get copyWith => __$ProposedOrderCopyWithImpl<_ProposedOrder>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProposedOrder&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.side, side) || other.side == side)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.price, price) || other.price == price)&&(identical(other.triggerPrice, triggerPrice) || other.triggerPrice == triggerPrice)&&(identical(other.orderType, orderType) || other.orderType == orderType)&&(identical(other.product, product) || other.product == product)&&(identical(other.exchange, exchange) || other.exchange == exchange)&&(identical(other.symbolToken, symbolToken) || other.symbolToken == symbolToken));
}


@override
int get hashCode {
    return Object.hash(runtimeType,symbol,side,quantity,price,triggerPrice,orderType,product,exchange,symbolToken);
}

@override
String toString() {
    return 'ProposedOrder(symbol: $symbol, side: $side, quantity: $quantity, price: $price, triggerPrice: $triggerPrice, orderType: $orderType, product: $product, exchange: $exchange, symbolToken: $symbolToken)';
}


}

/// @nodoc
abstract mixin class _$ProposedOrderCopyWith<$Res> implements $ProposedOrderCopyWith<$Res> {
  factory _$ProposedOrderCopyWith(_ProposedOrder value, $Res Function(_ProposedOrder) _then) = __$ProposedOrderCopyWithImpl;
@override @useResult
$Res call({
 String symbol, TradeSide side, int quantity, double? price, double? triggerPrice, String orderType, String product, String exchange, String? symbolToken
});




}
/// @nodoc
class __$ProposedOrderCopyWithImpl<$Res>
    implements _$ProposedOrderCopyWith<$Res> {
  __$ProposedOrderCopyWithImpl(this._self, this._then);

  final _ProposedOrder _self;
  final $Res Function(_ProposedOrder) _then;

/// Create a copy of ProposedOrder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? side = null,Object? quantity = null,Object? price = freezed,Object? triggerPrice = freezed,Object? orderType = null,Object? product = null,Object? exchange = null,Object? symbolToken = freezed,}) {
  return _then(_ProposedOrder(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,side: null == side ? _self.side : side // ignore: cast_nullable_to_non_nullable
as TradeSide,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,triggerPrice: freezed == triggerPrice ? _self.triggerPrice : triggerPrice // ignore: cast_nullable_to_non_nullable
as double?,orderType: null == orderType ? _self.orderType : orderType // ignore: cast_nullable_to_non_nullable
as String,product: null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as String,exchange: null == exchange ? _self.exchange : exchange // ignore: cast_nullable_to_non_nullable
as String,symbolToken: freezed == symbolToken ? _self.symbolToken : symbolToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$TradeProposal {

 String get id; ProposalStatus get status; String get summary; ProposedOrder get order;/// Server time.
 DateTime get createdAt; Duration get ttl; String? get orderId; String? get error;
/// Create a copy of TradeProposal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TradeProposalCopyWith<TradeProposal> get copyWith => _$TradeProposalCopyWithImpl<TradeProposal>(this as TradeProposal, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TradeProposal;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TradeProposal&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.summary, _this.summary) || other.summary == _this.summary)&&(identical(other.order, _this.order) || other.order == _this.order)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.ttl, _this.ttl) || other.ttl == _this.ttl)&&(identical(other.orderId, _this.orderId) || other.orderId == _this.orderId)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as TradeProposal;
  return Object.hash(runtimeType,_this.id,_this.status,_this.summary,_this.order,_this.createdAt,_this.ttl,_this.orderId,_this.error);
}

@override
String toString() {
  final _this = this as TradeProposal;
  return 'TradeProposal(id: ${_this.id}, status: ${_this.status}, summary: ${_this.summary}, order: ${_this.order}, createdAt: ${_this.createdAt}, ttl: ${_this.ttl}, orderId: ${_this.orderId}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $TradeProposalCopyWith<$Res>  {
  factory $TradeProposalCopyWith(TradeProposal value, $Res Function(TradeProposal) _then) = _$TradeProposalCopyWithImpl;
@useResult
$Res call({
 String id, ProposalStatus status, String summary, ProposedOrder order, DateTime createdAt, Duration ttl, String? orderId, String? error
});


$ProposedOrderCopyWith<$Res> get order;

}
/// @nodoc
class _$TradeProposalCopyWithImpl<$Res>
    implements $TradeProposalCopyWith<$Res> {
  _$TradeProposalCopyWithImpl(this._self, this._then);

  final TradeProposal _self;
  final $Res Function(TradeProposal) _then;

/// Create a copy of TradeProposal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? status = null,Object? summary = null,Object? order = null,Object? createdAt = null,Object? ttl = null,Object? orderId = freezed,Object? error = freezed,}) {
  return _then(TradeProposal(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ProposalStatus,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as ProposedOrder,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,ttl: null == ttl ? _self.ttl : ttl // ignore: cast_nullable_to_non_nullable
as Duration,orderId: freezed == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of TradeProposal
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProposedOrderCopyWith<$Res> get order {
  
  return $ProposedOrderCopyWith<$Res>(_self.order, (value) {
    return _then(_self.copyWith(order: value));
  });
}
}


/// Adds pattern-matching-related methods to [TradeProposal].
extension TradeProposalPatterns on TradeProposal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TradeProposal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TradeProposal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TradeProposal value)  $default,){
final _that = this;
switch (_that) {
case _TradeProposal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TradeProposal value)?  $default,){
final _that = this;
switch (_that) {
case _TradeProposal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  ProposalStatus status,  String summary,  ProposedOrder order,  DateTime createdAt,  Duration ttl,  String? orderId,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TradeProposal() when $default != null:
return $default(_that.id,_that.status,_that.summary,_that.order,_that.createdAt,_that.ttl,_that.orderId,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  ProposalStatus status,  String summary,  ProposedOrder order,  DateTime createdAt,  Duration ttl,  String? orderId,  String? error)  $default,) {final _that = this;
switch (_that) {
case _TradeProposal():
return $default(_that.id,_that.status,_that.summary,_that.order,_that.createdAt,_that.ttl,_that.orderId,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  ProposalStatus status,  String summary,  ProposedOrder order,  DateTime createdAt,  Duration ttl,  String? orderId,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _TradeProposal() when $default != null:
return $default(_that.id,_that.status,_that.summary,_that.order,_that.createdAt,_that.ttl,_that.orderId,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _TradeProposal extends TradeProposal {
  const _TradeProposal({required this.id, required this.status, required this.summary, required this.order, required this.createdAt, required this.ttl, this.orderId, this.error}): super._();
  

@override final  String id;
@override final  ProposalStatus status;
@override final  String summary;
@override final  ProposedOrder order;
/// Server time.
@override final  DateTime createdAt;
@override final  Duration ttl;
@override final  String? orderId;
@override final  String? error;

/// Create a copy of TradeProposal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TradeProposalCopyWith<_TradeProposal> get copyWith => __$TradeProposalCopyWithImpl<_TradeProposal>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TradeProposal&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.order, order) || other.order == order)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.ttl, ttl) || other.ttl == ttl)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,status,summary,order,createdAt,ttl,orderId,error);
}

@override
String toString() {
    return 'TradeProposal(id: $id, status: $status, summary: $summary, order: $order, createdAt: $createdAt, ttl: $ttl, orderId: $orderId, error: $error)';
}


}

/// @nodoc
abstract mixin class _$TradeProposalCopyWith<$Res> implements $TradeProposalCopyWith<$Res> {
  factory _$TradeProposalCopyWith(_TradeProposal value, $Res Function(_TradeProposal) _then) = __$TradeProposalCopyWithImpl;
@override @useResult
$Res call({
 String id, ProposalStatus status, String summary, ProposedOrder order, DateTime createdAt, Duration ttl, String? orderId, String? error
});


@override $ProposedOrderCopyWith<$Res> get order;

}
/// @nodoc
class __$TradeProposalCopyWithImpl<$Res>
    implements _$TradeProposalCopyWith<$Res> {
  __$TradeProposalCopyWithImpl(this._self, this._then);

  final _TradeProposal _self;
  final $Res Function(_TradeProposal) _then;

/// Create a copy of TradeProposal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? status = null,Object? summary = null,Object? order = null,Object? createdAt = null,Object? ttl = null,Object? orderId = freezed,Object? error = freezed,}) {
  return _then(_TradeProposal(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ProposalStatus,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as ProposedOrder,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,ttl: null == ttl ? _self.ttl : ttl // ignore: cast_nullable_to_non_nullable
as Duration,orderId: freezed == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of TradeProposal
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProposedOrderCopyWith<$Res> get order {
  
  return $ProposedOrderCopyWith<$Res>(_self.order, (value) {
    return _then(_self.copyWith(order: value));
  });
}
}

/// @nodoc
mixin _$ExecutionResult {

 bool get ok; String? get orderId; String? get error;
/// Create a copy of ExecutionResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExecutionResultCopyWith<ExecutionResult> get copyWith => _$ExecutionResultCopyWithImpl<ExecutionResult>(this as ExecutionResult, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ExecutionResult;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExecutionResult&&(identical(other.ok, _this.ok) || other.ok == _this.ok)&&(identical(other.orderId, _this.orderId) || other.orderId == _this.orderId)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as ExecutionResult;
  return Object.hash(runtimeType,_this.ok,_this.orderId,_this.error);
}

@override
String toString() {
  final _this = this as ExecutionResult;
  return 'ExecutionResult(ok: ${_this.ok}, orderId: ${_this.orderId}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $ExecutionResultCopyWith<$Res>  {
  factory $ExecutionResultCopyWith(ExecutionResult value, $Res Function(ExecutionResult) _then) = _$ExecutionResultCopyWithImpl;
@useResult
$Res call({
 bool ok, String? orderId, String? error
});




}
/// @nodoc
class _$ExecutionResultCopyWithImpl<$Res>
    implements $ExecutionResultCopyWith<$Res> {
  _$ExecutionResultCopyWithImpl(this._self, this._then);

  final ExecutionResult _self;
  final $Res Function(ExecutionResult) _then;

/// Create a copy of ExecutionResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ok = null,Object? orderId = freezed,Object? error = freezed,}) {
  return _then(ExecutionResult(
ok: null == ok ? _self.ok : ok // ignore: cast_nullable_to_non_nullable
as bool,orderId: freezed == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ExecutionResult].
extension ExecutionResultPatterns on ExecutionResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExecutionResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExecutionResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExecutionResult value)  $default,){
final _that = this;
switch (_that) {
case _ExecutionResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExecutionResult value)?  $default,){
final _that = this;
switch (_that) {
case _ExecutionResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool ok,  String? orderId,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExecutionResult() when $default != null:
return $default(_that.ok,_that.orderId,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool ok,  String? orderId,  String? error)  $default,) {final _that = this;
switch (_that) {
case _ExecutionResult():
return $default(_that.ok,_that.orderId,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool ok,  String? orderId,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _ExecutionResult() when $default != null:
return $default(_that.ok,_that.orderId,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _ExecutionResult implements ExecutionResult {
  const _ExecutionResult({required this.ok, this.orderId, this.error});
  

@override final  bool ok;
@override final  String? orderId;
@override final  String? error;

/// Create a copy of ExecutionResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExecutionResultCopyWith<_ExecutionResult> get copyWith => __$ExecutionResultCopyWithImpl<_ExecutionResult>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExecutionResult&&(identical(other.ok, ok) || other.ok == ok)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,ok,orderId,error);
}

@override
String toString() {
    return 'ExecutionResult(ok: $ok, orderId: $orderId, error: $error)';
}


}

/// @nodoc
abstract mixin class _$ExecutionResultCopyWith<$Res> implements $ExecutionResultCopyWith<$Res> {
  factory _$ExecutionResultCopyWith(_ExecutionResult value, $Res Function(_ExecutionResult) _then) = __$ExecutionResultCopyWithImpl;
@override @useResult
$Res call({
 bool ok, String? orderId, String? error
});




}
/// @nodoc
class __$ExecutionResultCopyWithImpl<$Res>
    implements _$ExecutionResultCopyWith<$Res> {
  __$ExecutionResultCopyWithImpl(this._self, this._then);

  final _ExecutionResult _self;
  final $Res Function(_ExecutionResult) _then;

/// Create a copy of ExecutionResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ok = null,Object? orderId = freezed,Object? error = freezed,}) {
  return _then(_ExecutionResult(
ok: null == ok ? _self.ok : ok // ignore: cast_nullable_to_non_nullable
as bool,orderId: freezed == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$BriefingSchedule {

 int get id; bool get enabled; DateTime? get nextRun; DateTime? get lastRun;/// `pending`, `running`, …
 String get status;
/// Create a copy of BriefingSchedule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BriefingScheduleCopyWith<BriefingSchedule> get copyWith => _$BriefingScheduleCopyWithImpl<BriefingSchedule>(this as BriefingSchedule, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BriefingSchedule;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BriefingSchedule&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.enabled, _this.enabled) || other.enabled == _this.enabled)&&(identical(other.nextRun, _this.nextRun) || other.nextRun == _this.nextRun)&&(identical(other.lastRun, _this.lastRun) || other.lastRun == _this.lastRun)&&(identical(other.status, _this.status) || other.status == _this.status));
}


@override
int get hashCode {
  final _this = this as BriefingSchedule;
  return Object.hash(runtimeType,_this.id,_this.enabled,_this.nextRun,_this.lastRun,_this.status);
}

@override
String toString() {
  final _this = this as BriefingSchedule;
  return 'BriefingSchedule(id: ${_this.id}, enabled: ${_this.enabled}, nextRun: ${_this.nextRun}, lastRun: ${_this.lastRun}, status: ${_this.status})';
}


}

/// @nodoc
abstract mixin class $BriefingScheduleCopyWith<$Res>  {
  factory $BriefingScheduleCopyWith(BriefingSchedule value, $Res Function(BriefingSchedule) _then) = _$BriefingScheduleCopyWithImpl;
@useResult
$Res call({
 int id, bool enabled, DateTime? nextRun, DateTime? lastRun, String status
});




}
/// @nodoc
class _$BriefingScheduleCopyWithImpl<$Res>
    implements $BriefingScheduleCopyWith<$Res> {
  _$BriefingScheduleCopyWithImpl(this._self, this._then);

  final BriefingSchedule _self;
  final $Res Function(BriefingSchedule) _then;

/// Create a copy of BriefingSchedule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? enabled = null,Object? nextRun = freezed,Object? lastRun = freezed,Object? status = null,}) {
  return _then(BriefingSchedule(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,nextRun: freezed == nextRun ? _self.nextRun : nextRun // ignore: cast_nullable_to_non_nullable
as DateTime?,lastRun: freezed == lastRun ? _self.lastRun : lastRun // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BriefingSchedule].
extension BriefingSchedulePatterns on BriefingSchedule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BriefingSchedule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BriefingSchedule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BriefingSchedule value)  $default,){
final _that = this;
switch (_that) {
case _BriefingSchedule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BriefingSchedule value)?  $default,){
final _that = this;
switch (_that) {
case _BriefingSchedule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  bool enabled,  DateTime? nextRun,  DateTime? lastRun,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BriefingSchedule() when $default != null:
return $default(_that.id,_that.enabled,_that.nextRun,_that.lastRun,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  bool enabled,  DateTime? nextRun,  DateTime? lastRun,  String status)  $default,) {final _that = this;
switch (_that) {
case _BriefingSchedule():
return $default(_that.id,_that.enabled,_that.nextRun,_that.lastRun,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  bool enabled,  DateTime? nextRun,  DateTime? lastRun,  String status)?  $default,) {final _that = this;
switch (_that) {
case _BriefingSchedule() when $default != null:
return $default(_that.id,_that.enabled,_that.nextRun,_that.lastRun,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _BriefingSchedule implements BriefingSchedule {
  const _BriefingSchedule({required this.id, required this.enabled, this.nextRun, this.lastRun, this.status = 'pending'});
  

@override final  int id;
@override final  bool enabled;
@override final  DateTime? nextRun;
@override final  DateTime? lastRun;
/// `pending`, `running`, …
@override@JsonKey() final  String status;

/// Create a copy of BriefingSchedule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BriefingScheduleCopyWith<_BriefingSchedule> get copyWith => __$BriefingScheduleCopyWithImpl<_BriefingSchedule>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BriefingSchedule&&(identical(other.id, id) || other.id == id)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.nextRun, nextRun) || other.nextRun == nextRun)&&(identical(other.lastRun, lastRun) || other.lastRun == lastRun)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,enabled,nextRun,lastRun,status);
}

@override
String toString() {
    return 'BriefingSchedule(id: $id, enabled: $enabled, nextRun: $nextRun, lastRun: $lastRun, status: $status)';
}


}

/// @nodoc
abstract mixin class _$BriefingScheduleCopyWith<$Res> implements $BriefingScheduleCopyWith<$Res> {
  factory _$BriefingScheduleCopyWith(_BriefingSchedule value, $Res Function(_BriefingSchedule) _then) = __$BriefingScheduleCopyWithImpl;
@override @useResult
$Res call({
 int id, bool enabled, DateTime? nextRun, DateTime? lastRun, String status
});




}
/// @nodoc
class __$BriefingScheduleCopyWithImpl<$Res>
    implements _$BriefingScheduleCopyWith<$Res> {
  __$BriefingScheduleCopyWithImpl(this._self, this._then);

  final _BriefingSchedule _self;
  final $Res Function(_BriefingSchedule) _then;

/// Create a copy of BriefingSchedule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? enabled = null,Object? nextRun = freezed,Object? lastRun = freezed,Object? status = null,}) {
  return _then(_BriefingSchedule(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,nextRun: freezed == nextRun ? _self.nextRun : nextRun // ignore: cast_nullable_to_non_nullable
as DateTime?,lastRun: freezed == lastRun ? _self.lastRun : lastRun // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$BriefingLog {

 int get id; BriefingOutcome get outcome; String get message; Duration? get duration; DateTime? get at;
/// Create a copy of BriefingLog
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BriefingLogCopyWith<BriefingLog> get copyWith => _$BriefingLogCopyWithImpl<BriefingLog>(this as BriefingLog, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BriefingLog;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BriefingLog&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.outcome, _this.outcome) || other.outcome == _this.outcome)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.duration, _this.duration) || other.duration == _this.duration)&&(identical(other.at, _this.at) || other.at == _this.at));
}


@override
int get hashCode {
  final _this = this as BriefingLog;
  return Object.hash(runtimeType,_this.id,_this.outcome,_this.message,_this.duration,_this.at);
}

@override
String toString() {
  final _this = this as BriefingLog;
  return 'BriefingLog(id: ${_this.id}, outcome: ${_this.outcome}, message: ${_this.message}, duration: ${_this.duration}, at: ${_this.at})';
}


}

/// @nodoc
abstract mixin class $BriefingLogCopyWith<$Res>  {
  factory $BriefingLogCopyWith(BriefingLog value, $Res Function(BriefingLog) _then) = _$BriefingLogCopyWithImpl;
@useResult
$Res call({
 int id, BriefingOutcome outcome, String message, Duration? duration, DateTime? at
});




}
/// @nodoc
class _$BriefingLogCopyWithImpl<$Res>
    implements $BriefingLogCopyWith<$Res> {
  _$BriefingLogCopyWithImpl(this._self, this._then);

  final BriefingLog _self;
  final $Res Function(BriefingLog) _then;

/// Create a copy of BriefingLog
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? outcome = null,Object? message = null,Object? duration = freezed,Object? at = freezed,}) {
  return _then(BriefingLog(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,outcome: null == outcome ? _self.outcome : outcome // ignore: cast_nullable_to_non_nullable
as BriefingOutcome,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration?,at: freezed == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [BriefingLog].
extension BriefingLogPatterns on BriefingLog {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BriefingLog value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BriefingLog() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BriefingLog value)  $default,){
final _that = this;
switch (_that) {
case _BriefingLog():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BriefingLog value)?  $default,){
final _that = this;
switch (_that) {
case _BriefingLog() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  BriefingOutcome outcome,  String message,  Duration? duration,  DateTime? at)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BriefingLog() when $default != null:
return $default(_that.id,_that.outcome,_that.message,_that.duration,_that.at);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  BriefingOutcome outcome,  String message,  Duration? duration,  DateTime? at)  $default,) {final _that = this;
switch (_that) {
case _BriefingLog():
return $default(_that.id,_that.outcome,_that.message,_that.duration,_that.at);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  BriefingOutcome outcome,  String message,  Duration? duration,  DateTime? at)?  $default,) {final _that = this;
switch (_that) {
case _BriefingLog() when $default != null:
return $default(_that.id,_that.outcome,_that.message,_that.duration,_that.at);case _:
  return null;

}
}

}

/// @nodoc


class _BriefingLog implements BriefingLog {
  const _BriefingLog({required this.id, required this.outcome, this.message = '', this.duration, this.at});
  

@override final  int id;
@override final  BriefingOutcome outcome;
@override@JsonKey() final  String message;
@override final  Duration? duration;
@override final  DateTime? at;

/// Create a copy of BriefingLog
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BriefingLogCopyWith<_BriefingLog> get copyWith => __$BriefingLogCopyWithImpl<_BriefingLog>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BriefingLog&&(identical(other.id, id) || other.id == id)&&(identical(other.outcome, outcome) || other.outcome == outcome)&&(identical(other.message, message) || other.message == message)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.at, at) || other.at == at));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,outcome,message,duration,at);
}

@override
String toString() {
    return 'BriefingLog(id: $id, outcome: $outcome, message: $message, duration: $duration, at: $at)';
}


}

/// @nodoc
abstract mixin class _$BriefingLogCopyWith<$Res> implements $BriefingLogCopyWith<$Res> {
  factory _$BriefingLogCopyWith(_BriefingLog value, $Res Function(_BriefingLog) _then) = __$BriefingLogCopyWithImpl;
@override @useResult
$Res call({
 int id, BriefingOutcome outcome, String message, Duration? duration, DateTime? at
});




}
/// @nodoc
class __$BriefingLogCopyWithImpl<$Res>
    implements _$BriefingLogCopyWith<$Res> {
  __$BriefingLogCopyWithImpl(this._self, this._then);

  final _BriefingLog _self;
  final $Res Function(_BriefingLog) _then;

/// Create a copy of BriefingLog
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? outcome = null,Object? message = null,Object? duration = freezed,Object? at = freezed,}) {
  return _then(_BriefingLog(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,outcome: null == outcome ? _self.outcome : outcome // ignore: cast_nullable_to_non_nullable
as BriefingOutcome,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration?,at: freezed == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
