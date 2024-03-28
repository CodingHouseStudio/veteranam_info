import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/information/information.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../text_dependency.dart';

void main() {
  group(KScreenName.information, () {
    setUp(configureDependenciesTest);

    setUpAll(setUpGlobal);

    setupFirebaseAuthMocks();

    tearDown(GetIt.I.reset);
    testWidgets('renders initial', (tester) async {
      await tester.pumpApp(const InformationScreen());

      expect(find.byKey(KWidgetkeys.informationKeys.screen), findsOneWidget);

      await tester.pumpAndSettle();
      expect(
        find.byKey(KWidgetkeys.informationKeys.discountsButton),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.informationKeys.investorsButton),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.informationKeys.profileButton),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.informationKeys.storyButton),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.informationKeys.workButton),
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

        expect(find.byKey(KWidgetkeys.informationKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();
        expect(
          find.byKey(KWidgetkeys.informationKeys.discountsButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.informationKeys.investorsButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.informationKeys.profileButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.informationKeys.storyButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.informationKeys.workButton),
          findsOneWidget,
        );
      });

      testWidgets('go to ${KScreenName.discounts}', (tester) async {
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const InformationScreen(),
          ),
        );

        expect(find.byKey(KWidgetkeys.informationKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.informationKeys.discountsButton),
          findsOneWidget,
        );
        await tester.tap(
          find.byKey(
            KWidgetkeys.informationKeys.discountsButton,
          ),
        );

        verify(
          () => mockGoRouter.go(
            '${KRoute.home.path}${KRoute.discounts.path}',
          ),
        ).called(1);
      });

      testWidgets('go to ${KScreenName.investors}', (tester) async {
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const InformationScreen(),
          ),
        );

        expect(find.byKey(KWidgetkeys.informationKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.informationKeys.investorsButton),
          findsOneWidget,
        );
        await tester.tap(
          find.byKey(
            KWidgetkeys.informationKeys.investorsButton,
          ),
        );

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
            child: const InformationScreen(),
          ),
        );

        expect(find.byKey(KWidgetkeys.informationKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.informationKeys.profileButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWidgetkeys.informationKeys.profileButton));

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
            child: const InformationScreen(),
          ),
        );

        expect(find.byKey(KWidgetkeys.informationKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.informationKeys.storyButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWidgetkeys.informationKeys.storyButton));

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
            child: const InformationScreen(),
          ),
        );

        expect(find.byKey(KWidgetkeys.informationKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.informationKeys.workButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWidgetkeys.informationKeys.workButton));

        verify(
          () => mockGoRouter.go(
            '${KRoute.home.path}${KRoute.work.path}',
          ),
        ).called(1);
      });
    });
  });
}
