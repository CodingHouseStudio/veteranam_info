import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared.dart';

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
      KTest.testIsWeb = false;
      Config.value = Config.production;
      ExtendedDateTime.current = KTestText.dateTime;
      ExtendedDateTime.id = KTestText.feedbackModel.id;

      mockUrlRepository = MockIUrlRepository();
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
      when(mockUrlRepository.copy(KAppText.email)).thenAnswer(
        (invocation) async => const Right(true),
      );
    });

    testWidgets('${KGroupText.intial} ', (tester) async {
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
      testWidgets('${KGroupText.intial} ', (tester) async {
        when(mockUrlRepository.copy(KTestText.downloadURL)).thenAnswer(
          (invocation) async => const Right(true),
        );
        when(mockUrlRepository.copy(KAppText.email)).thenAnswer(
          (invocation) async => const Left(SomeFailure.copy()),
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
        testWidgets('Feedback box widget navigation', (tester) async {
          await feedbackPumpAppHelper(
            mockFeedbackRepository: mockFeedbackRepository,
            tester: tester,
            mockGoRouter: mockGoRouter,
            mockAppAuthenticationRepository: mockAppAuthenticationRepository,
            mockUrlRepository: mockUrlRepository,
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