import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kozak/shared/repositories/repositories.dart';
import 'package:kozak/shared/shared.dart';

/// COMMENT: Cubit changes and sets localization in App
@Singleton()
class LanguageCubit extends Cubit<Language?> {
  LanguageCubit({
    // required UserSettingRepository userSettingRepository,
    required AuthenticationRepository appAuthenticationRepository,
  })  :
        //  _userSettingRepository = userSettingRepository,
        _appAuthenticationRepository = appAuthenticationRepository,
        super(null);
  // final UserSettingRepository _userSettingRepository;
  final AuthenticationRepository _appAuthenticationRepository;

  Future<void> changeLanguage(String language) async {
    final locale = language.getLocale;
    // await _userSettingRepository.updateUserSetting(
    //   _userSettingRepository.currentUserSetting.copyWith(locale: locale),
    // );
    emit(locale);
  }

  Future<void> initLanguage() async {
    // final result = await _userSettingRepository
    //     .getUserSetting(_appAuthenticationRepository.currentUser.id);
    // result.fold(
    // (l) =>
    emit(
      Language.ukrain,
      // ),
      // (r) => emit(r.locale),
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
