import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import '../test_dependency.dart';
import 'helper/profile_saves_initial_helper.dart';
import 'helper/profile_saves_pump_and_helper.dart';

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
