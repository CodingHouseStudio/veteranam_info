import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/components/home/home.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/helpers.dart';
import '../test_mocks/test_mocks.dart';

void main() {
  group(ScreenName.home, () {
    testWidgets('renders initial', (tester) async {
      await tester.pumpApp(const HomeScreen());

      expect(find.byKey(KWIdgetkeys.homeKeys.screen), findsOneWidget);

      await tester.pumpAndSettle();
      expect(find.byKey(KWIdgetkeys.homeKeys.discountsButton), findsOneWidget);

      expect(
        find.byKey(KWIdgetkeys.homeKeys.informationButton),
        findsOneWidget,
      );

      expect(find.byKey(KWIdgetkeys.homeKeys.investorsButton), findsOneWidget);

      expect(find.byKey(KWIdgetkeys.homeKeys.profileButton), findsOneWidget);

      expect(find.byKey(KWIdgetkeys.homeKeys.storyButton), findsOneWidget);

      expect(find.byKey(KWIdgetkeys.homeKeys.workButton), findsOneWidget);
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

        expect(find.byKey(KWIdgetkeys.homeKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();
        expect(
          find.byKey(KWIdgetkeys.homeKeys.discountsButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWIdgetkeys.homeKeys.informationButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWIdgetkeys.homeKeys.investorsButton),
          findsOneWidget,
        );

        expect(find.byKey(KWIdgetkeys.homeKeys.profileButton), findsOneWidget);

        expect(find.byKey(KWIdgetkeys.homeKeys.storyButton), findsOneWidget);

        expect(find.byKey(KWIdgetkeys.homeKeys.workButton), findsOneWidget);
      });

      testWidgets('go to ${ScreenName.discounts}', (tester) async {
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const HomeScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.homeKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWIdgetkeys.homeKeys.discountsButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWIdgetkeys.homeKeys.discountsButton));

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
            child: const HomeScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.homeKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWIdgetkeys.homeKeys.informationButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWIdgetkeys.homeKeys.informationButton));

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
            child: const HomeScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.homeKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWIdgetkeys.homeKeys.investorsButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWIdgetkeys.homeKeys.investorsButton));

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
            child: const HomeScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.homeKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWIdgetkeys.homeKeys.profileButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWIdgetkeys.homeKeys.profileButton));

        verify(
          () => mockGoRouter.go(
            '${KRouteStatic.home.path}${KRouteStatic.profile.path}',
          ),
        ).called(1);
      });

      testWidgets('go to ${ScreenName.story}', (tester) async {
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const HomeScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.homeKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWIdgetkeys.homeKeys.storyButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWIdgetkeys.homeKeys.storyButton));

        verify(
          () => mockGoRouter.go(
            '${KRouteStatic.home.path}${KRouteStatic.story.path}',
          ),
        ).called(1);
      });

      testWidgets('go to ${ScreenName.work}', (tester) async {
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const HomeScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.homeKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWIdgetkeys.homeKeys.workButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWIdgetkeys.homeKeys.workButton));

        verify(
          () => mockGoRouter.go(
            '${KRouteStatic.home.path}${KRouteStatic.work.path}',
          ),
        ).called(1);
      });
    });
  });
}
