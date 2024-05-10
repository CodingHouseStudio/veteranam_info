import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import '../text_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.error} ', () {
    testWidgets('${KGroupText.intial} ', (tester) async {
      await errorPumpAppHelper(tester: tester);

      await errorInitialHelper(tester);
    });
    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.intial} ', (tester) async {
        await errorPumpAppHelper(tester: tester, mockGoRouter: mockGoRouter);

        await errorInitialHelper(tester);
      });

      group('${KGroupText.goTo} ', () {
        testWidgets(KScreenBlocName.home, (tester) async {
          await errorPumpAppHelper(tester: tester, mockGoRouter: mockGoRouter);

          await buttonHelper(tester: tester, mockGoRouter: mockGoRouter);
        });
      });
    });
  });
}
