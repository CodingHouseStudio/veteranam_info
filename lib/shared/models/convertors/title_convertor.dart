import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:veteranam/shared/constants/dimensions/min_max_size_constants.dart';
import 'package:veteranam/shared/extension/extension_dart_constants.dart';
import 'package:veteranam/shared/models/translate_model.dart';

class TitleConverter implements JsonConverter<TranslateModel, dynamic> {
  const TitleConverter();

  @override
  TranslateModel fromJson(dynamic json) {
    final map = json as Map<String, dynamic>;
    final uk = (map[TranslateModelJsonField.uk] as String)
        .setStringLength(KMinMaxSize.titleMaxLength);
    final en = (map[TranslateModelJsonField.en] as String)
        .setStringLength(KMinMaxSize.titleMaxLength);
    return TranslateModel(
      uk: uk,
      en: en,
    );
  }

  @override
  dynamic toJson(TranslateModel object) {
    return {
      TranslateModelJsonField.uk:
          object.uk.setStringLength(KMinMaxSize.titleMaxLength),
      TranslateModelJsonField.en:
          object.en?.setStringLength(KMinMaxSize.titleMaxLength),
    };
  }
}
