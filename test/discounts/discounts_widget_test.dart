import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/discounts/discounts.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  setUp(configureDependenciesTest);

  tearDown(GetIt.I.reset);
  group(KScreenName.discounts, () {
    testWidgets('renders initial', (tester) async {
      await tester.pumpApp(const DiscountsScreen());

      expect(find.byKey(KWidgetkeys.discountsKeys.screen), findsOneWidget);

      await tester.pumpAndSettle();
      expect(
        find.byKey(KWidgetkeys.discountsKeys.informationButton),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.discountsKeys.investorsButton),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.discountsKeys.profileButton),
        findsOneWidget,
      );

      expect(find.byKey(KWidgetkeys.discountsKeys.storyButton), findsOneWidget);

      expect(find.byKey(KWidgetkeys.discountsKeys.workButton), findsOneWidget);
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

        expect(find.byKey(KWidgetkeys.discountsKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();
        expect(
          find.byKey(KWidgetkeys.discountsKeys.informationButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.discountsKeys.investorsButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.discountsKeys.profileButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.discountsKeys.storyButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.discountsKeys.workButton),
          findsOneWidget,
        );
      });

      testWidgets('go to ${KScreenName.information}', (tester) async {
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const DiscountsScreen(),
          ),
        );

        expect(find.byKey(KWidgetkeys.discountsKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.discountsKeys.informationButton),
          findsOneWidget,
        );
        await tester.tap(
          find.byKey(
            KWidgetkeys.discountsKeys.informationButton,
          ),
        );

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
            child: const DiscountsScreen(),
          ),
        );

        expect(find.byKey(KWidgetkeys.discountsKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.discountsKeys.investorsButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWidgetkeys.discountsKeys.investorsButton));

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
            child: const DiscountsScreen(),
          ),
        );

        expect(find.byKey(KWidgetkeys.discountsKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.discountsKeys.profileButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWidgetkeys.discountsKeys.profileButton));

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
            child: const DiscountsScreen(),
          ),
        );

        expect(find.byKey(KWidgetkeys.discountsKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.discountsKeys.storyButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWidgetkeys.discountsKeys.storyButton));

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
            child: const DiscountsScreen(),
          ),
        );

        expect(find.byKey(KWidgetkeys.discountsKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.discountsKeys.workButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWidgetkeys.discountsKeys.workButton));

        verify(
          () => mockGoRouter.go(
            '${KRoute.home.path}${KRoute.work.path}',
          ),
        ).called(1);
      });
    });
  });
}
