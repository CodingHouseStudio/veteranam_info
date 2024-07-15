import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/shared.dart';
import '../text_dependency.dart';

import 'helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.privacyPolicy} ', () {
    testWidgets('${KGroupText.intial} ', (tester) async {
      await privacyPolicyPumpAppHelper(tester: tester);

      await privacyPolicyInitialHelper(tester);
    });

    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.intial} ', (tester) async {
        await privacyPolicyPumpAppHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
        );

        await privacyPolicyInitialHelper(tester);
      });
      group('${KGroupText.goTo} ', () {
        testWidgets('${KRoute.home.name} ', (tester) async {
          await privacyPolicyPumpAppHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );

          await cancelHelper(tester: tester, mockGoRouter: mockGoRouter);
        });
      });
    });
  });
}
