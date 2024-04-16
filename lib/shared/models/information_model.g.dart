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
      date: DateTime.parse(json['date'] as String),
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const <String>[],
      image: json['image'] as String?,
    );

Map<String, dynamic> _$$InformationModelImplToJson(
        _$InformationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'news': instance.news,
      'date': instance.date.toIso8601String(),
      'tags': instance.tags,
      'image': instance.image,
    };
