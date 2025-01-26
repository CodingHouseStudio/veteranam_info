import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import '../test_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUpAll(configureDependenciesTest);

  setUp(resetTestVariables);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.userRole} ', () {
    testWidgets('${KGroupText.initial} ', (tester) async {
      await userRolePumpAppHelper(
        tester: tester,
      );

      await userRoleInitialHelper(tester);
    });

    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.initial} ', (tester) async {
        await userRolePumpAppHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
        );

        await userRoleInitialHelper(tester);
      });
      // testWidgets('Drop down buttons intial', (tester) async {
      //   await userRolePumpAppHelper(
      //     tester: tester,
      //     mockGoRouter: mockGoRouter,
      //   );

      //   await dropDownScrollHelper(
      //     test: () async => userRoleLoginButtonHelper(
      //       tester: tester,
      //     ),
      //     tester: tester,
      //   );
      // });
      group('${KGroupText.goTo} ', () {
        testWidgets('Sign Up business button ', (tester) async {
          await userRolePumpAppHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );

          await signUpButtonsNavigationHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
        testWidgets('Drop down button for user login', (tester) async {
          await userRolePumpAppHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );

          await dropDownLoginUserNavigationHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
        testWidgets('Drop down button for business login', (tester) async {
          await userRolePumpAppHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );

          await dropDownLoginBusinessNavigationHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
      });
    });
  });
}
