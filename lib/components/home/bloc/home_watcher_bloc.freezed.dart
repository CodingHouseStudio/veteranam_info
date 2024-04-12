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
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
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
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
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
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
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
mixin _$HomeWatcherState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<QuestionModel> questionModelItems) success,
    required TResult Function(HomeFailure failure) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<QuestionModel> questionModelItems)? success,
    TResult? Function(HomeFailure failure)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<QuestionModel> questionModelItems)? success,
    TResult Function(HomeFailure failure)? failure,
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
    required TResult Function(HomeFailure failure) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<QuestionModel> questionModelItems)? success,
    TResult? Function(HomeFailure failure)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<QuestionModel> questionModelItems)? success,
    TResult Function(HomeFailure failure)? failure,
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
    required TResult Function(HomeFailure failure) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<QuestionModel> questionModelItems)? success,
    TResult? Function(HomeFailure failure)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<QuestionModel> questionModelItems)? success,
    TResult Function(HomeFailure failure)? failure,
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
    required TResult Function(HomeFailure failure) failure,
  }) {
    return success(questionModelItems);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<QuestionModel> questionModelItems)? success,
    TResult? Function(HomeFailure failure)? failure,
  }) {
    return success?.call(questionModelItems);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<QuestionModel> questionModelItems)? success,
    TResult Function(HomeFailure failure)? failure,
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
  @useResult
  $Res call({HomeFailure failure});
}

/// @nodoc
class __$$HomeWatcherStateFailureImplCopyWithImpl<$Res>
    extends _$HomeWatcherStateCopyWithImpl<$Res, _$HomeWatcherStateFailureImpl>
    implements _$$HomeWatcherStateFailureImplCopyWith<$Res> {
  __$$HomeWatcherStateFailureImplCopyWithImpl(
      _$HomeWatcherStateFailureImpl _value,
      $Res Function(_$HomeWatcherStateFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failure = null,
  }) {
    return _then(_$HomeWatcherStateFailureImpl(
      null == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as HomeFailure,
    ));
  }
}

/// @nodoc

class _$HomeWatcherStateFailureImpl implements HomeWatcherStateFailure {
  const _$HomeWatcherStateFailureImpl(this.failure);

  @override
  final HomeFailure failure;

  @override
  String toString() {
    return 'HomeWatcherState.failure(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeWatcherStateFailureImpl &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeWatcherStateFailureImplCopyWith<_$HomeWatcherStateFailureImpl>
      get copyWith => __$$HomeWatcherStateFailureImplCopyWithImpl<
          _$HomeWatcherStateFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<QuestionModel> questionModelItems) success,
    required TResult Function(HomeFailure failure) failure,
  }) {
    return failure(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<QuestionModel> questionModelItems)? success,
    TResult? Function(HomeFailure failure)? failure,
  }) {
    return failure?.call(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<QuestionModel> questionModelItems)? success,
    TResult Function(HomeFailure failure)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this.failure);
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
  const factory HomeWatcherStateFailure(final HomeFailure failure) =
      _$HomeWatcherStateFailureImpl;

  HomeFailure get failure;
  @JsonKey(ignore: true)
  _$$HomeWatcherStateFailureImplCopyWith<_$HomeWatcherStateFailureImpl>
      get copyWith => throw _privateConstructorUsedError;
}
