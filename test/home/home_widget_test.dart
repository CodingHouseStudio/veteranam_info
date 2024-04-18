import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../text_dependency.dart';
import 'home_widget/boxes_helper.dart';
import 'home_widget/home_widget.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.home} ', () {
    late IHomeRepository mockHomeRepository;
    late HomeWatcherBloc homeBloc;
    late IFeedbackRepository mockFeedbackRepository;
    late FeedbackBloc feedbackBloc;
    setUp(() {
      ExtendedDateTime.customTime = KTestText.feedbackModel.timestamp;
      mockHomeRepository = MockIHomeRepository();
      when(mockHomeRepository.getQuestions()).thenAnswer(
        (invocation) async => const Right(KTestText.questionModelItems),
      );
      mockFeedbackRepository = MockIFeedbackRepository();
      when(mockFeedbackRepository.sendFeedback(KTestText.feedbackModel))
          .thenAnswer(
        (invocation) async => const Right(true),
      );
    });
    void registerHomeBloc() {
      homeBloc = HomeWatcherBloc(homeRepository: mockHomeRepository);
      if (GetIt.I.isRegistered<HomeWatcherBloc>()) {
        GetIt.I.unregister<HomeWatcherBloc>();
      }
      GetIt.I.registerSingleton<HomeWatcherBloc>(homeBloc);
    }

    void registerFeedbackBloc() {
      feedbackBloc = FeedbackBloc(feedbackRepository: mockFeedbackRepository);
      if (GetIt.I.isRegistered<FeedbackBloc>()) {
        GetIt.I.unregister<FeedbackBloc>();
      }
      GetIt.I.registerSingleton<FeedbackBloc>(feedbackBloc);
    }

    testWidgets('${KGroupText.intial} ', (tester) async {
      registerHomeBloc();
      await tester.pumpApp(const HomeScreen(), isHome: true);

      expect(find.byKey(KWidgetkeys.screen.home.screen), findsOneWidget);

      await tester.pumpAndSettle();

      await homeBoxHelper(tester);

      await listQuestionHelper(tester);
    });

    testWidgets('Feedback enter correct text and save it', (tester) async {
      registerHomeBloc();
      registerFeedbackBloc();
      await tester.pumpApp(const HomeScreen(), isHome: true);

      expect(find.byKey(KWidgetkeys.screen.home.screen), findsOneWidget);

      await tester.pumpAndSettle();

      await feedbackEnterTextHelper(
        tester: tester,
        email: KTestText.useremail,
        field: KTestText.field,
      );

      await feedbackHelper(tester: tester, isSuccess: true);
    });

    testWidgets('Feedback enter incorrect text and save it', (tester) async {
      registerHomeBloc();
      await tester.pumpApp(const HomeScreen(), isHome: true);

      expect(find.byKey(KWidgetkeys.screen.home.screen), findsOneWidget);

      await tester.pumpAndSettle();

      await feedbackEnterTextHelper(
        tester: tester,
        email: KTestText.useremailIncorrect,
        field: KTestText.field,
      );

      await feedbackHelper(tester: tester);
    });

    testWidgets('Feedback enter text and clear it', (tester) async {
      registerHomeBloc();
      registerFeedbackBloc();
      await tester.pumpApp(const HomeScreen(), isHome: true);

      expect(find.byKey(KWidgetkeys.screen.home.screen), findsOneWidget);

      await tester.pumpAndSettle();

      await feedbackClearTextHelper(
        tester: tester,
        email: KTestText.useremail,
        field: KTestText.field,
      );
    });

    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.intial} ', (tester) async {
        registerHomeBloc();
        await tester.pumpApp(
          const HomeScreen(),
          isHome: true,
          mockGoRouter: mockGoRouter,
        );

        expect(find.byKey(KWidgetkeys.screen.home.screen), findsOneWidget);

        await tester.pumpAndSettle();

        await listQuestionHelper(tester);
      });

      group('${KGroupText.goTo} ', () {
        testWidgets('nawbar widget navigation', (tester) async {
          registerHomeBloc();
          await tester.pumpApp(
            const HomeScreen(),
            isHome: true,
            mockGoRouter: mockGoRouter,
          );

          expect(
            find.byKey(KWidgetkeys.screen.home.screen),
            findsOneWidget,
          );

          await tester.pumpAndSettle();

          await nawbarTitleHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });

        testWidgets('box widget navigation', (tester) async {
          registerHomeBloc();
          await tester.pumpApp(
            const HomeScreen(),
            isHome: true,
            mockGoRouter: mockGoRouter,
          );

          expect(find.byKey(KWidgetkeys.screen.home.screen), findsOneWidget);

          await tester.pumpAndSettle();

          await boxexHelper(
            tester: tester,
            routes: KTestText.boxRoutes,
            mockGoRouter: mockGoRouter,
          );
        });
      });
    });
  });
}
