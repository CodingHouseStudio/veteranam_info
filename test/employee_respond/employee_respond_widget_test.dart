import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../test_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUpAll(configureDependenciesTest);

  setUp(resetTestVariables);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.employeeRespond} ', () {
    setUp(employeeRespondWidgetTestRegister);
    testWidgets('${KGroupText.initial} ', (tester) async {
      await employeeRespondPumpAppHelper(
        tester,
      );

      await employeeRespondInitialHelper(tester);
    });
    testWidgets('Fill Form Incorrect Send', (tester) async {
      await employeeRespondPumpAppHelper(
        tester,
      );

      await formIncorrectSendHelper(tester);
    });
    testWidgets('Fill Form Correct Send', (tester) async {
      await employeeRespondPumpAppHelper(
        tester,
      );

      await formCorrectSendHelper(tester);
    });
    testWidgets('Fill Form Without Resume Send', (tester) async {
      await employeeRespondPumpAppHelper(
        tester,
      );

      await formWithoundResumeSendHelper(tester);
    });
    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.initial} ', (tester) async {
        await employeeRespondPumpAppHelper(
          tester,
          mockGoRouter: mockGoRouter,
        );

        await employeeRespondInitialHelper(tester);
      });
      group('${KGroupText.goTo} ', () {
        testWidgets('${KRoute.workEmployee.name} ', (tester) async {
          await employeeRespondPumpAppHelper(
            tester,
            mockGoRouter: mockGoRouter,
          );
          await cancelHelper(mockGoRouter: mockGoRouter, tester: tester);
        });
      });
    });
  });
}
