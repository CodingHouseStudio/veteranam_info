import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../text_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.home} ', () {
    late AuthenticationRepository mockAuthenticationRepository;
    late IHomeRepository mockHomeRepository;
    late IFeedbackRepository mockFeedbackRepository;
    setUp(() {
      ExtendedDateTime.current = KTestText.dateTime;
      ExtendedDateTime.id = KTestText.feedbackModel.id;
      mockAuthenticationRepository = MockAuthenticationRepository();
      when(mockAuthenticationRepository.currentUser).thenAnswer(
        (realInvocation) => User.empty,
      );
      when(mockAuthenticationRepository.getUserSetting()).thenAnswer(
        (realInvocation) async => UserSetting.empty,
      );
      mockHomeRepository = MockIHomeRepository();
      when(mockHomeRepository.getQuestions()).thenAnswer(
        (invocation) async => Right(KTestText.questionModelItems),
      );
      mockFeedbackRepository = MockIFeedbackRepository();
      when(mockFeedbackRepository.sendFeedback(KTestText.feedbackModel))
          .thenAnswer(
        (invocation) async => const Right(true),
      );
    });

    testWidgets('${KGroupText.intial} ', (tester) async {
      await homePumpAppHelper(
        mockFeedbackRepository: mockFeedbackRepository,
        mockHomeRepository: mockHomeRepository,
        mockAuthenticationRepository: mockAuthenticationRepository,
        tester: tester,
      );

      await homeInitialHelper(tester);
    });

    testWidgets('Feedback enter correct text and save it', (tester) async {
      await homePumpAppHelper(
        mockFeedbackRepository: mockFeedbackRepository,
        mockHomeRepository: mockHomeRepository,
        mockAuthenticationRepository: mockAuthenticationRepository,
        tester: tester,
      );

      await correctSaveHelper(tester);
    });

    testWidgets('Feedback enter incorrect text and save it', (tester) async {
      await homePumpAppHelper(
        mockFeedbackRepository: mockFeedbackRepository,
        mockHomeRepository: mockHomeRepository,
        mockAuthenticationRepository: mockAuthenticationRepository,
        tester: tester,
      );

      await incorrectSaveHelper(tester);
    });

    testWidgets('Feedback enter text and clear it', (tester) async {
      await homePumpAppHelper(
        mockFeedbackRepository: mockFeedbackRepository,
        mockHomeRepository: mockHomeRepository,
        mockAuthenticationRepository: mockAuthenticationRepository,
        tester: tester,
      );

      await feedbackClearTextHelper(
        tester: tester,
        email: KTestText.userEmail,
        field: KTestText.field,
      );
    });

    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.intial} ', (tester) async {
        await homePumpAppHelper(
          mockFeedbackRepository: mockFeedbackRepository,
          mockHomeRepository: mockHomeRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
          tester: tester,
          mockGoRouter: mockGoRouter,
        );

        await homeInitialHelper(tester);
      });

      group('${KGroupText.goTo} ', () {
        testWidgets('nawbar widget navigation', (tester) async {
          await homePumpAppHelper(
            mockFeedbackRepository: mockFeedbackRepository,
            mockHomeRepository: mockHomeRepository,
            mockAuthenticationRepository: mockAuthenticationRepository,
            tester: tester,
            mockGoRouter: mockGoRouter,
          );

          await navbarNavigationHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });

        testWidgets('box widget navigation', (tester) async {
          await homePumpAppHelper(
            mockFeedbackRepository: mockFeedbackRepository,
            mockHomeRepository: mockHomeRepository,
            mockAuthenticationRepository: mockAuthenticationRepository,
            tester: tester,
            mockGoRouter: mockGoRouter,
          );

          await boxexHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });

        testWidgets('Feedback box widget navigation', (tester) async {
          await homePumpAppHelper(
            mockFeedbackRepository: mockFeedbackRepository,
            mockHomeRepository: mockHomeRepository,
            mockAuthenticationRepository: mockAuthenticationRepository,
            tester: tester,
            mockGoRouter: mockGoRouter,
          );

          await feedbackNavigationHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
        testWidgets('All footer widget navigation', (tester) async {
          await homePumpAppHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
            mockAuthenticationRepository: mockAuthenticationRepository,
            mockFeedbackRepository: mockFeedbackRepository,
            mockHomeRepository: mockHomeRepository,
          );

          await footerButtonsHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
      });
    });
  });
}
