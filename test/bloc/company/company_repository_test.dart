import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseException;
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

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
        (_) => KTestVariables.user,
      );
      when(
        mockCache.read<CompanyModel>(
          key: CompanyRepository.userCompanyCacheKey,
        ),
      ).thenAnswer(
        (_) => KTestVariables.pureCompanyModel,
      );
    });
    group('${KGroupText.successful} ', () {
      setUp(() {
        when(
          mockFirestoreService.updateCompany(
            KTestVariables.fullCompanyModel.copyWith(
              image: KTestVariables.imageModel,
            ),
          ),
        ).thenAnswer(
          (_) async {},
        );
        when(
          mockFirestoreService.updateCompany(
            KTestVariables.pureCompanyModel
                .copyWith(deletedOn: KTestVariables.dateTime),
          ),
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
            filePickerItem: KTestVariables.filePickerItem,
            id: KTestVariables.fullCompanyModel.id,
            collecltionName: FirebaseCollectionName.companies,
          ),
        ).thenAnswer(
          (_) async => KTestVariables.imageModel.downloadURL,
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
          appAuthenticationRepository: mockAppAuthenticationRepository,
          cache: mockCache,
          firestoreService: mockFirestoreService,
          storageService: mockStorageService,
        );
      });
      test('Update company with image', () async {
        expect(
          await companyRepository.updateCompany(
            company:
                KTestVariables.fullCompanyModel.copyWith(userEmails: const []),
            imageItem: KTestVariables.filePickerItem,
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
            KTestVariables.fullCompanyModel.copyWith(
              image: KTestVariables.imageModel,
            ),
          ),
        ).thenThrow(Exception(KGroupText.failureSend));
        when(
          mockFirestoreService.updateCompany(
            KTestVariables.pureCompanyModel
                .copyWith(deletedOn: KTestVariables.dateTime),
          ),
        ).thenThrow(Exception(KGroupText.failure));

        when(
          mockAppAuthenticationRepository.logOut(),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        );

        when(
          mockStorageService.saveFile(
            filePickerItem: KTestVariables.filePickerItem,
            id: KTestVariables.fullCompanyModel.id,
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
          appAuthenticationRepository: mockAppAuthenticationRepository,
          cache: mockCache,
          firestoreService: mockFirestoreService,
          storageService: mockStorageService,
        );
      });
      test('Update company with image', () async {
        expect(
          await companyRepository.updateCompany(
            company:
                KTestVariables.fullCompanyModel.copyWith(userEmails: const []),
            imageItem: KTestVariables.filePickerItem,
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
            KTestVariables.fullCompanyModel.copyWith(
              image: KTestVariables.imageModel,
            ),
          ),
        ).thenThrow(FirebaseException(plugin: KGroupText.failureSend));
        when(
          mockFirestoreService.updateCompany(
            KTestVariables.pureCompanyModel
                .copyWith(deletedOn: KTestVariables.dateTime),
          ),
        ).thenThrow(FirebaseException(plugin: KGroupText.failure));

        when(
          mockAppAuthenticationRepository.logOut(),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        );

        when(
          mockStorageService.saveFile(
            filePickerItem: KTestVariables.filePickerItem,
            id: KTestVariables.fullCompanyModel.id,
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
          appAuthenticationRepository: mockAppAuthenticationRepository,
          cache: mockCache,
          firestoreService: mockFirestoreService,
          storageService: mockStorageService,
        );
      });
      test('Update company with image', () async {
        expect(
          await companyRepository.updateCompany(
            company:
                KTestVariables.fullCompanyModel.copyWith(userEmails: const []),
            imageItem: KTestVariables.filePickerItem,
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
