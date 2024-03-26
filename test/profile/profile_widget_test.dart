import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/components/profile/profile.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/helpers.dart';
import '../test_mocks/test_mocks.dart';

void main() {
  group(ScreenName.profile, () {
    testWidgets('renders initial', (tester) async {
      await tester.pumpApp(const ProfileScreen());

      expect(find.byKey(KWIdgetkeys.profileKeys.screen), findsOneWidget);

      await tester.pumpAndSettle();
      expect(
        find.byKey(KWIdgetkeys.profileKeys.discountsButton),
        findsOneWidget,
      );

      expect(
        find.byKey(KWIdgetkeys.profileKeys.informationButton),
        findsOneWidget,
      );

      expect(
        find.byKey(KWIdgetkeys.profileKeys.investorsButton),
        findsOneWidget,
      );

      expect(find.byKey(KWIdgetkeys.profileKeys.storyButton), findsOneWidget);

      expect(find.byKey(KWIdgetkeys.profileKeys.workButton), findsOneWidget);
    });
    group('Mock Go Router', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('renders initial', (tester) async {
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const ProfileScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.profileKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();
        expect(
          find.byKey(KWIdgetkeys.profileKeys.discountsButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWIdgetkeys.profileKeys.informationButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWIdgetkeys.profileKeys.investorsButton),
          findsOneWidget,
        );

        expect(find.byKey(KWIdgetkeys.profileKeys.storyButton), findsOneWidget);

        expect(find.byKey(KWIdgetkeys.profileKeys.workButton), findsOneWidget);
      });

      testWidgets('go to ${ScreenName.discounts}', (tester) async {
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const ProfileScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.profileKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWIdgetkeys.profileKeys.discountsButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWIdgetkeys.profileKeys.discountsButton));

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
            child: const ProfileScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.profileKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWIdgetkeys.profileKeys.informationButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWIdgetkeys.profileKeys.informationButton));

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
            child: const ProfileScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.profileKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWIdgetkeys.profileKeys.investorsButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWIdgetkeys.profileKeys.investorsButton));

        verify(
          () => mockGoRouter.go(
            '${KRouteStatic.home.path}${KRouteStatic.investors.path}',
          ),
        ).called(1);
      });

      testWidgets('go to ${ScreenName.story}', (tester) async {
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const ProfileScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.profileKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWIdgetkeys.profileKeys.storyButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWIdgetkeys.profileKeys.storyButton));

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
            child: const ProfileScreen(),
          ),
        );

        expect(find.byKey(KWIdgetkeys.profileKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWIdgetkeys.profileKeys.workButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWIdgetkeys.profileKeys.workButton));

        verify(
          () => mockGoRouter.go(
            '${KRouteStatic.home.path}${KRouteStatic.work.path}',
          ),
        ).called(1);
      });
    });
  });
}
