import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../text_dependency.dart';
import 'investors_widget/investors_widget.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.investors} ', () {
    late IInvestorsRepository mockInvestorsRepository;
    late InvestorsWatcherBloc investorsBloc;
    late IFeedbackRepository mockFeedbackRepository;
    late FeedbackBloc feedbackBloc;
    setUp(() {
      ExtendedDateTime.customTime = KTestText.feedbackModel.timestamp;
      mockInvestorsRepository = MockIInvestorsRepository();
      when(mockInvestorsRepository.getFunds()).thenAnswer(
        (invocation) async => const Right(KTestText.fundItems),
      );

      mockFeedbackRepository = MockIFeedbackRepository();
      when(mockFeedbackRepository.sendFeedback(KTestText.feedbackModel))
          .thenAnswer(
        (invocation) async => const Right(true),
      );
    });
    void registerInvestorsBloc() {
      investorsBloc =
          InvestorsWatcherBloc(investorsRepository: mockInvestorsRepository);
      if (GetIt.I.isRegistered<InvestorsWatcherBloc>()) {
        GetIt.I.unregister<InvestorsWatcherBloc>();
      }
      GetIt.I.registerSingleton<InvestorsWatcherBloc>(investorsBloc);
    }

    void registerFeedbackBloc() {
      feedbackBloc = FeedbackBloc(feedbackRepository: mockFeedbackRepository);
      if (GetIt.I.isRegistered<FeedbackBloc>()) {
        GetIt.I.unregister<FeedbackBloc>();
      }
      GetIt.I.registerSingleton<FeedbackBloc>(feedbackBloc);
    }

    testWidgets('${KGroupText.intial} ', (tester) async {
      registerInvestorsBloc();
      await tester.pumpApp(const InvestorsScreen());

      expect(
        find.byKey(KWidgetkeys.screen.investors.screen),
        findsOneWidget,
      );

      await tester.pumpAndSettle();

      await feedbackHelper(tester);

      await donatesCardHelper(tester);
    });

    testWidgets('Feedback enter correct text and save it', (tester) async {
      registerInvestorsBloc();
      registerFeedbackBloc();
      await tester.pumpApp(const InvestorsScreen());

      expect(
        find.byKey(KWidgetkeys.screen.investors.screen),
        findsOneWidget,
      );

      await tester.pumpAndSettle();

      await feedbackEnterTextHelper(
        tester: tester,
        email: KTestText.userEmail,
        field: KTestText.field,
      );

      await scrollingHelper(tester: tester, offset: KTestConstants.scrollingUp);

      await feedbackBoxHelper(tester);
    });

    testWidgets('Feedback enter incorrect text and save it', (tester) async {
      registerInvestorsBloc();
      await tester.pumpApp(const InvestorsScreen());

      expect(
        find.byKey(KWidgetkeys.screen.investors.screen),
        findsOneWidget,
      );

      await tester.pumpAndSettle();

      await feedbackEnterTextHelper(
        tester: tester,
        email: KTestText.useremailIncorrect,
        field: KTestText.field,
      );

      await scrollingHelper(tester: tester, offset: KTestConstants.scrollingUp);

      await feedbackHelper(tester);
    });

    testWidgets('Feedback enter text and clear it', (tester) async {
      registerInvestorsBloc();
      registerFeedbackBloc();
      await tester.pumpApp(const InvestorsScreen());

      expect(
        find.byKey(KWidgetkeys.screen.investors.screen),
        findsOneWidget,
      );

      await tester.pumpAndSettle();

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
        registerInvestorsBloc();
        registerInvestorsBloc();
        await tester.pumpApp(
          const InvestorsScreen(),
          mockGoRouter: mockGoRouter,
        );

        expect(
          find.byKey(KWidgetkeys.screen.investors.screen),
          findsOneWidget,
        );

        await tester.pumpAndSettle();

        await feedbackHelper(tester);

        await donatesCardHelper(tester);
      });
      group('${KGroupText.goTo} ', () {
        testWidgets('All footer widget navigation', (tester) async {
          registerInvestorsBloc();
          registerFeedbackBloc();
          await tester.pumpApp(
            const InvestorsScreen(),
            mockGoRouter: mockGoRouter,
          );

          expect(
            find.byKey(KWidgetkeys.screen.investors.screen),
            findsOneWidget,
          );

          await tester.pumpAndSettle();

          await footerButtonsHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });

        testWidgets('Feedback box widget navigation', (tester) async {
          registerInvestorsBloc();
          registerFeedbackBloc();
          await tester.pumpApp(
            const InvestorsScreen(),
            mockGoRouter: mockGoRouter,
          );

          expect(
            find.byKey(KWidgetkeys.screen.investors.screen),
            findsOneWidget,
          );

          await tester.pumpAndSettle();

          await feedbackEnterTextHelper(
            tester: tester,
            email: KTestText.userEmail,
            field: KTestText.field,
          );

          await feedbackBoxNavigationHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
      });
    });
  });
}
