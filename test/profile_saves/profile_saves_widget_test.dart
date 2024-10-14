import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import '../test_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);

  group('${KScreenBlocName.profileSaves} ', () {
    testWidgets('${KGroupText.initial} ', (tester) async {
      await profileSavesPumpAppHelper(tester: tester);

      await profileSavesInitialHelper(tester);
    });

    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());

      testWidgets('${KGroupText.initial} ', (tester) async {
        await profileSavesPumpAppHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
        );

        await profileSavesInitialHelper(tester);
      });
    });
  });
}
