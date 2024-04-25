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
    required TResult Function(String? filter, bool? isSelected) filter,
    required TResult Function() filterReset,
    required TResult Function(dynamic failure) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(List<InformationModel> informationItemsModel)? updated,
    TResult? Function()? loadNextItems,
    TResult? Function(String? filter, bool? isSelected)? filter,
    TResult? Function()? filterReset,
    TResult? Function(dynamic failure)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(List<InformationModel> informationItemsModel)? updated,
    TResult Function()? loadNextItems,
    TResult Function(String? filter, bool? isSelected)? filter,
    TResult Function()? filterReset,
    TResult Function(dynamic failure)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Updated value) updated,
    required TResult Function(_LoadNextItems value) loadNextItems,
    required TResult Function(_Filter value) filter,
    required TResult Function(_FilterReset value) filterReset,
    required TResult Function(_Failure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Updated value)? updated,
    TResult? Function(_LoadNextItems value)? loadNextItems,
    TResult? Function(_Filter value)? filter,
    TResult? Function(_FilterReset value)? filterReset,
    TResult? Function(_Failure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Updated value)? updated,
    TResult Function(_LoadNextItems value)? loadNextItems,
    TResult Function(_Filter value)? filter,
    TResult Function(_FilterReset value)? filterReset,
    TResult Function(_Failure value)? failure,
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
    required TResult Function(String? filter, bool? isSelected) filter,
    required TResult Function() filterReset,
    required TResult Function(dynamic failure) failure,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(List<InformationModel> informationItemsModel)? updated,
    TResult? Function()? loadNextItems,
    TResult? Function(String? filter, bool? isSelected)? filter,
    TResult? Function()? filterReset,
    TResult? Function(dynamic failure)? failure,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(List<InformationModel> informationItemsModel)? updated,
    TResult Function()? loadNextItems,
    TResult Function(String? filter, bool? isSelected)? filter,
    TResult Function()? filterReset,
    TResult Function(dynamic failure)? failure,
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
    required TResult Function(_FilterReset value) filterReset,
    required TResult Function(_Failure value) failure,
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
    TResult? Function(_FilterReset value)? filterReset,
    TResult? Function(_Failure value)? failure,
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
    TResult Function(_FilterReset value)? filterReset,
    TResult Function(_Failure value)? failure,
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
    required TResult Function(String? filter, bool? isSelected) filter,
    required TResult Function() filterReset,
    required TResult Function(dynamic failure) failure,
  }) {
    return updated(informationItemsModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(List<InformationModel> informationItemsModel)? updated,
    TResult? Function()? loadNextItems,
    TResult? Function(String? filter, bool? isSelected)? filter,
    TResult? Function()? filterReset,
    TResult? Function(dynamic failure)? failure,
  }) {
    return updated?.call(informationItemsModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(List<InformationModel> informationItemsModel)? updated,
    TResult Function()? loadNextItems,
    TResult Function(String? filter, bool? isSelected)? filter,
    TResult Function()? filterReset,
    TResult Function(dynamic failure)? failure,
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
    required TResult Function(_FilterReset value) filterReset,
    required TResult Function(_Failure value) failure,
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
    TResult? Function(_FilterReset value)? filterReset,
    TResult? Function(_Failure value)? failure,
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
    TResult Function(_FilterReset value)? filterReset,
    TResult Function(_Failure value)? failure,
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
    required TResult Function(String? filter, bool? isSelected) filter,
    required TResult Function() filterReset,
    required TResult Function(dynamic failure) failure,
  }) {
    return loadNextItems();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(List<InformationModel> informationItemsModel)? updated,
    TResult? Function()? loadNextItems,
    TResult? Function(String? filter, bool? isSelected)? filter,
    TResult? Function()? filterReset,
    TResult? Function(dynamic failure)? failure,
  }) {
    return loadNextItems?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(List<InformationModel> informationItemsModel)? updated,
    TResult Function()? loadNextItems,
    TResult Function(String? filter, bool? isSelected)? filter,
    TResult Function()? filterReset,
    TResult Function(dynamic failure)? failure,
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
    required TResult Function(_FilterReset value) filterReset,
    required TResult Function(_Failure value) failure,
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
    TResult? Function(_FilterReset value)? filterReset,
    TResult? Function(_Failure value)? failure,
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
    TResult Function(_FilterReset value)? filterReset,
    TResult Function(_Failure value)? failure,
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
  $Res call({String? filter, bool? isSelected});
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
    Object? filter = freezed,
    Object? isSelected = freezed,
  }) {
    return _then(_$FilterImpl(
      filter: freezed == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as String?,
      isSelected: freezed == isSelected
          ? _value.isSelected
          : isSelected // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$FilterImpl implements _Filter {
  const _$FilterImpl({this.filter, this.isSelected});

  @override
  final String? filter;
  @override
  final bool? isSelected;

  @override
  String toString() {
    return 'InformationWatcherEvent.filter(filter: $filter, isSelected: $isSelected)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilterImpl &&
            (identical(other.filter, filter) || other.filter == filter) &&
            (identical(other.isSelected, isSelected) ||
                other.isSelected == isSelected));
  }

  @override
  int get hashCode => Object.hash(runtimeType, filter, isSelected);

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
    required TResult Function(String? filter, bool? isSelected) filter,
    required TResult Function() filterReset,
    required TResult Function(dynamic failure) failure,
  }) {
    return filter(this.filter, isSelected);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(List<InformationModel> informationItemsModel)? updated,
    TResult? Function()? loadNextItems,
    TResult? Function(String? filter, bool? isSelected)? filter,
    TResult? Function()? filterReset,
    TResult? Function(dynamic failure)? failure,
  }) {
    return filter?.call(this.filter, isSelected);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(List<InformationModel> informationItemsModel)? updated,
    TResult Function()? loadNextItems,
    TResult Function(String? filter, bool? isSelected)? filter,
    TResult Function()? filterReset,
    TResult Function(dynamic failure)? failure,
    required TResult orElse(),
  }) {
    if (filter != null) {
      return filter(this.filter, isSelected);
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
    required TResult Function(_FilterReset value) filterReset,
    required TResult Function(_Failure value) failure,
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
    TResult? Function(_FilterReset value)? filterReset,
    TResult? Function(_Failure value)? failure,
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
    TResult Function(_FilterReset value)? filterReset,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (filter != null) {
      return filter(this);
    }
    return orElse();
  }
}

abstract class _Filter implements InformationWatcherEvent {
  const factory _Filter({final String? filter, final bool? isSelected}) =
      _$FilterImpl;

  String? get filter;
  bool? get isSelected;
  @JsonKey(ignore: true)
  _$$FilterImplCopyWith<_$FilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FilterResetImplCopyWith<$Res> {
  factory _$$FilterResetImplCopyWith(
          _$FilterResetImpl value, $Res Function(_$FilterResetImpl) then) =
      __$$FilterResetImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FilterResetImplCopyWithImpl<$Res>
    extends _$InformationWatcherEventCopyWithImpl<$Res, _$FilterResetImpl>
    implements _$$FilterResetImplCopyWith<$Res> {
  __$$FilterResetImplCopyWithImpl(
      _$FilterResetImpl _value, $Res Function(_$FilterResetImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$FilterResetImpl implements _FilterReset {
  const _$FilterResetImpl();

  @override
  String toString() {
    return 'InformationWatcherEvent.filterReset()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FilterResetImpl);
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
    required TResult Function(String? filter, bool? isSelected) filter,
    required TResult Function() filterReset,
    required TResult Function(dynamic failure) failure,
  }) {
    return filterReset();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(List<InformationModel> informationItemsModel)? updated,
    TResult? Function()? loadNextItems,
    TResult? Function(String? filter, bool? isSelected)? filter,
    TResult? Function()? filterReset,
    TResult? Function(dynamic failure)? failure,
  }) {
    return filterReset?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(List<InformationModel> informationItemsModel)? updated,
    TResult Function()? loadNextItems,
    TResult Function(String? filter, bool? isSelected)? filter,
    TResult Function()? filterReset,
    TResult Function(dynamic failure)? failure,
    required TResult orElse(),
  }) {
    if (filterReset != null) {
      return filterReset();
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
    required TResult Function(_FilterReset value) filterReset,
    required TResult Function(_Failure value) failure,
  }) {
    return filterReset(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Updated value)? updated,
    TResult? Function(_LoadNextItems value)? loadNextItems,
    TResult? Function(_Filter value)? filter,
    TResult? Function(_FilterReset value)? filterReset,
    TResult? Function(_Failure value)? failure,
  }) {
    return filterReset?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Updated value)? updated,
    TResult Function(_LoadNextItems value)? loadNextItems,
    TResult Function(_Filter value)? filter,
    TResult Function(_FilterReset value)? filterReset,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (filterReset != null) {
      return filterReset(this);
    }
    return orElse();
  }
}

abstract class _FilterReset implements InformationWatcherEvent {
  const factory _FilterReset() = _$FilterResetImpl;
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
    required TResult Function(String? filter, bool? isSelected) filter,
    required TResult Function() filterReset,
    required TResult Function(dynamic failure) failure,
  }) {
    return failure(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(List<InformationModel> informationItemsModel)? updated,
    TResult? Function()? loadNextItems,
    TResult? Function(String? filter, bool? isSelected)? filter,
    TResult? Function()? filterReset,
    TResult? Function(dynamic failure)? failure,
  }) {
    return failure?.call(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(List<InformationModel> informationItemsModel)? updated,
    TResult Function()? loadNextItems,
    TResult Function(String? filter, bool? isSelected)? filter,
    TResult Function()? filterReset,
    TResult Function(dynamic failure)? failure,
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
    required TResult Function(_FilterReset value) filterReset,
    required TResult Function(_Failure value) failure,
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
    TResult? Function(_FilterReset value)? filterReset,
    TResult? Function(_Failure value)? failure,
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
    TResult Function(_FilterReset value)? filterReset,
    TResult Function(_Failure value)? failure,
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
mixin _$InformationWatcherState {
  List<InformationModel> get informationModelItems =>
      throw _privateConstructorUsedError;
  List<InformationModel> get filteredInformationModelItems =>
      throw _privateConstructorUsedError;
  List<String>? get filters => throw _privateConstructorUsedError;
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
      List<String>? filters,
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
    Object? filters = freezed,
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
      filters: freezed == filters
          ? _value.filters
          : filters // ignore: cast_nullable_to_non_nullable
              as List<String>?,
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
abstract class _$$InformationWatcherStateImplCopyWith<$Res>
    implements $InformationWatcherStateCopyWith<$Res> {
  factory _$$InformationWatcherStateImplCopyWith(
          _$InformationWatcherStateImpl value,
          $Res Function(_$InformationWatcherStateImpl) then) =
      __$$InformationWatcherStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<InformationModel> informationModelItems,
      List<InformationModel> filteredInformationModelItems,
      List<String>? filters,
      LoadingStatus loadingStatus,
      int itemsLoaded,
      InformationFailure? failure});
}

/// @nodoc
class __$$InformationWatcherStateImplCopyWithImpl<$Res>
    extends _$InformationWatcherStateCopyWithImpl<$Res,
        _$InformationWatcherStateImpl>
    implements _$$InformationWatcherStateImplCopyWith<$Res> {
  __$$InformationWatcherStateImplCopyWithImpl(
      _$InformationWatcherStateImpl _value,
      $Res Function(_$InformationWatcherStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? informationModelItems = null,
    Object? filteredInformationModelItems = null,
    Object? filters = freezed,
    Object? loadingStatus = null,
    Object? itemsLoaded = null,
    Object? failure = freezed,
  }) {
    return _then(_$InformationWatcherStateImpl(
      informationModelItems: null == informationModelItems
          ? _value._informationModelItems
          : informationModelItems // ignore: cast_nullable_to_non_nullable
              as List<InformationModel>,
      filteredInformationModelItems: null == filteredInformationModelItems
          ? _value._filteredInformationModelItems
          : filteredInformationModelItems // ignore: cast_nullable_to_non_nullable
              as List<InformationModel>,
      filters: freezed == filters
          ? _value._filters
          : filters // ignore: cast_nullable_to_non_nullable
              as List<String>?,
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

class _$InformationWatcherStateImpl implements InformationWatcherState {
  const _$InformationWatcherStateImpl(
      {required final List<InformationModel> informationModelItems,
      required final List<InformationModel> filteredInformationModelItems,
      required final List<String>? filters,
      required this.loadingStatus,
      required this.itemsLoaded,
      required this.failure})
      : _informationModelItems = informationModelItems,
        _filteredInformationModelItems = filteredInformationModelItems,
        _filters = filters;

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

  final List<String>? _filters;
  @override
  List<String>? get filters {
    final value = _filters;
    if (value == null) return null;
    if (_filters is EqualUnmodifiableListView) return _filters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final LoadingStatus loadingStatus;
  @override
  final int itemsLoaded;
  @override
  final InformationFailure? failure;

  @override
  String toString() {
    return 'InformationWatcherState(informationModelItems: $informationModelItems, filteredInformationModelItems: $filteredInformationModelItems, filters: $filters, loadingStatus: $loadingStatus, itemsLoaded: $itemsLoaded, failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InformationWatcherStateImpl &&
            const DeepCollectionEquality()
                .equals(other._informationModelItems, _informationModelItems) &&
            const DeepCollectionEquality().equals(
                other._filteredInformationModelItems,
                _filteredInformationModelItems) &&
            const DeepCollectionEquality().equals(other._filters, _filters) &&
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
      const DeepCollectionEquality().hash(_filters),
      loadingStatus,
      itemsLoaded,
      failure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InformationWatcherStateImplCopyWith<_$InformationWatcherStateImpl>
      get copyWith => __$$InformationWatcherStateImplCopyWithImpl<
          _$InformationWatcherStateImpl>(this, _$identity);
}

abstract class InformationWatcherState implements InformationWatcherState {
  const factory InformationWatcherState(
          {required final List<InformationModel> informationModelItems,
          required final List<InformationModel> filteredInformationModelItems,
          required final List<String>? filters,
          required final LoadingStatus loadingStatus,
          required final int itemsLoaded,
          required final InformationFailure? failure}) =
      _$InformationWatcherStateImpl;

  @override
  List<InformationModel> get informationModelItems;
  @override
  List<InformationModel> get filteredInformationModelItems;
  @override
  List<String>? get filters;
  @override
  LoadingStatus get loadingStatus;
  @override
  int get itemsLoaded;
  @override
  InformationFailure? get failure;
  @override
  @JsonKey(ignore: true)
  _$$InformationWatcherStateImplCopyWith<_$InformationWatcherStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
