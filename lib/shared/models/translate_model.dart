import 'package:freezed_annotation/freezed_annotation.dart';

part 'translate_model.freezed.dart';
part 'translate_model.g.dart';

@freezed
class TranslateModel with _$TranslateModel {
  const factory TranslateModel({
    required String uk,
    required String en,
  }) = _TranslateModel;

  factory TranslateModel.fromJson(Map<String, dynamic> json) =>
      _$TranslateModelFromJson(json);
}
