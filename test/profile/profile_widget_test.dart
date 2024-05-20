import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import '../text_dependency.dart';

import 'helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.profile} ', () {
    testWidgets('${KGroupText.intial} ', (tester) async {
      await profilePumpAppHelper(tester: tester);

      await profileInitialHelper(tester);
    });
    testWidgets('Show log out dialog', (tester) async {
      await profilePumpAppHelper(tester: tester);

      await logOutDialoglHelper(tester);
    });

    testWidgets('Show delete account dialog', (tester) async {
      await profilePumpAppHelper(tester: tester);

      await deleteAccountDialoglHelper(tester);
    });

    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.intial} ', (tester) async {
        await profilePumpAppHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
        );

        await profileInitialHelper(tester);
      });

      group('${KGroupText.goTo} ', () {
        testWidgets('Log out dialog unconfirm button pop', (tester) async {
          await profilePumpAppHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );

          await logOutUnconfirmButtonlHelper(tester, mockGoRouter);
        });

        testWidgets('Log out dialog confirm button pop', (tester) async {
          await profilePumpAppHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );

          await logOutConfirmButtonlHelper(tester, mockGoRouter);
        });

        testWidgets('Delete account dialog unconfirm button pop',
            (tester) async {
          await profilePumpAppHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );

          await deleteAccountUnconfirmButtonlHelper(tester, mockGoRouter);
        });

        testWidgets('Delete account dialog confirm button pop', (tester) async {
          await profilePumpAppHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );

          await deleteAccountConfirmButtonlHelper(tester, mockGoRouter);
        });
      });
    });
  });
}
