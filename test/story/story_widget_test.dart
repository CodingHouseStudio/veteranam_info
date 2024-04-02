import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

import '../text_dependency.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group(KScreenName.story, () {
    testWidgets('renders initial', (tester) async {
      await tester.pumpApp(const StoryScreen());

      expect(find.byKey(KWidgetkeys.storyKeys.screen), findsOneWidget);

      await tester.pumpAndSettle();

      await storyCardHelper(tester);

      // await footerHelper(tester: tester, email: KTestText.useremail);
    });
    group('Mock Go Router', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('renders initial', (tester) async {
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const StoryScreen(),
          ),
        );

        expect(find.byKey(KWidgetkeys.storyKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        await storyCardHelper(tester);

        await footerHelper(tester: tester, email: KTestText.useremail);
      });
      group('go to', () {
        testWidgets(KScreenName.information, (tester) async {
          await tester.pumpApp(
            MockGoRouterProvider(
              goRouter: mockGoRouter,
              child: const StoryScreen(),
            ),
          );

          expect(find.byKey(KWidgetkeys.storyKeys.screen), findsOneWidget);

          await tester.pumpAndSettle();

          await footerInformationRoutHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });

        testWidgets(KScreenName.investors, (tester) async {
          await tester.pumpApp(
            MockGoRouterProvider(
              goRouter: mockGoRouter,
              child: const StoryScreen(),
            ),
          );

          expect(find.byKey(KWidgetkeys.storyKeys.screen), findsOneWidget);

          await tester.pumpAndSettle();

          await footerInvestorsRoutHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });

        testWidgets(KScreenName.profile, (tester) async {
          await tester.pumpApp(
            MockGoRouterProvider(
              goRouter: mockGoRouter,
              child: const StoryScreen(),
            ),
          );

          expect(find.byKey(KWidgetkeys.storyKeys.screen), findsOneWidget);

          await tester.pumpAndSettle();

          await footerProfileRoutHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });

        testWidgets(KScreenName.story, (tester) async {
          await tester.pumpApp(
            MockGoRouterProvider(
              goRouter: mockGoRouter,
              child: const StoryScreen(),
            ),
          );

          expect(find.byKey(KWidgetkeys.storyKeys.screen), findsOneWidget);

          await tester.pumpAndSettle();

          await footerStoryRoutHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });

        testWidgets(KScreenName.work, (tester) async {
          await tester.pumpApp(
            MockGoRouterProvider(
              goRouter: mockGoRouter,
              child: const StoryScreen(),
            ),
          );

          expect(find.byKey(KWidgetkeys.storyKeys.screen), findsOneWidget);

          await tester.pumpAndSettle();

          await footerWorkRoutHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });

        testWidgets(KScreenName.discounts, (tester) async {
          await tester.pumpApp(
            MockGoRouterProvider(
              goRouter: mockGoRouter,
              child: const StoryScreen(),
            ),
          );

          expect(find.byKey(KWidgetkeys.storyKeys.screen), findsOneWidget);

          await tester.pumpAndSettle();

          await footerDiscountsRoutHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
      });
    });
  });
}
