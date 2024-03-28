import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/story/story.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  setUp(configureDependenciesTest);

  tearDown(GetIt.I.reset);
  group(KScreenName.story, () {
    testWidgets('renders initial', (tester) async {
      await tester.pumpApp(const StoryScreen());

      expect(find.byKey(KWidgetkeys.storyKeys.screen), findsOneWidget);

      await tester.pumpAndSettle();
      expect(find.byKey(KWidgetkeys.storyKeys.discountsButton), findsOneWidget);

      expect(
        find.byKey(KWidgetkeys.storyKeys.informationButton),
        findsOneWidget,
      );

      expect(find.byKey(KWidgetkeys.storyKeys.investorsButton), findsOneWidget);

      expect(find.byKey(KWidgetkeys.storyKeys.profileButton), findsOneWidget);

      expect(find.byKey(KWidgetkeys.storyKeys.workButton), findsOneWidget);
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
        expect(
          find.byKey(KWidgetkeys.storyKeys.discountsButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.storyKeys.informationButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.storyKeys.investorsButton),
          findsOneWidget,
        );

        expect(find.byKey(KWidgetkeys.storyKeys.profileButton), findsOneWidget);

        expect(find.byKey(KWidgetkeys.storyKeys.workButton), findsOneWidget);
      });

      testWidgets('go to ${KScreenName.discounts}', (tester) async {
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const StoryScreen(),
          ),
        );

        expect(find.byKey(KWidgetkeys.storyKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.storyKeys.discountsButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWidgetkeys.storyKeys.discountsButton));

        verify(
          () => mockGoRouter.go(
            '${KRoute.home.path}${KRoute.discounts.path}',
          ),
        ).called(1);
      });

      testWidgets('go to ${KScreenName.information}', (tester) async {
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const StoryScreen(),
          ),
        );

        expect(find.byKey(KWidgetkeys.storyKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.storyKeys.informationButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWidgetkeys.storyKeys.informationButton));

        verify(
          () => mockGoRouter.go(
            '${KRoute.home.path}${KRoute.information.path}',
          ),
        ).called(1);
      });

      testWidgets('go to ${KScreenName.investors}', (tester) async {
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const StoryScreen(),
          ),
        );

        expect(find.byKey(KWidgetkeys.storyKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.storyKeys.investorsButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWidgetkeys.storyKeys.investorsButton));

        verify(
          () => mockGoRouter.go(
            '${KRoute.home.path}${KRoute.investors.path}',
          ),
        ).called(1);
      });

      testWidgets('go to ${KScreenName.profile}', (tester) async {
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const StoryScreen(),
          ),
        );

        expect(find.byKey(KWidgetkeys.storyKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.storyKeys.profileButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWidgetkeys.storyKeys.profileButton));

        verify(
          () => mockGoRouter.go(
            '${KRoute.home.path}${KRoute.profile.path}',
          ),
        ).called(1);
      });

      testWidgets('go to ${KScreenName.work}', (tester) async {
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const StoryScreen(),
          ),
        );

        expect(find.byKey(KWidgetkeys.storyKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.storyKeys.workButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWidgetkeys.storyKeys.workButton));

        verify(
          () => mockGoRouter.go(
            '${KRoute.home.path}${KRoute.work.path}',
          ),
        ).called(1);
      });
    });
  });
}
