import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/components/discounts/discounts.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/helpers.dart';
import '../test_mocks/test_mocks.dart';

void main() {
  group(ScreenName.discounts, () {
    testWidgets('renders initial', (tester) async {
      await tester.pumpApp(const DiscountsScreen());

      expect(find.byKey(KWIdgetkeys.discountsKeys.screen), findsOneWidget);

      await tester.pumpAndSettle();
      expect(
        find.byKey(KWIdgetkeys.discountsKeys.informationButton),
        findsOneWidget,
      );

      expect(
        find.byKey(KWIdgetkeys.discountsKeys.investorsButton),
        findsOneWidget,
      );

      expect(
        find.byKey(KWIdgetkeys.discountsKeys.profileButton),
        findsOneWidget,
      );

      expect(find.byKey(KWIdgetkeys.discountsKeys.storyButton), findsOneWidget);

      expect(find.byKey(KWIdgetkeys.discountsKeys.workButton), findsOneWidget);
    });
    group('Mock Go Router', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('renders initial', (tester) async {
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const DiscountsScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.discountsKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();
        expect(
          find.byKey(KWIdgetkeys.discountsKeys.informationButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWIdgetkeys.discountsKeys.investorsButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWIdgetkeys.discountsKeys.profileButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWIdgetkeys.discountsKeys.storyButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWIdgetkeys.discountsKeys.workButton),
          findsOneWidget,
        );
      });

      testWidgets('go to ${ScreenName.information}', (tester) async {
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const DiscountsScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.discountsKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWIdgetkeys.discountsKeys.informationButton),
          findsOneWidget,
        );
        await tester.tap(
          find.byKey(
            KWIdgetkeys.discountsKeys.informationButton,
          ),
        );

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
            child: const DiscountsScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.discountsKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWIdgetkeys.discountsKeys.investorsButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWIdgetkeys.discountsKeys.investorsButton));

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
            child: const DiscountsScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.discountsKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWIdgetkeys.discountsKeys.profileButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWIdgetkeys.discountsKeys.profileButton));

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
            child: const DiscountsScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.discountsKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWIdgetkeys.discountsKeys.storyButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWIdgetkeys.discountsKeys.storyButton));

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
            child: const DiscountsScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.discountsKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWIdgetkeys.discountsKeys.workButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWIdgetkeys.discountsKeys.workButton));

        verify(
          () => mockGoRouter.go(
            '${KRouteStatic.home.path}${KRouteStatic.work.path}',
          ),
        ).called(1);
      });
    });
  });
}
