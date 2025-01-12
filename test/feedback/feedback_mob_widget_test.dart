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
  group('${KScreenBlocName.feedback} ', () {
    late IFeedbackRepository mockFeedbackRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    late IUrlRepository mockUrlRepository;
    setUp(() {
      Config.testIsWeb = false;
      Config.falvourValue = Config.production;
      ExtendedDateTime.current = KTestVariables.dateTime;
      ExtendedDateTime.id = KTestVariables.feedbackModel.id;

      mockUrlRepository = MockIUrlRepository();
      mockFeedbackRepository = MockIFeedbackRepository();
      when(mockFeedbackRepository.sendFeedback(KTestVariables.feedbackModel))
          .thenAnswer(
        (invocation) async => const Right(true),
      );
      when(
        mockFeedbackRepository
            .checkUserNeedShowFeedback(KTestVariables.user.id),
      ).thenAnswer(
        (invocation) async => const Right(true),
      );
      mockAppAuthenticationRepository = MockAppAuthenticationRepository();
      when(mockAppAuthenticationRepository.currentUserSetting).thenAnswer(
        (realInvocation) => UserSetting.empty,
      );
      when(mockAppAuthenticationRepository.currentUser).thenAnswer(
        (realInvocation) => KTestVariables.user,
      );
      when(mockUrlRepository.copy(KAppText.email)).thenAnswer(
        (invocation) async => const Right(true),
      );
    });

    testWidgets('${KGroupText.initial} ', (tester) async {
      await feedbackPumpAppHelper(
        mockFeedbackRepository: mockFeedbackRepository,
        tester: tester,
        mockAppAuthenticationRepository: mockAppAuthenticationRepository,
        mockUrlRepository: mockUrlRepository,
      );

      await feedbackInitialHelper(tester);
    });

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
          mockFeedbackRepository: mockFeedbackRepository,
          tester: tester,
          mockGoRouter: mockGoRouter,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockUrlRepository: mockUrlRepository,
        );

        await feedbackInitialHelper(tester);
      });
      group('${KGroupText.goTo} ', () {
        testWidgets('nawbar back button pop() navigation', (tester) async {
          await feedbackPumpAppHelper(
            mockFeedbackRepository: mockFeedbackRepository,
            tester: tester,
            mockGoRouter: mockGoRouter,
            mockAppAuthenticationRepository: mockAppAuthenticationRepository,
            mockUrlRepository: mockUrlRepository,
          );
          // TODO(test): change
          // await nawbarBackButtonHelper(
          //   tester: tester,
          //   mockGoRouter: mockGoRouter,
          // );
        });
      });
    });
  });
}
