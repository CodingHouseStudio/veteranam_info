import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../test_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.error} ', () {
    testWidgets('${KGroupText.initial} ', (tester) async {
      await errorPumpAppHelper(tester: tester);

      await errorInitialHelper(tester);
    });
    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.initial} ', (tester) async {
        await errorPumpAppHelper(tester: tester, mockGoRouter: mockGoRouter);

        await errorInitialHelper(tester);
      });

      group('${KGroupText.goTo} ', () {
        testWidgets('${KScreenBlocName.home} ', (tester) async {
          await errorPumpAppHelper(tester: tester, mockGoRouter: mockGoRouter);

          await buttonHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
            routeName: KRoute.home.name,
          );
        });
        testWidgets('${KScreenBlocName.home} ', (tester) async {
          Config.testIsWeb = false;

          await errorPumpAppHelper(tester: tester, mockGoRouter: mockGoRouter);

          await buttonHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
            routeName: KRoute.settings.name,
          );
        });
        testWidgets('${KScreenBlocName.home} ', (tester) async {
          Config.roleValue = Config.business;
          await errorPumpAppHelper(tester: tester, mockGoRouter: mockGoRouter);

          await buttonHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
            routeName: KRoute.myDiscounts.name, //KRoute.businessDashboard.name,
          );
        });
      });
    });
  });
}
