import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared.dart';

import '../text_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.home} PROD', () {
    late AuthenticationRepository mockAuthenticationRepository;
    late IHomeRepository mockHomeRepository;
    setUp(() {
      Config.value = Config.production;
      ExtendedDateTime.current = KTestText.dateTime;
      ExtendedDateTime.id = KTestText.feedbackModel.id;
      mockHomeRepository = MockIHomeRepository();
      mockAuthenticationRepository = MockAuthenticationRepository();

      when(mockAuthenticationRepository.currentUser).thenAnswer(
        (realInvocation) => User.empty,
      );
      when(mockAuthenticationRepository.currentUserSetting).thenAnswer(
        (realInvocation) => UserSetting.empty,
      );
      when(mockAuthenticationRepository.isAnonymouslyOrEmty()).thenAnswer(
        (realInvocation) => true,
      );
      when(mockHomeRepository.getQuestions()).thenAnswer(
        (invocation) async => Right(KTestText.questionModelItems),
      );
    });

    testWidgets('${KGroupText.intial} ', (tester) async {
      await homePumpAppHelper(
        // mockFeedbackRepository: mockFeedbackRepository,
        mockHomeRepository: mockHomeRepository,
        mockAuthenticationRepository: mockAuthenticationRepository,
        tester: tester,
        // mockAppAuthenticationRepository:
        // mockAppAuthenticationRepository,
      );

      await homeInitialHelper(tester);
    });

    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.intial} ', (tester) async {
        await homePumpAppHelper(
          // mockFeedbackRepository: mockFeedbackRepository,
          mockHomeRepository: mockHomeRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
          tester: tester,
          mockGoRouter: mockGoRouter,
          // mockAppAuthenticationRepository:
          // mockAppAuthenticationRepository,
        );

        await homeInitialHelper(tester);
      });
      group('${KGroupText.goTo} ', () {
        testWidgets('nawbar navigation widget', (tester) async {
          await homePumpAppHelper(
            // mockFeedbackRepository: mockFeedbackRepository,
            mockHomeRepository: mockHomeRepository,
            mockAuthenticationRepository: mockAuthenticationRepository,
            tester: tester,
            mockGoRouter: mockGoRouter,
            // mockAppAuthenticationRepository:
            // mockAppAuthenticationRepository,
          );

          await nawbarProdNavigationHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
      });
    });
  });
}
