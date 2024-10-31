import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/constants/route_constants.dart';

import '../test_dependency.dart';
import 'helper/box_home_navigation_helper.dart';
import 'helper/box_profile_navigation_helper.dart';
import 'helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.thank} ', () {
    testWidgets('${KGroupText.initial} ', (tester) async {
      await thanksPumpAppHelper(
        tester: tester,
      );

      await thanksInitialHelper(tester);
    });
    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.initial} ', (tester) async {
        await thanksPumpAppHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
        );

        await thanksInitialHelper(tester);
      });
      group('${KGroupText.goTo} ', () {
        testWidgets('${KRoute.workEmployee.name} ', (tester) async {
          await thanksPumpAppHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );

          await boxProfileNavigationHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
        testWidgets('${KRoute.employer.name} ', (tester) async {
          await thanksPumpAppHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );

          await boxHomeNavigationHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
      });
    });
  });
}
