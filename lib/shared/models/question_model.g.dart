// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuestionModelImpl _$$QuestionModelImplFromJson(Map<String, dynamic> json) =>
    _$QuestionModelImpl(
      id: json['id'] as String,
      title: const TitleConverter().fromJson(json['title'] as String),
      subtitle: const SubtitleConverter().fromJson(json['subtitle'] as String),
      navigationLink: json['navigationLink'] as String?,
    );

Map<String, dynamic> _$$QuestionModelImplToJson(_$QuestionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': const TitleConverter().toJson(instance.title),
      'subtitle': const SubtitleConverter().toJson(instance.subtitle),
      'navigationLink': instance.navigationLink,
    };
