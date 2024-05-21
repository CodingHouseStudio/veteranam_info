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
  group('${KScreenBlocName.investors} ', () {
    late IInvestorsRepository mockInvestorsRepository;
    late IFeedbackRepository mockFeedbackRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    setUp(() {
      ExtendedDateTime.current = KTestText.dateTime;
      ExtendedDateTime.id = KTestText.feedbackModel.id;
      mockInvestorsRepository = MockIInvestorsRepository();
      when(mockInvestorsRepository.getFunds()).thenAnswer(
        (invocation) async => Right(KTestText.fundItems),
      );

      mockFeedbackRepository = MockIFeedbackRepository();
      when(mockFeedbackRepository.sendFeedback(KTestText.feedbackModel))
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
      when(
        mockAppAuthenticationRepository.updateUserSetting(
          UserSetting.empty.copyWith(timeSendingFeedback: KTestText.dateTime),
        ),
      ).thenAnswer(
        (invocation) async => const Right(true),
      );
    });

    testWidgets('${KGroupText.intial} ', (tester) async {
      await investorsPumpAppHelper(
        mockFeedbackRepository: mockFeedbackRepository,
        mockInvestorsRepository: mockInvestorsRepository,
        tester: tester,
        mockAppAuthenticationRepository: mockAppAuthenticationRepository,
      );

      await investorsInitialHelper(tester);
    });

    testWidgets('Feedback enter correct text and save it', (tester) async {
      await investorsPumpAppHelper(
        mockFeedbackRepository: mockFeedbackRepository,
        mockInvestorsRepository: mockInvestorsRepository,
        tester: tester,
        mockAppAuthenticationRepository: mockAppAuthenticationRepository,
      );

      await correctSaveHelper(tester);
    });

    testWidgets('Feedback enter incorrect text and save it', (tester) async {
      await investorsPumpAppHelper(
        mockFeedbackRepository: mockFeedbackRepository,
        mockInvestorsRepository: mockInvestorsRepository,
        tester: tester,
        mockAppAuthenticationRepository: mockAppAuthenticationRepository,
      );

      await incorrectSaveHelper(tester);
    });

    testWidgets('Feedback enter text and clear it', (tester) async {
      await investorsPumpAppHelper(
        mockFeedbackRepository: mockFeedbackRepository,
        mockInvestorsRepository: mockInvestorsRepository,
        tester: tester,
        mockAppAuthenticationRepository: mockAppAuthenticationRepository,
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
        await investorsPumpAppHelper(
          mockFeedbackRepository: mockFeedbackRepository,
          mockInvestorsRepository: mockInvestorsRepository,
          tester: tester,
          mockGoRouter: mockGoRouter,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
        );

        await investorsInitialHelper(tester);
      });
      group('${KGroupText.goTo} ', () {
        testWidgets('Feedback box widget navigation', (tester) async {
          await investorsPumpAppHelper(
            mockFeedbackRepository: mockFeedbackRepository,
            mockInvestorsRepository: mockInvestorsRepository,
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
