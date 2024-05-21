import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import '../text_dependency.dart';
import 'helper/employee_respond_initial_helper.dart';
import 'helper/employee_respond_pump_app_helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.employeeRespond} ', () {
    testWidgets('${KGroupText.intial} ', (tester) async {
      await employeeRespondPumpAppHelper(tester: tester);

      await employeeRespondInitialHelper(tester);
    });
    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.intial} ', (tester) async {
        await employeeRespondPumpAppHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
        );

        await employeeRespondInitialHelper(tester);
      });
    });
  });
}
