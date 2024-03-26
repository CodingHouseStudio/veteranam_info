import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/components/story/story.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/helpers.dart';
import '../test_mocks/test_mocks.dart';

void main() {
  group(ScreenName.story, () {
    testWidgets('renders initial', (tester) async {
      await tester.pumpApp(const StoryScreen());

      expect(find.byKey(KWIdgetkeys.storyKeys.screen), findsOneWidget);

      await tester.pumpAndSettle();
      expect(find.byKey(KWIdgetkeys.storyKeys.discountsButton), findsOneWidget);

      expect(
        find.byKey(KWIdgetkeys.storyKeys.informationButton),
        findsOneWidget,
      );

      expect(find.byKey(KWIdgetkeys.storyKeys.investorsButton), findsOneWidget);

      expect(find.byKey(KWIdgetkeys.storyKeys.profileButton), findsOneWidget);

      expect(find.byKey(KWIdgetkeys.storyKeys.workButton), findsOneWidget);
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

        expect(find.byKey(KWIdgetkeys.storyKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();
        expect(
          find.byKey(KWIdgetkeys.storyKeys.discountsButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWIdgetkeys.storyKeys.informationButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWIdgetkeys.storyKeys.investorsButton),
          findsOneWidget,
        );

        expect(find.byKey(KWIdgetkeys.storyKeys.profileButton), findsOneWidget);

        expect(find.byKey(KWIdgetkeys.storyKeys.workButton), findsOneWidget);
      });

      testWidgets('go to ${ScreenName.discounts}', (tester) async {
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const StoryScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.storyKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWIdgetkeys.storyKeys.discountsButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWIdgetkeys.storyKeys.discountsButton));

        verify(
          () => mockGoRouter.go(
            '${KRouteStatic.home.path}${KRouteStatic.discounts.path}',
          ),
        ).called(1);
      });

      testWidgets('go to ${ScreenName.information}', (tester) async {
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const StoryScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.storyKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWIdgetkeys.storyKeys.informationButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWIdgetkeys.storyKeys.informationButton));

        verify(
          () => mockGoRouter.go(
            '${KRouteStatic.home.path}${KRouteStatic.information.path}',
          ),
        ).called(1);
      });

      testWidgets('go to ${ScreenName.investors}', (tester) async {
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const StoryScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.storyKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWIdgetkeys.storyKeys.investorsButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWIdgetkeys.storyKeys.investorsButton));

        verify(
          () => mockGoRouter.go(
            '${KRouteStatic.home.path}${KRouteStatic.investors.path}',
          ),
        ).called(1);
      });

      testWidgets('go to ${ScreenName.profile}', (tester) async {
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const StoryScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.storyKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWIdgetkeys.storyKeys.profileButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWIdgetkeys.storyKeys.profileButton));

        verify(
          () => mockGoRouter.go(
            '${KRouteStatic.home.path}${KRouteStatic.profile.path}',
          ),
        ).called(1);
      });

      testWidgets('go to ${ScreenName.work}', (tester) async {
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const StoryScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.storyKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWIdgetkeys.storyKeys.workButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWIdgetkeys.storyKeys.workButton));

        verify(
          () => mockGoRouter.go(
            '${KRouteStatic.home.path}${KRouteStatic.work.path}',
          ),
        ).called(1);
      });
    });
  });
}
