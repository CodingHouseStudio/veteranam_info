import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/profile/profile.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  setUp(configureDependenciesTest);

  tearDown(GetIt.I.reset);
  group(KScreenName.profile, () {
    testWidgets('renders initial', (tester) async {
      await tester.pumpApp(const ProfileScreen());

      expect(find.byKey(KWidgetkeys.profileKeys.screen), findsOneWidget);

      await tester.pumpAndSettle();
      expect(
        find.byKey(KWidgetkeys.profileKeys.discountsButton),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.profileKeys.informationButton),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.profileKeys.investorsButton),
        findsOneWidget,
      );

      expect(find.byKey(KWidgetkeys.profileKeys.storyButton), findsOneWidget);

      expect(find.byKey(KWidgetkeys.profileKeys.workButton), findsOneWidget);
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

        expect(find.byKey(KWidgetkeys.profileKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();
        expect(
          find.byKey(KWidgetkeys.profileKeys.discountsButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.profileKeys.informationButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.profileKeys.investorsButton),
          findsOneWidget,
        );

        expect(find.byKey(KWidgetkeys.profileKeys.storyButton), findsOneWidget);

        expect(find.byKey(KWidgetkeys.profileKeys.workButton), findsOneWidget);
      });

      testWidgets('go to ${KScreenName.discounts}', (tester) async {
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const ProfileScreen(),
          ),
        );

        expect(find.byKey(KWidgetkeys.profileKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.profileKeys.discountsButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWidgetkeys.profileKeys.discountsButton));

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
            child: const ProfileScreen(),
          ),
        );

        expect(find.byKey(KWidgetkeys.profileKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.profileKeys.informationButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWidgetkeys.profileKeys.informationButton));

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
            child: const ProfileScreen(),
          ),
        );

        expect(find.byKey(KWidgetkeys.profileKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.profileKeys.investorsButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWidgetkeys.profileKeys.investorsButton));

        verify(
          () => mockGoRouter.go(
            '${KRoute.home.path}${KRoute.investors.path}',
          ),
        ).called(1);
      });

      testWidgets('go to ${KScreenName.story}', (tester) async {
        await tester.pumpApp(
          MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const ProfileScreen(),
          ),
        );

        expect(find.byKey(KWidgetkeys.profileKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.profileKeys.storyButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWidgetkeys.profileKeys.storyButton));

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
            child: const ProfileScreen(),
          ),
        );

        expect(find.byKey(KWidgetkeys.profileKeys.screen), findsOneWidget);

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.profileKeys.workButton),
          findsOneWidget,
        );
        await tester.tap(find.byKey(KWidgetkeys.profileKeys.workButton));

        verify(
          () => mockGoRouter.go(
            '${KRoute.home.path}${KRoute.work.path}',
          ),
        ).called(1);
      });
    });
  });
}
