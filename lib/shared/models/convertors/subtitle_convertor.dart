import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:veteranam/shared/constants/dimensions/min_max_size_constants.dart';
import 'package:veteranam/shared/extension/extension_dart.dart';
import 'package:veteranam/shared/models/translate_model.dart';

class SubtitleConverter implements JsonConverter<TranslateModel, dynamic> {
  const SubtitleConverter();

  @override
  TranslateModel fromJson(dynamic json) {
    final map = json as Map<String, dynamic>;
    final uk = (map[TranslateModelJsonField.uk] as String)
        .setStringLength(KMinMaxSize.subtitleMaxLength);
    final en = (map[TranslateModelJsonField.en] as String)
        .setStringLength(KMinMaxSize.subtitleMaxLength);
    return TranslateModel(
      uk: uk,
      en: en,
    );
  }

  @override
  dynamic toJson(TranslateModel object) {
    return {
      TranslateModelJsonField.uk:
          object.uk.setStringLength(KMinMaxSize.subtitleMaxLength),
      TranslateModelJsonField.en:
          object.en?.setStringLength(KMinMaxSize.subtitleMaxLength),
    };
  }
}

/// FOLDER FILES COMMENT: Classes set filtering for getting and adding in json
