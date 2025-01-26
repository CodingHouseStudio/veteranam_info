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
  group('${KScreenBlocName.questionsForm} ', () {
    setUp(questionFormWidgetTestRegister);
    testWidgets('${KGroupText.initial} ', (tester) async {
      await questionFormPumpAppHelper(
        tester,
      );

      await questionForminitialHelper(tester);
    });
    testWidgets('check point switch', (tester) async {
      await questionFormPumpAppHelper(
        tester,
      );

      await checkPointHelper(tester);
    });
    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.initial} ', (tester) async {
        await questionFormPumpAppHelper(
          tester,
          mockGoRouter: mockGoRouter,
        );

        await questionForminitialHelper(tester);
      });
      testWidgets('send user role', (tester) async {
        await questionFormPumpAppHelper(
          tester,
          mockGoRouter: mockGoRouter,
        );

        await sendUserRoleHelper(
          tester: tester,
          mockUserRepository: mockUserRepository,
        );
      });
    });
  });
}
