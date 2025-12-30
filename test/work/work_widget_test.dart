import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'package:veteranam/shared/constants/route_constants.dart';
import '../test_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUpAll(configureDependenciesTest);

  setUp(resetTestVariables);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.work} ', () {
    testWidgets('${KGroupText.initial} ', (tester) async {
      await workPumpAppHelper(
        tester: tester,
      );

      await workInitialHelper(tester);
    });
    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.initial} ', (tester) async {
        await workPumpAppHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
        );

        await workInitialHelper(tester);
      });
      group('${KGroupText.goTo} ', () {
        testWidgets('${KRoute.workEmployee.name} ', (tester) async {
          await workPumpAppHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );

          await boxEmployeeNavigationHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
        testWidgets('${KRoute.employer.name} ', (tester) async {
          await workPumpAppHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );

          await boxEmployerNavigationHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
      });
    });
  });
}
