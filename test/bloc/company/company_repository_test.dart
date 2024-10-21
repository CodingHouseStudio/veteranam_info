import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseException;
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  tearDown(GetIt.I.reset);

  group('${KScreenBlocName.company} ${KGroupText.repository} ', () {
    late ICompanyRepository companyRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    late CacheClient mockCache;
    late FirestoreService mockFirestoreService;
    late StorageService mockStorageService;
    setUp(() {
      mockFirestoreService = MockFirestoreService();
      mockCache = MockCacheClient();
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
      mockStorageService = MockStorageService();
      when(
        mockAppAuthenticationRepository.currentUser,
      ).thenAnswer(
        (_) => KTestText.user,
      );
      when(
        mockCache.read<CompanyModel>(
          key: CompanyRepository.userCompanyCacheKey,
        ),
      ).thenAnswer(
        (_) => KTestText.pureCompanyModel,
      );
    });
    group('${KGroupText.successful} ', () {
      setUp(() {
        when(
          mockFirestoreService.updateCompany(
            KTestText.fullCompanyModel.copyWith(
              image: KTestText.imageModel,
            ),
          ),
        ).thenAnswer(
          (_) async {},
        );
        when(
          mockFirestoreService.deleteCompany(KTestText.pureCompanyModel.id),
        ).thenAnswer(
          (_) async {},
        );

        when(
          mockAppAuthenticationRepository.logOut(),
        ).thenAnswer(
          (_) async => const Right(true),
        );

        when(
          mockStorageService.saveFile(
            imagePickerItem: KTestText.imagePickerItem,
            id: KTestText.fullCompanyModel.id,
            collecltionName: FirebaseCollectionName.companies,
          ),
        ).thenAnswer(
          (_) async => KTestText.imageModel.downloadURL,
        );
        if (GetIt.I.isRegistered<FirestoreService>()) {
          GetIt.I.unregister<FirestoreService>();
        }
        GetIt.I.registerSingleton(mockFirestoreService);

        if (GetIt.I.isRegistered<StorageService>()) {
          GetIt.I.unregister<StorageService>();
        }
        GetIt.I.registerSingleton(mockStorageService);
        companyRepository = CompanyRepository(
          mockAppAuthenticationRepository,
          mockCache,
        );
      });
      test('Update company with image', () async {
        expect(
          await companyRepository.updateCompany(
            company: KTestText.fullCompanyModel.copyWith(userEmails: const []),
            imageItem: KTestText.imagePickerItem,
          ),
          isA<Right<SomeFailure, bool>>()
              .having((e) => e.value, 'value', isTrue),
        );
      });
      test('Delete company', () async {
        expect(
          await companyRepository.deleteCompany(),
          isA<Right<SomeFailure, bool>>()
              .having((e) => e.value, 'value', isTrue),
        );
      });
    });
    group('${KGroupText.failure} ', () {
      setUp(() {
        when(
          mockFirestoreService.updateCompany(
            KTestText.fullCompanyModel.copyWith(
              image: KTestText.imageModel,
            ),
          ),
        ).thenThrow(Exception(KGroupText.failureSend));
        when(
          mockFirestoreService.deleteCompany(KTestText.pureCompanyModel.id),
        ).thenThrow(Exception(KGroupText.failure));

        when(
          mockAppAuthenticationRepository.logOut(),
        ).thenAnswer(
          (_) async => Left(SomeFailure.serverError(error: null)),
        );

        when(
          mockStorageService.saveFile(
            imagePickerItem: KTestText.imagePickerItem,
            id: KTestText.fullCompanyModel.id,
            collecltionName: FirebaseCollectionName.companies,
          ),
        ).thenThrow(Exception(KGroupText.failureSend));
        if (GetIt.I.isRegistered<FirestoreService>()) {
          GetIt.I.unregister<FirestoreService>();
        }
        GetIt.I.registerSingleton(mockFirestoreService);

        if (GetIt.I.isRegistered<StorageService>()) {
          GetIt.I.unregister<StorageService>();
        }
        GetIt.I.registerSingleton(mockStorageService);
        companyRepository = CompanyRepository(
          mockAppAuthenticationRepository,
          mockCache,
        );
      });
      test('Update company with image', () async {
        expect(
          await companyRepository.updateCompany(
            company: KTestText.fullCompanyModel.copyWith(userEmails: const []),
            imageItem: KTestText.imagePickerItem,
          ),
          isA<Left<SomeFailure, bool>>(),
        );
      });
      test('Delete company', () async {
        expect(
          await companyRepository.deleteCompany(),
          isA<Left<SomeFailure, bool>>(),
        );
      });
    });
    group('${KGroupText.firebaseFailure} ', () {
      setUp(() {
        when(
          mockFirestoreService.updateCompany(
            KTestText.fullCompanyModel.copyWith(
              image: KTestText.imageModel,
            ),
          ),
        ).thenThrow(FirebaseException(plugin: KGroupText.failureSend));
        when(
          mockFirestoreService.deleteCompany(KTestText.pureCompanyModel.id),
        ).thenThrow(FirebaseException(plugin: KGroupText.failure));

        when(
          mockAppAuthenticationRepository.logOut(),
        ).thenAnswer(
          (_) async => Left(SomeFailure.serverError(error: null)),
        );

        when(
          mockStorageService.saveFile(
            imagePickerItem: KTestText.imagePickerItem,
            id: KTestText.fullCompanyModel.id,
            collecltionName: FirebaseCollectionName.companies,
          ),
        ).thenThrow(FirebaseException(plugin: KGroupText.failureSend));
        if (GetIt.I.isRegistered<FirestoreService>()) {
          GetIt.I.unregister<FirestoreService>();
        }
        GetIt.I.registerSingleton(mockFirestoreService);

        if (GetIt.I.isRegistered<StorageService>()) {
          GetIt.I.unregister<StorageService>();
        }
        GetIt.I.registerSingleton(mockStorageService);
        companyRepository = CompanyRepository(
          mockAppAuthenticationRepository,
          mockCache,
        );
      });
      test('Update company with image', () async {
        expect(
          await companyRepository.updateCompany(
            company: KTestText.fullCompanyModel.copyWith(userEmails: const []),
            imageItem: KTestText.imagePickerItem,
          ),
          isA<Left<SomeFailure, bool>>(),
        );
      });
      test('Delete company', () async {
        expect(
          await companyRepository.deleteCompany(),
          isA<Left<SomeFailure, bool>>(),
        );
      });
    });

    tearDown(() {
      companyRepository.dispose();
    });
  });
}
