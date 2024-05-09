import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

import '../text_dependency.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.profile} ', () {
    testWidgets('${KGroupText.intial} ', (tester) async {
      await tester.pumpApp(const ProfileScreen());

      expect(
        find.byKey(KWidgetkeys.screen.profile.screen),
        findsOneWidget,
      );

      await tester.pumpAndSettle();
    });

    testWidgets('Show log out dialog', (tester) async {
      await tester.pumpApp(const ProfileScreen());

      expect(
        find.byKey(KWidgetkeys.screen.profile.screen),
        findsOneWidget,
      );

      await tester.pumpAndSettle();

      await profileCardLogOutHelper(tester);
    });

    testWidgets('Show delete account dialog', (tester) async {
      await tester.pumpApp(const ProfileScreen());

      expect(
        find.byKey(KWidgetkeys.screen.profile.screen),
        findsOneWidget,
      );

      await tester.pumpAndSettle();

      await profileCardDeleteAccountHelper(tester);
    });

    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.intial} ', (tester) async {
        await tester.pumpApp(const ProfileScreen(), mockGoRouter: mockGoRouter);

        expect(
          find.byKey(KWidgetkeys.screen.profile.screen),
          findsOneWidget,
        );

        await tester.pumpAndSettle();
      });

      group('${KGroupText.goTo} ', () {
        testWidgets('Log out dialog unconfirm button pop', (tester) async {
          await tester.pumpApp(
            const ProfileScreen(),
            mockGoRouter: mockGoRouter,
          );

          expect(
            find.byKey(KWidgetkeys.screen.profile.screen),
            findsOneWidget,
          );

          await tester.pumpAndSettle();

          await profileCardLogOutHelper(tester);

          await dialogLogOutUnconfirmHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });

        testWidgets('Log out dialog confirm button pop', (tester) async {
          await tester.pumpApp(
            const ProfileScreen(),
            mockGoRouter: mockGoRouter,
          );

          expect(
            find.byKey(KWidgetkeys.screen.profile.screen),
            findsOneWidget,
          );

          await tester.pumpAndSettle();

          await profileCardLogOutHelper(tester);

          await dialogLogOutConfirmHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });

        testWidgets('Delete account dialog unconfirm button pop',
            (tester) async {
          await tester.pumpApp(
            const ProfileScreen(),
            mockGoRouter: mockGoRouter,
          );

          expect(
            find.byKey(KWidgetkeys.screen.profile.screen),
            findsOneWidget,
          );

          await tester.pumpAndSettle();

          await profileCardDeleteAccountHelper(tester);

          await dialogDeleteAccountUnconfirmHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });

        testWidgets('Delete account dialog confirm button pop', (tester) async {
          await tester.pumpApp(
            const ProfileScreen(),
            mockGoRouter: mockGoRouter,
          );

          expect(
            find.byKey(KWidgetkeys.screen.profile.screen),
            findsOneWidget,
          );

          await tester.pumpAndSettle();

          await profileCardDeleteAccountHelper(tester);

          await dialogDeleteAccountUnconfirmHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
      });
    });
  });
}
