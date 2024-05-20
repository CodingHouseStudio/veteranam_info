import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import '../text_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.questionsForm} ', () {
    testWidgets('${KGroupText.intial} ', (tester) async {
      await questionFormPumpAppHelper(tester: tester);

      await questionForminitialHelper(tester);
    });
    testWidgets('check point switch', (tester) async {
      await questionFormPumpAppHelper(tester: tester);

      await checkPointHelper(tester);
    });
    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.intial} ', (tester) async {
        await questionFormPumpAppHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
        );

        await questionForminitialHelper(tester);
      });
      // group('${KGroupText.goTo} ', () {
      // });
    });
  });
}
