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
  group('${KScreenBlocName.feedback} ', () {
    late IFeedbackRepository mockFeedbackRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    setUp(() {
      ExtendedDateTime.current = KTestText.dateTime;
      ExtendedDateTime.id = KTestText.feedbackModel.id;

      mockFeedbackRepository = MockIFeedbackRepository();
      when(mockFeedbackRepository.sendFeedback(KTestText.feedbackModel))
          .thenAnswer(
        (invocation) async => const Right(true),
      );
      when(mockFeedbackRepository.checkUserNeedShowFeedback(KTestText.user.id))
          .thenAnswer(
        (invocation) async => const Right(true),
      );
      mockAppAuthenticationRepository = MockAppAuthenticationRepository();
      when(mockAppAuthenticationRepository.currentUserSetting).thenAnswer(
        (realInvocation) => UserSetting.empty,
      );
      when(mockAppAuthenticationRepository.currentUser).thenAnswer(
        (realInvocation) => KTestText.user,
      );
    });

    group('${KGroupText.failure} ', () {
      testWidgets('${KGroupText.error} ', (tester) async {
        when(mockFeedbackRepository.sendFeedback(KTestText.feedbackModel))
            .thenAnswer(
          (invocation) async => const Left(SomeFailure.serverError()),
        );
        await feedbackPumpAppHelper(
          mockFeedbackRepository: mockFeedbackRepository,
          tester: tester,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
        );

        await feedbackFailureHelper(tester);
      });
      testWidgets('${KGroupText.failureNetwork} ', (tester) async {
        when(mockFeedbackRepository.sendFeedback(KTestText.feedbackModel))
            .thenAnswer(
          (invocation) async => const Left(SomeFailure.network()),
        );
        await feedbackPumpAppHelper(
          mockFeedbackRepository: mockFeedbackRepository,
          tester: tester,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
        );

        await feedbackFailureHelper(tester);
      });
      testWidgets('${KGroupText.failureSend} ', (tester) async {
        when(mockFeedbackRepository.sendFeedback(KTestText.feedbackModel))
            .thenAnswer(
          (invocation) async => const Left(SomeFailure.send()),
        );
        await feedbackPumpAppHelper(
          mockFeedbackRepository: mockFeedbackRepository,
          tester: tester,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
        );

        await feedbackFailureHelper(tester);
      });
    });

    testWidgets('${KGroupText.intial} ', (tester) async {
      await feedbackPumpAppHelper(
        mockFeedbackRepository: mockFeedbackRepository,
        tester: tester,
        mockAppAuthenticationRepository: mockAppAuthenticationRepository,
      );

      await feedbackInitialHelper(tester);
    });

    testWidgets('Feedback enter correct text and save it', (tester) async {
      await feedbackPumpAppHelper(
        mockFeedbackRepository: mockFeedbackRepository,
        tester: tester,
        mockAppAuthenticationRepository: mockAppAuthenticationRepository,
      );

      await correctSaveHelper(tester);
    });

    testWidgets('Feedback enter incorrect text and save it', (tester) async {
      await feedbackPumpAppHelper(
        mockFeedbackRepository: mockFeedbackRepository,
        tester: tester,
        mockAppAuthenticationRepository: mockAppAuthenticationRepository,
      );

      await incorrectSaveHelper(tester);
    });

    // testWidgets('Feedback enter text and clear it', (tester) async {
    //   await feedbackPumpAppHelper(
    //     mockFeedbackRepository: mockFeedbackRepository,
    //     tester: tester,
    //     mockAppAuthenticationRepository: mockAppAuthenticationRepository,
    //   );

    //   await feedbackClearTextHelper(
    //     tester: tester,
    //     email: KTestText.userEmail,
    //     field: KTestText.field,
    //   );
    // });

    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.intial} ', (tester) async {
        await feedbackPumpAppHelper(
          mockFeedbackRepository: mockFeedbackRepository,
          tester: tester,
          mockGoRouter: mockGoRouter,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
        );

        await feedbackInitialHelper(tester);
      });
      group('${KGroupText.goTo} ', () {
        testWidgets('Feedback box widget navigation', (tester) async {
          await feedbackPumpAppHelper(
            mockFeedbackRepository: mockFeedbackRepository,
            tester: tester,
            mockGoRouter: mockGoRouter,
            mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          );

          await feedbackNavigationHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
      });
    });
  });
}
