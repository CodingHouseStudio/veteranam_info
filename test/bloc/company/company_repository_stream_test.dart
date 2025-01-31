import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  setupFirebaseAuthMocks();

  tearDownAll(GetIt.I.reset);

  group(
      '${KScreenBlocName.authentication} ${KGroupText.repository} '
      '${KGroupText.stream}', () {
    late ICompanyRepository companyRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    late CacheClient mockCache;
    late FirestoreService mockFirestoreService;
    late StorageService mockStorageService;
    late ISharedPrefencesRepository mockSharedPrefencesRepository;

    setUp(() {
      mockFirestoreService = MockFirestoreService();
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
      mockStorageService = MockStorageService();
      mockSharedPrefencesRepository = MockISharedPrefencesRepository();

      when(
        mockFirestoreService.updateCompany(
          KTestVariables.pureCompanyModel.copyWith(userEmails: []),
        ),
      ).thenAnswer(
        (_) async {},
      );
      when(
        mockAppAuthenticationRepository.currentUser,
      ).thenAnswer(
        (_) => KTestVariables.user,
      );
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();

      when(mockAppAuthenticationRepository.isAnonymously).thenAnswer(
        (_) => false,
      );

      when(
        mockAppAuthenticationRepository
            .createFcmUserSettingAndRemoveDeletePameter(),
      ).thenAnswer(
        (_) async => const Right(true),
      );
    });
    group('Stream', () {
      late StreamController<CompanyModel> companyStreamController;
      late StreamController<User> userStreamController;
      setUp(() {
        mockCache = MockCacheClient();

        companyStreamController = StreamController<CompanyModel>()
          ..add(KTestVariables.pureCompanyModel);
        userStreamController = StreamController<User>()
          ..add(KTestVariables.user);

        when(mockAppAuthenticationRepository.user).thenAnswer(
          (_) => userStreamController.stream,
        );

        when(
          mockFirestoreService.getUserCompany(KTestVariables.user.email!),
        ).thenAnswer(
          (_) => companyStreamController.stream,
        );

        when(
          mockCache.read<CompanyModel>(
            key: CompanyRepository.userCompanyCacheKey,
          ),
        ).thenAnswer(
          (_) => KTestVariables.pureCompanyModel,
        );

        when(
          mockSharedPrefencesRepository.initWait(),
        ).thenAnswer(
          (_) async => true,
        );

        companyRepository = CompanyRepository(
          appAuthenticationRepository: mockAppAuthenticationRepository,
          cache: mockCache,
          firestoreService: mockFirestoreService,
          storageService: mockStorageService,
          sharedPrefencesRepository: mockSharedPrefencesRepository,
        );
      });
      group('Company Changed', () {
        late Timer timer;
        setUp(() async {
          when(
            mockCache.read<CompanyModel>(
              key: CompanyRepository.userCompanyCacheKey,
            ),
          ).thenAnswer(
            (_) => KTestVariables.pureCompanyModel
                .copyWith(userEmails: [], deletedOn: KTestVariables.dateTime),
          );
          timer = Timer(const Duration(milliseconds: 30), () async {
            await companyStreamController.close();
            companyStreamController = StreamController<CompanyModel>()
              ..add(KTestVariables.fullCompanyModel);
            userStreamController.add(
              KTestVariables.profileUserWithoutPhoto,
            );
          });
        });
        test('Company ${KGroupText.stream}', () async {
          final stream = companyRepository.company.asBroadcastStream();
          await expectLater(
            stream,
            emitsInOrder([
              KTestVariables.pureCompanyModel,
              KTestVariables.fullCompanyModel,
            ]),
          );
        });
        tearDown(
          () => timer.cancel(),
        );
      });

      group('Company empty', () {
        setUp(() => userStreamController.add(User.empty));
        test('company ${KGroupText.stream}', () async {
          await expectLater(
            companyRepository.company,
            emitsInOrder(
              [KTestVariables.pureCompanyModel],
            ),
          );
        });
      });

      tearDown(() async {
        await userStreamController.close();
        await companyStreamController.close();
        companyRepository.dispose();
      });
    });

    group('Shared Preferences Cache', () {
      setUp(() {
        mockCache = CacheClient();

        when(
          mockSharedPrefencesRepository.initWait(),
        ).thenAnswer(
          (_) async {
            await KTestConstants.delay;
            return true;
          },
        );

        when(
          mockSharedPrefencesRepository
              .getString(CompanyRepository.userCompanyCodeCacheKey),
        ).thenAnswer(
          (_) => KTestVariables.fullCompanyModel.code,
        );

        when(
          mockSharedPrefencesRepository
              .getString(CompanyRepository.userCompanyLinkCacheKey),
        ).thenAnswer(
          (_) => KTestVariables.fullCompanyModel.link,
        );

        when(
          mockSharedPrefencesRepository
              .getString(CompanyRepository.userCompanyNameCacheKey),
        ).thenAnswer(
          (_) => KTestVariables.fullCompanyModel.companyName,
        );

        when(
          mockSharedPrefencesRepository
              .getString(CompanyRepository.userCompanyPublicNameCacheKey),
        ).thenAnswer(
          (_) => KTestVariables.fullCompanyModel.publicName,
        );

        when(
          mockSharedPrefencesRepository
              .getStringList(CompanyRepository.userCompanyUserEmailsCacheKey),
        ).thenAnswer(
          (_) => KTestVariables.fullCompanyModel.userEmails,
        );

        companyRepository = CompanyRepository(
          appAuthenticationRepository: mockAppAuthenticationRepository,
          cache: mockCache,
          firestoreService: mockFirestoreService,
          storageService: mockStorageService,
          sharedPrefencesRepository: mockSharedPrefencesRepository,
        );
      });
      test('Get Company From shared Preferences', () async {
        await expectLater(
          companyRepository.company,
          emitsInOrder(
            [
              KTestVariables.fullCompanyModel.copyWith(
                id: CompanyRepository.companySharedPreferencesId,
              ),
            ],
          ),
        );
      });
    });
  });
}
