import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/components/home/home.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/helpers.dart';
import '../test_mocks/test_mocks.dart';

void main() {
  group(KScreenName.home, () {
    testWidgets('renders initial', (tester) async {
      await tester.pumpApp(const HomeScreen());

      expect(find.byKey(KWidgetkeys.homeKeys.screen), findsOneWidget);

      await tester.pumpAndSettle();
      expect(find.byKey(KWidgetkeys.homeKeys.discountsButton), findsOneWidget);

      expect(
        find.byKey(KWidgetkeys.homeKeys.informationButton),
        findsOneWidget,
      );

      expect(find.byKey(KWidgetkeys.homeKeys.investorsButton), findsOneWidget);

      expect(find.byKey(KWidgetkeys.homeKeys.profileButton), findsOneWidget);

      expect(find.byKey(KWidgetkeys.homeKeys.storyButton), findsOneWidget);

      expect(find.byKey(KWidgetkeys.homeKeys.workButton), findsOneWidget);

      await questionHelper(
        tester,
      );
    });
    group('Mock Go Router', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('renders initial', (tester) async {
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const HomeScreen(),
          ),
        );

        expect(find.byKey(KWidgetkeys.homeKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();
        expect(
          find.byKey(KWidgetkeys.homeKeys.discountsButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.homeKeys.informationButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.homeKeys.investorsButton),
          findsOneWidget,
        );

        expect(find.byKey(KWidgetkeys.homeKeys.profileButton), findsOneWidget);

        expect(find.byKey(KWidgetkeys.homeKeys.storyButton), findsOneWidget);

        expect(find.byKey(KWidgetkeys.homeKeys.workButton), findsOneWidget);

        await questionHelper(
          tester,
        );
      });

      testWidgets('go to ${KScreenName.discounts}', (tester) async {
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const HomeScreen(),
          ),
        );

        expect(find.byKey(KWidgetkeys.homeKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.homeKeys.discountsButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWidgetkeys.homeKeys.discountsButton));

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
            child: const HomeScreen(),
          ),
        );

        expect(find.byKey(KWidgetkeys.homeKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.homeKeys.informationButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWidgetkeys.homeKeys.informationButton));

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
            child: const HomeScreen(),
          ),
        );

        expect(find.byKey(KWidgetkeys.homeKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.homeKeys.investorsButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWidgetkeys.homeKeys.investorsButton));

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
            child: const HomeScreen(),
          ),
        );

        expect(find.byKey(KWidgetkeys.homeKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.homeKeys.profileButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWidgetkeys.homeKeys.profileButton));

        verify(
          () => mockGoRouter.go(
            '${KRoute.home.path}${KRoute.profile.path}',
          ),
        ).called(1);
      });

      testWidgets('go to ${KScreenName.story}', (tester) async {
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const HomeScreen(),
          ),
        );

        expect(find.byKey(KWidgetkeys.homeKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.homeKeys.storyButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWidgetkeys.homeKeys.storyButton));

        verify(
          () => mockGoRouter.go(
            '${KRoute.home.path}${KRoute.story.path}',
          ),
        ).called(1);
      });

      testWidgets('go to ${KScreenName.work}', (tester) async {
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const HomeScreen(),
          ),
        );

        expect(find.byKey(KWidgetkeys.homeKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.homeKeys.workButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWidgetkeys.homeKeys.workButton));

        verify(
          () => mockGoRouter.go(
            '${KRoute.home.path}${KRoute.work.path}',
          ),
        ).called(1);
      });
    });
  });
}
