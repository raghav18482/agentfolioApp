// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Country {

/// ISO 3166 alpha-2, e.g. `IN`.
 String get iso;/// Without the plus, e.g. `91`.
 String get dialCode; String get name;
/// Create a copy of Country
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CountryCopyWith<Country> get copyWith => _$CountryCopyWithImpl<Country>(this as Country, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Country;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Country&&(identical(other.iso, _this.iso) || other.iso == _this.iso)&&(identical(other.dialCode, _this.dialCode) || other.dialCode == _this.dialCode)&&(identical(other.name, _this.name) || other.name == _this.name));
}


@override
int get hashCode {
  final _this = this as Country;
  return Object.hash(runtimeType,_this.iso,_this.dialCode,_this.name);
}

@override
String toString() {
  final _this = this as Country;
  return 'Country(iso: ${_this.iso}, dialCode: ${_this.dialCode}, name: ${_this.name})';
}


}

/// @nodoc
abstract mixin class $CountryCopyWith<$Res>  {
  factory $CountryCopyWith(Country value, $Res Function(Country) _then) = _$CountryCopyWithImpl;
@useResult
$Res call({
 String iso, String dialCode, String name
});




}
/// @nodoc
class _$CountryCopyWithImpl<$Res>
    implements $CountryCopyWith<$Res> {
  _$CountryCopyWithImpl(this._self, this._then);

  final Country _self;
  final $Res Function(Country) _then;

/// Create a copy of Country
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? iso = null,Object? dialCode = null,Object? name = null,}) {
  return _then(Country(
iso: null == iso ? _self.iso : iso // ignore: cast_nullable_to_non_nullable
as String,dialCode: null == dialCode ? _self.dialCode : dialCode // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Country].
extension CountryPatterns on Country {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Country value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Country() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Country value)  $default,){
final _that = this;
switch (_that) {
case _Country():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Country value)?  $default,){
final _that = this;
switch (_that) {
case _Country() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String iso,  String dialCode,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Country() when $default != null:
return $default(_that.iso,_that.dialCode,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String iso,  String dialCode,  String name)  $default,) {final _that = this;
switch (_that) {
case _Country():
return $default(_that.iso,_that.dialCode,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String iso,  String dialCode,  String name)?  $default,) {final _that = this;
switch (_that) {
case _Country() when $default != null:
return $default(_that.iso,_that.dialCode,_that.name);case _:
  return null;

}
}

}

/// @nodoc


class _Country extends Country {
  const _Country({required this.iso, required this.dialCode, required this.name}): super._();
  

/// ISO 3166 alpha-2, e.g. `IN`.
@override final  String iso;
/// Without the plus, e.g. `91`.
@override final  String dialCode;
@override final  String name;

/// Create a copy of Country
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CountryCopyWith<_Country> get copyWith => __$CountryCopyWithImpl<_Country>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Country&&(identical(other.iso, iso) || other.iso == iso)&&(identical(other.dialCode, dialCode) || other.dialCode == dialCode)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode {
    return Object.hash(runtimeType,iso,dialCode,name);
}

@override
String toString() {
    return 'Country(iso: $iso, dialCode: $dialCode, name: $name)';
}


}

/// @nodoc
abstract mixin class _$CountryCopyWith<$Res> implements $CountryCopyWith<$Res> {
  factory _$CountryCopyWith(_Country value, $Res Function(_Country) _then) = __$CountryCopyWithImpl;
@override @useResult
$Res call({
 String iso, String dialCode, String name
});




}
/// @nodoc
class __$CountryCopyWithImpl<$Res>
    implements _$CountryCopyWith<$Res> {
  __$CountryCopyWithImpl(this._self, this._then);

  final _Country _self;
  final $Res Function(_Country) _then;

/// Create a copy of Country
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? iso = null,Object? dialCode = null,Object? name = null,}) {
  return _then(_Country(
iso: null == iso ? _self.iso : iso // ignore: cast_nullable_to_non_nullable
as String,dialCode: null == dialCode ? _self.dialCode : dialCode // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$AuthConfig {

 List<Country> get countries; String get defaultDialCode; int get minPasswordChars;
/// Create a copy of AuthConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthConfigCopyWith<AuthConfig> get copyWith => _$AuthConfigCopyWithImpl<AuthConfig>(this as AuthConfig, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AuthConfig;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthConfig&&const DeepCollectionEquality().equals(other.countries, _this.countries)&&(identical(other.defaultDialCode, _this.defaultDialCode) || other.defaultDialCode == _this.defaultDialCode)&&(identical(other.minPasswordChars, _this.minPasswordChars) || other.minPasswordChars == _this.minPasswordChars));
}


@override
int get hashCode {
  final _this = this as AuthConfig;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.countries),_this.defaultDialCode,_this.minPasswordChars);
}

@override
String toString() {
  final _this = this as AuthConfig;
  return 'AuthConfig(countries: ${_this.countries}, defaultDialCode: ${_this.defaultDialCode}, minPasswordChars: ${_this.minPasswordChars})';
}


}

/// @nodoc
abstract mixin class $AuthConfigCopyWith<$Res>  {
  factory $AuthConfigCopyWith(AuthConfig value, $Res Function(AuthConfig) _then) = _$AuthConfigCopyWithImpl;
@useResult
$Res call({
 List<Country> countries, String defaultDialCode, int minPasswordChars
});




}
/// @nodoc
class _$AuthConfigCopyWithImpl<$Res>
    implements $AuthConfigCopyWith<$Res> {
  _$AuthConfigCopyWithImpl(this._self, this._then);

  final AuthConfig _self;
  final $Res Function(AuthConfig) _then;

/// Create a copy of AuthConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? countries = null,Object? defaultDialCode = null,Object? minPasswordChars = null,}) {
  return _then(AuthConfig(
countries: null == countries ? _self.countries : countries // ignore: cast_nullable_to_non_nullable
as List<Country>,defaultDialCode: null == defaultDialCode ? _self.defaultDialCode : defaultDialCode // ignore: cast_nullable_to_non_nullable
as String,minPasswordChars: null == minPasswordChars ? _self.minPasswordChars : minPasswordChars // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthConfig].
extension AuthConfigPatterns on AuthConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthConfig value)  $default,){
final _that = this;
switch (_that) {
case _AuthConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthConfig value)?  $default,){
final _that = this;
switch (_that) {
case _AuthConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Country> countries,  String defaultDialCode,  int minPasswordChars)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthConfig() when $default != null:
return $default(_that.countries,_that.defaultDialCode,_that.minPasswordChars);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Country> countries,  String defaultDialCode,  int minPasswordChars)  $default,) {final _that = this;
switch (_that) {
case _AuthConfig():
return $default(_that.countries,_that.defaultDialCode,_that.minPasswordChars);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Country> countries,  String defaultDialCode,  int minPasswordChars)?  $default,) {final _that = this;
switch (_that) {
case _AuthConfig() when $default != null:
return $default(_that.countries,_that.defaultDialCode,_that.minPasswordChars);case _:
  return null;

}
}

}

/// @nodoc


class _AuthConfig extends AuthConfig {
  const _AuthConfig({required  List<Country> countries, required this.defaultDialCode, required this.minPasswordChars}): _countries = countries,super._();
  

 final  List<Country> _countries;
@override List<Country> get countries {
  if (_countries is EqualUnmodifiableListView) return _countries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_countries);
}

@override final  String defaultDialCode;
@override final  int minPasswordChars;

/// Create a copy of AuthConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthConfigCopyWith<_AuthConfig> get copyWith => __$AuthConfigCopyWithImpl<_AuthConfig>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthConfig&&const DeepCollectionEquality().equals(other.countries, _countries)&&(identical(other.defaultDialCode, defaultDialCode) || other.defaultDialCode == defaultDialCode)&&(identical(other.minPasswordChars, minPasswordChars) || other.minPasswordChars == minPasswordChars));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_countries),defaultDialCode,minPasswordChars);
}

@override
String toString() {
    return 'AuthConfig(countries: $countries, defaultDialCode: $defaultDialCode, minPasswordChars: $minPasswordChars)';
}


}

/// @nodoc
abstract mixin class _$AuthConfigCopyWith<$Res> implements $AuthConfigCopyWith<$Res> {
  factory _$AuthConfigCopyWith(_AuthConfig value, $Res Function(_AuthConfig) _then) = __$AuthConfigCopyWithImpl;
@override @useResult
$Res call({
 List<Country> countries, String defaultDialCode, int minPasswordChars
});




}
/// @nodoc
class __$AuthConfigCopyWithImpl<$Res>
    implements _$AuthConfigCopyWith<$Res> {
  __$AuthConfigCopyWithImpl(this._self, this._then);

  final _AuthConfig _self;
  final $Res Function(_AuthConfig) _then;

/// Create a copy of AuthConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? countries = null,Object? defaultDialCode = null,Object? minPasswordChars = null,}) {
  return _then(_AuthConfig(
countries: null == countries ? _self._countries : countries // ignore: cast_nullable_to_non_nullable
as List<Country>,defaultDialCode: null == defaultDialCode ? _self.defaultDialCode : defaultDialCode // ignore: cast_nullable_to_non_nullable
as String,minPasswordChars: null == minPasswordChars ? _self.minPasswordChars : minPasswordChars // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$PhoneNumber {

 String get dialCode; String get national;
/// Create a copy of PhoneNumber
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhoneNumberCopyWith<PhoneNumber> get copyWith => _$PhoneNumberCopyWithImpl<PhoneNumber>(this as PhoneNumber, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PhoneNumber;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhoneNumber&&(identical(other.dialCode, _this.dialCode) || other.dialCode == _this.dialCode)&&(identical(other.national, _this.national) || other.national == _this.national));
}


@override
int get hashCode {
  final _this = this as PhoneNumber;
  return Object.hash(runtimeType,_this.dialCode,_this.national);
}

@override
String toString() {
  final _this = this as PhoneNumber;
  return 'PhoneNumber(dialCode: ${_this.dialCode}, national: ${_this.national})';
}


}

/// @nodoc
abstract mixin class $PhoneNumberCopyWith<$Res>  {
  factory $PhoneNumberCopyWith(PhoneNumber value, $Res Function(PhoneNumber) _then) = _$PhoneNumberCopyWithImpl;
@useResult
$Res call({
 String dialCode, String national
});




}
/// @nodoc
class _$PhoneNumberCopyWithImpl<$Res>
    implements $PhoneNumberCopyWith<$Res> {
  _$PhoneNumberCopyWithImpl(this._self, this._then);

  final PhoneNumber _self;
  final $Res Function(PhoneNumber) _then;

/// Create a copy of PhoneNumber
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dialCode = null,Object? national = null,}) {
  return _then(PhoneNumber(
dialCode: null == dialCode ? _self.dialCode : dialCode // ignore: cast_nullable_to_non_nullable
as String,national: null == national ? _self.national : national // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PhoneNumber].
extension PhoneNumberPatterns on PhoneNumber {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhoneNumber value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhoneNumber() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhoneNumber value)  $default,){
final _that = this;
switch (_that) {
case _PhoneNumber():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhoneNumber value)?  $default,){
final _that = this;
switch (_that) {
case _PhoneNumber() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String dialCode,  String national)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhoneNumber() when $default != null:
return $default(_that.dialCode,_that.national);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String dialCode,  String national)  $default,) {final _that = this;
switch (_that) {
case _PhoneNumber():
return $default(_that.dialCode,_that.national);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String dialCode,  String national)?  $default,) {final _that = this;
switch (_that) {
case _PhoneNumber() when $default != null:
return $default(_that.dialCode,_that.national);case _:
  return null;

}
}

}

/// @nodoc


class _PhoneNumber extends PhoneNumber {
  const _PhoneNumber({required this.dialCode, required this.national}): super._();
  

@override final  String dialCode;
@override final  String national;

/// Create a copy of PhoneNumber
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhoneNumberCopyWith<_PhoneNumber> get copyWith => __$PhoneNumberCopyWithImpl<_PhoneNumber>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhoneNumber&&(identical(other.dialCode, dialCode) || other.dialCode == dialCode)&&(identical(other.national, national) || other.national == national));
}


@override
int get hashCode {
    return Object.hash(runtimeType,dialCode,national);
}

@override
String toString() {
    return 'PhoneNumber(dialCode: $dialCode, national: $national)';
}


}

/// @nodoc
abstract mixin class _$PhoneNumberCopyWith<$Res> implements $PhoneNumberCopyWith<$Res> {
  factory _$PhoneNumberCopyWith(_PhoneNumber value, $Res Function(_PhoneNumber) _then) = __$PhoneNumberCopyWithImpl;
@override @useResult
$Res call({
 String dialCode, String national
});




}
/// @nodoc
class __$PhoneNumberCopyWithImpl<$Res>
    implements _$PhoneNumberCopyWith<$Res> {
  __$PhoneNumberCopyWithImpl(this._self, this._then);

  final _PhoneNumber _self;
  final $Res Function(_PhoneNumber) _then;

/// Create a copy of PhoneNumber
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dialCode = null,Object? national = null,}) {
  return _then(_PhoneNumber(
dialCode: null == dialCode ? _self.dialCode : dialCode // ignore: cast_nullable_to_non_nullable
as String,national: null == national ? _self.national : national // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
