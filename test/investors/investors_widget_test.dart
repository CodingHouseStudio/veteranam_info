import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/investors/investors.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../text_dependency.dart';

void main() {
  group(KScreenName.investors, () {
    setUp(configureDependenciesTest);

    setUpAll(setUpGlobal);

    setupFirebaseAuthMocks();

    tearDown(GetIt.I.reset);
    testWidgets('renders initial', (tester) async {
      await tester.pumpApp(const InvestorsScreen());

      expect(find.byKey(KWidgetkeys.investorsKeys.screen), findsOneWidget);

      await tester.pumpAndSettle();
      expect(
        find.byKey(KWidgetkeys.investorsKeys.discountsButton),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.investorsKeys.informationButton),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.investorsKeys.profileButton),
        findsOneWidget,
      );

      expect(find.byKey(KWidgetkeys.investorsKeys.storyButton), findsOneWidget);

      expect(find.byKey(KWidgetkeys.investorsKeys.workButton), findsOneWidget);
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

        expect(find.byKey(KWidgetkeys.investorsKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();
        expect(
          find.byKey(KWidgetkeys.investorsKeys.discountsButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.investorsKeys.informationButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.investorsKeys.profileButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.investorsKeys.storyButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.investorsKeys.workButton),
          findsOneWidget,
        );
      });

      testWidgets('go to ${KScreenName.discounts}', (tester) async {
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const InvestorsScreen(),
          ),
        );

        expect(find.byKey(KWidgetkeys.investorsKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.investorsKeys.discountsButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWidgetkeys.investorsKeys.discountsButton));

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
            child: const InvestorsScreen(),
          ),
        );

        expect(find.byKey(KWidgetkeys.investorsKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.investorsKeys.informationButton),
          findsOneWidget,
        );
        await tester.tap(
          find.byKey(
            KWidgetkeys.investorsKeys.informationButton,
          ),
        );

        verify(
          () => mockGoRouter.go(
            '${KRoute.home.path}${KRoute.information.path}',
          ),
        ).called(1);
      });

      testWidgets('go to ${KScreenName.profile}', (tester) async {
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const InvestorsScreen(),
          ),
        );

        expect(find.byKey(KWidgetkeys.investorsKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.investorsKeys.profileButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWidgetkeys.investorsKeys.profileButton));

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
            child: const InvestorsScreen(),
          ),
        );

        expect(find.byKey(KWidgetkeys.investorsKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.investorsKeys.storyButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWidgetkeys.investorsKeys.storyButton));

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
            child: const InvestorsScreen(),
          ),
        );

        expect(find.byKey(KWidgetkeys.investorsKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.investorsKeys.workButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWidgetkeys.investorsKeys.workButton));

        verify(
          () => mockGoRouter.go(
            '${KRoute.home.path}${KRoute.work.path}',
          ),
        ).called(1);
      });
    });
  });
}
