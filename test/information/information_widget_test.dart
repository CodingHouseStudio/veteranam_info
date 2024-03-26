import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/components/information/information.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/helpers.dart';
import '../test_mocks/test_mocks.dart';

void main() {
  group(ScreenName.information, () {
    testWidgets('renders initial', (tester) async {
      await tester.pumpApp(const InformationScreen());

      expect(find.byKey(KWIdgetkeys.informationKeys.screen), findsOneWidget);

      await tester.pumpAndSettle();
      expect(
        find.byKey(KWIdgetkeys.informationKeys.discountsButton),
        findsOneWidget,
      );

      expect(
        find.byKey(KWIdgetkeys.informationKeys.investorsButton),
        findsOneWidget,
      );

      expect(
        find.byKey(KWIdgetkeys.informationKeys.profileButton),
        findsOneWidget,
      );

      expect(
        find.byKey(KWIdgetkeys.informationKeys.storyButton),
        findsOneWidget,
      );

      expect(
        find.byKey(KWIdgetkeys.informationKeys.workButton),
        findsOneWidget,
      );
    });
    group('Mock Go Router', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('renders initial', (tester) async {
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const InformationScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.informationKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();
        expect(
          find.byKey(KWIdgetkeys.informationKeys.discountsButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWIdgetkeys.informationKeys.investorsButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWIdgetkeys.informationKeys.profileButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWIdgetkeys.informationKeys.storyButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWIdgetkeys.informationKeys.workButton),
          findsOneWidget,
        );
      });

      testWidgets('go to ${ScreenName.discounts}', (tester) async {
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const InformationScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.informationKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWIdgetkeys.informationKeys.discountsButton),
          findsOneWidget,
        );
        await tester.tap(
          find.byKey(
            KWIdgetkeys.informationKeys.discountsButton,
          ),
        );

        verify(
          () => mockGoRouter.go(
            '${KRouteStatic.home.path}${KRouteStatic.discounts.path}',
          ),
        ).called(1);
      });

      testWidgets('go to ${ScreenName.investors}', (tester) async {
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const InformationScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.informationKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWIdgetkeys.informationKeys.investorsButton),
          findsOneWidget,
        );
        await tester.tap(
          find.byKey(
            KWIdgetkeys.informationKeys.investorsButton,
          ),
        );

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
            child: const InformationScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.informationKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWIdgetkeys.informationKeys.profileButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWIdgetkeys.informationKeys.profileButton));

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
            child: const InformationScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.informationKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWIdgetkeys.informationKeys.storyButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWIdgetkeys.informationKeys.storyButton));

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
            child: const InformationScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.informationKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWIdgetkeys.informationKeys.workButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWIdgetkeys.informationKeys.workButton));

        verify(
          () => mockGoRouter.go(
            '${KRouteStatic.home.path}${KRouteStatic.work.path}',
          ),
        ).called(1);
      });
    });
  });
}
