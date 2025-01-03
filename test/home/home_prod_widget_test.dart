import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../test_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.home} ${KScreenBlocName.prod}', () {
    late UserRepository mockUserRepository;
    late IFaqRepository mockFaqRepository;
    late AuthenticationRepository mockAuthenticationRepository;
    late IUrlRepository mockUrlRepository;
    late AppInfoRepository mockBuildRepository;
    late FirebaseRemoteConfigProvider mockFirebaseRemoteConfigProvider;
    setUp(() {
      Config.falvourValue = Config.production;
      ExtendedDateTime.current = KTestVariables.dateTime;
      ExtendedDateTime.id = KTestVariables.feedbackModel.id;
      mockFaqRepository = MockIFaqRepository();
      mockUserRepository = MockUserRepository();
      mockUrlRepository = MockIUrlRepository();
      mockBuildRepository = MockAppInfoRepository();
      mockFirebaseRemoteConfigProvider = MockFirebaseRemoteConfigProvider();
      mockAuthenticationRepository = MockAuthenticationRepository();

      when(mockAuthenticationRepository.currectAuthenticationStatus).thenAnswer(
        (realInvocation) => AuthenticationStatus.anonymous,
      );

      when(mockUserRepository.currentUser).thenAnswer(
        (realInvocation) => User.empty,
      );
      when(mockUserRepository.currentUserSetting).thenAnswer(
        (realInvocation) => UserSetting.empty,
      );
      // when(mockUserRepository.isAnonymously).thenAnswer(
      //   (realInvocation) => true,
      // );
      when(mockFaqRepository.getQuestions()).thenAnswer(
        (invocation) async => Right(KTestVariables.questionModelItems),
      );
      when(mockUrlRepository.copy(KAppText.email)).thenAnswer(
        (invocation) async => const Right(true),
      );
      when(mockBuildRepository.getBuildInfo()).thenAnswer(
        (invocation) async => AppInfoRepository.defaultValue,
      );
      when(
        mockFirebaseRemoteConfigProvider
            .getString(AppVersionCubit.mobAppVersionKey),
      ).thenAnswer(
        (_) => KTestVariables.build,
      );
    });

    testWidgets('${KGroupText.initial} ', (tester) async {
      await homePumpAppHelper(
        // mockFeedbackRepository: mockFeedbackRepository,
        mockFaqRepository: mockFaqRepository,
        mockUserRepository: mockUserRepository,
        tester: tester,
        mockBuildRepository: mockBuildRepository,
        mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
        mockUrlRepository: mockUrlRepository,
        mockAuthencticationRepository: mockAuthenticationRepository,
        // mockAppAuthenticationRepository:
        // mockAppAuthenticationRepository,
      );

      await homeInitialHelper(tester);
    });

    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.initial} ', (tester) async {
        await homePumpAppHelper(
          // mockFeedbackRepository: mockFeedbackRepository,
          mockFaqRepository: mockFaqRepository,
          mockUserRepository: mockUserRepository,
          tester: tester,
          mockBuildRepository: mockBuildRepository, mockGoRouter: mockGoRouter,
          mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
          mockUrlRepository: mockUrlRepository,
          mockAuthencticationRepository: mockAuthenticationRepository,
          // mockAppAuthenticationRepository:
          // mockAppAuthenticationRepository,
        );

        await homeInitialHelper(tester);
      });
      group('${KGroupText.goTo} ', () {
        testWidgets('nawbar navigation widget', (tester) async {
          await homePumpAppHelper(
            // mockFeedbackRepository: mockFeedbackRepository,
            mockFaqRepository: mockFaqRepository,
            mockUserRepository: mockUserRepository,
            tester: tester,
            mockBuildRepository: mockBuildRepository,
            mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
            mockGoRouter: mockGoRouter,
            mockAuthencticationRepository: mockAuthenticationRepository,
            mockUrlRepository: mockUrlRepository,
            // mockAppAuthenticationRepository:
            // mockAppAuthenticationRepository,
          );

          await nawbarProdNavigationHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
        // group('${Config.business} ', () {
        //   setUp(
        //     () {
        //       when(mockAuthenticationRepository.currectAuthenticationStatus)
        //           .thenAnswer(
        //         (realInvocation) => AuthenticationStatus.authenticated,
        //       );
        //       when(mockUserRepository.user).thenAnswer(
        //         (realInvocation) => Stream.value(KTestText.userWithoutPhoto),
        //       );
        //       Config.roleValue = Config.business;
        //     },
        //   );
        //   testWidgets('${KRoute.profile.name} ', (tester) async {
        //     await homePumpAppHelper(
        //       // mockFeedbackRepository: mockFeedbackRepository,
        //       mockFaqRepository: mockFaqRepository,
        //       mockUserRepository: mockUserRepository,
        //       mockBuildRepository: mockBuildRepository, tester: tester,
        //       mockFirebaseRemoteConfigProvider:
        //           mockFirebaseRemoteConfigProvider,
        //       mockGoRouter: mockGoRouter,
        //       mockAuthencticationRepository: mockAuthenticationRepository,
        //       mockUrlRepository: mockUrlRepository,
        //       // mockAppAuthenticationRepository:
        //       // mockAppAuthenticationRepository,
        //     );

        //     await homeChangeWindowSizeHelper(
        //       tester: tester,
        //       test: () async => nawbarBusinessNavigationHelper(
        //         tester: tester,
        //         mockGoRouter: mockGoRouter,
        //       ),
        //     );
        //   });
        //   testWidgets('${KRoute.company.name} ', (tester) async {
        //     await homePumpAppHelper(
        //       // mockFeedbackRepository: mockFeedbackRepository,
        //       mockFaqRepository: mockFaqRepository,
        //       mockUserRepository: mockUserRepository,
        //       mockBuildRepository: mockBuildRepository, tester: tester,
        //       mockFirebaseRemoteConfigProvider:
        //           mockFirebaseRemoteConfigProvider,
        //       mockGoRouter: mockGoRouter,
        //       mockAuthencticationRepository: mockAuthenticationRepository,
        //       mockUrlRepository: mockUrlRepository,
        //       // mockAppAuthenticationRepository:
        //       // mockAppAuthenticationRepository,
        //     );

        //     await nawbarBusinessProfileNavigationHelper(
        //       tester: tester,
        //       mockGoRouter: mockGoRouter,
        //     );
        //   });
        // });
      });
    });
  });
}
