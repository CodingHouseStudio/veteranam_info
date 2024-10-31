import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:veteranam/shared/models/models.dart';

class TranslateConverter implements JsonConverter<TranslateModel, dynamic> {
  const TranslateConverter();

  @override
  TranslateModel fromJson(dynamic json) {
    return TranslateModel.fromJson(json as Map<String, dynamic>);
  }

  @override
  dynamic toJson(TranslateModel object) {
    return object.toJson();
  }
}
