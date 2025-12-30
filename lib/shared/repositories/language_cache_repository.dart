import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:veteranam/shared/shared_dart.dart';

@Singleton(as: ILanguageCacheRepository)
class LanguageCacheRepository implements ILanguageCacheRepository {
  LanguageCacheRepository({
    required SharedPrefencesProvider sharedPrefencesRepository,
  }) : _sharedPrefencesRepository = sharedPrefencesRepository;
  final SharedPrefencesProvider _sharedPrefencesRepository;

  @visibleForTesting
  static const userLanguageKey = '__user_language_key__';

  @override
  Language? get getFromCache {
    final languageCode = _sharedPrefencesRepository.getString(userLanguageKey);
    if (languageCode != null) {
      return Language.getFromLanguageCode(languageCode);
    }
    return null;
  }

  @override
  void saveToCache({
    required Language language,
    required Language previousLanguage,
  }) {
    if (language != previousLanguage) {
      _sharedPrefencesRepository.setString(
        key: userLanguageKey,
        value: language.value.languageCode,
      );
    }
  }
}
