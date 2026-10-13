// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'broker_account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BrokerAccount {

 String get id; BrokerId get brokerId; String get clientCode; AccountStatus get status; String? get label;
/// Create a copy of BrokerAccount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BrokerAccountCopyWith<BrokerAccount> get copyWith => _$BrokerAccountCopyWithImpl<BrokerAccount>(this as BrokerAccount, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BrokerAccount;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BrokerAccount&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.brokerId, _this.brokerId) || other.brokerId == _this.brokerId)&&(identical(other.clientCode, _this.clientCode) || other.clientCode == _this.clientCode)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.label, _this.label) || other.label == _this.label));
}


@override
int get hashCode {
  final _this = this as BrokerAccount;
  return Object.hash(runtimeType,_this.id,_this.brokerId,_this.clientCode,_this.status,_this.label);
}

@override
String toString() {
  final _this = this as BrokerAccount;
  return 'BrokerAccount(id: ${_this.id}, brokerId: ${_this.brokerId}, clientCode: ${_this.clientCode}, status: ${_this.status}, label: ${_this.label})';
}


}

/// @nodoc
abstract mixin class $BrokerAccountCopyWith<$Res>  {
  factory $BrokerAccountCopyWith(BrokerAccount value, $Res Function(BrokerAccount) _then) = _$BrokerAccountCopyWithImpl;
@useResult
$Res call({
 String id, BrokerId brokerId, String clientCode, AccountStatus status, String? label
});




}
/// @nodoc
class _$BrokerAccountCopyWithImpl<$Res>
    implements $BrokerAccountCopyWith<$Res> {
  _$BrokerAccountCopyWithImpl(this._self, this._then);

  final BrokerAccount _self;
  final $Res Function(BrokerAccount) _then;

/// Create a copy of BrokerAccount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? brokerId = null,Object? clientCode = null,Object? status = null,Object? label = freezed,}) {
  return _then(BrokerAccount(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,brokerId: null == brokerId ? _self.brokerId : brokerId // ignore: cast_nullable_to_non_nullable
as BrokerId,clientCode: null == clientCode ? _self.clientCode : clientCode // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AccountStatus,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BrokerAccount].
extension BrokerAccountPatterns on BrokerAccount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BrokerAccount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BrokerAccount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BrokerAccount value)  $default,){
final _that = this;
switch (_that) {
case _BrokerAccount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BrokerAccount value)?  $default,){
final _that = this;
switch (_that) {
case _BrokerAccount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  BrokerId brokerId,  String clientCode,  AccountStatus status,  String? label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BrokerAccount() when $default != null:
return $default(_that.id,_that.brokerId,_that.clientCode,_that.status,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  BrokerId brokerId,  String clientCode,  AccountStatus status,  String? label)  $default,) {final _that = this;
switch (_that) {
case _BrokerAccount():
return $default(_that.id,_that.brokerId,_that.clientCode,_that.status,_that.label);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  BrokerId brokerId,  String clientCode,  AccountStatus status,  String? label)?  $default,) {final _that = this;
switch (_that) {
case _BrokerAccount() when $default != null:
return $default(_that.id,_that.brokerId,_that.clientCode,_that.status,_that.label);case _:
  return null;

}
}

}

/// @nodoc


class _BrokerAccount implements BrokerAccount {
  const _BrokerAccount({required this.id, required this.brokerId, required this.clientCode, this.status = AccountStatus.active, this.label});
  

@override final  String id;
@override final  BrokerId brokerId;
@override final  String clientCode;
@override@JsonKey() final  AccountStatus status;
@override final  String? label;

/// Create a copy of BrokerAccount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BrokerAccountCopyWith<_BrokerAccount> get copyWith => __$BrokerAccountCopyWithImpl<_BrokerAccount>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BrokerAccount&&(identical(other.id, id) || other.id == id)&&(identical(other.brokerId, brokerId) || other.brokerId == brokerId)&&(identical(other.clientCode, clientCode) || other.clientCode == clientCode)&&(identical(other.status, status) || other.status == status)&&(identical(other.label, label) || other.label == label));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,brokerId,clientCode,status,label);
}

@override
String toString() {
    return 'BrokerAccount(id: $id, brokerId: $brokerId, clientCode: $clientCode, status: $status, label: $label)';
}


}

/// @nodoc
abstract mixin class _$BrokerAccountCopyWith<$Res> implements $BrokerAccountCopyWith<$Res> {
  factory _$BrokerAccountCopyWith(_BrokerAccount value, $Res Function(_BrokerAccount) _then) = __$BrokerAccountCopyWithImpl;
@override @useResult
$Res call({
 String id, BrokerId brokerId, String clientCode, AccountStatus status, String? label
});




}
/// @nodoc
class __$BrokerAccountCopyWithImpl<$Res>
    implements _$BrokerAccountCopyWith<$Res> {
  __$BrokerAccountCopyWithImpl(this._self, this._then);

  final _BrokerAccount _self;
  final $Res Function(_BrokerAccount) _then;

/// Create a copy of BrokerAccount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? brokerId = null,Object? clientCode = null,Object? status = null,Object? label = freezed,}) {
  return _then(_BrokerAccount(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,brokerId: null == brokerId ? _self.brokerId : brokerId // ignore: cast_nullable_to_non_nullable
as BrokerId,clientCode: null == clientCode ? _self.clientCode : clientCode // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AccountStatus,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
