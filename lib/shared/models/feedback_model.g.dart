// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FeedbackModelImpl _$$FeedbackModelImplFromJson(Map<String, dynamic> json) =>
    _$FeedbackModelImpl(
      id: json['id'] as String,
      guestId: json['guestId'] as String,
      guestName: json['guestName'] as String,
      email: json['email'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      message: json['message'] as String,
      status: $enumDecodeNullable(_$FeedbackStatusEnumMap, json['status']) ??
          FeedbackStatus.isNew,
    );

Map<String, dynamic> _$$FeedbackModelImplToJson(_$FeedbackModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'guestId': instance.guestId,
      'guestName': instance.guestName,
      'email': instance.email,
      'timestamp': instance.timestamp.toIso8601String(),
      'message': instance.message,
      'status': _$FeedbackStatusEnumMap[instance.status],
    };

const _$FeedbackStatusEnumMap = {
  FeedbackStatus.isNew: 'isNew',
  FeedbackStatus.responseRequired: 'responseRequired',
  FeedbackStatus.resolved: 'resolved',
  FeedbackStatus.ideas: 'ideas',
};
