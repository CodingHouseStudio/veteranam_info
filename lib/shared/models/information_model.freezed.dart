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
  List<String> get category => throw _privateConstructorUsedError;
  List<String> get categoryUA => throw _privateConstructorUsedError;
  String get topic => throw _privateConstructorUsedError;
  String get topicUA => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime get fetchDate => throw _privateConstructorUsedError;
  String? get link => throw _privateConstructorUsedError;
  String? get directLink => throw _privateConstructorUsedError;
  @ImageConverter()
  List<ImageModel>? get image => throw _privateConstructorUsedError;

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
      List<String> category,
      List<String> categoryUA,
      String topic,
      String topicUA,
      String status,
      DateTime fetchDate,
      String? link,
      String? directLink,
      @ImageConverter() List<ImageModel>? image});
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
    Object? category = null,
    Object? categoryUA = null,
    Object? topic = null,
    Object? topicUA = null,
    Object? status = null,
    Object? fetchDate = null,
    Object? link = freezed,
    Object? directLink = freezed,
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
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as List<String>,
      categoryUA: null == categoryUA
          ? _value.categoryUA
          : categoryUA // ignore: cast_nullable_to_non_nullable
              as List<String>,
      topic: null == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      topicUA: null == topicUA
          ? _value.topicUA
          : topicUA // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      fetchDate: null == fetchDate
          ? _value.fetchDate
          : fetchDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      link: freezed == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String?,
      directLink: freezed == directLink
          ? _value.directLink
          : directLink // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as List<ImageModel>?,
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
      List<String> category,
      List<String> categoryUA,
      String topic,
      String topicUA,
      String status,
      DateTime fetchDate,
      String? link,
      String? directLink,
      @ImageConverter() List<ImageModel>? image});
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
    Object? category = null,
    Object? categoryUA = null,
    Object? topic = null,
    Object? topicUA = null,
    Object? status = null,
    Object? fetchDate = null,
    Object? link = freezed,
    Object? directLink = freezed,
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
      category: null == category
          ? _value._category
          : category // ignore: cast_nullable_to_non_nullable
              as List<String>,
      categoryUA: null == categoryUA
          ? _value._categoryUA
          : categoryUA // ignore: cast_nullable_to_non_nullable
              as List<String>,
      topic: null == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      topicUA: null == topicUA
          ? _value.topicUA
          : topicUA // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      fetchDate: null == fetchDate
          ? _value.fetchDate
          : fetchDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      link: freezed == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String?,
      directLink: freezed == directLink
          ? _value.directLink
          : directLink // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value._image
          : image // ignore: cast_nullable_to_non_nullable
              as List<ImageModel>?,
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
      required final List<String> category,
      required final List<String> categoryUA,
      required this.topic,
      required this.topicUA,
      required this.status,
      required this.fetchDate,
      this.link,
      this.directLink,
      @ImageConverter() final List<ImageModel>? image})
      : _category = category,
        _categoryUA = categoryUA,
        _image = image;

  factory _$InformationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$InformationModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String news;
  final List<String> _category;
  @override
  List<String> get category {
    if (_category is EqualUnmodifiableListView) return _category;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_category);
  }

  final List<String> _categoryUA;
  @override
  List<String> get categoryUA {
    if (_categoryUA is EqualUnmodifiableListView) return _categoryUA;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categoryUA);
  }

  @override
  final String topic;
  @override
  final String topicUA;
  @override
  final String status;
  @override
  final DateTime fetchDate;
  @override
  final String? link;
  @override
  final String? directLink;
  final List<ImageModel>? _image;
  @override
  @ImageConverter()
  List<ImageModel>? get image {
    final value = _image;
    if (value == null) return null;
    if (_image is EqualUnmodifiableListView) return _image;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'InformationModel(id: $id, title: $title, news: $news, category: $category, categoryUA: $categoryUA, topic: $topic, topicUA: $topicUA, status: $status, fetchDate: $fetchDate, link: $link, directLink: $directLink, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InformationModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.news, news) || other.news == news) &&
            const DeepCollectionEquality().equals(other._category, _category) &&
            const DeepCollectionEquality()
                .equals(other._categoryUA, _categoryUA) &&
            (identical(other.topic, topic) || other.topic == topic) &&
            (identical(other.topicUA, topicUA) || other.topicUA == topicUA) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.fetchDate, fetchDate) ||
                other.fetchDate == fetchDate) &&
            (identical(other.link, link) || other.link == link) &&
            (identical(other.directLink, directLink) ||
                other.directLink == directLink) &&
            const DeepCollectionEquality().equals(other._image, _image));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      news,
      const DeepCollectionEquality().hash(_category),
      const DeepCollectionEquality().hash(_categoryUA),
      topic,
      topicUA,
      status,
      fetchDate,
      link,
      directLink,
      const DeepCollectionEquality().hash(_image));

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
          required final List<String> category,
          required final List<String> categoryUA,
          required final String topic,
          required final String topicUA,
          required final String status,
          required final DateTime fetchDate,
          final String? link,
          final String? directLink,
          @ImageConverter() final List<ImageModel>? image}) =
      _$InformationModelImpl;

  factory _InformationModel.fromJson(Map<String, dynamic> json) =
      _$InformationModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get news;
  @override
  List<String> get category;
  @override
  List<String> get categoryUA;
  @override
  String get topic;
  @override
  String get topicUA;
  @override
  String get status;
  @override
  DateTime get fetchDate;
  @override
  String? get link;
  @override
  String? get directLink;
  @override
  @ImageConverter()
  List<ImageModel>? get image;
  @override
  @JsonKey(ignore: true)
  _$$InformationModelImplCopyWith<_$InformationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
