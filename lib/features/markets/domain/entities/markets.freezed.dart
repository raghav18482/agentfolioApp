// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'markets.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ArticleSentiment {

 ArticleTone get tone; double get confidence;
/// Create a copy of ArticleSentiment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticleSentimentCopyWith<ArticleSentiment> get copyWith => _$ArticleSentimentCopyWithImpl<ArticleSentiment>(this as ArticleSentiment, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ArticleSentiment;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArticleSentiment&&(identical(other.tone, _this.tone) || other.tone == _this.tone)&&(identical(other.confidence, _this.confidence) || other.confidence == _this.confidence));
}


@override
int get hashCode {
  final _this = this as ArticleSentiment;
  return Object.hash(runtimeType,_this.tone,_this.confidence);
}

@override
String toString() {
  final _this = this as ArticleSentiment;
  return 'ArticleSentiment(tone: ${_this.tone}, confidence: ${_this.confidence})';
}


}

/// @nodoc
abstract mixin class $ArticleSentimentCopyWith<$Res>  {
  factory $ArticleSentimentCopyWith(ArticleSentiment value, $Res Function(ArticleSentiment) _then) = _$ArticleSentimentCopyWithImpl;
@useResult
$Res call({
 ArticleTone tone, double confidence
});




}
/// @nodoc
class _$ArticleSentimentCopyWithImpl<$Res>
    implements $ArticleSentimentCopyWith<$Res> {
  _$ArticleSentimentCopyWithImpl(this._self, this._then);

  final ArticleSentiment _self;
  final $Res Function(ArticleSentiment) _then;

/// Create a copy of ArticleSentiment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tone = null,Object? confidence = null,}) {
  return _then(ArticleSentiment(
tone: null == tone ? _self.tone : tone // ignore: cast_nullable_to_non_nullable
as ArticleTone,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ArticleSentiment].
extension ArticleSentimentPatterns on ArticleSentiment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArticleSentiment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArticleSentiment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArticleSentiment value)  $default,){
final _that = this;
switch (_that) {
case _ArticleSentiment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArticleSentiment value)?  $default,){
final _that = this;
switch (_that) {
case _ArticleSentiment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ArticleTone tone,  double confidence)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArticleSentiment() when $default != null:
return $default(_that.tone,_that.confidence);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ArticleTone tone,  double confidence)  $default,) {final _that = this;
switch (_that) {
case _ArticleSentiment():
return $default(_that.tone,_that.confidence);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ArticleTone tone,  double confidence)?  $default,) {final _that = this;
switch (_that) {
case _ArticleSentiment() when $default != null:
return $default(_that.tone,_that.confidence);case _:
  return null;

}
}

}

/// @nodoc


class _ArticleSentiment implements ArticleSentiment {
  const _ArticleSentiment({required this.tone, required this.confidence});
  

@override final  ArticleTone tone;
@override final  double confidence;

/// Create a copy of ArticleSentiment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArticleSentimentCopyWith<_ArticleSentiment> get copyWith => __$ArticleSentimentCopyWithImpl<_ArticleSentiment>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArticleSentiment&&(identical(other.tone, tone) || other.tone == tone)&&(identical(other.confidence, confidence) || other.confidence == confidence));
}


@override
int get hashCode {
    return Object.hash(runtimeType,tone,confidence);
}

@override
String toString() {
    return 'ArticleSentiment(tone: $tone, confidence: $confidence)';
}


}

/// @nodoc
abstract mixin class _$ArticleSentimentCopyWith<$Res> implements $ArticleSentimentCopyWith<$Res> {
  factory _$ArticleSentimentCopyWith(_ArticleSentiment value, $Res Function(_ArticleSentiment) _then) = __$ArticleSentimentCopyWithImpl;
@override @useResult
$Res call({
 ArticleTone tone, double confidence
});




}
/// @nodoc
class __$ArticleSentimentCopyWithImpl<$Res>
    implements _$ArticleSentimentCopyWith<$Res> {
  __$ArticleSentimentCopyWithImpl(this._self, this._then);

  final _ArticleSentiment _self;
  final $Res Function(_ArticleSentiment) _then;

/// Create a copy of ArticleSentiment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tone = null,Object? confidence = null,}) {
  return _then(_ArticleSentiment(
tone: null == tone ? _self.tone : tone // ignore: cast_nullable_to_non_nullable
as ArticleTone,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$NewsArticle {

 String get title; String get description; String get source;/// The publisher's page, through Google News. Null when not a web link.
 Uri? get link;/// Parsed from [rawDate] when it is a standard date.
 DateTime? get publishedAt;/// The date exactly as the server sent it, kept so sentiment requests
/// echo the article back unchanged.
 String get rawDate; ArticleSentiment? get sentiment;
/// Create a copy of NewsArticle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewsArticleCopyWith<NewsArticle> get copyWith => _$NewsArticleCopyWithImpl<NewsArticle>(this as NewsArticle, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as NewsArticle;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewsArticle&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.source, _this.source) || other.source == _this.source)&&(identical(other.link, _this.link) || other.link == _this.link)&&(identical(other.publishedAt, _this.publishedAt) || other.publishedAt == _this.publishedAt)&&(identical(other.rawDate, _this.rawDate) || other.rawDate == _this.rawDate)&&(identical(other.sentiment, _this.sentiment) || other.sentiment == _this.sentiment));
}


@override
int get hashCode {
  final _this = this as NewsArticle;
  return Object.hash(runtimeType,_this.title,_this.description,_this.source,_this.link,_this.publishedAt,_this.rawDate,_this.sentiment);
}

@override
String toString() {
  final _this = this as NewsArticle;
  return 'NewsArticle(title: ${_this.title}, description: ${_this.description}, source: ${_this.source}, link: ${_this.link}, publishedAt: ${_this.publishedAt}, rawDate: ${_this.rawDate}, sentiment: ${_this.sentiment})';
}


}

/// @nodoc
abstract mixin class $NewsArticleCopyWith<$Res>  {
  factory $NewsArticleCopyWith(NewsArticle value, $Res Function(NewsArticle) _then) = _$NewsArticleCopyWithImpl;
@useResult
$Res call({
 String title, String description, String source, Uri? link, DateTime? publishedAt, String rawDate, ArticleSentiment? sentiment
});


$ArticleSentimentCopyWith<$Res>? get sentiment;

}
/// @nodoc
class _$NewsArticleCopyWithImpl<$Res>
    implements $NewsArticleCopyWith<$Res> {
  _$NewsArticleCopyWithImpl(this._self, this._then);

  final NewsArticle _self;
  final $Res Function(NewsArticle) _then;

/// Create a copy of NewsArticle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? description = null,Object? source = null,Object? link = freezed,Object? publishedAt = freezed,Object? rawDate = null,Object? sentiment = freezed,}) {
  return _then(NewsArticle(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as Uri?,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,rawDate: null == rawDate ? _self.rawDate : rawDate // ignore: cast_nullable_to_non_nullable
as String,sentiment: freezed == sentiment ? _self.sentiment : sentiment // ignore: cast_nullable_to_non_nullable
as ArticleSentiment?,
  ));
}
/// Create a copy of NewsArticle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArticleSentimentCopyWith<$Res>? get sentiment {
    if (_self.sentiment == null) {
    return null;
  }

  return $ArticleSentimentCopyWith<$Res>(_self.sentiment!, (value) {
    return _then(_self.copyWith(sentiment: value));
  });
}
}


/// Adds pattern-matching-related methods to [NewsArticle].
extension NewsArticlePatterns on NewsArticle {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NewsArticle value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NewsArticle() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NewsArticle value)  $default,){
final _that = this;
switch (_that) {
case _NewsArticle():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NewsArticle value)?  $default,){
final _that = this;
switch (_that) {
case _NewsArticle() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String description,  String source,  Uri? link,  DateTime? publishedAt,  String rawDate,  ArticleSentiment? sentiment)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NewsArticle() when $default != null:
return $default(_that.title,_that.description,_that.source,_that.link,_that.publishedAt,_that.rawDate,_that.sentiment);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String description,  String source,  Uri? link,  DateTime? publishedAt,  String rawDate,  ArticleSentiment? sentiment)  $default,) {final _that = this;
switch (_that) {
case _NewsArticle():
return $default(_that.title,_that.description,_that.source,_that.link,_that.publishedAt,_that.rawDate,_that.sentiment);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String description,  String source,  Uri? link,  DateTime? publishedAt,  String rawDate,  ArticleSentiment? sentiment)?  $default,) {final _that = this;
switch (_that) {
case _NewsArticle() when $default != null:
return $default(_that.title,_that.description,_that.source,_that.link,_that.publishedAt,_that.rawDate,_that.sentiment);case _:
  return null;

}
}

}

/// @nodoc


class _NewsArticle implements NewsArticle {
  const _NewsArticle({required this.title, required this.description, required this.source, this.link, this.publishedAt, this.rawDate = '', this.sentiment});
  

@override final  String title;
@override final  String description;
@override final  String source;
/// The publisher's page, through Google News. Null when not a web link.
@override final  Uri? link;
/// Parsed from [rawDate] when it is a standard date.
@override final  DateTime? publishedAt;
/// The date exactly as the server sent it, kept so sentiment requests
/// echo the article back unchanged.
@override@JsonKey() final  String rawDate;
@override final  ArticleSentiment? sentiment;

/// Create a copy of NewsArticle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewsArticleCopyWith<_NewsArticle> get copyWith => __$NewsArticleCopyWithImpl<_NewsArticle>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewsArticle&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.source, source) || other.source == source)&&(identical(other.link, link) || other.link == link)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.rawDate, rawDate) || other.rawDate == rawDate)&&(identical(other.sentiment, sentiment) || other.sentiment == sentiment));
}


@override
int get hashCode {
    return Object.hash(runtimeType,title,description,source,link,publishedAt,rawDate,sentiment);
}

@override
String toString() {
    return 'NewsArticle(title: $title, description: $description, source: $source, link: $link, publishedAt: $publishedAt, rawDate: $rawDate, sentiment: $sentiment)';
}


}

/// @nodoc
abstract mixin class _$NewsArticleCopyWith<$Res> implements $NewsArticleCopyWith<$Res> {
  factory _$NewsArticleCopyWith(_NewsArticle value, $Res Function(_NewsArticle) _then) = __$NewsArticleCopyWithImpl;
@override @useResult
$Res call({
 String title, String description, String source, Uri? link, DateTime? publishedAt, String rawDate, ArticleSentiment? sentiment
});


@override $ArticleSentimentCopyWith<$Res>? get sentiment;

}
/// @nodoc
class __$NewsArticleCopyWithImpl<$Res>
    implements _$NewsArticleCopyWith<$Res> {
  __$NewsArticleCopyWithImpl(this._self, this._then);

  final _NewsArticle _self;
  final $Res Function(_NewsArticle) _then;

/// Create a copy of NewsArticle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = null,Object? source = null,Object? link = freezed,Object? publishedAt = freezed,Object? rawDate = null,Object? sentiment = freezed,}) {
  return _then(_NewsArticle(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as Uri?,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,rawDate: null == rawDate ? _self.rawDate : rawDate // ignore: cast_nullable_to_non_nullable
as String,sentiment: freezed == sentiment ? _self.sentiment : sentiment // ignore: cast_nullable_to_non_nullable
as ArticleSentiment?,
  ));
}

/// Create a copy of NewsArticle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArticleSentimentCopyWith<$Res>? get sentiment {
    if (_self.sentiment == null) {
    return null;
  }

  return $ArticleSentimentCopyWith<$Res>(_self.sentiment!, (value) {
    return _then(_self.copyWith(sentiment: value));
  });
}
}

/// @nodoc
mixin _$SentimentSummary {

 Mood get mood;/// -1 (all negative) to 1 (all positive).
 double get score; int get bullish; int get bearish; int get neutral;
/// Create a copy of SentimentSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SentimentSummaryCopyWith<SentimentSummary> get copyWith => _$SentimentSummaryCopyWithImpl<SentimentSummary>(this as SentimentSummary, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SentimentSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SentimentSummary&&(identical(other.mood, _this.mood) || other.mood == _this.mood)&&(identical(other.score, _this.score) || other.score == _this.score)&&(identical(other.bullish, _this.bullish) || other.bullish == _this.bullish)&&(identical(other.bearish, _this.bearish) || other.bearish == _this.bearish)&&(identical(other.neutral, _this.neutral) || other.neutral == _this.neutral));
}


@override
int get hashCode {
  final _this = this as SentimentSummary;
  return Object.hash(runtimeType,_this.mood,_this.score,_this.bullish,_this.bearish,_this.neutral);
}

@override
String toString() {
  final _this = this as SentimentSummary;
  return 'SentimentSummary(mood: ${_this.mood}, score: ${_this.score}, bullish: ${_this.bullish}, bearish: ${_this.bearish}, neutral: ${_this.neutral})';
}


}

/// @nodoc
abstract mixin class $SentimentSummaryCopyWith<$Res>  {
  factory $SentimentSummaryCopyWith(SentimentSummary value, $Res Function(SentimentSummary) _then) = _$SentimentSummaryCopyWithImpl;
@useResult
$Res call({
 Mood mood, double score, int bullish, int bearish, int neutral
});




}
/// @nodoc
class _$SentimentSummaryCopyWithImpl<$Res>
    implements $SentimentSummaryCopyWith<$Res> {
  _$SentimentSummaryCopyWithImpl(this._self, this._then);

  final SentimentSummary _self;
  final $Res Function(SentimentSummary) _then;

/// Create a copy of SentimentSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mood = null,Object? score = null,Object? bullish = null,Object? bearish = null,Object? neutral = null,}) {
  return _then(SentimentSummary(
mood: null == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as Mood,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,bullish: null == bullish ? _self.bullish : bullish // ignore: cast_nullable_to_non_nullable
as int,bearish: null == bearish ? _self.bearish : bearish // ignore: cast_nullable_to_non_nullable
as int,neutral: null == neutral ? _self.neutral : neutral // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SentimentSummary].
extension SentimentSummaryPatterns on SentimentSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SentimentSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SentimentSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SentimentSummary value)  $default,){
final _that = this;
switch (_that) {
case _SentimentSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SentimentSummary value)?  $default,){
final _that = this;
switch (_that) {
case _SentimentSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Mood mood,  double score,  int bullish,  int bearish,  int neutral)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SentimentSummary() when $default != null:
return $default(_that.mood,_that.score,_that.bullish,_that.bearish,_that.neutral);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Mood mood,  double score,  int bullish,  int bearish,  int neutral)  $default,) {final _that = this;
switch (_that) {
case _SentimentSummary():
return $default(_that.mood,_that.score,_that.bullish,_that.bearish,_that.neutral);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Mood mood,  double score,  int bullish,  int bearish,  int neutral)?  $default,) {final _that = this;
switch (_that) {
case _SentimentSummary() when $default != null:
return $default(_that.mood,_that.score,_that.bullish,_that.bearish,_that.neutral);case _:
  return null;

}
}

}

/// @nodoc


class _SentimentSummary extends SentimentSummary {
  const _SentimentSummary({required this.mood, required this.score, required this.bullish, required this.bearish, required this.neutral}): super._();
  

@override final  Mood mood;
/// -1 (all negative) to 1 (all positive).
@override final  double score;
@override final  int bullish;
@override final  int bearish;
@override final  int neutral;

/// Create a copy of SentimentSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SentimentSummaryCopyWith<_SentimentSummary> get copyWith => __$SentimentSummaryCopyWithImpl<_SentimentSummary>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SentimentSummary&&(identical(other.mood, mood) || other.mood == mood)&&(identical(other.score, score) || other.score == score)&&(identical(other.bullish, bullish) || other.bullish == bullish)&&(identical(other.bearish, bearish) || other.bearish == bearish)&&(identical(other.neutral, neutral) || other.neutral == neutral));
}


@override
int get hashCode {
    return Object.hash(runtimeType,mood,score,bullish,bearish,neutral);
}

@override
String toString() {
    return 'SentimentSummary(mood: $mood, score: $score, bullish: $bullish, bearish: $bearish, neutral: $neutral)';
}


}

/// @nodoc
abstract mixin class _$SentimentSummaryCopyWith<$Res> implements $SentimentSummaryCopyWith<$Res> {
  factory _$SentimentSummaryCopyWith(_SentimentSummary value, $Res Function(_SentimentSummary) _then) = __$SentimentSummaryCopyWithImpl;
@override @useResult
$Res call({
 Mood mood, double score, int bullish, int bearish, int neutral
});




}
/// @nodoc
class __$SentimentSummaryCopyWithImpl<$Res>
    implements _$SentimentSummaryCopyWith<$Res> {
  __$SentimentSummaryCopyWithImpl(this._self, this._then);

  final _SentimentSummary _self;
  final $Res Function(_SentimentSummary) _then;

/// Create a copy of SentimentSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mood = null,Object? score = null,Object? bullish = null,Object? bearish = null,Object? neutral = null,}) {
  return _then(_SentimentSummary(
mood: null == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as Mood,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,bullish: null == bullish ? _self.bullish : bullish // ignore: cast_nullable_to_non_nullable
as int,bearish: null == bearish ? _self.bearish : bearish // ignore: cast_nullable_to_non_nullable
as int,neutral: null == neutral ? _self.neutral : neutral // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$SectorNews {

 String get name;/// Rupees invested in this sector.
 double get invested; List<NewsArticle> get articles; SentimentSummary? get sentiment;
/// Create a copy of SectorNews
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SectorNewsCopyWith<SectorNews> get copyWith => _$SectorNewsCopyWithImpl<SectorNews>(this as SectorNews, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SectorNews;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SectorNews&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.invested, _this.invested) || other.invested == _this.invested)&&const DeepCollectionEquality().equals(other.articles, _this.articles)&&(identical(other.sentiment, _this.sentiment) || other.sentiment == _this.sentiment));
}


@override
int get hashCode {
  final _this = this as SectorNews;
  return Object.hash(runtimeType,_this.name,_this.invested,const DeepCollectionEquality().hash(_this.articles),_this.sentiment);
}

@override
String toString() {
  final _this = this as SectorNews;
  return 'SectorNews(name: ${_this.name}, invested: ${_this.invested}, articles: ${_this.articles}, sentiment: ${_this.sentiment})';
}


}

/// @nodoc
abstract mixin class $SectorNewsCopyWith<$Res>  {
  factory $SectorNewsCopyWith(SectorNews value, $Res Function(SectorNews) _then) = _$SectorNewsCopyWithImpl;
@useResult
$Res call({
 String name, double invested, List<NewsArticle> articles, SentimentSummary? sentiment
});


$SentimentSummaryCopyWith<$Res>? get sentiment;

}
/// @nodoc
class _$SectorNewsCopyWithImpl<$Res>
    implements $SectorNewsCopyWith<$Res> {
  _$SectorNewsCopyWithImpl(this._self, this._then);

  final SectorNews _self;
  final $Res Function(SectorNews) _then;

/// Create a copy of SectorNews
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? invested = null,Object? articles = null,Object? sentiment = freezed,}) {
  return _then(SectorNews(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,invested: null == invested ? _self.invested : invested // ignore: cast_nullable_to_non_nullable
as double,articles: null == articles ? _self.articles : articles // ignore: cast_nullable_to_non_nullable
as List<NewsArticle>,sentiment: freezed == sentiment ? _self.sentiment : sentiment // ignore: cast_nullable_to_non_nullable
as SentimentSummary?,
  ));
}
/// Create a copy of SectorNews
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SentimentSummaryCopyWith<$Res>? get sentiment {
    if (_self.sentiment == null) {
    return null;
  }

  return $SentimentSummaryCopyWith<$Res>(_self.sentiment!, (value) {
    return _then(_self.copyWith(sentiment: value));
  });
}
}


/// Adds pattern-matching-related methods to [SectorNews].
extension SectorNewsPatterns on SectorNews {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SectorNews value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SectorNews() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SectorNews value)  $default,){
final _that = this;
switch (_that) {
case _SectorNews():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SectorNews value)?  $default,){
final _that = this;
switch (_that) {
case _SectorNews() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  double invested,  List<NewsArticle> articles,  SentimentSummary? sentiment)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SectorNews() when $default != null:
return $default(_that.name,_that.invested,_that.articles,_that.sentiment);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  double invested,  List<NewsArticle> articles,  SentimentSummary? sentiment)  $default,) {final _that = this;
switch (_that) {
case _SectorNews():
return $default(_that.name,_that.invested,_that.articles,_that.sentiment);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  double invested,  List<NewsArticle> articles,  SentimentSummary? sentiment)?  $default,) {final _that = this;
switch (_that) {
case _SectorNews() when $default != null:
return $default(_that.name,_that.invested,_that.articles,_that.sentiment);case _:
  return null;

}
}

}

/// @nodoc


class _SectorNews implements SectorNews {
  const _SectorNews({required this.name, required this.invested, required  List<NewsArticle> articles, this.sentiment}): _articles = articles;
  

@override final  String name;
/// Rupees invested in this sector.
@override final  double invested;
 final  List<NewsArticle> _articles;
@override List<NewsArticle> get articles {
  if (_articles is EqualUnmodifiableListView) return _articles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_articles);
}

@override final  SentimentSummary? sentiment;

/// Create a copy of SectorNews
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SectorNewsCopyWith<_SectorNews> get copyWith => __$SectorNewsCopyWithImpl<_SectorNews>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SectorNews&&(identical(other.name, name) || other.name == name)&&(identical(other.invested, invested) || other.invested == invested)&&const DeepCollectionEquality().equals(other.articles, _articles)&&(identical(other.sentiment, sentiment) || other.sentiment == sentiment));
}


@override
int get hashCode {
    return Object.hash(runtimeType,name,invested,const DeepCollectionEquality().hash(_articles),sentiment);
}

@override
String toString() {
    return 'SectorNews(name: $name, invested: $invested, articles: $articles, sentiment: $sentiment)';
}


}

/// @nodoc
abstract mixin class _$SectorNewsCopyWith<$Res> implements $SectorNewsCopyWith<$Res> {
  factory _$SectorNewsCopyWith(_SectorNews value, $Res Function(_SectorNews) _then) = __$SectorNewsCopyWithImpl;
@override @useResult
$Res call({
 String name, double invested, List<NewsArticle> articles, SentimentSummary? sentiment
});


@override $SentimentSummaryCopyWith<$Res>? get sentiment;

}
/// @nodoc
class __$SectorNewsCopyWithImpl<$Res>
    implements _$SectorNewsCopyWith<$Res> {
  __$SectorNewsCopyWithImpl(this._self, this._then);

  final _SectorNews _self;
  final $Res Function(_SectorNews) _then;

/// Create a copy of SectorNews
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? invested = null,Object? articles = null,Object? sentiment = freezed,}) {
  return _then(_SectorNews(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,invested: null == invested ? _self.invested : invested // ignore: cast_nullable_to_non_nullable
as double,articles: null == articles ? _self._articles : articles // ignore: cast_nullable_to_non_nullable
as List<NewsArticle>,sentiment: freezed == sentiment ? _self.sentiment : sentiment // ignore: cast_nullable_to_non_nullable
as SentimentSummary?,
  ));
}

/// Create a copy of SectorNews
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SentimentSummaryCopyWith<$Res>? get sentiment {
    if (_self.sentiment == null) {
    return null;
  }

  return $SentimentSummaryCopyWith<$Res>(_self.sentiment!, (value) {
    return _then(_self.copyWith(sentiment: value));
  });
}
}

/// @nodoc
mixin _$PortfolioNews {

 NewsPeriod get period; List<SectorNews> get sectors;
/// Create a copy of PortfolioNews
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PortfolioNewsCopyWith<PortfolioNews> get copyWith => _$PortfolioNewsCopyWithImpl<PortfolioNews>(this as PortfolioNews, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PortfolioNews;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PortfolioNews&&(identical(other.period, _this.period) || other.period == _this.period)&&const DeepCollectionEquality().equals(other.sectors, _this.sectors));
}


@override
int get hashCode {
  final _this = this as PortfolioNews;
  return Object.hash(runtimeType,_this.period,const DeepCollectionEquality().hash(_this.sectors));
}

@override
String toString() {
  final _this = this as PortfolioNews;
  return 'PortfolioNews(period: ${_this.period}, sectors: ${_this.sectors})';
}


}

/// @nodoc
abstract mixin class $PortfolioNewsCopyWith<$Res>  {
  factory $PortfolioNewsCopyWith(PortfolioNews value, $Res Function(PortfolioNews) _then) = _$PortfolioNewsCopyWithImpl;
@useResult
$Res call({
 NewsPeriod period, List<SectorNews> sectors
});




}
/// @nodoc
class _$PortfolioNewsCopyWithImpl<$Res>
    implements $PortfolioNewsCopyWith<$Res> {
  _$PortfolioNewsCopyWithImpl(this._self, this._then);

  final PortfolioNews _self;
  final $Res Function(PortfolioNews) _then;

/// Create a copy of PortfolioNews
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? period = null,Object? sectors = null,}) {
  return _then(PortfolioNews(
period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as NewsPeriod,sectors: null == sectors ? _self.sectors : sectors // ignore: cast_nullable_to_non_nullable
as List<SectorNews>,
  ));
}

}


/// Adds pattern-matching-related methods to [PortfolioNews].
extension PortfolioNewsPatterns on PortfolioNews {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PortfolioNews value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PortfolioNews() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PortfolioNews value)  $default,){
final _that = this;
switch (_that) {
case _PortfolioNews():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PortfolioNews value)?  $default,){
final _that = this;
switch (_that) {
case _PortfolioNews() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( NewsPeriod period,  List<SectorNews> sectors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PortfolioNews() when $default != null:
return $default(_that.period,_that.sectors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( NewsPeriod period,  List<SectorNews> sectors)  $default,) {final _that = this;
switch (_that) {
case _PortfolioNews():
return $default(_that.period,_that.sectors);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( NewsPeriod period,  List<SectorNews> sectors)?  $default,) {final _that = this;
switch (_that) {
case _PortfolioNews() when $default != null:
return $default(_that.period,_that.sectors);case _:
  return null;

}
}

}

/// @nodoc


class _PortfolioNews extends PortfolioNews {
  const _PortfolioNews({required this.period, required  List<SectorNews> sectors}): _sectors = sectors,super._();
  

@override final  NewsPeriod period;
 final  List<SectorNews> _sectors;
@override List<SectorNews> get sectors {
  if (_sectors is EqualUnmodifiableListView) return _sectors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sectors);
}


/// Create a copy of PortfolioNews
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PortfolioNewsCopyWith<_PortfolioNews> get copyWith => __$PortfolioNewsCopyWithImpl<_PortfolioNews>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PortfolioNews&&(identical(other.period, period) || other.period == period)&&const DeepCollectionEquality().equals(other.sectors, _sectors));
}


@override
int get hashCode {
    return Object.hash(runtimeType,period,const DeepCollectionEquality().hash(_sectors));
}

@override
String toString() {
    return 'PortfolioNews(period: $period, sectors: $sectors)';
}


}

/// @nodoc
abstract mixin class _$PortfolioNewsCopyWith<$Res> implements $PortfolioNewsCopyWith<$Res> {
  factory _$PortfolioNewsCopyWith(_PortfolioNews value, $Res Function(_PortfolioNews) _then) = __$PortfolioNewsCopyWithImpl;
@override @useResult
$Res call({
 NewsPeriod period, List<SectorNews> sectors
});




}
/// @nodoc
class __$PortfolioNewsCopyWithImpl<$Res>
    implements _$PortfolioNewsCopyWith<$Res> {
  __$PortfolioNewsCopyWithImpl(this._self, this._then);

  final _PortfolioNews _self;
  final $Res Function(_PortfolioNews) _then;

/// Create a copy of PortfolioNews
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? period = null,Object? sectors = null,}) {
  return _then(_PortfolioNews(
period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as NewsPeriod,sectors: null == sectors ? _self._sectors : sectors // ignore: cast_nullable_to_non_nullable
as List<SectorNews>,
  ));
}


}

/// @nodoc
mixin _$NewsSentiment {

 List<SectorNews> get sectors; SentimentSummary get overall;
/// Create a copy of NewsSentiment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewsSentimentCopyWith<NewsSentiment> get copyWith => _$NewsSentimentCopyWithImpl<NewsSentiment>(this as NewsSentiment, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as NewsSentiment;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewsSentiment&&const DeepCollectionEquality().equals(other.sectors, _this.sectors)&&(identical(other.overall, _this.overall) || other.overall == _this.overall));
}


@override
int get hashCode {
  final _this = this as NewsSentiment;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.sectors),_this.overall);
}

@override
String toString() {
  final _this = this as NewsSentiment;
  return 'NewsSentiment(sectors: ${_this.sectors}, overall: ${_this.overall})';
}


}

/// @nodoc
abstract mixin class $NewsSentimentCopyWith<$Res>  {
  factory $NewsSentimentCopyWith(NewsSentiment value, $Res Function(NewsSentiment) _then) = _$NewsSentimentCopyWithImpl;
@useResult
$Res call({
 List<SectorNews> sectors, SentimentSummary overall
});


$SentimentSummaryCopyWith<$Res> get overall;

}
/// @nodoc
class _$NewsSentimentCopyWithImpl<$Res>
    implements $NewsSentimentCopyWith<$Res> {
  _$NewsSentimentCopyWithImpl(this._self, this._then);

  final NewsSentiment _self;
  final $Res Function(NewsSentiment) _then;

/// Create a copy of NewsSentiment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sectors = null,Object? overall = null,}) {
  return _then(NewsSentiment(
sectors: null == sectors ? _self.sectors : sectors // ignore: cast_nullable_to_non_nullable
as List<SectorNews>,overall: null == overall ? _self.overall : overall // ignore: cast_nullable_to_non_nullable
as SentimentSummary,
  ));
}
/// Create a copy of NewsSentiment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SentimentSummaryCopyWith<$Res> get overall {
  
  return $SentimentSummaryCopyWith<$Res>(_self.overall, (value) {
    return _then(_self.copyWith(overall: value));
  });
}
}


/// Adds pattern-matching-related methods to [NewsSentiment].
extension NewsSentimentPatterns on NewsSentiment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NewsSentiment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NewsSentiment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NewsSentiment value)  $default,){
final _that = this;
switch (_that) {
case _NewsSentiment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NewsSentiment value)?  $default,){
final _that = this;
switch (_that) {
case _NewsSentiment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<SectorNews> sectors,  SentimentSummary overall)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NewsSentiment() when $default != null:
return $default(_that.sectors,_that.overall);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<SectorNews> sectors,  SentimentSummary overall)  $default,) {final _that = this;
switch (_that) {
case _NewsSentiment():
return $default(_that.sectors,_that.overall);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<SectorNews> sectors,  SentimentSummary overall)?  $default,) {final _that = this;
switch (_that) {
case _NewsSentiment() when $default != null:
return $default(_that.sectors,_that.overall);case _:
  return null;

}
}

}

/// @nodoc


class _NewsSentiment implements NewsSentiment {
  const _NewsSentiment({required  List<SectorNews> sectors, required this.overall}): _sectors = sectors;
  

 final  List<SectorNews> _sectors;
@override List<SectorNews> get sectors {
  if (_sectors is EqualUnmodifiableListView) return _sectors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sectors);
}

@override final  SentimentSummary overall;

/// Create a copy of NewsSentiment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewsSentimentCopyWith<_NewsSentiment> get copyWith => __$NewsSentimentCopyWithImpl<_NewsSentiment>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewsSentiment&&const DeepCollectionEquality().equals(other.sectors, _sectors)&&(identical(other.overall, overall) || other.overall == overall));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_sectors),overall);
}

@override
String toString() {
    return 'NewsSentiment(sectors: $sectors, overall: $overall)';
}


}

/// @nodoc
abstract mixin class _$NewsSentimentCopyWith<$Res> implements $NewsSentimentCopyWith<$Res> {
  factory _$NewsSentimentCopyWith(_NewsSentiment value, $Res Function(_NewsSentiment) _then) = __$NewsSentimentCopyWithImpl;
@override @useResult
$Res call({
 List<SectorNews> sectors, SentimentSummary overall
});


@override $SentimentSummaryCopyWith<$Res> get overall;

}
/// @nodoc
class __$NewsSentimentCopyWithImpl<$Res>
    implements _$NewsSentimentCopyWith<$Res> {
  __$NewsSentimentCopyWithImpl(this._self, this._then);

  final _NewsSentiment _self;
  final $Res Function(_NewsSentiment) _then;

/// Create a copy of NewsSentiment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sectors = null,Object? overall = null,}) {
  return _then(_NewsSentiment(
sectors: null == sectors ? _self._sectors : sectors // ignore: cast_nullable_to_non_nullable
as List<SectorNews>,overall: null == overall ? _self.overall : overall // ignore: cast_nullable_to_non_nullable
as SentimentSummary,
  ));
}

/// Create a copy of NewsSentiment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SentimentSummaryCopyWith<$Res> get overall {
  
  return $SentimentSummaryCopyWith<$Res>(_self.overall, (value) {
    return _then(_self.copyWith(overall: value));
  });
}
}

/// @nodoc
mixin _$IndexMove {

 String get name; double get changePercent;
/// Create a copy of IndexMove
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IndexMoveCopyWith<IndexMove> get copyWith => _$IndexMoveCopyWithImpl<IndexMove>(this as IndexMove, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as IndexMove;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IndexMove&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.changePercent, _this.changePercent) || other.changePercent == _this.changePercent));
}


@override
int get hashCode {
  final _this = this as IndexMove;
  return Object.hash(runtimeType,_this.name,_this.changePercent);
}

@override
String toString() {
  final _this = this as IndexMove;
  return 'IndexMove(name: ${_this.name}, changePercent: ${_this.changePercent})';
}


}

/// @nodoc
abstract mixin class $IndexMoveCopyWith<$Res>  {
  factory $IndexMoveCopyWith(IndexMove value, $Res Function(IndexMove) _then) = _$IndexMoveCopyWithImpl;
@useResult
$Res call({
 String name, double changePercent
});




}
/// @nodoc
class _$IndexMoveCopyWithImpl<$Res>
    implements $IndexMoveCopyWith<$Res> {
  _$IndexMoveCopyWithImpl(this._self, this._then);

  final IndexMove _self;
  final $Res Function(IndexMove) _then;

/// Create a copy of IndexMove
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? changePercent = null,}) {
  return _then(IndexMove(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,changePercent: null == changePercent ? _self.changePercent : changePercent // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [IndexMove].
extension IndexMovePatterns on IndexMove {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IndexMove value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IndexMove() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IndexMove value)  $default,){
final _that = this;
switch (_that) {
case _IndexMove():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IndexMove value)?  $default,){
final _that = this;
switch (_that) {
case _IndexMove() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  double changePercent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IndexMove() when $default != null:
return $default(_that.name,_that.changePercent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  double changePercent)  $default,) {final _that = this;
switch (_that) {
case _IndexMove():
return $default(_that.name,_that.changePercent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  double changePercent)?  $default,) {final _that = this;
switch (_that) {
case _IndexMove() when $default != null:
return $default(_that.name,_that.changePercent);case _:
  return null;

}
}

}

/// @nodoc


class _IndexMove implements IndexMove {
  const _IndexMove({required this.name, required this.changePercent});
  

@override final  String name;
@override final  double changePercent;

/// Create a copy of IndexMove
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IndexMoveCopyWith<_IndexMove> get copyWith => __$IndexMoveCopyWithImpl<_IndexMove>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _IndexMove&&(identical(other.name, name) || other.name == name)&&(identical(other.changePercent, changePercent) || other.changePercent == changePercent));
}


@override
int get hashCode {
    return Object.hash(runtimeType,name,changePercent);
}

@override
String toString() {
    return 'IndexMove(name: $name, changePercent: $changePercent)';
}


}

/// @nodoc
abstract mixin class _$IndexMoveCopyWith<$Res> implements $IndexMoveCopyWith<$Res> {
  factory _$IndexMoveCopyWith(_IndexMove value, $Res Function(_IndexMove) _then) = __$IndexMoveCopyWithImpl;
@override @useResult
$Res call({
 String name, double changePercent
});




}
/// @nodoc
class __$IndexMoveCopyWithImpl<$Res>
    implements _$IndexMoveCopyWith<$Res> {
  __$IndexMoveCopyWithImpl(this._self, this._then);

  final _IndexMove _self;
  final $Res Function(_IndexMove) _then;

/// Create a copy of IndexMove
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? changePercent = null,}) {
  return _then(_IndexMove(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,changePercent: null == changePercent ? _self.changePercent : changePercent // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$MarketBreadth {

 List<IndexMove> get indices; double? get vix;/// Points, from NSE's daily VIX history: can lag a session.
 double? get vixChange;/// Percent, from the live market watch: today's move.
 double? get vixChangePercent; int? get week52Highs; int? get week52Lows; int? get advances; int? get declines;
/// Create a copy of MarketBreadth
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarketBreadthCopyWith<MarketBreadth> get copyWith => _$MarketBreadthCopyWithImpl<MarketBreadth>(this as MarketBreadth, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MarketBreadth;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarketBreadth&&const DeepCollectionEquality().equals(other.indices, _this.indices)&&(identical(other.vix, _this.vix) || other.vix == _this.vix)&&(identical(other.vixChange, _this.vixChange) || other.vixChange == _this.vixChange)&&(identical(other.vixChangePercent, _this.vixChangePercent) || other.vixChangePercent == _this.vixChangePercent)&&(identical(other.week52Highs, _this.week52Highs) || other.week52Highs == _this.week52Highs)&&(identical(other.week52Lows, _this.week52Lows) || other.week52Lows == _this.week52Lows)&&(identical(other.advances, _this.advances) || other.advances == _this.advances)&&(identical(other.declines, _this.declines) || other.declines == _this.declines));
}


@override
int get hashCode {
  final _this = this as MarketBreadth;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.indices),_this.vix,_this.vixChange,_this.vixChangePercent,_this.week52Highs,_this.week52Lows,_this.advances,_this.declines);
}

@override
String toString() {
  final _this = this as MarketBreadth;
  return 'MarketBreadth(indices: ${_this.indices}, vix: ${_this.vix}, vixChange: ${_this.vixChange}, vixChangePercent: ${_this.vixChangePercent}, week52Highs: ${_this.week52Highs}, week52Lows: ${_this.week52Lows}, advances: ${_this.advances}, declines: ${_this.declines})';
}


}

/// @nodoc
abstract mixin class $MarketBreadthCopyWith<$Res>  {
  factory $MarketBreadthCopyWith(MarketBreadth value, $Res Function(MarketBreadth) _then) = _$MarketBreadthCopyWithImpl;
@useResult
$Res call({
 List<IndexMove> indices, double? vix, double? vixChange, double? vixChangePercent, int? week52Highs, int? week52Lows, int? advances, int? declines
});




}
/// @nodoc
class _$MarketBreadthCopyWithImpl<$Res>
    implements $MarketBreadthCopyWith<$Res> {
  _$MarketBreadthCopyWithImpl(this._self, this._then);

  final MarketBreadth _self;
  final $Res Function(MarketBreadth) _then;

/// Create a copy of MarketBreadth
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? indices = null,Object? vix = freezed,Object? vixChange = freezed,Object? vixChangePercent = freezed,Object? week52Highs = freezed,Object? week52Lows = freezed,Object? advances = freezed,Object? declines = freezed,}) {
  return _then(MarketBreadth(
indices: null == indices ? _self.indices : indices // ignore: cast_nullable_to_non_nullable
as List<IndexMove>,vix: freezed == vix ? _self.vix : vix // ignore: cast_nullable_to_non_nullable
as double?,vixChange: freezed == vixChange ? _self.vixChange : vixChange // ignore: cast_nullable_to_non_nullable
as double?,vixChangePercent: freezed == vixChangePercent ? _self.vixChangePercent : vixChangePercent // ignore: cast_nullable_to_non_nullable
as double?,week52Highs: freezed == week52Highs ? _self.week52Highs : week52Highs // ignore: cast_nullable_to_non_nullable
as int?,week52Lows: freezed == week52Lows ? _self.week52Lows : week52Lows // ignore: cast_nullable_to_non_nullable
as int?,advances: freezed == advances ? _self.advances : advances // ignore: cast_nullable_to_non_nullable
as int?,declines: freezed == declines ? _self.declines : declines // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [MarketBreadth].
extension MarketBreadthPatterns on MarketBreadth {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MarketBreadth value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MarketBreadth() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MarketBreadth value)  $default,){
final _that = this;
switch (_that) {
case _MarketBreadth():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MarketBreadth value)?  $default,){
final _that = this;
switch (_that) {
case _MarketBreadth() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<IndexMove> indices,  double? vix,  double? vixChange,  double? vixChangePercent,  int? week52Highs,  int? week52Lows,  int? advances,  int? declines)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MarketBreadth() when $default != null:
return $default(_that.indices,_that.vix,_that.vixChange,_that.vixChangePercent,_that.week52Highs,_that.week52Lows,_that.advances,_that.declines);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<IndexMove> indices,  double? vix,  double? vixChange,  double? vixChangePercent,  int? week52Highs,  int? week52Lows,  int? advances,  int? declines)  $default,) {final _that = this;
switch (_that) {
case _MarketBreadth():
return $default(_that.indices,_that.vix,_that.vixChange,_that.vixChangePercent,_that.week52Highs,_that.week52Lows,_that.advances,_that.declines);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<IndexMove> indices,  double? vix,  double? vixChange,  double? vixChangePercent,  int? week52Highs,  int? week52Lows,  int? advances,  int? declines)?  $default,) {final _that = this;
switch (_that) {
case _MarketBreadth() when $default != null:
return $default(_that.indices,_that.vix,_that.vixChange,_that.vixChangePercent,_that.week52Highs,_that.week52Lows,_that.advances,_that.declines);case _:
  return null;

}
}

}

/// @nodoc


class _MarketBreadth implements MarketBreadth {
  const _MarketBreadth({required  List<IndexMove> indices, this.vix, this.vixChange, this.vixChangePercent, this.week52Highs, this.week52Lows, this.advances, this.declines}): _indices = indices;
  

 final  List<IndexMove> _indices;
@override List<IndexMove> get indices {
  if (_indices is EqualUnmodifiableListView) return _indices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_indices);
}

@override final  double? vix;
/// Points, from NSE's daily VIX history: can lag a session.
@override final  double? vixChange;
/// Percent, from the live market watch: today's move.
@override final  double? vixChangePercent;
@override final  int? week52Highs;
@override final  int? week52Lows;
@override final  int? advances;
@override final  int? declines;

/// Create a copy of MarketBreadth
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarketBreadthCopyWith<_MarketBreadth> get copyWith => __$MarketBreadthCopyWithImpl<_MarketBreadth>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarketBreadth&&const DeepCollectionEquality().equals(other.indices, _indices)&&(identical(other.vix, vix) || other.vix == vix)&&(identical(other.vixChange, vixChange) || other.vixChange == vixChange)&&(identical(other.vixChangePercent, vixChangePercent) || other.vixChangePercent == vixChangePercent)&&(identical(other.week52Highs, week52Highs) || other.week52Highs == week52Highs)&&(identical(other.week52Lows, week52Lows) || other.week52Lows == week52Lows)&&(identical(other.advances, advances) || other.advances == advances)&&(identical(other.declines, declines) || other.declines == declines));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_indices),vix,vixChange,vixChangePercent,week52Highs,week52Lows,advances,declines);
}

@override
String toString() {
    return 'MarketBreadth(indices: $indices, vix: $vix, vixChange: $vixChange, vixChangePercent: $vixChangePercent, week52Highs: $week52Highs, week52Lows: $week52Lows, advances: $advances, declines: $declines)';
}


}

/// @nodoc
abstract mixin class _$MarketBreadthCopyWith<$Res> implements $MarketBreadthCopyWith<$Res> {
  factory _$MarketBreadthCopyWith(_MarketBreadth value, $Res Function(_MarketBreadth) _then) = __$MarketBreadthCopyWithImpl;
@override @useResult
$Res call({
 List<IndexMove> indices, double? vix, double? vixChange, double? vixChangePercent, int? week52Highs, int? week52Lows, int? advances, int? declines
});




}
/// @nodoc
class __$MarketBreadthCopyWithImpl<$Res>
    implements _$MarketBreadthCopyWith<$Res> {
  __$MarketBreadthCopyWithImpl(this._self, this._then);

  final _MarketBreadth _self;
  final $Res Function(_MarketBreadth) _then;

/// Create a copy of MarketBreadth
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? indices = null,Object? vix = freezed,Object? vixChange = freezed,Object? vixChangePercent = freezed,Object? week52Highs = freezed,Object? week52Lows = freezed,Object? advances = freezed,Object? declines = freezed,}) {
  return _then(_MarketBreadth(
indices: null == indices ? _self._indices : indices // ignore: cast_nullable_to_non_nullable
as List<IndexMove>,vix: freezed == vix ? _self.vix : vix // ignore: cast_nullable_to_non_nullable
as double?,vixChange: freezed == vixChange ? _self.vixChange : vixChange // ignore: cast_nullable_to_non_nullable
as double?,vixChangePercent: freezed == vixChangePercent ? _self.vixChangePercent : vixChangePercent // ignore: cast_nullable_to_non_nullable
as double?,week52Highs: freezed == week52Highs ? _self.week52Highs : week52Highs // ignore: cast_nullable_to_non_nullable
as int?,week52Lows: freezed == week52Lows ? _self.week52Lows : week52Lows // ignore: cast_nullable_to_non_nullable
as int?,advances: freezed == advances ? _self.advances : advances // ignore: cast_nullable_to_non_nullable
as int?,declines: freezed == declines ? _self.declines : declines // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
mixin _$IndexReturns {

 double? get level; double? get week; double? get month; double? get quarter; double? get halfYear; double? get year;
/// Create a copy of IndexReturns
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IndexReturnsCopyWith<IndexReturns> get copyWith => _$IndexReturnsCopyWithImpl<IndexReturns>(this as IndexReturns, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as IndexReturns;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IndexReturns&&(identical(other.level, _this.level) || other.level == _this.level)&&(identical(other.week, _this.week) || other.week == _this.week)&&(identical(other.month, _this.month) || other.month == _this.month)&&(identical(other.quarter, _this.quarter) || other.quarter == _this.quarter)&&(identical(other.halfYear, _this.halfYear) || other.halfYear == _this.halfYear)&&(identical(other.year, _this.year) || other.year == _this.year));
}


@override
int get hashCode {
  final _this = this as IndexReturns;
  return Object.hash(runtimeType,_this.level,_this.week,_this.month,_this.quarter,_this.halfYear,_this.year);
}

@override
String toString() {
  final _this = this as IndexReturns;
  return 'IndexReturns(level: ${_this.level}, week: ${_this.week}, month: ${_this.month}, quarter: ${_this.quarter}, halfYear: ${_this.halfYear}, year: ${_this.year})';
}


}

/// @nodoc
abstract mixin class $IndexReturnsCopyWith<$Res>  {
  factory $IndexReturnsCopyWith(IndexReturns value, $Res Function(IndexReturns) _then) = _$IndexReturnsCopyWithImpl;
@useResult
$Res call({
 double? level, double? week, double? month, double? quarter, double? halfYear, double? year
});




}
/// @nodoc
class _$IndexReturnsCopyWithImpl<$Res>
    implements $IndexReturnsCopyWith<$Res> {
  _$IndexReturnsCopyWithImpl(this._self, this._then);

  final IndexReturns _self;
  final $Res Function(IndexReturns) _then;

/// Create a copy of IndexReturns
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? level = freezed,Object? week = freezed,Object? month = freezed,Object? quarter = freezed,Object? halfYear = freezed,Object? year = freezed,}) {
  return _then(IndexReturns(
level: freezed == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as double?,week: freezed == week ? _self.week : week // ignore: cast_nullable_to_non_nullable
as double?,month: freezed == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as double?,quarter: freezed == quarter ? _self.quarter : quarter // ignore: cast_nullable_to_non_nullable
as double?,halfYear: freezed == halfYear ? _self.halfYear : halfYear // ignore: cast_nullable_to_non_nullable
as double?,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [IndexReturns].
extension IndexReturnsPatterns on IndexReturns {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IndexReturns value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IndexReturns() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IndexReturns value)  $default,){
final _that = this;
switch (_that) {
case _IndexReturns():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IndexReturns value)?  $default,){
final _that = this;
switch (_that) {
case _IndexReturns() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? level,  double? week,  double? month,  double? quarter,  double? halfYear,  double? year)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IndexReturns() when $default != null:
return $default(_that.level,_that.week,_that.month,_that.quarter,_that.halfYear,_that.year);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? level,  double? week,  double? month,  double? quarter,  double? halfYear,  double? year)  $default,) {final _that = this;
switch (_that) {
case _IndexReturns():
return $default(_that.level,_that.week,_that.month,_that.quarter,_that.halfYear,_that.year);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? level,  double? week,  double? month,  double? quarter,  double? halfYear,  double? year)?  $default,) {final _that = this;
switch (_that) {
case _IndexReturns() when $default != null:
return $default(_that.level,_that.week,_that.month,_that.quarter,_that.halfYear,_that.year);case _:
  return null;

}
}

}

/// @nodoc


class _IndexReturns implements IndexReturns {
  const _IndexReturns({this.level, this.week, this.month, this.quarter, this.halfYear, this.year});
  

@override final  double? level;
@override final  double? week;
@override final  double? month;
@override final  double? quarter;
@override final  double? halfYear;
@override final  double? year;

/// Create a copy of IndexReturns
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IndexReturnsCopyWith<_IndexReturns> get copyWith => __$IndexReturnsCopyWithImpl<_IndexReturns>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _IndexReturns&&(identical(other.level, level) || other.level == level)&&(identical(other.week, week) || other.week == week)&&(identical(other.month, month) || other.month == month)&&(identical(other.quarter, quarter) || other.quarter == quarter)&&(identical(other.halfYear, halfYear) || other.halfYear == halfYear)&&(identical(other.year, year) || other.year == year));
}


@override
int get hashCode {
    return Object.hash(runtimeType,level,week,month,quarter,halfYear,year);
}

@override
String toString() {
    return 'IndexReturns(level: $level, week: $week, month: $month, quarter: $quarter, halfYear: $halfYear, year: $year)';
}


}

/// @nodoc
abstract mixin class _$IndexReturnsCopyWith<$Res> implements $IndexReturnsCopyWith<$Res> {
  factory _$IndexReturnsCopyWith(_IndexReturns value, $Res Function(_IndexReturns) _then) = __$IndexReturnsCopyWithImpl;
@override @useResult
$Res call({
 double? level, double? week, double? month, double? quarter, double? halfYear, double? year
});




}
/// @nodoc
class __$IndexReturnsCopyWithImpl<$Res>
    implements _$IndexReturnsCopyWith<$Res> {
  __$IndexReturnsCopyWithImpl(this._self, this._then);

  final _IndexReturns _self;
  final $Res Function(_IndexReturns) _then;

/// Create a copy of IndexReturns
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? level = freezed,Object? week = freezed,Object? month = freezed,Object? quarter = freezed,Object? halfYear = freezed,Object? year = freezed,}) {
  return _then(_IndexReturns(
level: freezed == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as double?,week: freezed == week ? _self.week : week // ignore: cast_nullable_to_non_nullable
as double?,month: freezed == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as double?,quarter: freezed == quarter ? _self.quarter : quarter // ignore: cast_nullable_to_non_nullable
as double?,halfYear: freezed == halfYear ? _self.halfYear : halfYear // ignore: cast_nullable_to_non_nullable
as double?,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

/// @nodoc
mixin _$SectorHolding {

 String get symbol; double get lastPrice; double get pnlPercent;
/// Create a copy of SectorHolding
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SectorHoldingCopyWith<SectorHolding> get copyWith => _$SectorHoldingCopyWithImpl<SectorHolding>(this as SectorHolding, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SectorHolding;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SectorHolding&&(identical(other.symbol, _this.symbol) || other.symbol == _this.symbol)&&(identical(other.lastPrice, _this.lastPrice) || other.lastPrice == _this.lastPrice)&&(identical(other.pnlPercent, _this.pnlPercent) || other.pnlPercent == _this.pnlPercent));
}


@override
int get hashCode {
  final _this = this as SectorHolding;
  return Object.hash(runtimeType,_this.symbol,_this.lastPrice,_this.pnlPercent);
}

@override
String toString() {
  final _this = this as SectorHolding;
  return 'SectorHolding(symbol: ${_this.symbol}, lastPrice: ${_this.lastPrice}, pnlPercent: ${_this.pnlPercent})';
}


}

/// @nodoc
abstract mixin class $SectorHoldingCopyWith<$Res>  {
  factory $SectorHoldingCopyWith(SectorHolding value, $Res Function(SectorHolding) _then) = _$SectorHoldingCopyWithImpl;
@useResult
$Res call({
 String symbol, double lastPrice, double pnlPercent
});




}
/// @nodoc
class _$SectorHoldingCopyWithImpl<$Res>
    implements $SectorHoldingCopyWith<$Res> {
  _$SectorHoldingCopyWithImpl(this._self, this._then);

  final SectorHolding _self;
  final $Res Function(SectorHolding) _then;

/// Create a copy of SectorHolding
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? lastPrice = null,Object? pnlPercent = null,}) {
  return _then(SectorHolding(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,lastPrice: null == lastPrice ? _self.lastPrice : lastPrice // ignore: cast_nullable_to_non_nullable
as double,pnlPercent: null == pnlPercent ? _self.pnlPercent : pnlPercent // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SectorHolding].
extension SectorHoldingPatterns on SectorHolding {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SectorHolding value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SectorHolding() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SectorHolding value)  $default,){
final _that = this;
switch (_that) {
case _SectorHolding():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SectorHolding value)?  $default,){
final _that = this;
switch (_that) {
case _SectorHolding() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  double lastPrice,  double pnlPercent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SectorHolding() when $default != null:
return $default(_that.symbol,_that.lastPrice,_that.pnlPercent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  double lastPrice,  double pnlPercent)  $default,) {final _that = this;
switch (_that) {
case _SectorHolding():
return $default(_that.symbol,_that.lastPrice,_that.pnlPercent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  double lastPrice,  double pnlPercent)?  $default,) {final _that = this;
switch (_that) {
case _SectorHolding() when $default != null:
return $default(_that.symbol,_that.lastPrice,_that.pnlPercent);case _:
  return null;

}
}

}

/// @nodoc


class _SectorHolding implements SectorHolding {
  const _SectorHolding({required this.symbol, required this.lastPrice, required this.pnlPercent});
  

@override final  String symbol;
@override final  double lastPrice;
@override final  double pnlPercent;

/// Create a copy of SectorHolding
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SectorHoldingCopyWith<_SectorHolding> get copyWith => __$SectorHoldingCopyWithImpl<_SectorHolding>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SectorHolding&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.lastPrice, lastPrice) || other.lastPrice == lastPrice)&&(identical(other.pnlPercent, pnlPercent) || other.pnlPercent == pnlPercent));
}


@override
int get hashCode {
    return Object.hash(runtimeType,symbol,lastPrice,pnlPercent);
}

@override
String toString() {
    return 'SectorHolding(symbol: $symbol, lastPrice: $lastPrice, pnlPercent: $pnlPercent)';
}


}

/// @nodoc
abstract mixin class _$SectorHoldingCopyWith<$Res> implements $SectorHoldingCopyWith<$Res> {
  factory _$SectorHoldingCopyWith(_SectorHolding value, $Res Function(_SectorHolding) _then) = __$SectorHoldingCopyWithImpl;
@override @useResult
$Res call({
 String symbol, double lastPrice, double pnlPercent
});




}
/// @nodoc
class __$SectorHoldingCopyWithImpl<$Res>
    implements _$SectorHoldingCopyWith<$Res> {
  __$SectorHoldingCopyWithImpl(this._self, this._then);

  final _SectorHolding _self;
  final $Res Function(_SectorHolding) _then;

/// Create a copy of SectorHolding
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? lastPrice = null,Object? pnlPercent = null,}) {
  return _then(_SectorHolding(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,lastPrice: null == lastPrice ? _self.lastPrice : lastPrice // ignore: cast_nullable_to_non_nullable
as double,pnlPercent: null == pnlPercent ? _self.pnlPercent : pnlPercent // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$SectorExposure {

 String get name;/// Percent of the portfolio's current value.
 double get weight; double get invested; int get holdingsCount;/// The largest few holdings in the sector.
 List<SectorHolding> get holdings;/// What moves this sector, in a sentence.
 String get driver; String? get indexName; IndexReturns? get indexReturns;
/// Create a copy of SectorExposure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SectorExposureCopyWith<SectorExposure> get copyWith => _$SectorExposureCopyWithImpl<SectorExposure>(this as SectorExposure, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SectorExposure;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SectorExposure&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.weight, _this.weight) || other.weight == _this.weight)&&(identical(other.invested, _this.invested) || other.invested == _this.invested)&&(identical(other.holdingsCount, _this.holdingsCount) || other.holdingsCount == _this.holdingsCount)&&const DeepCollectionEquality().equals(other.holdings, _this.holdings)&&(identical(other.driver, _this.driver) || other.driver == _this.driver)&&(identical(other.indexName, _this.indexName) || other.indexName == _this.indexName)&&(identical(other.indexReturns, _this.indexReturns) || other.indexReturns == _this.indexReturns));
}


@override
int get hashCode {
  final _this = this as SectorExposure;
  return Object.hash(runtimeType,_this.name,_this.weight,_this.invested,_this.holdingsCount,const DeepCollectionEquality().hash(_this.holdings),_this.driver,_this.indexName,_this.indexReturns);
}

@override
String toString() {
  final _this = this as SectorExposure;
  return 'SectorExposure(name: ${_this.name}, weight: ${_this.weight}, invested: ${_this.invested}, holdingsCount: ${_this.holdingsCount}, holdings: ${_this.holdings}, driver: ${_this.driver}, indexName: ${_this.indexName}, indexReturns: ${_this.indexReturns})';
}


}

/// @nodoc
abstract mixin class $SectorExposureCopyWith<$Res>  {
  factory $SectorExposureCopyWith(SectorExposure value, $Res Function(SectorExposure) _then) = _$SectorExposureCopyWithImpl;
@useResult
$Res call({
 String name, double weight, double invested, int holdingsCount, List<SectorHolding> holdings, String driver, String? indexName, IndexReturns? indexReturns
});


$IndexReturnsCopyWith<$Res>? get indexReturns;

}
/// @nodoc
class _$SectorExposureCopyWithImpl<$Res>
    implements $SectorExposureCopyWith<$Res> {
  _$SectorExposureCopyWithImpl(this._self, this._then);

  final SectorExposure _self;
  final $Res Function(SectorExposure) _then;

/// Create a copy of SectorExposure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? weight = null,Object? invested = null,Object? holdingsCount = null,Object? holdings = null,Object? driver = null,Object? indexName = freezed,Object? indexReturns = freezed,}) {
  return _then(SectorExposure(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,invested: null == invested ? _self.invested : invested // ignore: cast_nullable_to_non_nullable
as double,holdingsCount: null == holdingsCount ? _self.holdingsCount : holdingsCount // ignore: cast_nullable_to_non_nullable
as int,holdings: null == holdings ? _self.holdings : holdings // ignore: cast_nullable_to_non_nullable
as List<SectorHolding>,driver: null == driver ? _self.driver : driver // ignore: cast_nullable_to_non_nullable
as String,indexName: freezed == indexName ? _self.indexName : indexName // ignore: cast_nullable_to_non_nullable
as String?,indexReturns: freezed == indexReturns ? _self.indexReturns : indexReturns // ignore: cast_nullable_to_non_nullable
as IndexReturns?,
  ));
}
/// Create a copy of SectorExposure
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IndexReturnsCopyWith<$Res>? get indexReturns {
    if (_self.indexReturns == null) {
    return null;
  }

  return $IndexReturnsCopyWith<$Res>(_self.indexReturns!, (value) {
    return _then(_self.copyWith(indexReturns: value));
  });
}
}


/// Adds pattern-matching-related methods to [SectorExposure].
extension SectorExposurePatterns on SectorExposure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SectorExposure value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SectorExposure() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SectorExposure value)  $default,){
final _that = this;
switch (_that) {
case _SectorExposure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SectorExposure value)?  $default,){
final _that = this;
switch (_that) {
case _SectorExposure() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  double weight,  double invested,  int holdingsCount,  List<SectorHolding> holdings,  String driver,  String? indexName,  IndexReturns? indexReturns)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SectorExposure() when $default != null:
return $default(_that.name,_that.weight,_that.invested,_that.holdingsCount,_that.holdings,_that.driver,_that.indexName,_that.indexReturns);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  double weight,  double invested,  int holdingsCount,  List<SectorHolding> holdings,  String driver,  String? indexName,  IndexReturns? indexReturns)  $default,) {final _that = this;
switch (_that) {
case _SectorExposure():
return $default(_that.name,_that.weight,_that.invested,_that.holdingsCount,_that.holdings,_that.driver,_that.indexName,_that.indexReturns);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  double weight,  double invested,  int holdingsCount,  List<SectorHolding> holdings,  String driver,  String? indexName,  IndexReturns? indexReturns)?  $default,) {final _that = this;
switch (_that) {
case _SectorExposure() when $default != null:
return $default(_that.name,_that.weight,_that.invested,_that.holdingsCount,_that.holdings,_that.driver,_that.indexName,_that.indexReturns);case _:
  return null;

}
}

}

/// @nodoc


class _SectorExposure implements SectorExposure {
  const _SectorExposure({required this.name, required this.weight, required this.invested, required this.holdingsCount, required  List<SectorHolding> holdings, required this.driver, this.indexName, this.indexReturns}): _holdings = holdings;
  

@override final  String name;
/// Percent of the portfolio's current value.
@override final  double weight;
@override final  double invested;
@override final  int holdingsCount;
/// The largest few holdings in the sector.
 final  List<SectorHolding> _holdings;
/// The largest few holdings in the sector.
@override List<SectorHolding> get holdings {
  if (_holdings is EqualUnmodifiableListView) return _holdings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_holdings);
}

/// What moves this sector, in a sentence.
@override final  String driver;
@override final  String? indexName;
@override final  IndexReturns? indexReturns;

/// Create a copy of SectorExposure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SectorExposureCopyWith<_SectorExposure> get copyWith => __$SectorExposureCopyWithImpl<_SectorExposure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SectorExposure&&(identical(other.name, name) || other.name == name)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.invested, invested) || other.invested == invested)&&(identical(other.holdingsCount, holdingsCount) || other.holdingsCount == holdingsCount)&&const DeepCollectionEquality().equals(other.holdings, _holdings)&&(identical(other.driver, driver) || other.driver == driver)&&(identical(other.indexName, indexName) || other.indexName == indexName)&&(identical(other.indexReturns, indexReturns) || other.indexReturns == indexReturns));
}


@override
int get hashCode {
    return Object.hash(runtimeType,name,weight,invested,holdingsCount,const DeepCollectionEquality().hash(_holdings),driver,indexName,indexReturns);
}

@override
String toString() {
    return 'SectorExposure(name: $name, weight: $weight, invested: $invested, holdingsCount: $holdingsCount, holdings: $holdings, driver: $driver, indexName: $indexName, indexReturns: $indexReturns)';
}


}

/// @nodoc
abstract mixin class _$SectorExposureCopyWith<$Res> implements $SectorExposureCopyWith<$Res> {
  factory _$SectorExposureCopyWith(_SectorExposure value, $Res Function(_SectorExposure) _then) = __$SectorExposureCopyWithImpl;
@override @useResult
$Res call({
 String name, double weight, double invested, int holdingsCount, List<SectorHolding> holdings, String driver, String? indexName, IndexReturns? indexReturns
});


@override $IndexReturnsCopyWith<$Res>? get indexReturns;

}
/// @nodoc
class __$SectorExposureCopyWithImpl<$Res>
    implements _$SectorExposureCopyWith<$Res> {
  __$SectorExposureCopyWithImpl(this._self, this._then);

  final _SectorExposure _self;
  final $Res Function(_SectorExposure) _then;

/// Create a copy of SectorExposure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? weight = null,Object? invested = null,Object? holdingsCount = null,Object? holdings = null,Object? driver = null,Object? indexName = freezed,Object? indexReturns = freezed,}) {
  return _then(_SectorExposure(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,invested: null == invested ? _self.invested : invested // ignore: cast_nullable_to_non_nullable
as double,holdingsCount: null == holdingsCount ? _self.holdingsCount : holdingsCount // ignore: cast_nullable_to_non_nullable
as int,holdings: null == holdings ? _self._holdings : holdings // ignore: cast_nullable_to_non_nullable
as List<SectorHolding>,driver: null == driver ? _self.driver : driver // ignore: cast_nullable_to_non_nullable
as String,indexName: freezed == indexName ? _self.indexName : indexName // ignore: cast_nullable_to_non_nullable
as String?,indexReturns: freezed == indexReturns ? _self.indexReturns : indexReturns // ignore: cast_nullable_to_non_nullable
as IndexReturns?,
  ));
}

/// Create a copy of SectorExposure
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IndexReturnsCopyWith<$Res>? get indexReturns {
    if (_self.indexReturns == null) {
    return null;
  }

  return $IndexReturnsCopyWith<$Res>(_self.indexReturns!, (value) {
    return _then(_self.copyWith(indexReturns: value));
  });
}
}

// dart format on
