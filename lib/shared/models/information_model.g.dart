// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'information_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InformationModelImpl _$$InformationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$InformationModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      news: json['news'] as String,
      category:
          (json['category'] as List<dynamic>).map((e) => e as String).toList(),
      categoryUA: (json['categoryUA'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      topic: json['topic'] as String,
      topicUA: json['topicUA'] as String,
      status: json['status'] as String,
      fetchDate: DateTime.parse(json['fetchDate'] as String),
      image: const ImageConverter().fromJson(json['image'] as List?),
    );

Map<String, dynamic> _$$InformationModelImplToJson(
        _$InformationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'news': instance.news,
      'category': instance.category,
      'categoryUA': instance.categoryUA,
      'topic': instance.topic,
      'topicUA': instance.topicUA,
      'status': instance.status,
      'fetchDate': instance.fetchDate.toIso8601String(),
      'image': const ImageConverter().toJson(instance.image),
    };
