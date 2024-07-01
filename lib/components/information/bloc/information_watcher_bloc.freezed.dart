// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'information_watcher_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$InformationWatcherEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(List<InformationModel> informationItemsModel)
        updated,
    required TResult Function() loadNextItems,
    required TResult Function(int filterIndex) filter,
    required TResult Function(dynamic failure) failure,
    required TResult Function(InformationModel informationModel, bool isLiked)
        like,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(List<InformationModel> informationItemsModel)? updated,
    TResult? Function()? loadNextItems,
    TResult? Function(int filterIndex)? filter,
    TResult? Function(dynamic failure)? failure,
    TResult? Function(InformationModel informationModel, bool isLiked)? like,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(List<InformationModel> informationItemsModel)? updated,
    TResult Function()? loadNextItems,
    TResult Function(int filterIndex)? filter,
    TResult Function(dynamic failure)? failure,
    TResult Function(InformationModel informationModel, bool isLiked)? like,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Updated value) updated,
    required TResult Function(_LoadNextItems value) loadNextItems,
    required TResult Function(_Filter value) filter,
    required TResult Function(_Failure value) failure,
    required TResult Function(_LikeInformation value) like,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Updated value)? updated,
    TResult? Function(_LoadNextItems value)? loadNextItems,
    TResult? Function(_Filter value)? filter,
    TResult? Function(_Failure value)? failure,
    TResult? Function(_LikeInformation value)? like,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Updated value)? updated,
    TResult Function(_LoadNextItems value)? loadNextItems,
    TResult Function(_Filter value)? filter,
    TResult Function(_Failure value)? failure,
    TResult Function(_LikeInformation value)? like,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InformationWatcherEventCopyWith<$Res> {
  factory $InformationWatcherEventCopyWith(InformationWatcherEvent value,
          $Res Function(InformationWatcherEvent) then) =
      _$InformationWatcherEventCopyWithImpl<$Res, InformationWatcherEvent>;
}

/// @nodoc
class _$InformationWatcherEventCopyWithImpl<$Res,
        $Val extends InformationWatcherEvent>
    implements $InformationWatcherEventCopyWith<$Res> {
  _$InformationWatcherEventCopyWithImpl(this._value, this._then);

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
    extends _$InformationWatcherEventCopyWithImpl<$Res, _$StartedImpl>
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
    return 'InformationWatcherEvent.started()';
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
    required TResult Function(List<InformationModel> informationItemsModel)
        updated,
    required TResult Function() loadNextItems,
    required TResult Function(int filterIndex) filter,
    required TResult Function(dynamic failure) failure,
    required TResult Function(InformationModel informationModel, bool isLiked)
        like,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(List<InformationModel> informationItemsModel)? updated,
    TResult? Function()? loadNextItems,
    TResult? Function(int filterIndex)? filter,
    TResult? Function(dynamic failure)? failure,
    TResult? Function(InformationModel informationModel, bool isLiked)? like,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(List<InformationModel> informationItemsModel)? updated,
    TResult Function()? loadNextItems,
    TResult Function(int filterIndex)? filter,
    TResult Function(dynamic failure)? failure,
    TResult Function(InformationModel informationModel, bool isLiked)? like,
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
    required TResult Function(_LoadNextItems value) loadNextItems,
    required TResult Function(_Filter value) filter,
    required TResult Function(_Failure value) failure,
    required TResult Function(_LikeInformation value) like,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Updated value)? updated,
    TResult? Function(_LoadNextItems value)? loadNextItems,
    TResult? Function(_Filter value)? filter,
    TResult? Function(_Failure value)? failure,
    TResult? Function(_LikeInformation value)? like,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Updated value)? updated,
    TResult Function(_LoadNextItems value)? loadNextItems,
    TResult Function(_Filter value)? filter,
    TResult Function(_Failure value)? failure,
    TResult Function(_LikeInformation value)? like,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements InformationWatcherEvent {
  const factory _Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$UpdatedImplCopyWith<$Res> {
  factory _$$UpdatedImplCopyWith(
          _$UpdatedImpl value, $Res Function(_$UpdatedImpl) then) =
      __$$UpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<InformationModel> informationItemsModel});
}

/// @nodoc
class __$$UpdatedImplCopyWithImpl<$Res>
    extends _$InformationWatcherEventCopyWithImpl<$Res, _$UpdatedImpl>
    implements _$$UpdatedImplCopyWith<$Res> {
  __$$UpdatedImplCopyWithImpl(
      _$UpdatedImpl _value, $Res Function(_$UpdatedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? informationItemsModel = null,
  }) {
    return _then(_$UpdatedImpl(
      null == informationItemsModel
          ? _value._informationItemsModel
          : informationItemsModel // ignore: cast_nullable_to_non_nullable
              as List<InformationModel>,
    ));
  }
}

/// @nodoc

class _$UpdatedImpl implements _Updated {
  const _$UpdatedImpl(final List<InformationModel> informationItemsModel)
      : _informationItemsModel = informationItemsModel;

  final List<InformationModel> _informationItemsModel;
  @override
  List<InformationModel> get informationItemsModel {
    if (_informationItemsModel is EqualUnmodifiableListView)
      return _informationItemsModel;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_informationItemsModel);
  }

  @override
  String toString() {
    return 'InformationWatcherEvent.updated(informationItemsModel: $informationItemsModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatedImpl &&
            const DeepCollectionEquality()
                .equals(other._informationItemsModel, _informationItemsModel));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_informationItemsModel));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatedImplCopyWith<_$UpdatedImpl> get copyWith =>
      __$$UpdatedImplCopyWithImpl<_$UpdatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(List<InformationModel> informationItemsModel)
        updated,
    required TResult Function() loadNextItems,
    required TResult Function(int filterIndex) filter,
    required TResult Function(dynamic failure) failure,
    required TResult Function(InformationModel informationModel, bool isLiked)
        like,
  }) {
    return updated(informationItemsModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(List<InformationModel> informationItemsModel)? updated,
    TResult? Function()? loadNextItems,
    TResult? Function(int filterIndex)? filter,
    TResult? Function(dynamic failure)? failure,
    TResult? Function(InformationModel informationModel, bool isLiked)? like,
  }) {
    return updated?.call(informationItemsModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(List<InformationModel> informationItemsModel)? updated,
    TResult Function()? loadNextItems,
    TResult Function(int filterIndex)? filter,
    TResult Function(dynamic failure)? failure,
    TResult Function(InformationModel informationModel, bool isLiked)? like,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(informationItemsModel);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Updated value) updated,
    required TResult Function(_LoadNextItems value) loadNextItems,
    required TResult Function(_Filter value) filter,
    required TResult Function(_Failure value) failure,
    required TResult Function(_LikeInformation value) like,
  }) {
    return updated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Updated value)? updated,
    TResult? Function(_LoadNextItems value)? loadNextItems,
    TResult? Function(_Filter value)? filter,
    TResult? Function(_Failure value)? failure,
    TResult? Function(_LikeInformation value)? like,
  }) {
    return updated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Updated value)? updated,
    TResult Function(_LoadNextItems value)? loadNextItems,
    TResult Function(_Filter value)? filter,
    TResult Function(_Failure value)? failure,
    TResult Function(_LikeInformation value)? like,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(this);
    }
    return orElse();
  }
}

abstract class _Updated implements InformationWatcherEvent {
  const factory _Updated(final List<InformationModel> informationItemsModel) =
      _$UpdatedImpl;

  List<InformationModel> get informationItemsModel;
  @JsonKey(ignore: true)
  _$$UpdatedImplCopyWith<_$UpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadNextItemsImplCopyWith<$Res> {
  factory _$$LoadNextItemsImplCopyWith(
          _$LoadNextItemsImpl value, $Res Function(_$LoadNextItemsImpl) then) =
      __$$LoadNextItemsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadNextItemsImplCopyWithImpl<$Res>
    extends _$InformationWatcherEventCopyWithImpl<$Res, _$LoadNextItemsImpl>
    implements _$$LoadNextItemsImplCopyWith<$Res> {
  __$$LoadNextItemsImplCopyWithImpl(
      _$LoadNextItemsImpl _value, $Res Function(_$LoadNextItemsImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadNextItemsImpl implements _LoadNextItems {
  const _$LoadNextItemsImpl();

  @override
  String toString() {
    return 'InformationWatcherEvent.loadNextItems()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadNextItemsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(List<InformationModel> informationItemsModel)
        updated,
    required TResult Function() loadNextItems,
    required TResult Function(int filterIndex) filter,
    required TResult Function(dynamic failure) failure,
    required TResult Function(InformationModel informationModel, bool isLiked)
        like,
  }) {
    return loadNextItems();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(List<InformationModel> informationItemsModel)? updated,
    TResult? Function()? loadNextItems,
    TResult? Function(int filterIndex)? filter,
    TResult? Function(dynamic failure)? failure,
    TResult? Function(InformationModel informationModel, bool isLiked)? like,
  }) {
    return loadNextItems?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(List<InformationModel> informationItemsModel)? updated,
    TResult Function()? loadNextItems,
    TResult Function(int filterIndex)? filter,
    TResult Function(dynamic failure)? failure,
    TResult Function(InformationModel informationModel, bool isLiked)? like,
    required TResult orElse(),
  }) {
    if (loadNextItems != null) {
      return loadNextItems();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Updated value) updated,
    required TResult Function(_LoadNextItems value) loadNextItems,
    required TResult Function(_Filter value) filter,
    required TResult Function(_Failure value) failure,
    required TResult Function(_LikeInformation value) like,
  }) {
    return loadNextItems(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Updated value)? updated,
    TResult? Function(_LoadNextItems value)? loadNextItems,
    TResult? Function(_Filter value)? filter,
    TResult? Function(_Failure value)? failure,
    TResult? Function(_LikeInformation value)? like,
  }) {
    return loadNextItems?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Updated value)? updated,
    TResult Function(_LoadNextItems value)? loadNextItems,
    TResult Function(_Filter value)? filter,
    TResult Function(_Failure value)? failure,
    TResult Function(_LikeInformation value)? like,
    required TResult orElse(),
  }) {
    if (loadNextItems != null) {
      return loadNextItems(this);
    }
    return orElse();
  }
}

abstract class _LoadNextItems implements InformationWatcherEvent {
  const factory _LoadNextItems() = _$LoadNextItemsImpl;
}

/// @nodoc
abstract class _$$FilterImplCopyWith<$Res> {
  factory _$$FilterImplCopyWith(
          _$FilterImpl value, $Res Function(_$FilterImpl) then) =
      __$$FilterImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int filterIndex});
}

/// @nodoc
class __$$FilterImplCopyWithImpl<$Res>
    extends _$InformationWatcherEventCopyWithImpl<$Res, _$FilterImpl>
    implements _$$FilterImplCopyWith<$Res> {
  __$$FilterImplCopyWithImpl(
      _$FilterImpl _value, $Res Function(_$FilterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filterIndex = null,
  }) {
    return _then(_$FilterImpl(
      null == filterIndex
          ? _value.filterIndex
          : filterIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$FilterImpl implements _Filter {
  const _$FilterImpl(this.filterIndex);

  @override
  final int filterIndex;

  @override
  String toString() {
    return 'InformationWatcherEvent.filter(filterIndex: $filterIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilterImpl &&
            (identical(other.filterIndex, filterIndex) ||
                other.filterIndex == filterIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, filterIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FilterImplCopyWith<_$FilterImpl> get copyWith =>
      __$$FilterImplCopyWithImpl<_$FilterImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(List<InformationModel> informationItemsModel)
        updated,
    required TResult Function() loadNextItems,
    required TResult Function(int filterIndex) filter,
    required TResult Function(dynamic failure) failure,
    required TResult Function(InformationModel informationModel, bool isLiked)
        like,
  }) {
    return filter(filterIndex);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(List<InformationModel> informationItemsModel)? updated,
    TResult? Function()? loadNextItems,
    TResult? Function(int filterIndex)? filter,
    TResult? Function(dynamic failure)? failure,
    TResult? Function(InformationModel informationModel, bool isLiked)? like,
  }) {
    return filter?.call(filterIndex);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(List<InformationModel> informationItemsModel)? updated,
    TResult Function()? loadNextItems,
    TResult Function(int filterIndex)? filter,
    TResult Function(dynamic failure)? failure,
    TResult Function(InformationModel informationModel, bool isLiked)? like,
    required TResult orElse(),
  }) {
    if (filter != null) {
      return filter(filterIndex);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Updated value) updated,
    required TResult Function(_LoadNextItems value) loadNextItems,
    required TResult Function(_Filter value) filter,
    required TResult Function(_Failure value) failure,
    required TResult Function(_LikeInformation value) like,
  }) {
    return filter(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Updated value)? updated,
    TResult? Function(_LoadNextItems value)? loadNextItems,
    TResult? Function(_Filter value)? filter,
    TResult? Function(_Failure value)? failure,
    TResult? Function(_LikeInformation value)? like,
  }) {
    return filter?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Updated value)? updated,
    TResult Function(_LoadNextItems value)? loadNextItems,
    TResult Function(_Filter value)? filter,
    TResult Function(_Failure value)? failure,
    TResult Function(_LikeInformation value)? like,
    required TResult orElse(),
  }) {
    if (filter != null) {
      return filter(this);
    }
    return orElse();
  }
}

abstract class _Filter implements InformationWatcherEvent {
  const factory _Filter(final int filterIndex) = _$FilterImpl;

  int get filterIndex;
  @JsonKey(ignore: true)
  _$$FilterImplCopyWith<_$FilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailureImplCopyWith<$Res> {
  factory _$$FailureImplCopyWith(
          _$FailureImpl value, $Res Function(_$FailureImpl) then) =
      __$$FailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic failure});
}

/// @nodoc
class __$$FailureImplCopyWithImpl<$Res>
    extends _$InformationWatcherEventCopyWithImpl<$Res, _$FailureImpl>
    implements _$$FailureImplCopyWith<$Res> {
  __$$FailureImplCopyWithImpl(
      _$FailureImpl _value, $Res Function(_$FailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failure = freezed,
  }) {
    return _then(_$FailureImpl(
      freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$FailureImpl implements _Failure {
  const _$FailureImpl(this.failure);

  @override
  final dynamic failure;

  @override
  String toString() {
    return 'InformationWatcherEvent.failure(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailureImpl &&
            const DeepCollectionEquality().equals(other.failure, failure));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(failure));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailureImplCopyWith<_$FailureImpl> get copyWith =>
      __$$FailureImplCopyWithImpl<_$FailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(List<InformationModel> informationItemsModel)
        updated,
    required TResult Function() loadNextItems,
    required TResult Function(int filterIndex) filter,
    required TResult Function(dynamic failure) failure,
    required TResult Function(InformationModel informationModel, bool isLiked)
        like,
  }) {
    return failure(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(List<InformationModel> informationItemsModel)? updated,
    TResult? Function()? loadNextItems,
    TResult? Function(int filterIndex)? filter,
    TResult? Function(dynamic failure)? failure,
    TResult? Function(InformationModel informationModel, bool isLiked)? like,
  }) {
    return failure?.call(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(List<InformationModel> informationItemsModel)? updated,
    TResult Function()? loadNextItems,
    TResult Function(int filterIndex)? filter,
    TResult Function(dynamic failure)? failure,
    TResult Function(InformationModel informationModel, bool isLiked)? like,
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
    required TResult Function(_Started value) started,
    required TResult Function(_Updated value) updated,
    required TResult Function(_LoadNextItems value) loadNextItems,
    required TResult Function(_Filter value) filter,
    required TResult Function(_Failure value) failure,
    required TResult Function(_LikeInformation value) like,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Updated value)? updated,
    TResult? Function(_LoadNextItems value)? loadNextItems,
    TResult? Function(_Filter value)? filter,
    TResult? Function(_Failure value)? failure,
    TResult? Function(_LikeInformation value)? like,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Updated value)? updated,
    TResult Function(_LoadNextItems value)? loadNextItems,
    TResult Function(_Filter value)? filter,
    TResult Function(_Failure value)? failure,
    TResult Function(_LikeInformation value)? like,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _Failure implements InformationWatcherEvent {
  const factory _Failure(final dynamic failure) = _$FailureImpl;

  dynamic get failure;
  @JsonKey(ignore: true)
  _$$FailureImplCopyWith<_$FailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LikeInformationImplCopyWith<$Res> {
  factory _$$LikeInformationImplCopyWith(_$LikeInformationImpl value,
          $Res Function(_$LikeInformationImpl) then) =
      __$$LikeInformationImplCopyWithImpl<$Res>;
  @useResult
  $Res call({InformationModel informationModel, bool isLiked});

  $InformationModelCopyWith<$Res> get informationModel;
}

/// @nodoc
class __$$LikeInformationImplCopyWithImpl<$Res>
    extends _$InformationWatcherEventCopyWithImpl<$Res, _$LikeInformationImpl>
    implements _$$LikeInformationImplCopyWith<$Res> {
  __$$LikeInformationImplCopyWithImpl(
      _$LikeInformationImpl _value, $Res Function(_$LikeInformationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? informationModel = null,
    Object? isLiked = null,
  }) {
    return _then(_$LikeInformationImpl(
      informationModel: null == informationModel
          ? _value.informationModel
          : informationModel // ignore: cast_nullable_to_non_nullable
              as InformationModel,
      isLiked: null == isLiked
          ? _value.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $InformationModelCopyWith<$Res> get informationModel {
    return $InformationModelCopyWith<$Res>(_value.informationModel, (value) {
      return _then(_value.copyWith(informationModel: value));
    });
  }
}

/// @nodoc

class _$LikeInformationImpl implements _LikeInformation {
  const _$LikeInformationImpl(
      {required this.informationModel, required this.isLiked});

  @override
  final InformationModel informationModel;
  @override
  final bool isLiked;

  @override
  String toString() {
    return 'InformationWatcherEvent.like(informationModel: $informationModel, isLiked: $isLiked)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LikeInformationImpl &&
            (identical(other.informationModel, informationModel) ||
                other.informationModel == informationModel) &&
            (identical(other.isLiked, isLiked) || other.isLiked == isLiked));
  }

  @override
  int get hashCode => Object.hash(runtimeType, informationModel, isLiked);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LikeInformationImplCopyWith<_$LikeInformationImpl> get copyWith =>
      __$$LikeInformationImplCopyWithImpl<_$LikeInformationImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(List<InformationModel> informationItemsModel)
        updated,
    required TResult Function() loadNextItems,
    required TResult Function(int filterIndex) filter,
    required TResult Function(dynamic failure) failure,
    required TResult Function(InformationModel informationModel, bool isLiked)
        like,
  }) {
    return like(informationModel, isLiked);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(List<InformationModel> informationItemsModel)? updated,
    TResult? Function()? loadNextItems,
    TResult? Function(int filterIndex)? filter,
    TResult? Function(dynamic failure)? failure,
    TResult? Function(InformationModel informationModel, bool isLiked)? like,
  }) {
    return like?.call(informationModel, isLiked);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(List<InformationModel> informationItemsModel)? updated,
    TResult Function()? loadNextItems,
    TResult Function(int filterIndex)? filter,
    TResult Function(dynamic failure)? failure,
    TResult Function(InformationModel informationModel, bool isLiked)? like,
    required TResult orElse(),
  }) {
    if (like != null) {
      return like(informationModel, isLiked);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Updated value) updated,
    required TResult Function(_LoadNextItems value) loadNextItems,
    required TResult Function(_Filter value) filter,
    required TResult Function(_Failure value) failure,
    required TResult Function(_LikeInformation value) like,
  }) {
    return like(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Updated value)? updated,
    TResult? Function(_LoadNextItems value)? loadNextItems,
    TResult? Function(_Filter value)? filter,
    TResult? Function(_Failure value)? failure,
    TResult? Function(_LikeInformation value)? like,
  }) {
    return like?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Updated value)? updated,
    TResult Function(_LoadNextItems value)? loadNextItems,
    TResult Function(_Filter value)? filter,
    TResult Function(_Failure value)? failure,
    TResult Function(_LikeInformation value)? like,
    required TResult orElse(),
  }) {
    if (like != null) {
      return like(this);
    }
    return orElse();
  }
}

abstract class _LikeInformation implements InformationWatcherEvent {
  const factory _LikeInformation(
      {required final InformationModel informationModel,
      required final bool isLiked}) = _$LikeInformationImpl;

  InformationModel get informationModel;
  bool get isLiked;
  @JsonKey(ignore: true)
  _$$LikeInformationImplCopyWith<_$LikeInformationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$InformationWatcherState {
  List<InformationModel> get informationModelItems =>
      throw _privateConstructorUsedError;
  List<InformationModel> get filteredInformationModelItems =>
      throw _privateConstructorUsedError;
  List<int> get filtersIndex => throw _privateConstructorUsedError;
  LoadingStatus get loadingStatus => throw _privateConstructorUsedError;
  int get itemsLoaded => throw _privateConstructorUsedError;
  InformationFailure? get failure => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InformationWatcherStateCopyWith<InformationWatcherState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InformationWatcherStateCopyWith<$Res> {
  factory $InformationWatcherStateCopyWith(InformationWatcherState value,
          $Res Function(InformationWatcherState) then) =
      _$InformationWatcherStateCopyWithImpl<$Res, InformationWatcherState>;
  @useResult
  $Res call(
      {List<InformationModel> informationModelItems,
      List<InformationModel> filteredInformationModelItems,
      List<int> filtersIndex,
      LoadingStatus loadingStatus,
      int itemsLoaded,
      InformationFailure? failure});
}

/// @nodoc
class _$InformationWatcherStateCopyWithImpl<$Res,
        $Val extends InformationWatcherState>
    implements $InformationWatcherStateCopyWith<$Res> {
  _$InformationWatcherStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? informationModelItems = null,
    Object? filteredInformationModelItems = null,
    Object? filtersIndex = null,
    Object? loadingStatus = null,
    Object? itemsLoaded = null,
    Object? failure = freezed,
  }) {
    return _then(_value.copyWith(
      informationModelItems: null == informationModelItems
          ? _value.informationModelItems
          : informationModelItems // ignore: cast_nullable_to_non_nullable
              as List<InformationModel>,
      filteredInformationModelItems: null == filteredInformationModelItems
          ? _value.filteredInformationModelItems
          : filteredInformationModelItems // ignore: cast_nullable_to_non_nullable
              as List<InformationModel>,
      filtersIndex: null == filtersIndex
          ? _value.filtersIndex
          : filtersIndex // ignore: cast_nullable_to_non_nullable
              as List<int>,
      loadingStatus: null == loadingStatus
          ? _value.loadingStatus
          : loadingStatus // ignore: cast_nullable_to_non_nullable
              as LoadingStatus,
      itemsLoaded: null == itemsLoaded
          ? _value.itemsLoaded
          : itemsLoaded // ignore: cast_nullable_to_non_nullable
              as int,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as InformationFailure?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $InformationWatcherStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<InformationModel> informationModelItems,
      List<InformationModel> filteredInformationModelItems,
      List<int> filtersIndex,
      LoadingStatus loadingStatus,
      int itemsLoaded,
      InformationFailure? failure});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$InformationWatcherStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? informationModelItems = null,
    Object? filteredInformationModelItems = null,
    Object? filtersIndex = null,
    Object? loadingStatus = null,
    Object? itemsLoaded = null,
    Object? failure = freezed,
  }) {
    return _then(_$InitialImpl(
      informationModelItems: null == informationModelItems
          ? _value._informationModelItems
          : informationModelItems // ignore: cast_nullable_to_non_nullable
              as List<InformationModel>,
      filteredInformationModelItems: null == filteredInformationModelItems
          ? _value._filteredInformationModelItems
          : filteredInformationModelItems // ignore: cast_nullable_to_non_nullable
              as List<InformationModel>,
      filtersIndex: null == filtersIndex
          ? _value._filtersIndex
          : filtersIndex // ignore: cast_nullable_to_non_nullable
              as List<int>,
      loadingStatus: null == loadingStatus
          ? _value.loadingStatus
          : loadingStatus // ignore: cast_nullable_to_non_nullable
              as LoadingStatus,
      itemsLoaded: null == itemsLoaded
          ? _value.itemsLoaded
          : itemsLoaded // ignore: cast_nullable_to_non_nullable
              as int,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as InformationFailure?,
    ));
  }
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl(
      {required final List<InformationModel> informationModelItems,
      required final List<InformationModel> filteredInformationModelItems,
      required final List<int> filtersIndex,
      required this.loadingStatus,
      required this.itemsLoaded,
      required this.failure})
      : _informationModelItems = informationModelItems,
        _filteredInformationModelItems = filteredInformationModelItems,
        _filtersIndex = filtersIndex;

  final List<InformationModel> _informationModelItems;
  @override
  List<InformationModel> get informationModelItems {
    if (_informationModelItems is EqualUnmodifiableListView)
      return _informationModelItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_informationModelItems);
  }

  final List<InformationModel> _filteredInformationModelItems;
  @override
  List<InformationModel> get filteredInformationModelItems {
    if (_filteredInformationModelItems is EqualUnmodifiableListView)
      return _filteredInformationModelItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredInformationModelItems);
  }

  final List<int> _filtersIndex;
  @override
  List<int> get filtersIndex {
    if (_filtersIndex is EqualUnmodifiableListView) return _filtersIndex;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filtersIndex);
  }

  @override
  final LoadingStatus loadingStatus;
  @override
  final int itemsLoaded;
  @override
  final InformationFailure? failure;

  @override
  String toString() {
    return 'InformationWatcherState(informationModelItems: $informationModelItems, filteredInformationModelItems: $filteredInformationModelItems, filtersIndex: $filtersIndex, loadingStatus: $loadingStatus, itemsLoaded: $itemsLoaded, failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            const DeepCollectionEquality()
                .equals(other._informationModelItems, _informationModelItems) &&
            const DeepCollectionEquality().equals(
                other._filteredInformationModelItems,
                _filteredInformationModelItems) &&
            const DeepCollectionEquality()
                .equals(other._filtersIndex, _filtersIndex) &&
            (identical(other.loadingStatus, loadingStatus) ||
                other.loadingStatus == loadingStatus) &&
            (identical(other.itemsLoaded, itemsLoaded) ||
                other.itemsLoaded == itemsLoaded) &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_informationModelItems),
      const DeepCollectionEquality().hash(_filteredInformationModelItems),
      const DeepCollectionEquality().hash(_filtersIndex),
      loadingStatus,
      itemsLoaded,
      failure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      __$$InitialImplCopyWithImpl<_$InitialImpl>(this, _$identity);
}

abstract class _Initial implements InformationWatcherState {
  const factory _Initial(
      {required final List<InformationModel> informationModelItems,
      required final List<InformationModel> filteredInformationModelItems,
      required final List<int> filtersIndex,
      required final LoadingStatus loadingStatus,
      required final int itemsLoaded,
      required final InformationFailure? failure}) = _$InitialImpl;

  @override
  List<InformationModel> get informationModelItems;
  @override
  List<InformationModel> get filteredInformationModelItems;
  @override
  List<int> get filtersIndex;
  @override
  LoadingStatus get loadingStatus;
  @override
  int get itemsLoaded;
  @override
  InformationFailure? get failure;
  @override
  @JsonKey(ignore: true)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
