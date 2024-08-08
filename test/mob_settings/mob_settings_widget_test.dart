import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/shared.dart';

import '../test_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.mobSettings} ', () {
    setUp(
      () => KTest.testIsWeb = false,
    );
    testWidgets('${KGroupText.intial} ', (tester) async {
      await mobSettingsPumpAppHelper(tester: tester);

      await mobSettingsInitialHelper(tester);
    });
    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.intial} ', (tester) async {
        await mobSettingsPumpAppHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
        );

        await mobSettingsInitialHelper(tester);
      });
      group('${KGroupText.goTo} ', () {
        testWidgets('${KRoute.myDiscounts.name} ', (tester) async {
          await mobSettingsPumpAppHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );

          await mobSettingsHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
      });
    });
  });
}
