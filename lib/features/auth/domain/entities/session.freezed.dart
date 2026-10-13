// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PremiumStatus {

 bool get registered; String? get whatsappNumber;
/// Create a copy of PremiumStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PremiumStatusCopyWith<PremiumStatus> get copyWith => _$PremiumStatusCopyWithImpl<PremiumStatus>(this as PremiumStatus, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PremiumStatus;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PremiumStatus&&(identical(other.registered, _this.registered) || other.registered == _this.registered)&&(identical(other.whatsappNumber, _this.whatsappNumber) || other.whatsappNumber == _this.whatsappNumber));
}


@override
int get hashCode {
  final _this = this as PremiumStatus;
  return Object.hash(runtimeType,_this.registered,_this.whatsappNumber);
}

@override
String toString() {
  final _this = this as PremiumStatus;
  return 'PremiumStatus(registered: ${_this.registered}, whatsappNumber: ${_this.whatsappNumber})';
}


}

/// @nodoc
abstract mixin class $PremiumStatusCopyWith<$Res>  {
  factory $PremiumStatusCopyWith(PremiumStatus value, $Res Function(PremiumStatus) _then) = _$PremiumStatusCopyWithImpl;
@useResult
$Res call({
 bool registered, String? whatsappNumber
});




}
/// @nodoc
class _$PremiumStatusCopyWithImpl<$Res>
    implements $PremiumStatusCopyWith<$Res> {
  _$PremiumStatusCopyWithImpl(this._self, this._then);

  final PremiumStatus _self;
  final $Res Function(PremiumStatus) _then;

/// Create a copy of PremiumStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? registered = null,Object? whatsappNumber = freezed,}) {
  return _then(PremiumStatus(
registered: null == registered ? _self.registered : registered // ignore: cast_nullable_to_non_nullable
as bool,whatsappNumber: freezed == whatsappNumber ? _self.whatsappNumber : whatsappNumber // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PremiumStatus].
extension PremiumStatusPatterns on PremiumStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PremiumStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PremiumStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PremiumStatus value)  $default,){
final _that = this;
switch (_that) {
case _PremiumStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PremiumStatus value)?  $default,){
final _that = this;
switch (_that) {
case _PremiumStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool registered,  String? whatsappNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PremiumStatus() when $default != null:
return $default(_that.registered,_that.whatsappNumber);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool registered,  String? whatsappNumber)  $default,) {final _that = this;
switch (_that) {
case _PremiumStatus():
return $default(_that.registered,_that.whatsappNumber);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool registered,  String? whatsappNumber)?  $default,) {final _that = this;
switch (_that) {
case _PremiumStatus() when $default != null:
return $default(_that.registered,_that.whatsappNumber);case _:
  return null;

}
}

}

/// @nodoc


class _PremiumStatus implements PremiumStatus {
  const _PremiumStatus({required this.registered, this.whatsappNumber});
  

@override final  bool registered;
@override final  String? whatsappNumber;

/// Create a copy of PremiumStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PremiumStatusCopyWith<_PremiumStatus> get copyWith => __$PremiumStatusCopyWithImpl<_PremiumStatus>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PremiumStatus&&(identical(other.registered, registered) || other.registered == registered)&&(identical(other.whatsappNumber, whatsappNumber) || other.whatsappNumber == whatsappNumber));
}


@override
int get hashCode {
    return Object.hash(runtimeType,registered,whatsappNumber);
}

@override
String toString() {
    return 'PremiumStatus(registered: $registered, whatsappNumber: $whatsappNumber)';
}


}

/// @nodoc
abstract mixin class _$PremiumStatusCopyWith<$Res> implements $PremiumStatusCopyWith<$Res> {
  factory _$PremiumStatusCopyWith(_PremiumStatus value, $Res Function(_PremiumStatus) _then) = __$PremiumStatusCopyWithImpl;
@override @useResult
$Res call({
 bool registered, String? whatsappNumber
});




}
/// @nodoc
class __$PremiumStatusCopyWithImpl<$Res>
    implements _$PremiumStatusCopyWith<$Res> {
  __$PremiumStatusCopyWithImpl(this._self, this._then);

  final _PremiumStatus _self;
  final $Res Function(_PremiumStatus) _then;

/// Create a copy of PremiumStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? registered = null,Object? whatsappNumber = freezed,}) {
  return _then(_PremiumStatus(
registered: null == registered ? _self.registered : registered // ignore: cast_nullable_to_non_nullable
as bool,whatsappNumber: freezed == whatsappNumber ? _self.whatsappNumber : whatsappNumber // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$AppUser {

 String get id; PremiumStatus get premium;
/// Create a copy of AppUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppUserCopyWith<AppUser> get copyWith => _$AppUserCopyWithImpl<AppUser>(this as AppUser, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AppUser;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppUser&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.premium, _this.premium) || other.premium == _this.premium));
}


@override
int get hashCode {
  final _this = this as AppUser;
  return Object.hash(runtimeType,_this.id,_this.premium);
}

@override
String toString() {
  final _this = this as AppUser;
  return 'AppUser(id: ${_this.id}, premium: ${_this.premium})';
}


}

/// @nodoc
abstract mixin class $AppUserCopyWith<$Res>  {
  factory $AppUserCopyWith(AppUser value, $Res Function(AppUser) _then) = _$AppUserCopyWithImpl;
@useResult
$Res call({
 String id, PremiumStatus premium
});


$PremiumStatusCopyWith<$Res> get premium;

}
/// @nodoc
class _$AppUserCopyWithImpl<$Res>
    implements $AppUserCopyWith<$Res> {
  _$AppUserCopyWithImpl(this._self, this._then);

  final AppUser _self;
  final $Res Function(AppUser) _then;

/// Create a copy of AppUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? premium = null,}) {
  return _then(AppUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,premium: null == premium ? _self.premium : premium // ignore: cast_nullable_to_non_nullable
as PremiumStatus,
  ));
}
/// Create a copy of AppUser
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PremiumStatusCopyWith<$Res> get premium {
  
  return $PremiumStatusCopyWith<$Res>(_self.premium, (value) {
    return _then(_self.copyWith(premium: value));
  });
}
}


/// Adds pattern-matching-related methods to [AppUser].
extension AppUserPatterns on AppUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppUser value)  $default,){
final _that = this;
switch (_that) {
case _AppUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppUser value)?  $default,){
final _that = this;
switch (_that) {
case _AppUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  PremiumStatus premium)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppUser() when $default != null:
return $default(_that.id,_that.premium);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  PremiumStatus premium)  $default,) {final _that = this;
switch (_that) {
case _AppUser():
return $default(_that.id,_that.premium);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  PremiumStatus premium)?  $default,) {final _that = this;
switch (_that) {
case _AppUser() when $default != null:
return $default(_that.id,_that.premium);case _:
  return null;

}
}

}

/// @nodoc


class _AppUser implements AppUser {
  const _AppUser({required this.id, required this.premium});
  

@override final  String id;
@override final  PremiumStatus premium;

/// Create a copy of AppUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppUserCopyWith<_AppUser> get copyWith => __$AppUserCopyWithImpl<_AppUser>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppUser&&(identical(other.id, id) || other.id == id)&&(identical(other.premium, premium) || other.premium == premium));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,premium);
}

@override
String toString() {
    return 'AppUser(id: $id, premium: $premium)';
}


}

/// @nodoc
abstract mixin class _$AppUserCopyWith<$Res> implements $AppUserCopyWith<$Res> {
  factory _$AppUserCopyWith(_AppUser value, $Res Function(_AppUser) _then) = __$AppUserCopyWithImpl;
@override @useResult
$Res call({
 String id, PremiumStatus premium
});


@override $PremiumStatusCopyWith<$Res> get premium;

}
/// @nodoc
class __$AppUserCopyWithImpl<$Res>
    implements _$AppUserCopyWith<$Res> {
  __$AppUserCopyWithImpl(this._self, this._then);

  final _AppUser _self;
  final $Res Function(_AppUser) _then;

/// Create a copy of AppUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? premium = null,}) {
  return _then(_AppUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,premium: null == premium ? _self.premium : premium // ignore: cast_nullable_to_non_nullable
as PremiumStatus,
  ));
}

/// Create a copy of AppUser
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PremiumStatusCopyWith<$Res> get premium {
  
  return $PremiumStatusCopyWith<$Res>(_self.premium, (value) {
    return _then(_self.copyWith(premium: value));
  });
}
}

/// @nodoc
mixin _$Session {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is Session);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'Session()';
}


}

/// @nodoc
class $SessionCopyWith<$Res>  {
$SessionCopyWith(Session _, $Res Function(Session) __);
}


/// Adds pattern-matching-related methods to [Session].
extension SessionPatterns on Session {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SignedOut value)?  signedOut,TResult Function( SignedIn value)?  signedIn,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SignedOut() when signedOut != null:
return signedOut(_that);case SignedIn() when signedIn != null:
return signedIn(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SignedOut value)  signedOut,required TResult Function( SignedIn value)  signedIn,}){
final _that = this;
switch (_that) {
case SignedOut():
return signedOut(_that);case SignedIn():
return signedIn(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SignedOut value)?  signedOut,TResult? Function( SignedIn value)?  signedIn,}){
final _that = this;
switch (_that) {
case SignedOut() when signedOut != null:
return signedOut(_that);case SignedIn() when signedIn != null:
return signedIn(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  signedOut,TResult Function( AppUser user,  List<BrokerAccount> accounts,  String activeAccountId)?  signedIn,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SignedOut() when signedOut != null:
return signedOut();case SignedIn() when signedIn != null:
return signedIn(_that.user,_that.accounts,_that.activeAccountId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  signedOut,required TResult Function( AppUser user,  List<BrokerAccount> accounts,  String activeAccountId)  signedIn,}) {final _that = this;
switch (_that) {
case SignedOut():
return signedOut();case SignedIn():
return signedIn(_that.user,_that.accounts,_that.activeAccountId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  signedOut,TResult? Function( AppUser user,  List<BrokerAccount> accounts,  String activeAccountId)?  signedIn,}) {final _that = this;
switch (_that) {
case SignedOut() when signedOut != null:
return signedOut();case SignedIn() when signedIn != null:
return signedIn(_that.user,_that.accounts,_that.activeAccountId);case _:
  return null;

}
}

}

/// @nodoc


class SignedOut implements Session {
  const SignedOut();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SignedOut);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'Session.signedOut()';
}


}




/// @nodoc


class SignedIn implements Session {
  const SignedIn({required this.user, required  List<BrokerAccount> accounts, required this.activeAccountId}): _accounts = accounts;
  

 final  AppUser user;
 final  List<BrokerAccount> _accounts;
 List<BrokerAccount> get accounts {
  if (_accounts is EqualUnmodifiableListView) return _accounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_accounts);
}

 final  String activeAccountId;

/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignedInCopyWith<SignedIn> get copyWith => _$SignedInCopyWithImpl<SignedIn>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SignedIn&&(identical(other.user, user) || other.user == user)&&const DeepCollectionEquality().equals(other.accounts, _accounts)&&(identical(other.activeAccountId, activeAccountId) || other.activeAccountId == activeAccountId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,user,const DeepCollectionEquality().hash(_accounts),activeAccountId);
}

@override
String toString() {
    return 'Session.signedIn(user: $user, accounts: $accounts, activeAccountId: $activeAccountId)';
}


}

/// @nodoc
abstract mixin class $SignedInCopyWith<$Res> implements $SessionCopyWith<$Res> {
  factory $SignedInCopyWith(SignedIn value, $Res Function(SignedIn) _then) = _$SignedInCopyWithImpl;
@useResult
$Res call({
 AppUser user, List<BrokerAccount> accounts, String activeAccountId
});


$AppUserCopyWith<$Res> get user;

}
/// @nodoc
class _$SignedInCopyWithImpl<$Res>
    implements $SignedInCopyWith<$Res> {
  _$SignedInCopyWithImpl(this._self, this._then);

  final SignedIn _self;
  final $Res Function(SignedIn) _then;

/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,Object? accounts = null,Object? activeAccountId = null,}) {
  return _then(SignedIn(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AppUser,accounts: null == accounts ? _self._accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<BrokerAccount>,activeAccountId: null == activeAccountId ? _self.activeAccountId : activeAccountId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppUserCopyWith<$Res> get user {
  
  return $AppUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
