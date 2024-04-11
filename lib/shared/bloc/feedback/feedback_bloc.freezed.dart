// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feedback_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FeedbackEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) nameUpdated,
    required TResult Function(String email) emailUpdated,
    required TResult Function(String message) messageUpdated,
    required TResult Function() save,
    required TResult Function() clear,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? nameUpdated,
    TResult? Function(String email)? emailUpdated,
    TResult? Function(String message)? messageUpdated,
    TResult? Function()? save,
    TResult? Function()? clear,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? nameUpdated,
    TResult Function(String email)? emailUpdated,
    TResult Function(String message)? messageUpdated,
    TResult Function()? save,
    TResult Function()? clear,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NameUpdated value) nameUpdated,
    required TResult Function(_EmailUpdated value) emailUpdated,
    required TResult Function(_MessageUpdated value) messageUpdated,
    required TResult Function(_Save value) save,
    required TResult Function(_Clear value) clear,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NameUpdated value)? nameUpdated,
    TResult? Function(_EmailUpdated value)? emailUpdated,
    TResult? Function(_MessageUpdated value)? messageUpdated,
    TResult? Function(_Save value)? save,
    TResult? Function(_Clear value)? clear,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NameUpdated value)? nameUpdated,
    TResult Function(_EmailUpdated value)? emailUpdated,
    TResult Function(_MessageUpdated value)? messageUpdated,
    TResult Function(_Save value)? save,
    TResult Function(_Clear value)? clear,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedbackEventCopyWith<$Res> {
  factory $FeedbackEventCopyWith(
          FeedbackEvent value, $Res Function(FeedbackEvent) then) =
      _$FeedbackEventCopyWithImpl<$Res, FeedbackEvent>;
}

/// @nodoc
class _$FeedbackEventCopyWithImpl<$Res, $Val extends FeedbackEvent>
    implements $FeedbackEventCopyWith<$Res> {
  _$FeedbackEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$NameUpdatedImplCopyWith<$Res> {
  factory _$$NameUpdatedImplCopyWith(
          _$NameUpdatedImpl value, $Res Function(_$NameUpdatedImpl) then) =
      __$$NameUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$NameUpdatedImplCopyWithImpl<$Res>
    extends _$FeedbackEventCopyWithImpl<$Res, _$NameUpdatedImpl>
    implements _$$NameUpdatedImplCopyWith<$Res> {
  __$$NameUpdatedImplCopyWithImpl(
      _$NameUpdatedImpl _value, $Res Function(_$NameUpdatedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$NameUpdatedImpl(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$NameUpdatedImpl implements _NameUpdated {
  const _$NameUpdatedImpl(this.name);

  @override
  final String name;

  @override
  String toString() {
    return 'FeedbackEvent.nameUpdated(name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NameUpdatedImpl &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NameUpdatedImplCopyWith<_$NameUpdatedImpl> get copyWith =>
      __$$NameUpdatedImplCopyWithImpl<_$NameUpdatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) nameUpdated,
    required TResult Function(String email) emailUpdated,
    required TResult Function(String message) messageUpdated,
    required TResult Function() save,
    required TResult Function() clear,
  }) {
    return nameUpdated(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? nameUpdated,
    TResult? Function(String email)? emailUpdated,
    TResult? Function(String message)? messageUpdated,
    TResult? Function()? save,
    TResult? Function()? clear,
  }) {
    return nameUpdated?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? nameUpdated,
    TResult Function(String email)? emailUpdated,
    TResult Function(String message)? messageUpdated,
    TResult Function()? save,
    TResult Function()? clear,
    required TResult orElse(),
  }) {
    if (nameUpdated != null) {
      return nameUpdated(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NameUpdated value) nameUpdated,
    required TResult Function(_EmailUpdated value) emailUpdated,
    required TResult Function(_MessageUpdated value) messageUpdated,
    required TResult Function(_Save value) save,
    required TResult Function(_Clear value) clear,
  }) {
    return nameUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NameUpdated value)? nameUpdated,
    TResult? Function(_EmailUpdated value)? emailUpdated,
    TResult? Function(_MessageUpdated value)? messageUpdated,
    TResult? Function(_Save value)? save,
    TResult? Function(_Clear value)? clear,
  }) {
    return nameUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NameUpdated value)? nameUpdated,
    TResult Function(_EmailUpdated value)? emailUpdated,
    TResult Function(_MessageUpdated value)? messageUpdated,
    TResult Function(_Save value)? save,
    TResult Function(_Clear value)? clear,
    required TResult orElse(),
  }) {
    if (nameUpdated != null) {
      return nameUpdated(this);
    }
    return orElse();
  }
}

abstract class _NameUpdated implements FeedbackEvent {
  const factory _NameUpdated(final String name) = _$NameUpdatedImpl;

  String get name;
  @JsonKey(ignore: true)
  _$$NameUpdatedImplCopyWith<_$NameUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EmailUpdatedImplCopyWith<$Res> {
  factory _$$EmailUpdatedImplCopyWith(
          _$EmailUpdatedImpl value, $Res Function(_$EmailUpdatedImpl) then) =
      __$$EmailUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$EmailUpdatedImplCopyWithImpl<$Res>
    extends _$FeedbackEventCopyWithImpl<$Res, _$EmailUpdatedImpl>
    implements _$$EmailUpdatedImplCopyWith<$Res> {
  __$$EmailUpdatedImplCopyWithImpl(
      _$EmailUpdatedImpl _value, $Res Function(_$EmailUpdatedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_$EmailUpdatedImpl(
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$EmailUpdatedImpl implements _EmailUpdated {
  const _$EmailUpdatedImpl(this.email);

  @override
  final String email;

  @override
  String toString() {
    return 'FeedbackEvent.emailUpdated(email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailUpdatedImpl &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailUpdatedImplCopyWith<_$EmailUpdatedImpl> get copyWith =>
      __$$EmailUpdatedImplCopyWithImpl<_$EmailUpdatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) nameUpdated,
    required TResult Function(String email) emailUpdated,
    required TResult Function(String message) messageUpdated,
    required TResult Function() save,
    required TResult Function() clear,
  }) {
    return emailUpdated(email);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? nameUpdated,
    TResult? Function(String email)? emailUpdated,
    TResult? Function(String message)? messageUpdated,
    TResult? Function()? save,
    TResult? Function()? clear,
  }) {
    return emailUpdated?.call(email);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? nameUpdated,
    TResult Function(String email)? emailUpdated,
    TResult Function(String message)? messageUpdated,
    TResult Function()? save,
    TResult Function()? clear,
    required TResult orElse(),
  }) {
    if (emailUpdated != null) {
      return emailUpdated(email);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NameUpdated value) nameUpdated,
    required TResult Function(_EmailUpdated value) emailUpdated,
    required TResult Function(_MessageUpdated value) messageUpdated,
    required TResult Function(_Save value) save,
    required TResult Function(_Clear value) clear,
  }) {
    return emailUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NameUpdated value)? nameUpdated,
    TResult? Function(_EmailUpdated value)? emailUpdated,
    TResult? Function(_MessageUpdated value)? messageUpdated,
    TResult? Function(_Save value)? save,
    TResult? Function(_Clear value)? clear,
  }) {
    return emailUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NameUpdated value)? nameUpdated,
    TResult Function(_EmailUpdated value)? emailUpdated,
    TResult Function(_MessageUpdated value)? messageUpdated,
    TResult Function(_Save value)? save,
    TResult Function(_Clear value)? clear,
    required TResult orElse(),
  }) {
    if (emailUpdated != null) {
      return emailUpdated(this);
    }
    return orElse();
  }
}

abstract class _EmailUpdated implements FeedbackEvent {
  const factory _EmailUpdated(final String email) = _$EmailUpdatedImpl;

  String get email;
  @JsonKey(ignore: true)
  _$$EmailUpdatedImplCopyWith<_$EmailUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MessageUpdatedImplCopyWith<$Res> {
  factory _$$MessageUpdatedImplCopyWith(_$MessageUpdatedImpl value,
          $Res Function(_$MessageUpdatedImpl) then) =
      __$$MessageUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$MessageUpdatedImplCopyWithImpl<$Res>
    extends _$FeedbackEventCopyWithImpl<$Res, _$MessageUpdatedImpl>
    implements _$$MessageUpdatedImplCopyWith<$Res> {
  __$$MessageUpdatedImplCopyWithImpl(
      _$MessageUpdatedImpl _value, $Res Function(_$MessageUpdatedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$MessageUpdatedImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MessageUpdatedImpl implements _MessageUpdated {
  const _$MessageUpdatedImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'FeedbackEvent.messageUpdated(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageUpdatedImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageUpdatedImplCopyWith<_$MessageUpdatedImpl> get copyWith =>
      __$$MessageUpdatedImplCopyWithImpl<_$MessageUpdatedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) nameUpdated,
    required TResult Function(String email) emailUpdated,
    required TResult Function(String message) messageUpdated,
    required TResult Function() save,
    required TResult Function() clear,
  }) {
    return messageUpdated(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? nameUpdated,
    TResult? Function(String email)? emailUpdated,
    TResult? Function(String message)? messageUpdated,
    TResult? Function()? save,
    TResult? Function()? clear,
  }) {
    return messageUpdated?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? nameUpdated,
    TResult Function(String email)? emailUpdated,
    TResult Function(String message)? messageUpdated,
    TResult Function()? save,
    TResult Function()? clear,
    required TResult orElse(),
  }) {
    if (messageUpdated != null) {
      return messageUpdated(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NameUpdated value) nameUpdated,
    required TResult Function(_EmailUpdated value) emailUpdated,
    required TResult Function(_MessageUpdated value) messageUpdated,
    required TResult Function(_Save value) save,
    required TResult Function(_Clear value) clear,
  }) {
    return messageUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NameUpdated value)? nameUpdated,
    TResult? Function(_EmailUpdated value)? emailUpdated,
    TResult? Function(_MessageUpdated value)? messageUpdated,
    TResult? Function(_Save value)? save,
    TResult? Function(_Clear value)? clear,
  }) {
    return messageUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NameUpdated value)? nameUpdated,
    TResult Function(_EmailUpdated value)? emailUpdated,
    TResult Function(_MessageUpdated value)? messageUpdated,
    TResult Function(_Save value)? save,
    TResult Function(_Clear value)? clear,
    required TResult orElse(),
  }) {
    if (messageUpdated != null) {
      return messageUpdated(this);
    }
    return orElse();
  }
}

abstract class _MessageUpdated implements FeedbackEvent {
  const factory _MessageUpdated(final String message) = _$MessageUpdatedImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$MessageUpdatedImplCopyWith<_$MessageUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SaveImplCopyWith<$Res> {
  factory _$$SaveImplCopyWith(
          _$SaveImpl value, $Res Function(_$SaveImpl) then) =
      __$$SaveImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SaveImplCopyWithImpl<$Res>
    extends _$FeedbackEventCopyWithImpl<$Res, _$SaveImpl>
    implements _$$SaveImplCopyWith<$Res> {
  __$$SaveImplCopyWithImpl(_$SaveImpl _value, $Res Function(_$SaveImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SaveImpl implements _Save {
  const _$SaveImpl();

  @override
  String toString() {
    return 'FeedbackEvent.save()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SaveImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) nameUpdated,
    required TResult Function(String email) emailUpdated,
    required TResult Function(String message) messageUpdated,
    required TResult Function() save,
    required TResult Function() clear,
  }) {
    return save();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? nameUpdated,
    TResult? Function(String email)? emailUpdated,
    TResult? Function(String message)? messageUpdated,
    TResult? Function()? save,
    TResult? Function()? clear,
  }) {
    return save?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? nameUpdated,
    TResult Function(String email)? emailUpdated,
    TResult Function(String message)? messageUpdated,
    TResult Function()? save,
    TResult Function()? clear,
    required TResult orElse(),
  }) {
    if (save != null) {
      return save();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NameUpdated value) nameUpdated,
    required TResult Function(_EmailUpdated value) emailUpdated,
    required TResult Function(_MessageUpdated value) messageUpdated,
    required TResult Function(_Save value) save,
    required TResult Function(_Clear value) clear,
  }) {
    return save(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NameUpdated value)? nameUpdated,
    TResult? Function(_EmailUpdated value)? emailUpdated,
    TResult? Function(_MessageUpdated value)? messageUpdated,
    TResult? Function(_Save value)? save,
    TResult? Function(_Clear value)? clear,
  }) {
    return save?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NameUpdated value)? nameUpdated,
    TResult Function(_EmailUpdated value)? emailUpdated,
    TResult Function(_MessageUpdated value)? messageUpdated,
    TResult Function(_Save value)? save,
    TResult Function(_Clear value)? clear,
    required TResult orElse(),
  }) {
    if (save != null) {
      return save(this);
    }
    return orElse();
  }
}

abstract class _Save implements FeedbackEvent {
  const factory _Save() = _$SaveImpl;
}

/// @nodoc
abstract class _$$ClearImplCopyWith<$Res> {
  factory _$$ClearImplCopyWith(
          _$ClearImpl value, $Res Function(_$ClearImpl) then) =
      __$$ClearImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearImplCopyWithImpl<$Res>
    extends _$FeedbackEventCopyWithImpl<$Res, _$ClearImpl>
    implements _$$ClearImplCopyWith<$Res> {
  __$$ClearImplCopyWithImpl(
      _$ClearImpl _value, $Res Function(_$ClearImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ClearImpl implements _Clear {
  const _$ClearImpl();

  @override
  String toString() {
    return 'FeedbackEvent.clear()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) nameUpdated,
    required TResult Function(String email) emailUpdated,
    required TResult Function(String message) messageUpdated,
    required TResult Function() save,
    required TResult Function() clear,
  }) {
    return clear();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? nameUpdated,
    TResult? Function(String email)? emailUpdated,
    TResult? Function(String message)? messageUpdated,
    TResult? Function()? save,
    TResult? Function()? clear,
  }) {
    return clear?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? nameUpdated,
    TResult Function(String email)? emailUpdated,
    TResult Function(String message)? messageUpdated,
    TResult Function()? save,
    TResult Function()? clear,
    required TResult orElse(),
  }) {
    if (clear != null) {
      return clear();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NameUpdated value) nameUpdated,
    required TResult Function(_EmailUpdated value) emailUpdated,
    required TResult Function(_MessageUpdated value) messageUpdated,
    required TResult Function(_Save value) save,
    required TResult Function(_Clear value) clear,
  }) {
    return clear(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NameUpdated value)? nameUpdated,
    TResult? Function(_EmailUpdated value)? emailUpdated,
    TResult? Function(_MessageUpdated value)? messageUpdated,
    TResult? Function(_Save value)? save,
    TResult? Function(_Clear value)? clear,
  }) {
    return clear?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NameUpdated value)? nameUpdated,
    TResult Function(_EmailUpdated value)? emailUpdated,
    TResult Function(_MessageUpdated value)? messageUpdated,
    TResult Function(_Save value)? save,
    TResult Function(_Clear value)? clear,
    required TResult orElse(),
  }) {
    if (clear != null) {
      return clear(this);
    }
    return orElse();
  }
}

abstract class _Clear implements FeedbackEvent {
  const factory _Clear() = _$ClearImpl;
}

/// @nodoc
mixin _$FeedbackState {
  NameFieldModel get name => throw _privateConstructorUsedError;
  EmailFieldModel get email => throw _privateConstructorUsedError;
  MessageFieldModel get message => throw _privateConstructorUsedError;
  FeedbackEnum get fieldsState => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FeedbackStateCopyWith<FeedbackState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedbackStateCopyWith<$Res> {
  factory $FeedbackStateCopyWith(
          FeedbackState value, $Res Function(FeedbackState) then) =
      _$FeedbackStateCopyWithImpl<$Res, FeedbackState>;
  @useResult
  $Res call(
      {NameFieldModel name,
      EmailFieldModel email,
      MessageFieldModel message,
      FeedbackEnum fieldsState});
}

/// @nodoc
class _$FeedbackStateCopyWithImpl<$Res, $Val extends FeedbackState>
    implements $FeedbackStateCopyWith<$Res> {
  _$FeedbackStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? message = null,
    Object? fieldsState = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as NameFieldModel,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as EmailFieldModel,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as MessageFieldModel,
      fieldsState: null == fieldsState
          ? _value.fieldsState
          : fieldsState // ignore: cast_nullable_to_non_nullable
              as FeedbackEnum,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FeedbackStateImplCopyWith<$Res>
    implements $FeedbackStateCopyWith<$Res> {
  factory _$$FeedbackStateImplCopyWith(
          _$FeedbackStateImpl value, $Res Function(_$FeedbackStateImpl) then) =
      __$$FeedbackStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {NameFieldModel name,
      EmailFieldModel email,
      MessageFieldModel message,
      FeedbackEnum fieldsState});
}

/// @nodoc
class __$$FeedbackStateImplCopyWithImpl<$Res>
    extends _$FeedbackStateCopyWithImpl<$Res, _$FeedbackStateImpl>
    implements _$$FeedbackStateImplCopyWith<$Res> {
  __$$FeedbackStateImplCopyWithImpl(
      _$FeedbackStateImpl _value, $Res Function(_$FeedbackStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? message = null,
    Object? fieldsState = null,
  }) {
    return _then(_$FeedbackStateImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as NameFieldModel,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as EmailFieldModel,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as MessageFieldModel,
      fieldsState: null == fieldsState
          ? _value.fieldsState
          : fieldsState // ignore: cast_nullable_to_non_nullable
              as FeedbackEnum,
    ));
  }
}

/// @nodoc

class _$FeedbackStateImpl implements _FeedbackState {
  const _$FeedbackStateImpl(
      {required this.name,
      required this.email,
      required this.message,
      required this.fieldsState});

  @override
  final NameFieldModel name;
  @override
  final EmailFieldModel email;
  @override
  final MessageFieldModel message;
  @override
  final FeedbackEnum fieldsState;

  @override
  String toString() {
    return 'FeedbackState(name: $name, email: $email, message: $message, fieldsState: $fieldsState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedbackStateImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.fieldsState, fieldsState) ||
                other.fieldsState == fieldsState));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, name, email, message, fieldsState);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedbackStateImplCopyWith<_$FeedbackStateImpl> get copyWith =>
      __$$FeedbackStateImplCopyWithImpl<_$FeedbackStateImpl>(this, _$identity);
}

abstract class _FeedbackState implements FeedbackState {
  const factory _FeedbackState(
      {required final NameFieldModel name,
      required final EmailFieldModel email,
      required final MessageFieldModel message,
      required final FeedbackEnum fieldsState}) = _$FeedbackStateImpl;

  @override
  NameFieldModel get name;
  @override
  EmailFieldModel get email;
  @override
  MessageFieldModel get message;
  @override
  FeedbackEnum get fieldsState;
  @override
  @JsonKey(ignore: true)
  _$$FeedbackStateImplCopyWith<_$FeedbackStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
