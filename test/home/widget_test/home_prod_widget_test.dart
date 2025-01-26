import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';
import '../helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.home} ${KScreenBlocName.prod}', () {
    setUp(() {
      Config.falvourValue = Config.production;
      homeWidgetTestRegister();

      when(mockFaqRepository.getQuestions()).thenAnswer(
        (invocation) async => Right(KTestVariables.questionModelItems),
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
      await homePumpAppHelper(tester);

      await homeInitialHelper(tester);
    });

    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.initial} ', (tester) async {
        await homePumpAppHelper(tester);

        await homeInitialHelper(tester);
      });
      group('${KGroupText.goTo} ', () {
        testWidgets('nawbar navigation widget', (tester) async {
          await homePumpAppHelper(
            tester,
            mockGoRouter: mockGoRouter,
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
        //         (realInvocation) => Stream.value(KTestVariables
        // .userWithoutPhoto),
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
