import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

const languagePrefsKey = 'languagePrefs';

/// COMMENT: Cubit changes and sets localization in App
@Singleton()
class LanguageCubit extends Cubit<Language?> {
  LanguageCubit() : super(null);

  Future<void> changeLanguage(String language) async {
    emit(language.getLocale);
  }

  Future<void> initLanguage() async {
    emit(
      Language.ukrain,
    );
  }
}

enum Language {
  ukrain(
    Locale('uk', 'UK'),
    // Assets.indonesia,
    'UA',
  ),
  english(
    Locale('en', 'US'),
    // Assets.english,
    'EN',
  );

  /// Add another languages support here
  const Language(this.value, this.text);

  final Locale value;
  // final AssetGenImage
  //     image; // Optional: this properties used for ListTile details
  final String text; // Optional: this properties used for ListTile details
}

extension LanguageExtension on Language {
  static List<Language> get getAllLanguage {
    return Language.values.map((lang) => lang).toList();
  }
}

extension GetLanguage on String {
  Language get getLocale {
    switch (this) {
      case 'UA':
        return Language.ukrain;
      case 'EN':
        return Language.english;
      default:
        return Language.ukrain;
    }
  }
}
