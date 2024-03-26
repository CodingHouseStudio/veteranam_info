import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/components/investors/investors.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/helpers.dart';
import '../test_mocks/test_mocks.dart';

void main() {
  group(ScreenName.investors, () {
    testWidgets('renders initial', (tester) async {
      await tester.pumpApp(const InvestorsScreen());

      expect(find.byKey(KWIdgetkeys.investorsKeys.screen), findsOneWidget);

      await tester.pumpAndSettle();
      expect(
        find.byKey(KWIdgetkeys.investorsKeys.discountsButton),
        findsOneWidget,
      );

      expect(
        find.byKey(KWIdgetkeys.investorsKeys.informationButton),
        findsOneWidget,
      );

      expect(
        find.byKey(KWIdgetkeys.investorsKeys.profileButton),
        findsOneWidget,
      );

      expect(find.byKey(KWIdgetkeys.investorsKeys.storyButton), findsOneWidget);

      expect(find.byKey(KWIdgetkeys.investorsKeys.workButton), findsOneWidget);
    });
    group('Mock Go Router', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('renders initial', (tester) async {
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const InvestorsScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.investorsKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();
        expect(
          find.byKey(KWIdgetkeys.investorsKeys.discountsButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWIdgetkeys.investorsKeys.informationButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWIdgetkeys.investorsKeys.profileButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWIdgetkeys.investorsKeys.storyButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWIdgetkeys.investorsKeys.workButton),
          findsOneWidget,
        );
      });

      testWidgets('go to ${ScreenName.discounts}', (tester) async {
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const InvestorsScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.investorsKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWIdgetkeys.investorsKeys.discountsButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWIdgetkeys.investorsKeys.discountsButton));

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
            child: const InvestorsScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.investorsKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWIdgetkeys.investorsKeys.informationButton),
          findsOneWidget,
        );
        await tester.tap(
          find.byKey(
            KWIdgetkeys.investorsKeys.informationButton,
          ),
        );

        verify(
          () => mockGoRouter.go(
            '${KRouteStatic.home.path}${KRouteStatic.information.path}',
          ),
        ).called(1);
      });

      testWidgets('go to ${ScreenName.profile}', (tester) async {
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const InvestorsScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.investorsKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWIdgetkeys.investorsKeys.profileButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWIdgetkeys.investorsKeys.profileButton));

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
            child: const InvestorsScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.investorsKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWIdgetkeys.investorsKeys.storyButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWIdgetkeys.investorsKeys.storyButton));

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
            child: const InvestorsScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.investorsKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWIdgetkeys.investorsKeys.workButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWIdgetkeys.investorsKeys.workButton));

        verify(
          () => mockGoRouter.go(
            '${KRouteStatic.home.path}${KRouteStatic.work.path}',
          ),
        ).called(1);
      });
    });
  });
}
