import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import '../test_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.userRole} ', () {
    testWidgets('${KGroupText.intial} ', (tester) async {
      await userRolePumpAppHelper(
        tester: tester,
      );

      await userRoleInitialHelper(tester);
    });

    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.intial} ', (tester) async {
        await userRolePumpAppHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
        );

        await userRoleInitialHelper(tester);
      });
      group('${KGroupText.goTo} ', () {
        testWidgets('Sign Up business button ', (tester) async {
          await userRolePumpAppHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );

          await signUpButtonsNavigationHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
            isUser: false,
          );
        });

        testWidgets('Sign Up user button ', (tester) async {
          await userRolePumpAppHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );

          await signUpButtonsNavigationHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
            isUser: true,
          );
        });

        testWidgets('Drop down buttons', (tester) async {
          await userRolePumpAppHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );

          await dropDownButtonHelper(
            tester: tester,
          );

          await dropDownButtonNavigationHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
      });
    });
  });
}
