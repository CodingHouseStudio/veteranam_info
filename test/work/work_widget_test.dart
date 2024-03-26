import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/components/work/work.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/helpers.dart';
import '../test_mocks/test_mocks.dart';

void main() {
  group(ScreenName.work, () {
    testWidgets('renders initial', (tester) async {
      await tester.pumpApp(const WorkScreen());

      expect(find.byKey(KWIdgetkeys.workKeys.screen), findsOneWidget);

      await tester.pumpAndSettle();
      expect(find.byKey(KWIdgetkeys.workKeys.discountsButton), findsOneWidget);

      expect(
        find.byKey(KWIdgetkeys.workKeys.informationButton),
        findsOneWidget,
      );

      expect(find.byKey(KWIdgetkeys.workKeys.investorsButton), findsOneWidget);

      expect(find.byKey(KWIdgetkeys.workKeys.profileButton), findsOneWidget);

      expect(find.byKey(KWIdgetkeys.workKeys.storyButton), findsOneWidget);
    });
    group('Mock Go Router', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('renders initial', (tester) async {
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const WorkScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.workKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();
        expect(
          find.byKey(KWIdgetkeys.workKeys.discountsButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWIdgetkeys.workKeys.informationButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWIdgetkeys.workKeys.investorsButton),
          findsOneWidget,
        );

        expect(find.byKey(KWIdgetkeys.workKeys.profileButton), findsOneWidget);

        expect(find.byKey(KWIdgetkeys.workKeys.storyButton), findsOneWidget);
      });

      testWidgets('go to ${ScreenName.discounts}', (tester) async {
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const WorkScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.workKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWIdgetkeys.workKeys.discountsButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWIdgetkeys.workKeys.discountsButton));

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
            child: const WorkScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.workKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWIdgetkeys.workKeys.informationButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWIdgetkeys.workKeys.informationButton));

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
            child: const WorkScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.workKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWIdgetkeys.workKeys.investorsButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWIdgetkeys.workKeys.investorsButton));

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
            child: const WorkScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.workKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWIdgetkeys.workKeys.profileButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWIdgetkeys.workKeys.profileButton));

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
            child: const WorkScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.workKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWIdgetkeys.workKeys.storyButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWIdgetkeys.workKeys.storyButton));

        verify(
          () => mockGoRouter.go(
            '${KRouteStatic.home.path}${KRouteStatic.story.path}',
          ),
        ).called(1);
      });
    });
  });
}
