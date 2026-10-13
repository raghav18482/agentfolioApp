// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'glossary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GlossaryBand {

 Verdict get verdict; String get note; double? get max;
/// Create a copy of GlossaryBand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GlossaryBandCopyWith<GlossaryBand> get copyWith => _$GlossaryBandCopyWithImpl<GlossaryBand>(this as GlossaryBand, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as GlossaryBand;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GlossaryBand&&(identical(other.verdict, _this.verdict) || other.verdict == _this.verdict)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.max, _this.max) || other.max == _this.max));
}


@override
int get hashCode {
  final _this = this as GlossaryBand;
  return Object.hash(runtimeType,_this.verdict,_this.note,_this.max);
}

@override
String toString() {
  final _this = this as GlossaryBand;
  return 'GlossaryBand(verdict: ${_this.verdict}, note: ${_this.note}, max: ${_this.max})';
}


}

/// @nodoc
abstract mixin class $GlossaryBandCopyWith<$Res>  {
  factory $GlossaryBandCopyWith(GlossaryBand value, $Res Function(GlossaryBand) _then) = _$GlossaryBandCopyWithImpl;
@useResult
$Res call({
 Verdict verdict, String note, double? max
});




}
/// @nodoc
class _$GlossaryBandCopyWithImpl<$Res>
    implements $GlossaryBandCopyWith<$Res> {
  _$GlossaryBandCopyWithImpl(this._self, this._then);

  final GlossaryBand _self;
  final $Res Function(GlossaryBand) _then;

/// Create a copy of GlossaryBand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? verdict = null,Object? note = null,Object? max = freezed,}) {
  return _then(GlossaryBand(
verdict: null == verdict ? _self.verdict : verdict // ignore: cast_nullable_to_non_nullable
as Verdict,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,max: freezed == max ? _self.max : max // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [GlossaryBand].
extension GlossaryBandPatterns on GlossaryBand {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GlossaryBand value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GlossaryBand() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GlossaryBand value)  $default,){
final _that = this;
switch (_that) {
case _GlossaryBand():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GlossaryBand value)?  $default,){
final _that = this;
switch (_that) {
case _GlossaryBand() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Verdict verdict,  String note,  double? max)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GlossaryBand() when $default != null:
return $default(_that.verdict,_that.note,_that.max);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Verdict verdict,  String note,  double? max)  $default,) {final _that = this;
switch (_that) {
case _GlossaryBand():
return $default(_that.verdict,_that.note,_that.max);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Verdict verdict,  String note,  double? max)?  $default,) {final _that = this;
switch (_that) {
case _GlossaryBand() when $default != null:
return $default(_that.verdict,_that.note,_that.max);case _:
  return null;

}
}

}

/// @nodoc


class _GlossaryBand implements GlossaryBand {
  const _GlossaryBand({required this.verdict, required this.note, this.max});
  

@override final  Verdict verdict;
@override final  String note;
@override final  double? max;

/// Create a copy of GlossaryBand
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GlossaryBandCopyWith<_GlossaryBand> get copyWith => __$GlossaryBandCopyWithImpl<_GlossaryBand>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GlossaryBand&&(identical(other.verdict, verdict) || other.verdict == verdict)&&(identical(other.note, note) || other.note == note)&&(identical(other.max, max) || other.max == max));
}


@override
int get hashCode {
    return Object.hash(runtimeType,verdict,note,max);
}

@override
String toString() {
    return 'GlossaryBand(verdict: $verdict, note: $note, max: $max)';
}


}

/// @nodoc
abstract mixin class _$GlossaryBandCopyWith<$Res> implements $GlossaryBandCopyWith<$Res> {
  factory _$GlossaryBandCopyWith(_GlossaryBand value, $Res Function(_GlossaryBand) _then) = __$GlossaryBandCopyWithImpl;
@override @useResult
$Res call({
 Verdict verdict, String note, double? max
});




}
/// @nodoc
class __$GlossaryBandCopyWithImpl<$Res>
    implements _$GlossaryBandCopyWith<$Res> {
  __$GlossaryBandCopyWithImpl(this._self, this._then);

  final _GlossaryBand _self;
  final $Res Function(_GlossaryBand) _then;

/// Create a copy of GlossaryBand
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? verdict = null,Object? note = null,Object? max = freezed,}) {
  return _then(_GlossaryBand(
verdict: null == verdict ? _self.verdict : verdict // ignore: cast_nullable_to_non_nullable
as Verdict,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,max: freezed == max ? _self.max : max // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

/// @nodoc
mixin _$GlossaryMetric {

 String get key; String get label; String get fullName; String get pillar; double get weight; String get formula; String get plain; String get ideal; List<GlossaryBand> get bands; String get caveat; String get watchOut;
/// Create a copy of GlossaryMetric
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GlossaryMetricCopyWith<GlossaryMetric> get copyWith => _$GlossaryMetricCopyWithImpl<GlossaryMetric>(this as GlossaryMetric, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as GlossaryMetric;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GlossaryMetric&&(identical(other.key, _this.key) || other.key == _this.key)&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.fullName, _this.fullName) || other.fullName == _this.fullName)&&(identical(other.pillar, _this.pillar) || other.pillar == _this.pillar)&&(identical(other.weight, _this.weight) || other.weight == _this.weight)&&(identical(other.formula, _this.formula) || other.formula == _this.formula)&&(identical(other.plain, _this.plain) || other.plain == _this.plain)&&(identical(other.ideal, _this.ideal) || other.ideal == _this.ideal)&&const DeepCollectionEquality().equals(other.bands, _this.bands)&&(identical(other.caveat, _this.caveat) || other.caveat == _this.caveat)&&(identical(other.watchOut, _this.watchOut) || other.watchOut == _this.watchOut));
}


@override
int get hashCode {
  final _this = this as GlossaryMetric;
  return Object.hash(runtimeType,_this.key,_this.label,_this.fullName,_this.pillar,_this.weight,_this.formula,_this.plain,_this.ideal,const DeepCollectionEquality().hash(_this.bands),_this.caveat,_this.watchOut);
}

@override
String toString() {
  final _this = this as GlossaryMetric;
  return 'GlossaryMetric(key: ${_this.key}, label: ${_this.label}, fullName: ${_this.fullName}, pillar: ${_this.pillar}, weight: ${_this.weight}, formula: ${_this.formula}, plain: ${_this.plain}, ideal: ${_this.ideal}, bands: ${_this.bands}, caveat: ${_this.caveat}, watchOut: ${_this.watchOut})';
}


}

/// @nodoc
abstract mixin class $GlossaryMetricCopyWith<$Res>  {
  factory $GlossaryMetricCopyWith(GlossaryMetric value, $Res Function(GlossaryMetric) _then) = _$GlossaryMetricCopyWithImpl;
@useResult
$Res call({
 String key, String label, String fullName, String pillar, double weight, String formula, String plain, String ideal, List<GlossaryBand> bands, String caveat, String watchOut
});




}
/// @nodoc
class _$GlossaryMetricCopyWithImpl<$Res>
    implements $GlossaryMetricCopyWith<$Res> {
  _$GlossaryMetricCopyWithImpl(this._self, this._then);

  final GlossaryMetric _self;
  final $Res Function(GlossaryMetric) _then;

/// Create a copy of GlossaryMetric
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? label = null,Object? fullName = null,Object? pillar = null,Object? weight = null,Object? formula = null,Object? plain = null,Object? ideal = null,Object? bands = null,Object? caveat = null,Object? watchOut = null,}) {
  return _then(GlossaryMetric(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,pillar: null == pillar ? _self.pillar : pillar // ignore: cast_nullable_to_non_nullable
as String,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,formula: null == formula ? _self.formula : formula // ignore: cast_nullable_to_non_nullable
as String,plain: null == plain ? _self.plain : plain // ignore: cast_nullable_to_non_nullable
as String,ideal: null == ideal ? _self.ideal : ideal // ignore: cast_nullable_to_non_nullable
as String,bands: null == bands ? _self.bands : bands // ignore: cast_nullable_to_non_nullable
as List<GlossaryBand>,caveat: null == caveat ? _self.caveat : caveat // ignore: cast_nullable_to_non_nullable
as String,watchOut: null == watchOut ? _self.watchOut : watchOut // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GlossaryMetric].
extension GlossaryMetricPatterns on GlossaryMetric {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GlossaryMetric value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GlossaryMetric() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GlossaryMetric value)  $default,){
final _that = this;
switch (_that) {
case _GlossaryMetric():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GlossaryMetric value)?  $default,){
final _that = this;
switch (_that) {
case _GlossaryMetric() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  String label,  String fullName,  String pillar,  double weight,  String formula,  String plain,  String ideal,  List<GlossaryBand> bands,  String caveat,  String watchOut)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GlossaryMetric() when $default != null:
return $default(_that.key,_that.label,_that.fullName,_that.pillar,_that.weight,_that.formula,_that.plain,_that.ideal,_that.bands,_that.caveat,_that.watchOut);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  String label,  String fullName,  String pillar,  double weight,  String formula,  String plain,  String ideal,  List<GlossaryBand> bands,  String caveat,  String watchOut)  $default,) {final _that = this;
switch (_that) {
case _GlossaryMetric():
return $default(_that.key,_that.label,_that.fullName,_that.pillar,_that.weight,_that.formula,_that.plain,_that.ideal,_that.bands,_that.caveat,_that.watchOut);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  String label,  String fullName,  String pillar,  double weight,  String formula,  String plain,  String ideal,  List<GlossaryBand> bands,  String caveat,  String watchOut)?  $default,) {final _that = this;
switch (_that) {
case _GlossaryMetric() when $default != null:
return $default(_that.key,_that.label,_that.fullName,_that.pillar,_that.weight,_that.formula,_that.plain,_that.ideal,_that.bands,_that.caveat,_that.watchOut);case _:
  return null;

}
}

}

/// @nodoc


class _GlossaryMetric extends GlossaryMetric {
  const _GlossaryMetric({required this.key, required this.label, required this.fullName, required this.pillar, required this.weight, required this.formula, required this.plain, required this.ideal, required  List<GlossaryBand> bands, required this.caveat, required this.watchOut}): _bands = bands,super._();
  

@override final  String key;
@override final  String label;
@override final  String fullName;
@override final  String pillar;
@override final  double weight;
@override final  String formula;
@override final  String plain;
@override final  String ideal;
 final  List<GlossaryBand> _bands;
@override List<GlossaryBand> get bands {
  if (_bands is EqualUnmodifiableListView) return _bands;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bands);
}

@override final  String caveat;
@override final  String watchOut;

/// Create a copy of GlossaryMetric
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GlossaryMetricCopyWith<_GlossaryMetric> get copyWith => __$GlossaryMetricCopyWithImpl<_GlossaryMetric>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GlossaryMetric&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.pillar, pillar) || other.pillar == pillar)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.formula, formula) || other.formula == formula)&&(identical(other.plain, plain) || other.plain == plain)&&(identical(other.ideal, ideal) || other.ideal == ideal)&&const DeepCollectionEquality().equals(other.bands, _bands)&&(identical(other.caveat, caveat) || other.caveat == caveat)&&(identical(other.watchOut, watchOut) || other.watchOut == watchOut));
}


@override
int get hashCode {
    return Object.hash(runtimeType,key,label,fullName,pillar,weight,formula,plain,ideal,const DeepCollectionEquality().hash(_bands),caveat,watchOut);
}

@override
String toString() {
    return 'GlossaryMetric(key: $key, label: $label, fullName: $fullName, pillar: $pillar, weight: $weight, formula: $formula, plain: $plain, ideal: $ideal, bands: $bands, caveat: $caveat, watchOut: $watchOut)';
}


}

/// @nodoc
abstract mixin class _$GlossaryMetricCopyWith<$Res> implements $GlossaryMetricCopyWith<$Res> {
  factory _$GlossaryMetricCopyWith(_GlossaryMetric value, $Res Function(_GlossaryMetric) _then) = __$GlossaryMetricCopyWithImpl;
@override @useResult
$Res call({
 String key, String label, String fullName, String pillar, double weight, String formula, String plain, String ideal, List<GlossaryBand> bands, String caveat, String watchOut
});




}
/// @nodoc
class __$GlossaryMetricCopyWithImpl<$Res>
    implements _$GlossaryMetricCopyWith<$Res> {
  __$GlossaryMetricCopyWithImpl(this._self, this._then);

  final _GlossaryMetric _self;
  final $Res Function(_GlossaryMetric) _then;

/// Create a copy of GlossaryMetric
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? label = null,Object? fullName = null,Object? pillar = null,Object? weight = null,Object? formula = null,Object? plain = null,Object? ideal = null,Object? bands = null,Object? caveat = null,Object? watchOut = null,}) {
  return _then(_GlossaryMetric(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,pillar: null == pillar ? _self.pillar : pillar // ignore: cast_nullable_to_non_nullable
as String,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,formula: null == formula ? _self.formula : formula // ignore: cast_nullable_to_non_nullable
as String,plain: null == plain ? _self.plain : plain // ignore: cast_nullable_to_non_nullable
as String,ideal: null == ideal ? _self.ideal : ideal // ignore: cast_nullable_to_non_nullable
as String,bands: null == bands ? _self._bands : bands // ignore: cast_nullable_to_non_nullable
as List<GlossaryBand>,caveat: null == caveat ? _self.caveat : caveat // ignore: cast_nullable_to_non_nullable
as String,watchOut: null == watchOut ? _self.watchOut : watchOut // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$GlossaryPillar {

 String get key; String get label; String get tagline; String get body;
/// Create a copy of GlossaryPillar
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GlossaryPillarCopyWith<GlossaryPillar> get copyWith => _$GlossaryPillarCopyWithImpl<GlossaryPillar>(this as GlossaryPillar, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as GlossaryPillar;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GlossaryPillar&&(identical(other.key, _this.key) || other.key == _this.key)&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.tagline, _this.tagline) || other.tagline == _this.tagline)&&(identical(other.body, _this.body) || other.body == _this.body));
}


@override
int get hashCode {
  final _this = this as GlossaryPillar;
  return Object.hash(runtimeType,_this.key,_this.label,_this.tagline,_this.body);
}

@override
String toString() {
  final _this = this as GlossaryPillar;
  return 'GlossaryPillar(key: ${_this.key}, label: ${_this.label}, tagline: ${_this.tagline}, body: ${_this.body})';
}


}

/// @nodoc
abstract mixin class $GlossaryPillarCopyWith<$Res>  {
  factory $GlossaryPillarCopyWith(GlossaryPillar value, $Res Function(GlossaryPillar) _then) = _$GlossaryPillarCopyWithImpl;
@useResult
$Res call({
 String key, String label, String tagline, String body
});




}
/// @nodoc
class _$GlossaryPillarCopyWithImpl<$Res>
    implements $GlossaryPillarCopyWith<$Res> {
  _$GlossaryPillarCopyWithImpl(this._self, this._then);

  final GlossaryPillar _self;
  final $Res Function(GlossaryPillar) _then;

/// Create a copy of GlossaryPillar
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? label = null,Object? tagline = null,Object? body = null,}) {
  return _then(GlossaryPillar(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,tagline: null == tagline ? _self.tagline : tagline // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GlossaryPillar].
extension GlossaryPillarPatterns on GlossaryPillar {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GlossaryPillar value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GlossaryPillar() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GlossaryPillar value)  $default,){
final _that = this;
switch (_that) {
case _GlossaryPillar():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GlossaryPillar value)?  $default,){
final _that = this;
switch (_that) {
case _GlossaryPillar() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  String label,  String tagline,  String body)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GlossaryPillar() when $default != null:
return $default(_that.key,_that.label,_that.tagline,_that.body);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  String label,  String tagline,  String body)  $default,) {final _that = this;
switch (_that) {
case _GlossaryPillar():
return $default(_that.key,_that.label,_that.tagline,_that.body);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  String label,  String tagline,  String body)?  $default,) {final _that = this;
switch (_that) {
case _GlossaryPillar() when $default != null:
return $default(_that.key,_that.label,_that.tagline,_that.body);case _:
  return null;

}
}

}

/// @nodoc


class _GlossaryPillar implements GlossaryPillar {
  const _GlossaryPillar({required this.key, required this.label, required this.tagline, required this.body});
  

@override final  String key;
@override final  String label;
@override final  String tagline;
@override final  String body;

/// Create a copy of GlossaryPillar
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GlossaryPillarCopyWith<_GlossaryPillar> get copyWith => __$GlossaryPillarCopyWithImpl<_GlossaryPillar>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GlossaryPillar&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label)&&(identical(other.tagline, tagline) || other.tagline == tagline)&&(identical(other.body, body) || other.body == body));
}


@override
int get hashCode {
    return Object.hash(runtimeType,key,label,tagline,body);
}

@override
String toString() {
    return 'GlossaryPillar(key: $key, label: $label, tagline: $tagline, body: $body)';
}


}

/// @nodoc
abstract mixin class _$GlossaryPillarCopyWith<$Res> implements $GlossaryPillarCopyWith<$Res> {
  factory _$GlossaryPillarCopyWith(_GlossaryPillar value, $Res Function(_GlossaryPillar) _then) = __$GlossaryPillarCopyWithImpl;
@override @useResult
$Res call({
 String key, String label, String tagline, String body
});




}
/// @nodoc
class __$GlossaryPillarCopyWithImpl<$Res>
    implements _$GlossaryPillarCopyWith<$Res> {
  __$GlossaryPillarCopyWithImpl(this._self, this._then);

  final _GlossaryPillar _self;
  final $Res Function(_GlossaryPillar) _then;

/// Create a copy of GlossaryPillar
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? label = null,Object? tagline = null,Object? body = null,}) {
  return _then(_GlossaryPillar(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,tagline: null == tagline ? _self.tagline : tagline // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$GlossaryIntro {

 String get title; String get body;
/// Create a copy of GlossaryIntro
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GlossaryIntroCopyWith<GlossaryIntro> get copyWith => _$GlossaryIntroCopyWithImpl<GlossaryIntro>(this as GlossaryIntro, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as GlossaryIntro;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GlossaryIntro&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.body, _this.body) || other.body == _this.body));
}


@override
int get hashCode {
  final _this = this as GlossaryIntro;
  return Object.hash(runtimeType,_this.title,_this.body);
}

@override
String toString() {
  final _this = this as GlossaryIntro;
  return 'GlossaryIntro(title: ${_this.title}, body: ${_this.body})';
}


}

/// @nodoc
abstract mixin class $GlossaryIntroCopyWith<$Res>  {
  factory $GlossaryIntroCopyWith(GlossaryIntro value, $Res Function(GlossaryIntro) _then) = _$GlossaryIntroCopyWithImpl;
@useResult
$Res call({
 String title, String body
});




}
/// @nodoc
class _$GlossaryIntroCopyWithImpl<$Res>
    implements $GlossaryIntroCopyWith<$Res> {
  _$GlossaryIntroCopyWithImpl(this._self, this._then);

  final GlossaryIntro _self;
  final $Res Function(GlossaryIntro) _then;

/// Create a copy of GlossaryIntro
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? body = null,}) {
  return _then(GlossaryIntro(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GlossaryIntro].
extension GlossaryIntroPatterns on GlossaryIntro {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GlossaryIntro value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GlossaryIntro() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GlossaryIntro value)  $default,){
final _that = this;
switch (_that) {
case _GlossaryIntro():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GlossaryIntro value)?  $default,){
final _that = this;
switch (_that) {
case _GlossaryIntro() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String body)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GlossaryIntro() when $default != null:
return $default(_that.title,_that.body);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String body)  $default,) {final _that = this;
switch (_that) {
case _GlossaryIntro():
return $default(_that.title,_that.body);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String body)?  $default,) {final _that = this;
switch (_that) {
case _GlossaryIntro() when $default != null:
return $default(_that.title,_that.body);case _:
  return null;

}
}

}

/// @nodoc


class _GlossaryIntro implements GlossaryIntro {
  const _GlossaryIntro({required this.title, required this.body});
  

@override final  String title;
@override final  String body;

/// Create a copy of GlossaryIntro
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GlossaryIntroCopyWith<_GlossaryIntro> get copyWith => __$GlossaryIntroCopyWithImpl<_GlossaryIntro>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GlossaryIntro&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body));
}


@override
int get hashCode {
    return Object.hash(runtimeType,title,body);
}

@override
String toString() {
    return 'GlossaryIntro(title: $title, body: $body)';
}


}

/// @nodoc
abstract mixin class _$GlossaryIntroCopyWith<$Res> implements $GlossaryIntroCopyWith<$Res> {
  factory _$GlossaryIntroCopyWith(_GlossaryIntro value, $Res Function(_GlossaryIntro) _then) = __$GlossaryIntroCopyWithImpl;
@override @useResult
$Res call({
 String title, String body
});




}
/// @nodoc
class __$GlossaryIntroCopyWithImpl<$Res>
    implements _$GlossaryIntroCopyWith<$Res> {
  __$GlossaryIntroCopyWithImpl(this._self, this._then);

  final _GlossaryIntro _self;
  final $Res Function(_GlossaryIntro) _then;

/// Create a copy of GlossaryIntro
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? body = null,}) {
  return _then(_GlossaryIntro(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$GradeBand {

 double get min; String get grade; String get label;
/// Create a copy of GradeBand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GradeBandCopyWith<GradeBand> get copyWith => _$GradeBandCopyWithImpl<GradeBand>(this as GradeBand, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as GradeBand;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GradeBand&&(identical(other.min, _this.min) || other.min == _this.min)&&(identical(other.grade, _this.grade) || other.grade == _this.grade)&&(identical(other.label, _this.label) || other.label == _this.label));
}


@override
int get hashCode {
  final _this = this as GradeBand;
  return Object.hash(runtimeType,_this.min,_this.grade,_this.label);
}

@override
String toString() {
  final _this = this as GradeBand;
  return 'GradeBand(min: ${_this.min}, grade: ${_this.grade}, label: ${_this.label})';
}


}

/// @nodoc
abstract mixin class $GradeBandCopyWith<$Res>  {
  factory $GradeBandCopyWith(GradeBand value, $Res Function(GradeBand) _then) = _$GradeBandCopyWithImpl;
@useResult
$Res call({
 double min, String grade, String label
});




}
/// @nodoc
class _$GradeBandCopyWithImpl<$Res>
    implements $GradeBandCopyWith<$Res> {
  _$GradeBandCopyWithImpl(this._self, this._then);

  final GradeBand _self;
  final $Res Function(GradeBand) _then;

/// Create a copy of GradeBand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? min = null,Object? grade = null,Object? label = null,}) {
  return _then(GradeBand(
min: null == min ? _self.min : min // ignore: cast_nullable_to_non_nullable
as double,grade: null == grade ? _self.grade : grade // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GradeBand].
extension GradeBandPatterns on GradeBand {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GradeBand value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GradeBand() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GradeBand value)  $default,){
final _that = this;
switch (_that) {
case _GradeBand():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GradeBand value)?  $default,){
final _that = this;
switch (_that) {
case _GradeBand() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double min,  String grade,  String label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GradeBand() when $default != null:
return $default(_that.min,_that.grade,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double min,  String grade,  String label)  $default,) {final _that = this;
switch (_that) {
case _GradeBand():
return $default(_that.min,_that.grade,_that.label);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double min,  String grade,  String label)?  $default,) {final _that = this;
switch (_that) {
case _GradeBand() when $default != null:
return $default(_that.min,_that.grade,_that.label);case _:
  return null;

}
}

}

/// @nodoc


class _GradeBand implements GradeBand {
  const _GradeBand({required this.min, required this.grade, required this.label});
  

@override final  double min;
@override final  String grade;
@override final  String label;

/// Create a copy of GradeBand
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GradeBandCopyWith<_GradeBand> get copyWith => __$GradeBandCopyWithImpl<_GradeBand>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GradeBand&&(identical(other.min, min) || other.min == min)&&(identical(other.grade, grade) || other.grade == grade)&&(identical(other.label, label) || other.label == label));
}


@override
int get hashCode {
    return Object.hash(runtimeType,min,grade,label);
}

@override
String toString() {
    return 'GradeBand(min: $min, grade: $grade, label: $label)';
}


}

/// @nodoc
abstract mixin class _$GradeBandCopyWith<$Res> implements $GradeBandCopyWith<$Res> {
  factory _$GradeBandCopyWith(_GradeBand value, $Res Function(_GradeBand) _then) = __$GradeBandCopyWithImpl;
@override @useResult
$Res call({
 double min, String grade, String label
});




}
/// @nodoc
class __$GradeBandCopyWithImpl<$Res>
    implements _$GradeBandCopyWith<$Res> {
  __$GradeBandCopyWithImpl(this._self, this._then);

  final _GradeBand _self;
  final $Res Function(_GradeBand) _then;

/// Create a copy of GradeBand
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? min = null,Object? grade = null,Object? label = null,}) {
  return _then(_GradeBand(
min: null == min ? _self.min : min // ignore: cast_nullable_to_non_nullable
as double,grade: null == grade ? _self.grade : grade // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ScoringGuide {

 List<GradeBand> get grades; List<String> get howItWorks; String get limits;
/// Create a copy of ScoringGuide
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScoringGuideCopyWith<ScoringGuide> get copyWith => _$ScoringGuideCopyWithImpl<ScoringGuide>(this as ScoringGuide, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ScoringGuide;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScoringGuide&&const DeepCollectionEquality().equals(other.grades, _this.grades)&&const DeepCollectionEquality().equals(other.howItWorks, _this.howItWorks)&&(identical(other.limits, _this.limits) || other.limits == _this.limits));
}


@override
int get hashCode {
  final _this = this as ScoringGuide;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.grades),const DeepCollectionEquality().hash(_this.howItWorks),_this.limits);
}

@override
String toString() {
  final _this = this as ScoringGuide;
  return 'ScoringGuide(grades: ${_this.grades}, howItWorks: ${_this.howItWorks}, limits: ${_this.limits})';
}


}

/// @nodoc
abstract mixin class $ScoringGuideCopyWith<$Res>  {
  factory $ScoringGuideCopyWith(ScoringGuide value, $Res Function(ScoringGuide) _then) = _$ScoringGuideCopyWithImpl;
@useResult
$Res call({
 List<GradeBand> grades, List<String> howItWorks, String limits
});




}
/// @nodoc
class _$ScoringGuideCopyWithImpl<$Res>
    implements $ScoringGuideCopyWith<$Res> {
  _$ScoringGuideCopyWithImpl(this._self, this._then);

  final ScoringGuide _self;
  final $Res Function(ScoringGuide) _then;

/// Create a copy of ScoringGuide
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? grades = null,Object? howItWorks = null,Object? limits = null,}) {
  return _then(ScoringGuide(
grades: null == grades ? _self.grades : grades // ignore: cast_nullable_to_non_nullable
as List<GradeBand>,howItWorks: null == howItWorks ? _self.howItWorks : howItWorks // ignore: cast_nullable_to_non_nullable
as List<String>,limits: null == limits ? _self.limits : limits // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ScoringGuide].
extension ScoringGuidePatterns on ScoringGuide {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScoringGuide value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScoringGuide() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScoringGuide value)  $default,){
final _that = this;
switch (_that) {
case _ScoringGuide():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScoringGuide value)?  $default,){
final _that = this;
switch (_that) {
case _ScoringGuide() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<GradeBand> grades,  List<String> howItWorks,  String limits)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScoringGuide() when $default != null:
return $default(_that.grades,_that.howItWorks,_that.limits);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<GradeBand> grades,  List<String> howItWorks,  String limits)  $default,) {final _that = this;
switch (_that) {
case _ScoringGuide():
return $default(_that.grades,_that.howItWorks,_that.limits);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<GradeBand> grades,  List<String> howItWorks,  String limits)?  $default,) {final _that = this;
switch (_that) {
case _ScoringGuide() when $default != null:
return $default(_that.grades,_that.howItWorks,_that.limits);case _:
  return null;

}
}

}

/// @nodoc


class _ScoringGuide implements ScoringGuide {
  const _ScoringGuide({required  List<GradeBand> grades, required  List<String> howItWorks, required this.limits}): _grades = grades,_howItWorks = howItWorks;
  

 final  List<GradeBand> _grades;
@override List<GradeBand> get grades {
  if (_grades is EqualUnmodifiableListView) return _grades;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_grades);
}

 final  List<String> _howItWorks;
@override List<String> get howItWorks {
  if (_howItWorks is EqualUnmodifiableListView) return _howItWorks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_howItWorks);
}

@override final  String limits;

/// Create a copy of ScoringGuide
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScoringGuideCopyWith<_ScoringGuide> get copyWith => __$ScoringGuideCopyWithImpl<_ScoringGuide>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScoringGuide&&const DeepCollectionEquality().equals(other.grades, _grades)&&const DeepCollectionEquality().equals(other.howItWorks, _howItWorks)&&(identical(other.limits, limits) || other.limits == limits));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_grades),const DeepCollectionEquality().hash(_howItWorks),limits);
}

@override
String toString() {
    return 'ScoringGuide(grades: $grades, howItWorks: $howItWorks, limits: $limits)';
}


}

/// @nodoc
abstract mixin class _$ScoringGuideCopyWith<$Res> implements $ScoringGuideCopyWith<$Res> {
  factory _$ScoringGuideCopyWith(_ScoringGuide value, $Res Function(_ScoringGuide) _then) = __$ScoringGuideCopyWithImpl;
@override @useResult
$Res call({
 List<GradeBand> grades, List<String> howItWorks, String limits
});




}
/// @nodoc
class __$ScoringGuideCopyWithImpl<$Res>
    implements _$ScoringGuideCopyWith<$Res> {
  __$ScoringGuideCopyWithImpl(this._self, this._then);

  final _ScoringGuide _self;
  final $Res Function(_ScoringGuide) _then;

/// Create a copy of ScoringGuide
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? grades = null,Object? howItWorks = null,Object? limits = null,}) {
  return _then(_ScoringGuide(
grades: null == grades ? _self._grades : grades // ignore: cast_nullable_to_non_nullable
as List<GradeBand>,howItWorks: null == howItWorks ? _self._howItWorks : howItWorks // ignore: cast_nullable_to_non_nullable
as List<String>,limits: null == limits ? _self.limits : limits // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$Glossary {

 List<GlossaryIntro> get intro;/// In the order the score and the guide present them.
 List<GlossaryPillar> get pillars;/// In the file's order, which groups them by pillar.
 Map<String, GlossaryMetric> get metrics; ScoringGuide get scoring;
/// Create a copy of Glossary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GlossaryCopyWith<Glossary> get copyWith => _$GlossaryCopyWithImpl<Glossary>(this as Glossary, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Glossary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Glossary&&const DeepCollectionEquality().equals(other.intro, _this.intro)&&const DeepCollectionEquality().equals(other.pillars, _this.pillars)&&const DeepCollectionEquality().equals(other.metrics, _this.metrics)&&(identical(other.scoring, _this.scoring) || other.scoring == _this.scoring));
}


@override
int get hashCode {
  final _this = this as Glossary;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.intro),const DeepCollectionEquality().hash(_this.pillars),const DeepCollectionEquality().hash(_this.metrics),_this.scoring);
}

@override
String toString() {
  final _this = this as Glossary;
  return 'Glossary(intro: ${_this.intro}, pillars: ${_this.pillars}, metrics: ${_this.metrics}, scoring: ${_this.scoring})';
}


}

/// @nodoc
abstract mixin class $GlossaryCopyWith<$Res>  {
  factory $GlossaryCopyWith(Glossary value, $Res Function(Glossary) _then) = _$GlossaryCopyWithImpl;
@useResult
$Res call({
 List<GlossaryIntro> intro, List<GlossaryPillar> pillars, Map<String, GlossaryMetric> metrics, ScoringGuide scoring
});


$ScoringGuideCopyWith<$Res> get scoring;

}
/// @nodoc
class _$GlossaryCopyWithImpl<$Res>
    implements $GlossaryCopyWith<$Res> {
  _$GlossaryCopyWithImpl(this._self, this._then);

  final Glossary _self;
  final $Res Function(Glossary) _then;

/// Create a copy of Glossary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? intro = null,Object? pillars = null,Object? metrics = null,Object? scoring = null,}) {
  return _then(Glossary(
intro: null == intro ? _self.intro : intro // ignore: cast_nullable_to_non_nullable
as List<GlossaryIntro>,pillars: null == pillars ? _self.pillars : pillars // ignore: cast_nullable_to_non_nullable
as List<GlossaryPillar>,metrics: null == metrics ? _self.metrics : metrics // ignore: cast_nullable_to_non_nullable
as Map<String, GlossaryMetric>,scoring: null == scoring ? _self.scoring : scoring // ignore: cast_nullable_to_non_nullable
as ScoringGuide,
  ));
}
/// Create a copy of Glossary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScoringGuideCopyWith<$Res> get scoring {
  
  return $ScoringGuideCopyWith<$Res>(_self.scoring, (value) {
    return _then(_self.copyWith(scoring: value));
  });
}
}


/// Adds pattern-matching-related methods to [Glossary].
extension GlossaryPatterns on Glossary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Glossary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Glossary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Glossary value)  $default,){
final _that = this;
switch (_that) {
case _Glossary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Glossary value)?  $default,){
final _that = this;
switch (_that) {
case _Glossary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<GlossaryIntro> intro,  List<GlossaryPillar> pillars,  Map<String, GlossaryMetric> metrics,  ScoringGuide scoring)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Glossary() when $default != null:
return $default(_that.intro,_that.pillars,_that.metrics,_that.scoring);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<GlossaryIntro> intro,  List<GlossaryPillar> pillars,  Map<String, GlossaryMetric> metrics,  ScoringGuide scoring)  $default,) {final _that = this;
switch (_that) {
case _Glossary():
return $default(_that.intro,_that.pillars,_that.metrics,_that.scoring);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<GlossaryIntro> intro,  List<GlossaryPillar> pillars,  Map<String, GlossaryMetric> metrics,  ScoringGuide scoring)?  $default,) {final _that = this;
switch (_that) {
case _Glossary() when $default != null:
return $default(_that.intro,_that.pillars,_that.metrics,_that.scoring);case _:
  return null;

}
}

}

/// @nodoc


class _Glossary extends Glossary {
  const _Glossary({required  List<GlossaryIntro> intro, required  List<GlossaryPillar> pillars, required  Map<String, GlossaryMetric> metrics, required this.scoring}): _intro = intro,_pillars = pillars,_metrics = metrics,super._();
  

 final  List<GlossaryIntro> _intro;
@override List<GlossaryIntro> get intro {
  if (_intro is EqualUnmodifiableListView) return _intro;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_intro);
}

/// In the order the score and the guide present them.
 final  List<GlossaryPillar> _pillars;
/// In the order the score and the guide present them.
@override List<GlossaryPillar> get pillars {
  if (_pillars is EqualUnmodifiableListView) return _pillars;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pillars);
}

/// In the file's order, which groups them by pillar.
 final  Map<String, GlossaryMetric> _metrics;
/// In the file's order, which groups them by pillar.
@override Map<String, GlossaryMetric> get metrics {
  if (_metrics is EqualUnmodifiableMapView) return _metrics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metrics);
}

@override final  ScoringGuide scoring;

/// Create a copy of Glossary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GlossaryCopyWith<_Glossary> get copyWith => __$GlossaryCopyWithImpl<_Glossary>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Glossary&&const DeepCollectionEquality().equals(other.intro, _intro)&&const DeepCollectionEquality().equals(other.pillars, _pillars)&&const DeepCollectionEquality().equals(other.metrics, _metrics)&&(identical(other.scoring, scoring) || other.scoring == scoring));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_intro),const DeepCollectionEquality().hash(_pillars),const DeepCollectionEquality().hash(_metrics),scoring);
}

@override
String toString() {
    return 'Glossary(intro: $intro, pillars: $pillars, metrics: $metrics, scoring: $scoring)';
}


}

/// @nodoc
abstract mixin class _$GlossaryCopyWith<$Res> implements $GlossaryCopyWith<$Res> {
  factory _$GlossaryCopyWith(_Glossary value, $Res Function(_Glossary) _then) = __$GlossaryCopyWithImpl;
@override @useResult
$Res call({
 List<GlossaryIntro> intro, List<GlossaryPillar> pillars, Map<String, GlossaryMetric> metrics, ScoringGuide scoring
});


@override $ScoringGuideCopyWith<$Res> get scoring;

}
/// @nodoc
class __$GlossaryCopyWithImpl<$Res>
    implements _$GlossaryCopyWith<$Res> {
  __$GlossaryCopyWithImpl(this._self, this._then);

  final _Glossary _self;
  final $Res Function(_Glossary) _then;

/// Create a copy of Glossary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? intro = null,Object? pillars = null,Object? metrics = null,Object? scoring = null,}) {
  return _then(_Glossary(
intro: null == intro ? _self._intro : intro // ignore: cast_nullable_to_non_nullable
as List<GlossaryIntro>,pillars: null == pillars ? _self._pillars : pillars // ignore: cast_nullable_to_non_nullable
as List<GlossaryPillar>,metrics: null == metrics ? _self._metrics : metrics // ignore: cast_nullable_to_non_nullable
as Map<String, GlossaryMetric>,scoring: null == scoring ? _self.scoring : scoring // ignore: cast_nullable_to_non_nullable
as ScoringGuide,
  ));
}

/// Create a copy of Glossary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScoringGuideCopyWith<$Res> get scoring {
  
  return $ScoringGuideCopyWith<$Res>(_self.scoring, (value) {
    return _then(_self.copyWith(scoring: value));
  });
}
}

// dart format on
