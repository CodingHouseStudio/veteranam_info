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
    testWidgets('Mobile feedback wrong enter text', (tester) async {
      await mobSettingsPumpAppHelper(tester: tester);

      await mobFeedbackOpenHelper(
        test: mobFeedbackWrongTextHelper,
        tester: tester,
      );
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
      testWidgets('Mobile feedback correct enter text', (tester) async {
        await mobSettingsPumpAppHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
        );

        await mobFeedbackOpenHelper(
          test: mobFeedbackCorrectTextHelper,
          tester: tester,
        );
      });
      group('${KGroupText.goTo} ', () {
        testWidgets('${KRoute.feedback.name} ', (tester) async {
          await mobSettingsPumpAppHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );

          await mobSettingsFeedbackHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });

        testWidgets('${KRoute.mobFAQ.name} ', (tester) async {
          await mobSettingsPumpAppHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );

          await mobFaqNavigationHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });

        testWidgets('${KRoute.privacyPolicy.name} ', (tester) async {
          await mobSettingsPumpAppHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );

          await privacyPolicyNavigationHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
      });
    });
  });
}
