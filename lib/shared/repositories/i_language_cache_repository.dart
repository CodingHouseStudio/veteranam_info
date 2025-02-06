import 'package:veteranam/shared/models/user_setting_model.dart';

abstract class ILanguageCacheRepository {
  Language? get getFromCache;
  void saveToCache({
    required Language language,
    required Language previousLanguage,
  });
}
