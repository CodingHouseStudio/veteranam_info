import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import '../text_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.consultation} ', () {
    testWidgets('${KGroupText.intial} ', (tester) async {
      await consultationPumpAppHelper(tester: tester);
    });
    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.intial} ', (tester) async {
        await consultationPumpAppHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
        );
      });
      // group('${KGroupText.goTo} ', () {
      // });
    });
  });
}
