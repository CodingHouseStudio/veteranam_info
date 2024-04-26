import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../bloc/authentication_bloc_unit_test.dart';
import '../text_dependency.dart';
import 'home_widget/home_widget.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.home} ', () {
    late AuthenticationRepository mockAuthenticationRepository;
    late IHomeRepository mockHomeRepository;
    late HomeWatcherBloc homeBloc;
    late AuthenticationBloc authenticationBloc;
    late IFeedbackRepository mockFeedbackRepository;
    late FeedbackBloc feedbackBloc;
    setUp(() {
      ExtendedDateTime.customTime = KTestText.feedbackModel.timestamp;
      mockAuthenticationRepository = MockAuthenticationRepositoryUnitTest();
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
    void registerAuthenticationBloc() {
      authenticationBloc = AuthenticationBloc(
        authenticationRepository: mockAuthenticationRepository,
      );
      if (GetIt.I.isRegistered<AuthenticationBloc>()) {
        GetIt.I.unregister<AuthenticationBloc>();
      }
      GetIt.I.registerSingleton<AuthenticationBloc>(authenticationBloc);
    }

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
      registerAuthenticationBloc();
      registerHomeBloc();
      await tester.pumpApp(
        const HomeScreen(),
      );

      expect(find.byKey(KWidgetkeys.screen.home.screen), findsOneWidget);

      await tester.pumpAndSettle();

      await nawbarHelper(
        tester: tester,
        searchText: KTestText.field,
        hasMic: false,
      );

      await homeBoxHelper(tester);

      await listQuestionHelper(tester);

      await footerHelper(tester);
    });

    testWidgets('Feedback enter correct text and save it', (tester) async {
      registerHomeBloc();
      registerFeedbackBloc();
      await tester.pumpApp(
        const HomeScreen(),
      );

      expect(find.byKey(KWidgetkeys.screen.home.screen), findsOneWidget);

      await tester.pumpAndSettle();

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown,
      );

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingUp200,
      );

      await feedbackEnterTextHelper(
        tester: tester,
        email: KTestText.useremail,
        field: KTestText.field,
      );

      await feedbackBoxHelper(tester);
    });

    testWidgets('Feedback enter incorrect text and save it', (tester) async {
      registerHomeBloc();
      await tester.pumpApp(
        const HomeScreen(),
      );

      expect(find.byKey(KWidgetkeys.screen.home.screen), findsOneWidget);

      await tester.pumpAndSettle();

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown,
      );

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingUp200,
      );

      await feedbackEnterTextHelper(
        tester: tester,
        email: KTestText.useremailIncorrect,
        field: KTestText.field,
      );

      await feedbackHelper(tester);
    });

    testWidgets('Feedback enter text and clear it', (tester) async {
      registerHomeBloc();
      registerFeedbackBloc();
      await tester.pumpApp(const HomeScreen());
      await tester.pumpApp(
        const HomeScreen(),
      );
      expect(find.byKey(KWidgetkeys.screen.home.screen), findsOneWidget);

      await tester.pumpAndSettle();

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown,
      );

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingUp200,
      );

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
        registerAuthenticationBloc();
        registerHomeBloc();
        await tester.pumpApp(
          const HomeScreen(),
          mockGoRouter: mockGoRouter,
        );

        expect(find.byKey(KWidgetkeys.screen.home.screen), findsOneWidget);

        await tester.pumpAndSettle();

        await nawbarHelper(
          tester: tester,
          searchText: KTestText.field,
          hasMic: false,
        );

        await homeBoxHelper(tester);

        await listQuestionHelper(tester);

        await footerHelper(tester);
      });

      group('${KGroupText.goTo} ', () {
        testWidgets('nawbar widget navigation', (tester) async {
          registerHomeBloc();
          await tester.pumpApp(
            const HomeScreen(),
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

          await nawbarLoginNavigationHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });

        testWidgets('box widget navigation', (tester) async {
          registerHomeBloc();
          await tester.pumpApp(
            const HomeScreen(),
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
