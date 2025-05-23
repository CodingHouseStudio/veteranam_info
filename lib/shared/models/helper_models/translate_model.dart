import 'package:freezed_annotation/freezed_annotation.dart';

part 'translate_model.freezed.dart';
part 'translate_model.g.dart';

@freezed
abstract class TranslateModel with _$TranslateModel {
  const factory TranslateModel({
    required String uk,
    String? en,
  }) = _TranslateModel;

  factory TranslateModel.fromJson(Map<String, dynamic> json) =>
      _$TranslateModelFromJson(json);
}

abstract class TranslateModelJsonField {
  static const uk = 'uk';
  static const en = 'en';
  static const enSufix = 'EN';
  static const trnslationListJson = 'trnslation_list_json';
}
