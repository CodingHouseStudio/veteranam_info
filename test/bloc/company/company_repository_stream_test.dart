import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);

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
        ..add(KTestText.pureCompanyModel);
      userStreamController = StreamController<User>()..add(KTestText.user);

      mockFirestoreService = MockFirestoreService();
      mockCache = MockCacheClient();
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
      mockStorageService = MockStorageService();
      when(
        mockFirestoreService.getUserCompany(KTestText.user.email!),
      ).thenAnswer(
        (_) => companyStreamController.stream,
      );
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
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();

      when(mockAppAuthenticationRepository.user).thenAnswer(
        (_) => userStreamController.stream,
      );
      when(mockAppAuthenticationRepository.isAnonymously).thenAnswer(
        (_) => false,
      );

      when(mockAppAuthenticationRepository.createFcmUserSetting()).thenAnswer(
        (_) async => const Right(true),
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

    group('User Changed', () {
      setUp(() async {
        when(
          mockCache.read<CompanyModel>(
            key: CompanyRepository.userCompanyCacheKey,
          ),
        ).thenAnswer(
          (_) => KTestText.pureCompanyModel.copyWith(userEmails: []),
        );
        Timer(const Duration(milliseconds: 30), () async {
          await companyStreamController.close();
          companyStreamController = StreamController<CompanyModel>()
            ..add(KTestText.fullCompanyModel);
          userStreamController.add(
            KTestText.profileUserWithoutPhoto,
          );
        });
      });
      test('user ${KGroupText.stream}', () async {
        final stream = companyRepository.company.asBroadcastStream();
        await expectLater(
          stream,
          emitsInOrder(
            [KTestText.pureCompanyModel],
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
            [KTestText.pureCompanyModel],
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
