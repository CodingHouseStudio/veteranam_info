import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import 'package:veteranam/shared/shared_dart.dart';
import '../../test_dependency.dart';
import '../helper/helper.dart';

void main() {
  setUpAll(configureDependenciesTest);

  setUp(resetTestVariables);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.feedback} ', () {
    setUp(feedbackWidgetTestRegister);

    group('${KGroupText.failure} ', () {
      testWidgets('${KGroupText.error} ', (tester) async {
        when(mockFeedbackRepository.sendFeedback(KTestVariables.feedbackModel))
            .thenAnswer(
          (invocation) async => const Left(
            SomeFailure.serverError,
          ),
        );
        await feedbackPumpAppHelper(
          tester,
        );

        await feedbackFailureHelper(tester);
      });
      testWidgets('${KGroupText.failureNetwork} ', (tester) async {
        when(mockFeedbackRepository.sendFeedback(KTestVariables.feedbackModel))
            .thenAnswer(
          (invocation) async => const Left(SomeFailure.network),
        );
        await feedbackPumpAppHelper(
          tester,
        );

        await feedbackFailureHelper(tester);
      });
      testWidgets('${KGroupText.failureSend} ', (tester) async {
        when(mockFeedbackRepository.sendFeedback(KTestVariables.feedbackModel))
            .thenAnswer(
          (invocation) async => const Left(SomeFailure.send),
        );
        await feedbackPumpAppHelper(
          tester,
        );

        await feedbackFailureHelper(tester);
      });
    });

    testWidgets('${KGroupText.initial} ', (tester) async {
      await feedbackPumpAppHelper(
        tester,
      );

      await feedbackInitialHelper(tester);
    });

    testWidgets('Feedback enter correct text and save it', (tester) async {
      await feedbackPumpAppHelper(
        tester,
      );

      await correctSaveHelper(tester);
    });

    testWidgets('Feedback enter incorrect text and save it', (tester) async {
      await feedbackPumpAppHelper(
        tester,
      );

      await incorrectSaveHelper(tester);
    });

    testWidgets('Email tap', (tester) async {
      await feedbackPumpAppHelper(
        tester,
      );

      await feedbackEmailTapHelper(tester);
    });

    // testWidgets('Feedback enter text and clear it', (tester) async {
    //   await feedbackPumpAppHelper(
    //     mockFeedbackRepository: mockFeedbackRepository,
    //     tester: tester,
    //     mockAppAuthenticationRepository: mockAppAuthenticationRepository,
    //   );

    //   await feedbackClearTextHelper(
    //     tester: tester,
    //     email: KTestVariables.userEmail,
    //     field: KTestVariables.field,
    //   );
    // });

    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.initial} ', (tester) async {
        when(mockUrlRepository.copy(KTestVariables.downloadURL)).thenAnswer(
          (invocation) async => const Right(true),
        );
        when(mockUrlRepository.copy(KAppText.email)).thenAnswer(
          (invocation) async => const Left(SomeFailure.copy),
        );
        await feedbackPumpAppHelper(
          tester,
          mockGoRouter: mockGoRouter,
        );

        await feedbackInitialHelper(tester);
      });
      group('${KGroupText.goTo} ', () {
        testWidgets('Feedback box widget navigation', (tester) async {
          await feedbackPumpAppHelper(
            tester,
            mockGoRouter: mockGoRouter,
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
