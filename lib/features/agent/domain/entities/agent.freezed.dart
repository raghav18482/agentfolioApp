// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatThread {

 int get id; AgentType get agentType; String get title; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of ChatThread
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatThreadCopyWith<ChatThread> get copyWith => _$ChatThreadCopyWithImpl<ChatThread>(this as ChatThread, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ChatThread;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatThread&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.agentType, _this.agentType) || other.agentType == _this.agentType)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}


@override
int get hashCode {
  final _this = this as ChatThread;
  return Object.hash(runtimeType,_this.id,_this.agentType,_this.title,_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as ChatThread;
  return 'ChatThread(id: ${_this.id}, agentType: ${_this.agentType}, title: ${_this.title}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $ChatThreadCopyWith<$Res>  {
  factory $ChatThreadCopyWith(ChatThread value, $Res Function(ChatThread) _then) = _$ChatThreadCopyWithImpl;
@useResult
$Res call({
 int id, AgentType agentType, String title, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$ChatThreadCopyWithImpl<$Res>
    implements $ChatThreadCopyWith<$Res> {
  _$ChatThreadCopyWithImpl(this._self, this._then);

  final ChatThread _self;
  final $Res Function(ChatThread) _then;

/// Create a copy of ChatThread
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? agentType = null,Object? title = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(ChatThread(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,agentType: null == agentType ? _self.agentType : agentType // ignore: cast_nullable_to_non_nullable
as AgentType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatThread].
extension ChatThreadPatterns on ChatThread {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatThread value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatThread() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatThread value)  $default,){
final _that = this;
switch (_that) {
case _ChatThread():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatThread value)?  $default,){
final _that = this;
switch (_that) {
case _ChatThread() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  AgentType agentType,  String title,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatThread() when $default != null:
return $default(_that.id,_that.agentType,_that.title,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  AgentType agentType,  String title,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ChatThread():
return $default(_that.id,_that.agentType,_that.title,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  AgentType agentType,  String title,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ChatThread() when $default != null:
return $default(_that.id,_that.agentType,_that.title,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _ChatThread implements ChatThread {
  const _ChatThread({required this.id, required this.agentType, required this.title, this.createdAt, this.updatedAt});
  

@override final  int id;
@override final  AgentType agentType;
@override final  String title;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of ChatThread
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatThreadCopyWith<_ChatThread> get copyWith => __$ChatThreadCopyWithImpl<_ChatThread>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatThread&&(identical(other.id, id) || other.id == id)&&(identical(other.agentType, agentType) || other.agentType == agentType)&&(identical(other.title, title) || other.title == title)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,agentType,title,createdAt,updatedAt);
}

@override
String toString() {
    return 'ChatThread(id: $id, agentType: $agentType, title: $title, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ChatThreadCopyWith<$Res> implements $ChatThreadCopyWith<$Res> {
  factory _$ChatThreadCopyWith(_ChatThread value, $Res Function(_ChatThread) _then) = __$ChatThreadCopyWithImpl;
@override @useResult
$Res call({
 int id, AgentType agentType, String title, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$ChatThreadCopyWithImpl<$Res>
    implements _$ChatThreadCopyWith<$Res> {
  __$ChatThreadCopyWithImpl(this._self, this._then);

  final _ChatThread _self;
  final $Res Function(_ChatThread) _then;

/// Create a copy of ChatThread
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? agentType = null,Object? title = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_ChatThread(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,agentType: null == agentType ? _self.agentType : agentType // ignore: cast_nullable_to_non_nullable
as AgentType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$ThreadList {

/// False when the server keeps no history for this user.
 bool get premium; List<ChatThread> get threads;
/// Create a copy of ThreadList
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ThreadListCopyWith<ThreadList> get copyWith => _$ThreadListCopyWithImpl<ThreadList>(this as ThreadList, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ThreadList;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ThreadList&&(identical(other.premium, _this.premium) || other.premium == _this.premium)&&const DeepCollectionEquality().equals(other.threads, _this.threads));
}


@override
int get hashCode {
  final _this = this as ThreadList;
  return Object.hash(runtimeType,_this.premium,const DeepCollectionEquality().hash(_this.threads));
}

@override
String toString() {
  final _this = this as ThreadList;
  return 'ThreadList(premium: ${_this.premium}, threads: ${_this.threads})';
}


}

/// @nodoc
abstract mixin class $ThreadListCopyWith<$Res>  {
  factory $ThreadListCopyWith(ThreadList value, $Res Function(ThreadList) _then) = _$ThreadListCopyWithImpl;
@useResult
$Res call({
 bool premium, List<ChatThread> threads
});




}
/// @nodoc
class _$ThreadListCopyWithImpl<$Res>
    implements $ThreadListCopyWith<$Res> {
  _$ThreadListCopyWithImpl(this._self, this._then);

  final ThreadList _self;
  final $Res Function(ThreadList) _then;

/// Create a copy of ThreadList
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? premium = null,Object? threads = null,}) {
  return _then(ThreadList(
premium: null == premium ? _self.premium : premium // ignore: cast_nullable_to_non_nullable
as bool,threads: null == threads ? _self.threads : threads // ignore: cast_nullable_to_non_nullable
as List<ChatThread>,
  ));
}

}


/// Adds pattern-matching-related methods to [ThreadList].
extension ThreadListPatterns on ThreadList {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ThreadList value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ThreadList() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ThreadList value)  $default,){
final _that = this;
switch (_that) {
case _ThreadList():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ThreadList value)?  $default,){
final _that = this;
switch (_that) {
case _ThreadList() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool premium,  List<ChatThread> threads)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ThreadList() when $default != null:
return $default(_that.premium,_that.threads);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool premium,  List<ChatThread> threads)  $default,) {final _that = this;
switch (_that) {
case _ThreadList():
return $default(_that.premium,_that.threads);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool premium,  List<ChatThread> threads)?  $default,) {final _that = this;
switch (_that) {
case _ThreadList() when $default != null:
return $default(_that.premium,_that.threads);case _:
  return null;

}
}

}

/// @nodoc


class _ThreadList implements ThreadList {
  const _ThreadList({required this.premium, required  List<ChatThread> threads}): _threads = threads;
  

/// False when the server keeps no history for this user.
@override final  bool premium;
 final  List<ChatThread> _threads;
@override List<ChatThread> get threads {
  if (_threads is EqualUnmodifiableListView) return _threads;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_threads);
}


/// Create a copy of ThreadList
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ThreadListCopyWith<_ThreadList> get copyWith => __$ThreadListCopyWithImpl<_ThreadList>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ThreadList&&(identical(other.premium, premium) || other.premium == premium)&&const DeepCollectionEquality().equals(other.threads, _threads));
}


@override
int get hashCode {
    return Object.hash(runtimeType,premium,const DeepCollectionEquality().hash(_threads));
}

@override
String toString() {
    return 'ThreadList(premium: $premium, threads: $threads)';
}


}

/// @nodoc
abstract mixin class _$ThreadListCopyWith<$Res> implements $ThreadListCopyWith<$Res> {
  factory _$ThreadListCopyWith(_ThreadList value, $Res Function(_ThreadList) _then) = __$ThreadListCopyWithImpl;
@override @useResult
$Res call({
 bool premium, List<ChatThread> threads
});




}
/// @nodoc
class __$ThreadListCopyWithImpl<$Res>
    implements _$ThreadListCopyWith<$Res> {
  __$ThreadListCopyWithImpl(this._self, this._then);

  final _ThreadList _self;
  final $Res Function(_ThreadList) _then;

/// Create a copy of ThreadList
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? premium = null,Object? threads = null,}) {
  return _then(_ThreadList(
premium: null == premium ? _self.premium : premium // ignore: cast_nullable_to_non_nullable
as bool,threads: null == threads ? _self._threads : threads // ignore: cast_nullable_to_non_nullable
as List<ChatThread>,
  ));
}


}

/// @nodoc
mixin _$ChatMessage {

/// Local only: stable across rebuilds, for keys and retries.
 String get id; ChatRole get role; String get text; Delivery get delivery;/// Why a send failed, in the server's words.
 String? get failure;/// The server's account of an APPROVE / REJECT it carried out.
 String? get approvalResult;
/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMessageCopyWith<ChatMessage> get copyWith => _$ChatMessageCopyWithImpl<ChatMessage>(this as ChatMessage, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ChatMessage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMessage&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.role, _this.role) || other.role == _this.role)&&(identical(other.text, _this.text) || other.text == _this.text)&&(identical(other.delivery, _this.delivery) || other.delivery == _this.delivery)&&(identical(other.failure, _this.failure) || other.failure == _this.failure)&&(identical(other.approvalResult, _this.approvalResult) || other.approvalResult == _this.approvalResult));
}


@override
int get hashCode {
  final _this = this as ChatMessage;
  return Object.hash(runtimeType,_this.id,_this.role,_this.text,_this.delivery,_this.failure,_this.approvalResult);
}

@override
String toString() {
  final _this = this as ChatMessage;
  return 'ChatMessage(id: ${_this.id}, role: ${_this.role}, text: ${_this.text}, delivery: ${_this.delivery}, failure: ${_this.failure}, approvalResult: ${_this.approvalResult})';
}


}

/// @nodoc
abstract mixin class $ChatMessageCopyWith<$Res>  {
  factory $ChatMessageCopyWith(ChatMessage value, $Res Function(ChatMessage) _then) = _$ChatMessageCopyWithImpl;
@useResult
$Res call({
 String id, ChatRole role, String text, Delivery delivery, String? failure, String? approvalResult
});




}
/// @nodoc
class _$ChatMessageCopyWithImpl<$Res>
    implements $ChatMessageCopyWith<$Res> {
  _$ChatMessageCopyWithImpl(this._self, this._then);

  final ChatMessage _self;
  final $Res Function(ChatMessage) _then;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? role = null,Object? text = null,Object? delivery = null,Object? failure = freezed,Object? approvalResult = freezed,}) {
  return _then(ChatMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as ChatRole,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,delivery: null == delivery ? _self.delivery : delivery // ignore: cast_nullable_to_non_nullable
as Delivery,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as String?,approvalResult: freezed == approvalResult ? _self.approvalResult : approvalResult // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatMessage].
extension ChatMessagePatterns on ChatMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatMessage value)  $default,){
final _that = this;
switch (_that) {
case _ChatMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatMessage value)?  $default,){
final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  ChatRole role,  String text,  Delivery delivery,  String? failure,  String? approvalResult)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
return $default(_that.id,_that.role,_that.text,_that.delivery,_that.failure,_that.approvalResult);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  ChatRole role,  String text,  Delivery delivery,  String? failure,  String? approvalResult)  $default,) {final _that = this;
switch (_that) {
case _ChatMessage():
return $default(_that.id,_that.role,_that.text,_that.delivery,_that.failure,_that.approvalResult);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  ChatRole role,  String text,  Delivery delivery,  String? failure,  String? approvalResult)?  $default,) {final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
return $default(_that.id,_that.role,_that.text,_that.delivery,_that.failure,_that.approvalResult);case _:
  return null;

}
}

}

/// @nodoc


class _ChatMessage implements ChatMessage {
  const _ChatMessage({required this.id, required this.role, required this.text, this.delivery = Delivery.delivered, this.failure, this.approvalResult});
  

/// Local only: stable across rebuilds, for keys and retries.
@override final  String id;
@override final  ChatRole role;
@override final  String text;
@override@JsonKey() final  Delivery delivery;
/// Why a send failed, in the server's words.
@override final  String? failure;
/// The server's account of an APPROVE / REJECT it carried out.
@override final  String? approvalResult;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatMessageCopyWith<_ChatMessage> get copyWith => __$ChatMessageCopyWithImpl<_ChatMessage>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.role, role) || other.role == role)&&(identical(other.text, text) || other.text == text)&&(identical(other.delivery, delivery) || other.delivery == delivery)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.approvalResult, approvalResult) || other.approvalResult == approvalResult));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,role,text,delivery,failure,approvalResult);
}

@override
String toString() {
    return 'ChatMessage(id: $id, role: $role, text: $text, delivery: $delivery, failure: $failure, approvalResult: $approvalResult)';
}


}

/// @nodoc
abstract mixin class _$ChatMessageCopyWith<$Res> implements $ChatMessageCopyWith<$Res> {
  factory _$ChatMessageCopyWith(_ChatMessage value, $Res Function(_ChatMessage) _then) = __$ChatMessageCopyWithImpl;
@override @useResult
$Res call({
 String id, ChatRole role, String text, Delivery delivery, String? failure, String? approvalResult
});




}
/// @nodoc
class __$ChatMessageCopyWithImpl<$Res>
    implements _$ChatMessageCopyWith<$Res> {
  __$ChatMessageCopyWithImpl(this._self, this._then);

  final _ChatMessage _self;
  final $Res Function(_ChatMessage) _then;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? role = null,Object? text = null,Object? delivery = null,Object? failure = freezed,Object? approvalResult = freezed,}) {
  return _then(_ChatMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as ChatRole,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,delivery: null == delivery ? _self.delivery : delivery // ignore: cast_nullable_to_non_nullable
as Delivery,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as String?,approvalResult: freezed == approvalResult ? _self.approvalResult : approvalResult // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$ChatReply {

 String get reply; String? get approvalResult; int? get threadId;
/// Create a copy of ChatReply
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatReplyCopyWith<ChatReply> get copyWith => _$ChatReplyCopyWithImpl<ChatReply>(this as ChatReply, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ChatReply;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatReply&&(identical(other.reply, _this.reply) || other.reply == _this.reply)&&(identical(other.approvalResult, _this.approvalResult) || other.approvalResult == _this.approvalResult)&&(identical(other.threadId, _this.threadId) || other.threadId == _this.threadId));
}


@override
int get hashCode {
  final _this = this as ChatReply;
  return Object.hash(runtimeType,_this.reply,_this.approvalResult,_this.threadId);
}

@override
String toString() {
  final _this = this as ChatReply;
  return 'ChatReply(reply: ${_this.reply}, approvalResult: ${_this.approvalResult}, threadId: ${_this.threadId})';
}


}

/// @nodoc
abstract mixin class $ChatReplyCopyWith<$Res>  {
  factory $ChatReplyCopyWith(ChatReply value, $Res Function(ChatReply) _then) = _$ChatReplyCopyWithImpl;
@useResult
$Res call({
 String reply, String? approvalResult, int? threadId
});




}
/// @nodoc
class _$ChatReplyCopyWithImpl<$Res>
    implements $ChatReplyCopyWith<$Res> {
  _$ChatReplyCopyWithImpl(this._self, this._then);

  final ChatReply _self;
  final $Res Function(ChatReply) _then;

/// Create a copy of ChatReply
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reply = null,Object? approvalResult = freezed,Object? threadId = freezed,}) {
  return _then(ChatReply(
reply: null == reply ? _self.reply : reply // ignore: cast_nullable_to_non_nullable
as String,approvalResult: freezed == approvalResult ? _self.approvalResult : approvalResult // ignore: cast_nullable_to_non_nullable
as String?,threadId: freezed == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatReply].
extension ChatReplyPatterns on ChatReply {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatReply value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatReply() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatReply value)  $default,){
final _that = this;
switch (_that) {
case _ChatReply():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatReply value)?  $default,){
final _that = this;
switch (_that) {
case _ChatReply() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String reply,  String? approvalResult,  int? threadId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatReply() when $default != null:
return $default(_that.reply,_that.approvalResult,_that.threadId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String reply,  String? approvalResult,  int? threadId)  $default,) {final _that = this;
switch (_that) {
case _ChatReply():
return $default(_that.reply,_that.approvalResult,_that.threadId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String reply,  String? approvalResult,  int? threadId)?  $default,) {final _that = this;
switch (_that) {
case _ChatReply() when $default != null:
return $default(_that.reply,_that.approvalResult,_that.threadId);case _:
  return null;

}
}

}

/// @nodoc


class _ChatReply implements ChatReply {
  const _ChatReply({required this.reply, this.approvalResult, this.threadId});
  

@override final  String reply;
@override final  String? approvalResult;
@override final  int? threadId;

/// Create a copy of ChatReply
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatReplyCopyWith<_ChatReply> get copyWith => __$ChatReplyCopyWithImpl<_ChatReply>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatReply&&(identical(other.reply, reply) || other.reply == reply)&&(identical(other.approvalResult, approvalResult) || other.approvalResult == approvalResult)&&(identical(other.threadId, threadId) || other.threadId == threadId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,reply,approvalResult,threadId);
}

@override
String toString() {
    return 'ChatReply(reply: $reply, approvalResult: $approvalResult, threadId: $threadId)';
}


}

/// @nodoc
abstract mixin class _$ChatReplyCopyWith<$Res> implements $ChatReplyCopyWith<$Res> {
  factory _$ChatReplyCopyWith(_ChatReply value, $Res Function(_ChatReply) _then) = __$ChatReplyCopyWithImpl;
@override @useResult
$Res call({
 String reply, String? approvalResult, int? threadId
});




}
/// @nodoc
class __$ChatReplyCopyWithImpl<$Res>
    implements _$ChatReplyCopyWith<$Res> {
  __$ChatReplyCopyWithImpl(this._self, this._then);

  final _ChatReply _self;
  final $Res Function(_ChatReply) _then;

/// Create a copy of ChatReply
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reply = null,Object? approvalResult = freezed,Object? threadId = freezed,}) {
  return _then(_ChatReply(
reply: null == reply ? _self.reply : reply // ignore: cast_nullable_to_non_nullable
as String,approvalResult: freezed == approvalResult ? _self.approvalResult : approvalResult // ignore: cast_nullable_to_non_nullable
as String?,threadId: freezed == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
