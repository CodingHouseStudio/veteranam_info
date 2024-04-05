import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

const languagePrefsKey = 'languagePrefs';

@Singleton()
class LanguageCubit extends Cubit<Language> {
  LanguageCubit() : super(Language.ukrain);

  Future<void> changeLanguage(int languageIndex) async {
    final language = languageIndex.getLocaleUseIndex;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      languagePrefsKey,
      language.value.languageCode,
    );

    emit(language);
  }

  Future<void> initLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final selectedLanguage = prefs.getString(languagePrefsKey);
    emit(
      selectedLanguage != null
          ? Language.values
              .where((item) => item.value.languageCode == selectedLanguage)
              .first
          : Language.ukrain,
    );
  }
}

enum Language {
  english(
    Locale('en', 'US'),
    // Assets.english,
    'English',
  ),
  ukrain(
    Locale('uk', 'UK'),
    // Assets.indonesia,
    'Bahasa Indonesia',
  );

  /// Add another languages support here
  const Language(this.value, this.text);

  final Locale value;
  // final AssetGenImage
  //     image; // Optional: this properties used for ListTile details
  final String text; // Optional: this properties used for ListTile details
}

extension GetLanguageFromIndex on int {
  Language get getLocaleUseIndex {
    switch (this) {
      case 0:
        return Language.ukrain;
      case 1:
        return Language.english;
      default:
        return Language.ukrain;
    }
  }
}
