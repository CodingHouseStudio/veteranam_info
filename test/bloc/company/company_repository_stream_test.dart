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
    late StreamController<CompanyModel> companyStreamController;
    late StreamController<User> userStreamController;

    setUp(() {
      companyStreamController = StreamController<CompanyModel>()
        ..add(KTestVariables.pureCompanyModel);
      userStreamController = StreamController<User>()..add(KTestVariables.user);

      mockFirestoreService = MockFirestoreService();
      mockCache = MockCacheClient();
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
      mockStorageService = MockStorageService();
      when(
        mockFirestoreService.getUserCompany(KTestVariables.user.email!),
      ).thenAnswer(
        (_) => companyStreamController.stream,
      );
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
      when(
        mockCache.read<CompanyModel>(
          key: CompanyRepository.userCompanyCacheKey,
        ),
      ).thenAnswer(
        (_) => KTestVariables.pureCompanyModel,
      );
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();

      when(mockAppAuthenticationRepository.user).thenAnswer(
        (_) => userStreamController.stream,
      );
      when(mockAppAuthenticationRepository.isAnonymously).thenAnswer(
        (_) => false,
      );

      when(
        mockAppAuthenticationRepository
            .createFcmUserSettingAndRemoveDeletePameter(),
      ).thenAnswer(
        (_) async => const Right(true),
      );

      companyRepository = CompanyRepository(
        appAuthenticationRepository: mockAppAuthenticationRepository,
        cache: mockCache,
        firestoreService: mockFirestoreService,
        storageService: mockStorageService,
      );
    });

    group('User Changed', () {
      setUp(() async {
        when(
          mockCache.read<CompanyModel>(
            key: CompanyRepository.userCompanyCacheKey,
          ),
        ).thenAnswer(
          (_) => KTestVariables.pureCompanyModel
              .copyWith(userEmails: [], deletedOn: KTestVariables.dateTime),
        );
        Timer(const Duration(milliseconds: 30), () async {
          await companyStreamController.close();
          companyStreamController = StreamController<CompanyModel>()
            ..add(KTestVariables.fullCompanyModel);
          userStreamController.add(
            KTestVariables.profileUserWithoutPhoto,
          );
        });
      });
      test('user ${KGroupText.stream}', () async {
        final stream = companyRepository.company.asBroadcastStream();
        await expectLater(
          stream,
          emitsInOrder(
            [KTestVariables.pureCompanyModel],
          ),
        );

        await stream.first;
      });
    });

    group('User empty', () {
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
}
