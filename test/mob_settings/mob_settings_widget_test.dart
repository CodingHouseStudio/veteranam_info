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
  group('${KScreenBlocName.mobSettings} ', () {
    late IFeedbackRepository mockFeedbackRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    late UserRepository mockUserRepository;
    // late BuildRepository mockBuildRepository;
    setUp(() {
      Config.testIsWeb = false;
      ExtendedDateTime.id = KTestVariables.id;
      ExtendedDateTime.current = KTestVariables.dateTime;

      mockFeedbackRepository = MockIFeedbackRepository();
      mockAppAuthenticationRepository = MockAppAuthenticationRepository();
      mockUserRepository = MockUserRepository();
      // mockBuildRepository = MockBuildRepository();

      when(
        mockAppAuthenticationRepository.currentUser,
      ).thenAnswer((realInvocation) => KTestVariables.user);
      // when(mockBuildRepository.getBuildInfo()).thenAnswer(
      //   (invocation) async => BuildRepository.defaultValue,
      // );

      // when(
      //   mockFeedbackRepository.sendMobFeedback(
      //     feedback: FeedbackModel(
      //       id: KTestText.id,
      //       message: KTestText.field,
      //       guestId: KTestText.user.id,
      //       guestName: null,
      //       email: null,
      //       timestamp: KTestText.dateTime,
      //     ),
      //     image: Uint8List(1),
      //   ),
      // ).thenAnswer(
      //   (realInvocation) async => const Right(true),
      // );

      when(mockUserRepository.currentUser).thenAnswer(
        (realInvocation) => User.empty,
      );
      when(mockUserRepository.currentUserSetting).thenAnswer(
        (realInvocation) => UserSetting.empty,
      );
      when(
        mockUserRepository.updateUserSetting(
          userSetting: UserSetting.empty.copyWith(locale: Language.english),
        ),
      ).thenAnswer(
        (invocation) async => const Right(true),
      );
      when(
        mockUserRepository.updateUserSetting(
          userSetting: UserSetting.empty.copyWith(locale: Language.ukrain),
        ),
      ).thenAnswer(
        (invocation) async => const Right(true),
      );
    });
    testWidgets('${KGroupText.initial} ', (tester) async {
      await mobSettingsPumpAppHelper(
        tester: tester,
        mockFeedbackRepository: mockFeedbackRepository,
        // mockBuildRepository: mockBuildRepository,
        mockAppAuthenticationRepository: mockAppAuthenticationRepository,
        mockUserRepository: mockUserRepository,
      );

      await mobSettingsInitialHelper(tester);
    });
    testWidgets('Mobile feedback wrong enter text', (tester) async {
      await mobSettingsPumpAppHelper(
        tester: tester,
        mockFeedbackRepository: mockFeedbackRepository,
        // mockBuildRepository: mockBuildRepository,
        mockAppAuthenticationRepository: mockAppAuthenticationRepository,
        mockUserRepository: mockUserRepository,
      );

      await mobFeedbackOpenHelper(
        test: mobFeedbackWrongTextHelper,
        tester: tester,
      );
    });

    testWidgets('${KGroupText.offlineNetwork} ', (tester) async {
      await networkMobHelper(
        tester: tester,
        pumpApp: () async => mobSettingsPumpAppHelper(
          //mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          // mockInvestorsRepository: mockInvestorsRepository,
          mockFeedbackRepository: mockFeedbackRepository,
          //mockBuildRepository: mockBuildRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockUserRepository: mockUserRepository,
          tester: tester,
        ),
      );
    });
    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.initial} ', (tester) async {
        await mobSettingsPumpAppHelper(
          tester: tester,
          mockFeedbackRepository: mockFeedbackRepository,
          // mockBuildRepository: mockBuildRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockGoRouter: mockGoRouter,
          mockUserRepository: mockUserRepository,
        );

        await mobSettingsInitialHelper(tester);
      });
      testWidgets('Mobile feedback correct enter text', (tester) async {
        await mobSettingsPumpAppHelper(
          tester: tester,
          mockFeedbackRepository: mockFeedbackRepository,
          // mockBuildRepository: mockBuildRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockGoRouter: mockGoRouter,
          mockUserRepository: mockUserRepository,
        );

        await mobFeedbackOpenHelper(
          test: mobFeedbackCorrectTextHelper,
          tester: tester,
        );
      });
      group('${KGroupText.goTo} ', () {
        testWidgets('${KRoute.feedback.name} ', (tester) async {
          await mobSettingsPumpAppHelper(
            tester: tester,
            mockFeedbackRepository: mockFeedbackRepository,
            // mockBuildRepository: mockBuildRepository,
            mockAppAuthenticationRepository: mockAppAuthenticationRepository,
            mockGoRouter: mockGoRouter,
            mockUserRepository: mockUserRepository,
          );

          await mobSettingsFeedbackHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });

        testWidgets('${KRoute.mobFAQ.name} ', (tester) async {
          await mobSettingsPumpAppHelper(
            tester: tester,
            mockFeedbackRepository: mockFeedbackRepository,
            // mockBuildRepository: mockBuildRepository,
            mockAppAuthenticationRepository: mockAppAuthenticationRepository,
            mockGoRouter: mockGoRouter,
            mockUserRepository: mockUserRepository,
          );

          await mobFaqNavigationHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });

        testWidgets('${KRoute.privacyPolicy.name} ', (tester) async {
          await mobSettingsPumpAppHelper(
            tester: tester,
            mockFeedbackRepository: mockFeedbackRepository,
            // mockBuildRepository: mockBuildRepository,
            mockAppAuthenticationRepository: mockAppAuthenticationRepository,
            mockGoRouter: mockGoRouter,
            mockUserRepository: mockUserRepository,
          );

          await privacyPolicyNavigationHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
      });
    });
  });
}
