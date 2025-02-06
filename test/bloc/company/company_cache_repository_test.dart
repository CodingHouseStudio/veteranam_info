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
    late ICompanyCacheRepository companyCacheRepository;
    late SharedPrefencesProvider mockSharedPreferencesRepository;
    setUp(() {
      mockSharedPreferencesRepository = MockSharedPrefencesProvider();

      companyCacheRepository = CompanyCacheRepository(
        sharedPrefencesRepository: mockSharedPreferencesRepository,
      );
      when(
        mockSharedPreferencesRepository.getString(
          CompanyCacheRepository.codeCacheKey,
        ),
      ).thenAnswer(
        (_) => KTestVariables.cacheCompany.code,
      );
      when(
        mockSharedPreferencesRepository.getString(
          CompanyCacheRepository.linkCacheKey,
        ),
      ).thenAnswer(
        (_) => KTestVariables.cacheCompany.link,
      );
      when(
        mockSharedPreferencesRepository.getString(
          CompanyCacheRepository.nameCacheKey,
        ),
      ).thenAnswer(
        (_) => KTestVariables.cacheCompany.companyName,
      );
      when(
        mockSharedPreferencesRepository.getString(
          CompanyCacheRepository.publicNameCacheKey,
        ),
      ).thenAnswer(
        (_) => KTestVariables.cacheCompany.publicName,
      );
      when(
        mockSharedPreferencesRepository.getStringList(
          CompanyCacheRepository.userEmailsCacheKey,
        ),
      ).thenAnswer(
        (_) => KTestVariables.cacheCompany.userEmails,
      );

      when(
        mockSharedPreferencesRepository.setString(
          key: CompanyCacheRepository.codeCacheKey,
          value: KTestVariables.fullCompanyModel.code!,
        ),
      ).thenAnswer(
        (_) async => true,
      );
      when(
        mockSharedPreferencesRepository.setString(
          key: CompanyCacheRepository.linkCacheKey,
          value: KTestVariables.fullCompanyModel.link!,
        ),
      ).thenAnswer(
        (_) async => true,
      );
      when(
        mockSharedPreferencesRepository.setString(
          key: CompanyCacheRepository.nameCacheKey,
          value: KTestVariables.fullCompanyModel.companyName!,
        ),
      ).thenAnswer(
        (_) async => true,
      );
      when(
        mockSharedPreferencesRepository.setString(
          key: CompanyCacheRepository.publicNameCacheKey,
          value: KTestVariables.fullCompanyModel.publicName!,
        ),
      ).thenAnswer(
        (_) async => true,
      );
      when(
        mockSharedPreferencesRepository.setStringList(
          key: CompanyCacheRepository.userEmailsCacheKey,
          value: KTestVariables.fullCompanyModel.userEmails,
        ),
      ).thenAnswer(
        (_) async => true,
      );

      when(
        mockSharedPreferencesRepository.remove(
          CompanyCacheRepository.codeCacheKey,
        ),
      ).thenAnswer(
        (_) async => true,
      );
      when(
        mockSharedPreferencesRepository.remove(
          CompanyCacheRepository.linkCacheKey,
        ),
      ).thenAnswer(
        (_) async => true,
      );
      when(
        mockSharedPreferencesRepository.remove(
          CompanyCacheRepository.nameCacheKey,
        ),
      ).thenAnswer(
        (_) async => true,
      );
      when(
        mockSharedPreferencesRepository.remove(
          CompanyCacheRepository.publicNameCacheKey,
        ),
      ).thenAnswer(
        (_) async => true,
      );
      when(
        mockSharedPreferencesRepository.remove(
          CompanyCacheRepository.userEmailsCacheKey,
        ),
      ).thenAnswer(
        (_) async => true,
      );
    });
    test('Get Company', () async {
      expect(
        companyCacheRepository.getFromCache,
        KTestVariables.cacheCompany,
      );
    });
    test('Save To Cache Comapany', () async {
      companyCacheRepository.saveToCache(
        company: KTestVariables.fullCompanyModel,
        previousCompany: CompanyModel.empty,
      );

      verify(
        mockSharedPreferencesRepository.setString(
          key: CompanyCacheRepository.codeCacheKey,
          value: KTestVariables.fullCompanyModel.code!,
        ),
      ).called(1);
      verify(
        mockSharedPreferencesRepository.setString(
          key: CompanyCacheRepository.nameCacheKey,
          value: KTestVariables.fullCompanyModel.companyName!,
        ),
      ).called(1);
      verify(
        mockSharedPreferencesRepository.setString(
          key: CompanyCacheRepository.publicNameCacheKey,
          value: KTestVariables.fullCompanyModel.publicName!,
        ),
      ).called(1);
      verify(
        mockSharedPreferencesRepository.setString(
          key: CompanyCacheRepository.linkCacheKey,
          value: KTestVariables.fullCompanyModel.link!,
        ),
      ).called(1);
      verify(
        mockSharedPreferencesRepository.setStringList(
          key: CompanyCacheRepository.userEmailsCacheKey,
          value: KTestVariables.fullCompanyModel.userEmails,
        ),
      ).called(1);
    });

    test('Save To Cache Comapany', () async {
      companyCacheRepository.cleanCache();

      verify(
        mockSharedPreferencesRepository.remove(
          CompanyCacheRepository.codeCacheKey,
        ),
      ).called(1);
      verify(
        mockSharedPreferencesRepository.remove(
          CompanyCacheRepository.nameCacheKey,
        ),
      ).called(1);
      verify(
        mockSharedPreferencesRepository.remove(
          CompanyCacheRepository.publicNameCacheKey,
        ),
      ).called(1);
      verify(
        mockSharedPreferencesRepository.remove(
          CompanyCacheRepository.linkCacheKey,
        ),
      ).called(1);
      verify(
        mockSharedPreferencesRepository.remove(
          CompanyCacheRepository.userEmailsCacheKey,
        ),
      ).called(1);
    });
  });
}
