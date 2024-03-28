import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/work/work.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../text_dependency.dart';

void main() {
  group(KScreenName.work, () {
    setUp(configureDependenciesTest);

    setUpAll(setUpGlobal);

    setupFirebaseAuthMocks();

    tearDown(GetIt.I.reset);
    testWidgets('renders initial', (tester) async {
      await tester.pumpApp(const WorkScreen());

      expect(find.byKey(KWidgetkeys.workKeys.screen), findsOneWidget);

      await tester.pumpAndSettle();
      expect(find.byKey(KWidgetkeys.workKeys.discountsButton), findsOneWidget);

      expect(
        find.byKey(KWidgetkeys.workKeys.informationButton),
        findsOneWidget,
      );

      expect(find.byKey(KWidgetkeys.workKeys.investorsButton), findsOneWidget);

      expect(find.byKey(KWidgetkeys.workKeys.profileButton), findsOneWidget);

      expect(find.byKey(KWidgetkeys.workKeys.storyButton), findsOneWidget);
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

        expect(find.byKey(KWidgetkeys.workKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();
        expect(
          find.byKey(KWidgetkeys.workKeys.discountsButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.workKeys.informationButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.workKeys.investorsButton),
          findsOneWidget,
        );

        expect(find.byKey(KWidgetkeys.workKeys.profileButton), findsOneWidget);

        expect(find.byKey(KWidgetkeys.workKeys.storyButton), findsOneWidget);
      });

      testWidgets('go to ${KScreenName.discounts}', (tester) async {
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const WorkScreen(),
          ),
        );

        expect(find.byKey(KWidgetkeys.workKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.workKeys.discountsButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWidgetkeys.workKeys.discountsButton));

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
            child: const WorkScreen(),
          ),
        );

        expect(find.byKey(KWidgetkeys.workKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.workKeys.informationButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWidgetkeys.workKeys.informationButton));

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
            child: const WorkScreen(),
          ),
        );

        expect(find.byKey(KWidgetkeys.workKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.workKeys.investorsButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWidgetkeys.workKeys.investorsButton));

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
            child: const WorkScreen(),
          ),
        );

        expect(find.byKey(KWidgetkeys.workKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.workKeys.profileButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWidgetkeys.workKeys.profileButton));

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
            child: const WorkScreen(),
          ),
        );

        expect(find.byKey(KWidgetkeys.workKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.workKeys.storyButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWidgetkeys.workKeys.storyButton));

        verify(
          () => mockGoRouter.go(
            '${KRoute.home.path}${KRoute.story.path}',
          ),
        ).called(1);
      });
    });
  });
}
