import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.companyCache} ${KGroupText.repository} ', () {
    late ILanguageCacheRepository languageCacheRepository;
    late SharedPrefencesRepository mockSharedPreferencesRepository;
    setUp(() {
      mockSharedPreferencesRepository = MockSharedPrefencesRepository();

      languageCacheRepository = LanguageCacheRepository(
        sharedPrefencesRepository: mockSharedPreferencesRepository,
      );
      when(
        mockSharedPreferencesRepository.getString(
          LanguageCacheRepository.userLanguageKey,
        ),
      ).thenAnswer(
        (_) => Language.english.value.languageCode,
      );

      when(
        mockSharedPreferencesRepository.setString(
          key: LanguageCacheRepository.userLanguageKey,
          value: Language.ukraine.value.languageCode,
        ),
      ).thenAnswer(
        (_) async => true,
      );
    });
    test('Get Company', () async {
      expect(
        languageCacheRepository.getFromCache,
        Language.english,
      );
    });
    test('Save To Cache Comapany', () async {
      languageCacheRepository.saveToCache(
        language: Language.ukraine,
        previousLanguage: Language.english,
      );

      verify(
        mockSharedPreferencesRepository.setString(
          key: LanguageCacheRepository.userLanguageKey,
          value: Language.ukraine.value.languageCode,
        ),
      ).called(1);
    });
  });
}
