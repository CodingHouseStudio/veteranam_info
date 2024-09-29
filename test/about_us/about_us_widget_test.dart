import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import '../test_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.aboutUs} ', () {
    testWidgets('${KGroupText.initial} ', (tester) async {
      await aboutUsPumpAppHelper(tester: tester);

      await aboutUsInitialHelper(tester);
    });
    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.initial} ', (tester) async {
        await aboutUsPumpAppHelper(tester: tester, mockGoRouter: mockGoRouter);

        await aboutUsInitialHelper(tester);
      });
      // group('${KGroupText.goTo} ', () {
      // });
    });
  });
}
