// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'information_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InformationModel _$InformationModelFromJson(Map<String, dynamic> json) {
  return _InformationModel.fromJson(json);
}

/// @nodoc
mixin _$InformationModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get news => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InformationModelCopyWith<InformationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InformationModelCopyWith<$Res> {
  factory $InformationModelCopyWith(
          InformationModel value, $Res Function(InformationModel) then) =
      _$InformationModelCopyWithImpl<$Res, InformationModel>;
  @useResult
  $Res call(
      {String id,
      String title,
      String news,
      DateTime date,
      List<String>? tags,
      String? image});
}

/// @nodoc
class _$InformationModelCopyWithImpl<$Res, $Val extends InformationModel>
    implements $InformationModelCopyWith<$Res> {
  _$InformationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? news = null,
    Object? date = null,
    Object? tags = freezed,
    Object? image = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      news: null == news
          ? _value.news
          : news // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InformationModelImplCopyWith<$Res>
    implements $InformationModelCopyWith<$Res> {
  factory _$$InformationModelImplCopyWith(_$InformationModelImpl value,
          $Res Function(_$InformationModelImpl) then) =
      __$$InformationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String news,
      DateTime date,
      List<String>? tags,
      String? image});
}

/// @nodoc
class __$$InformationModelImplCopyWithImpl<$Res>
    extends _$InformationModelCopyWithImpl<$Res, _$InformationModelImpl>
    implements _$$InformationModelImplCopyWith<$Res> {
  __$$InformationModelImplCopyWithImpl(_$InformationModelImpl _value,
      $Res Function(_$InformationModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? news = null,
    Object? date = null,
    Object? tags = freezed,
    Object? image = freezed,
  }) {
    return _then(_$InformationModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      news: null == news
          ? _value.news
          : news // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InformationModelImpl implements _InformationModel {
  const _$InformationModelImpl(
      {required this.id,
      required this.title,
      required this.news,
      required this.date,
      final List<String>? tags = const <String>[],
      this.image})
      : _tags = tags;

  factory _$InformationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$InformationModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String news;
  @override
  final DateTime date;
  final List<String>? _tags;
  @override
  @JsonKey()
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? image;

  @override
  String toString() {
    return 'InformationModel(id: $id, title: $title, news: $news, date: $date, tags: $tags, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InformationModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.news, news) || other.news == news) &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.image, image) || other.image == image));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, news, date,
      const DeepCollectionEquality().hash(_tags), image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InformationModelImplCopyWith<_$InformationModelImpl> get copyWith =>
      __$$InformationModelImplCopyWithImpl<_$InformationModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InformationModelImplToJson(
      this,
    );
  }
}

abstract class _InformationModel implements InformationModel {
  const factory _InformationModel(
      {required final String id,
      required final String title,
      required final String news,
      required final DateTime date,
      final List<String>? tags,
      final String? image}) = _$InformationModelImpl;

  factory _InformationModel.fromJson(Map<String, dynamic> json) =
      _$InformationModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get news;
  @override
  DateTime get date;
  @override
  List<String>? get tags;
  @override
  String? get image;
  @override
  @JsonKey(ignore: true)
  _$$InformationModelImplCopyWith<_$InformationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
