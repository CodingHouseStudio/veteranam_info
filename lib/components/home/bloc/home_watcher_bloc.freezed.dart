// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_watcher_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HomeWatcherEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(List<QuestionModel> questionModelItems) updated,
    required TResult Function() failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(List<QuestionModel> questionModelItems)? updated,
    TResult? Function()? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(List<QuestionModel> questionModelItems)? updated,
    TResult Function()? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Updated value) updated,
    required TResult Function(_Failure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Updated value)? updated,
    TResult? Function(_Failure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Updated value)? updated,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeWatcherEventCopyWith<$Res> {
  factory $HomeWatcherEventCopyWith(
          HomeWatcherEvent value, $Res Function(HomeWatcherEvent) then) =
      _$HomeWatcherEventCopyWithImpl<$Res, HomeWatcherEvent>;
}

/// @nodoc
class _$HomeWatcherEventCopyWithImpl<$Res, $Val extends HomeWatcherEvent>
    implements $HomeWatcherEventCopyWith<$Res> {
  _$HomeWatcherEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$StartedImplCopyWith<$Res> {
  factory _$$StartedImplCopyWith(
          _$StartedImpl value, $Res Function(_$StartedImpl) then) =
      __$$StartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StartedImplCopyWithImpl<$Res>
    extends _$HomeWatcherEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(
      _$StartedImpl _value, $Res Function(_$StartedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$StartedImpl implements _Started {
  const _$StartedImpl();

  @override
  String toString() {
    return 'HomeWatcherEvent.started()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(List<QuestionModel> questionModelItems) updated,
    required TResult Function() failure,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(List<QuestionModel> questionModelItems)? updated,
    TResult? Function()? failure,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(List<QuestionModel> questionModelItems)? updated,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Updated value) updated,
    required TResult Function(_Failure value) failure,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Updated value)? updated,
    TResult? Function(_Failure value)? failure,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Updated value)? updated,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements HomeWatcherEvent {
  const factory _Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$UpdatedImplCopyWith<$Res> {
  factory _$$UpdatedImplCopyWith(
          _$UpdatedImpl value, $Res Function(_$UpdatedImpl) then) =
      __$$UpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<QuestionModel> questionModelItems});
}

/// @nodoc
class __$$UpdatedImplCopyWithImpl<$Res>
    extends _$HomeWatcherEventCopyWithImpl<$Res, _$UpdatedImpl>
    implements _$$UpdatedImplCopyWith<$Res> {
  __$$UpdatedImplCopyWithImpl(
      _$UpdatedImpl _value, $Res Function(_$UpdatedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionModelItems = null,
  }) {
    return _then(_$UpdatedImpl(
      questionModelItems: null == questionModelItems
          ? _value._questionModelItems
          : questionModelItems // ignore: cast_nullable_to_non_nullable
              as List<QuestionModel>,
    ));
  }
}

/// @nodoc

class _$UpdatedImpl implements _Updated {
  const _$UpdatedImpl({required final List<QuestionModel> questionModelItems})
      : _questionModelItems = questionModelItems;

  final List<QuestionModel> _questionModelItems;
  @override
  List<QuestionModel> get questionModelItems {
    if (_questionModelItems is EqualUnmodifiableListView)
      return _questionModelItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questionModelItems);
  }

  @override
  String toString() {
    return 'HomeWatcherEvent.updated(questionModelItems: $questionModelItems)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatedImpl &&
            const DeepCollectionEquality()
                .equals(other._questionModelItems, _questionModelItems));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_questionModelItems));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatedImplCopyWith<_$UpdatedImpl> get copyWith =>
      __$$UpdatedImplCopyWithImpl<_$UpdatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(List<QuestionModel> questionModelItems) updated,
    required TResult Function() failure,
  }) {
    return updated(questionModelItems);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(List<QuestionModel> questionModelItems)? updated,
    TResult? Function()? failure,
  }) {
    return updated?.call(questionModelItems);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(List<QuestionModel> questionModelItems)? updated,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(questionModelItems);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Updated value) updated,
    required TResult Function(_Failure value) failure,
  }) {
    return updated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Updated value)? updated,
    TResult? Function(_Failure value)? failure,
  }) {
    return updated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Updated value)? updated,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(this);
    }
    return orElse();
  }
}

abstract class _Updated implements HomeWatcherEvent {
  const factory _Updated(
      {required final List<QuestionModel> questionModelItems}) = _$UpdatedImpl;

  List<QuestionModel> get questionModelItems;
  @JsonKey(ignore: true)
  _$$UpdatedImplCopyWith<_$UpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailureImplCopyWith<$Res> {
  factory _$$FailureImplCopyWith(
          _$FailureImpl value, $Res Function(_$FailureImpl) then) =
      __$$FailureImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FailureImplCopyWithImpl<$Res>
    extends _$HomeWatcherEventCopyWithImpl<$Res, _$FailureImpl>
    implements _$$FailureImplCopyWith<$Res> {
  __$$FailureImplCopyWithImpl(
      _$FailureImpl _value, $Res Function(_$FailureImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$FailureImpl implements _Failure {
  const _$FailureImpl();

  @override
  String toString() {
    return 'HomeWatcherEvent.failure()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FailureImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(List<QuestionModel> questionModelItems) updated,
    required TResult Function() failure,
  }) {
    return failure();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(List<QuestionModel> questionModelItems)? updated,
    TResult? Function()? failure,
  }) {
    return failure?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(List<QuestionModel> questionModelItems)? updated,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Updated value) updated,
    required TResult Function(_Failure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Updated value)? updated,
    TResult? Function(_Failure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Updated value)? updated,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _Failure implements HomeWatcherEvent {
  const factory _Failure() = _$FailureImpl;
}

/// @nodoc
mixin _$HomeWatcherState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<QuestionModel> questionModelItems) success,
    required TResult Function() failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<QuestionModel> questionModelItems)? success,
    TResult? Function()? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<QuestionModel> questionModelItems)? success,
    TResult Function()? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HomeWatcherStateInitial value) initial,
    required TResult Function(HomeWatcherStateLoading value) loading,
    required TResult Function(HomeWatcherStateSuccess value) success,
    required TResult Function(HomeWatcherStateFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HomeWatcherStateInitial value)? initial,
    TResult? Function(HomeWatcherStateLoading value)? loading,
    TResult? Function(HomeWatcherStateSuccess value)? success,
    TResult? Function(HomeWatcherStateFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HomeWatcherStateInitial value)? initial,
    TResult Function(HomeWatcherStateLoading value)? loading,
    TResult Function(HomeWatcherStateSuccess value)? success,
    TResult Function(HomeWatcherStateFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeWatcherStateCopyWith<$Res> {
  factory $HomeWatcherStateCopyWith(
          HomeWatcherState value, $Res Function(HomeWatcherState) then) =
      _$HomeWatcherStateCopyWithImpl<$Res, HomeWatcherState>;
}

/// @nodoc
class _$HomeWatcherStateCopyWithImpl<$Res, $Val extends HomeWatcherState>
    implements $HomeWatcherStateCopyWith<$Res> {
  _$HomeWatcherStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$HomeWatcherStateInitialImplCopyWith<$Res> {
  factory _$$HomeWatcherStateInitialImplCopyWith(
          _$HomeWatcherStateInitialImpl value,
          $Res Function(_$HomeWatcherStateInitialImpl) then) =
      __$$HomeWatcherStateInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$HomeWatcherStateInitialImplCopyWithImpl<$Res>
    extends _$HomeWatcherStateCopyWithImpl<$Res, _$HomeWatcherStateInitialImpl>
    implements _$$HomeWatcherStateInitialImplCopyWith<$Res> {
  __$$HomeWatcherStateInitialImplCopyWithImpl(
      _$HomeWatcherStateInitialImpl _value,
      $Res Function(_$HomeWatcherStateInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$HomeWatcherStateInitialImpl implements HomeWatcherStateInitial {
  const _$HomeWatcherStateInitialImpl();

  @override
  String toString() {
    return 'HomeWatcherState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeWatcherStateInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<QuestionModel> questionModelItems) success,
    required TResult Function() failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<QuestionModel> questionModelItems)? success,
    TResult? Function()? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<QuestionModel> questionModelItems)? success,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HomeWatcherStateInitial value) initial,
    required TResult Function(HomeWatcherStateLoading value) loading,
    required TResult Function(HomeWatcherStateSuccess value) success,
    required TResult Function(HomeWatcherStateFailure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HomeWatcherStateInitial value)? initial,
    TResult? Function(HomeWatcherStateLoading value)? loading,
    TResult? Function(HomeWatcherStateSuccess value)? success,
    TResult? Function(HomeWatcherStateFailure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HomeWatcherStateInitial value)? initial,
    TResult Function(HomeWatcherStateLoading value)? loading,
    TResult Function(HomeWatcherStateSuccess value)? success,
    TResult Function(HomeWatcherStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class HomeWatcherStateInitial implements HomeWatcherState {
  const factory HomeWatcherStateInitial() = _$HomeWatcherStateInitialImpl;
}

/// @nodoc
abstract class _$$HomeWatcherStateLoadingImplCopyWith<$Res> {
  factory _$$HomeWatcherStateLoadingImplCopyWith(
          _$HomeWatcherStateLoadingImpl value,
          $Res Function(_$HomeWatcherStateLoadingImpl) then) =
      __$$HomeWatcherStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$HomeWatcherStateLoadingImplCopyWithImpl<$Res>
    extends _$HomeWatcherStateCopyWithImpl<$Res, _$HomeWatcherStateLoadingImpl>
    implements _$$HomeWatcherStateLoadingImplCopyWith<$Res> {
  __$$HomeWatcherStateLoadingImplCopyWithImpl(
      _$HomeWatcherStateLoadingImpl _value,
      $Res Function(_$HomeWatcherStateLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$HomeWatcherStateLoadingImpl implements HomeWatcherStateLoading {
  const _$HomeWatcherStateLoadingImpl();

  @override
  String toString() {
    return 'HomeWatcherState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeWatcherStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<QuestionModel> questionModelItems) success,
    required TResult Function() failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<QuestionModel> questionModelItems)? success,
    TResult? Function()? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<QuestionModel> questionModelItems)? success,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HomeWatcherStateInitial value) initial,
    required TResult Function(HomeWatcherStateLoading value) loading,
    required TResult Function(HomeWatcherStateSuccess value) success,
    required TResult Function(HomeWatcherStateFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HomeWatcherStateInitial value)? initial,
    TResult? Function(HomeWatcherStateLoading value)? loading,
    TResult? Function(HomeWatcherStateSuccess value)? success,
    TResult? Function(HomeWatcherStateFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HomeWatcherStateInitial value)? initial,
    TResult Function(HomeWatcherStateLoading value)? loading,
    TResult Function(HomeWatcherStateSuccess value)? success,
    TResult Function(HomeWatcherStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class HomeWatcherStateLoading implements HomeWatcherState {
  const factory HomeWatcherStateLoading() = _$HomeWatcherStateLoadingImpl;
}

/// @nodoc
abstract class _$$HomeWatcherStateSuccessImplCopyWith<$Res> {
  factory _$$HomeWatcherStateSuccessImplCopyWith(
          _$HomeWatcherStateSuccessImpl value,
          $Res Function(_$HomeWatcherStateSuccessImpl) then) =
      __$$HomeWatcherStateSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<QuestionModel> questionModelItems});
}

/// @nodoc
class __$$HomeWatcherStateSuccessImplCopyWithImpl<$Res>
    extends _$HomeWatcherStateCopyWithImpl<$Res, _$HomeWatcherStateSuccessImpl>
    implements _$$HomeWatcherStateSuccessImplCopyWith<$Res> {
  __$$HomeWatcherStateSuccessImplCopyWithImpl(
      _$HomeWatcherStateSuccessImpl _value,
      $Res Function(_$HomeWatcherStateSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionModelItems = null,
  }) {
    return _then(_$HomeWatcherStateSuccessImpl(
      questionModelItems: null == questionModelItems
          ? _value._questionModelItems
          : questionModelItems // ignore: cast_nullable_to_non_nullable
              as List<QuestionModel>,
    ));
  }
}

/// @nodoc

class _$HomeWatcherStateSuccessImpl implements HomeWatcherStateSuccess {
  const _$HomeWatcherStateSuccessImpl(
      {required final List<QuestionModel> questionModelItems})
      : _questionModelItems = questionModelItems;

  final List<QuestionModel> _questionModelItems;
  @override
  List<QuestionModel> get questionModelItems {
    if (_questionModelItems is EqualUnmodifiableListView)
      return _questionModelItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questionModelItems);
  }

  @override
  String toString() {
    return 'HomeWatcherState.success(questionModelItems: $questionModelItems)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeWatcherStateSuccessImpl &&
            const DeepCollectionEquality()
                .equals(other._questionModelItems, _questionModelItems));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_questionModelItems));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeWatcherStateSuccessImplCopyWith<_$HomeWatcherStateSuccessImpl>
      get copyWith => __$$HomeWatcherStateSuccessImplCopyWithImpl<
          _$HomeWatcherStateSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<QuestionModel> questionModelItems) success,
    required TResult Function() failure,
  }) {
    return success(questionModelItems);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<QuestionModel> questionModelItems)? success,
    TResult? Function()? failure,
  }) {
    return success?.call(questionModelItems);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<QuestionModel> questionModelItems)? success,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(questionModelItems);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HomeWatcherStateInitial value) initial,
    required TResult Function(HomeWatcherStateLoading value) loading,
    required TResult Function(HomeWatcherStateSuccess value) success,
    required TResult Function(HomeWatcherStateFailure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HomeWatcherStateInitial value)? initial,
    TResult? Function(HomeWatcherStateLoading value)? loading,
    TResult? Function(HomeWatcherStateSuccess value)? success,
    TResult? Function(HomeWatcherStateFailure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HomeWatcherStateInitial value)? initial,
    TResult Function(HomeWatcherStateLoading value)? loading,
    TResult Function(HomeWatcherStateSuccess value)? success,
    TResult Function(HomeWatcherStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class HomeWatcherStateSuccess implements HomeWatcherState {
  const factory HomeWatcherStateSuccess(
          {required final List<QuestionModel> questionModelItems}) =
      _$HomeWatcherStateSuccessImpl;

  List<QuestionModel> get questionModelItems;
  @JsonKey(ignore: true)
  _$$HomeWatcherStateSuccessImplCopyWith<_$HomeWatcherStateSuccessImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HomeWatcherStateFailureImplCopyWith<$Res> {
  factory _$$HomeWatcherStateFailureImplCopyWith(
          _$HomeWatcherStateFailureImpl value,
          $Res Function(_$HomeWatcherStateFailureImpl) then) =
      __$$HomeWatcherStateFailureImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$HomeWatcherStateFailureImplCopyWithImpl<$Res>
    extends _$HomeWatcherStateCopyWithImpl<$Res, _$HomeWatcherStateFailureImpl>
    implements _$$HomeWatcherStateFailureImplCopyWith<$Res> {
  __$$HomeWatcherStateFailureImplCopyWithImpl(
      _$HomeWatcherStateFailureImpl _value,
      $Res Function(_$HomeWatcherStateFailureImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$HomeWatcherStateFailureImpl implements HomeWatcherStateFailure {
  const _$HomeWatcherStateFailureImpl();

  @override
  String toString() {
    return 'HomeWatcherState.failure()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeWatcherStateFailureImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<QuestionModel> questionModelItems) success,
    required TResult Function() failure,
  }) {
    return failure();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<QuestionModel> questionModelItems)? success,
    TResult? Function()? failure,
  }) {
    return failure?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<QuestionModel> questionModelItems)? success,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HomeWatcherStateInitial value) initial,
    required TResult Function(HomeWatcherStateLoading value) loading,
    required TResult Function(HomeWatcherStateSuccess value) success,
    required TResult Function(HomeWatcherStateFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HomeWatcherStateInitial value)? initial,
    TResult? Function(HomeWatcherStateLoading value)? loading,
    TResult? Function(HomeWatcherStateSuccess value)? success,
    TResult? Function(HomeWatcherStateFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HomeWatcherStateInitial value)? initial,
    TResult Function(HomeWatcherStateLoading value)? loading,
    TResult Function(HomeWatcherStateSuccess value)? success,
    TResult Function(HomeWatcherStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class HomeWatcherStateFailure implements HomeWatcherState {
  const factory HomeWatcherStateFailure() = _$HomeWatcherStateFailureImpl;
}
