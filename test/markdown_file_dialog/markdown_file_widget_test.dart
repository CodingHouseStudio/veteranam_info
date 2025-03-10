import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../test_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUpAll(configureDependenciesTest);

  setUp(resetTestVariables);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.privacyPolicy} ', () {
    setUpAll(mardownFileWidgetTestRegister);
    testWidgets('${KGroupText.initial} ', (tester) async {
      await markdownFileDialogPumpAppHelper(
        tester,
      );

      await markdownFileDialogInitialHelper(tester);
    });

    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.initial} ', (tester) async {
        await markdownFileDialogPumpAppHelper(
          tester,
          mockGoRouter: mockGoRouter,
        );

        await markdownFileDialogInitialHelper(tester);
      });
      group('${KGroupText.goTo} ', () {
        testWidgets('${KRoute.home.name} ', (tester) async {
          await markdownFileDialogPumpAppHelper(
            tester,
            mockGoRouter: mockGoRouter,
          );

          await cancelHelper(tester: tester, mockGoRouter: mockGoRouter);
        });
        group('${KRoute.discountsAdd.name} ', () {
          setUp(
            () {
              MockGoRouter.canPopValue = false;
              Config.roleValue = Config.business;
            },
          );
          testWidgets('${KRoute.discountsAdd.name} ', (tester) async {
            await markdownFileDialogPumpAppHelper(
              tester,
              mockGoRouter: mockGoRouter,
            );

            await cancelCanNotPopHelper(
              tester: tester,
              mockGoRouter: mockGoRouter,
              business: true,
            );
          });
        });
        group('${KRoute.home.name} ', () {
          setUp(() {
            MockGoRouter.canPopValue = false;
            Config.roleValue = Config.user;
          });
          testWidgets('${KRoute.home.name} ', (tester) async {
            await markdownFileDialogPumpAppHelper(
              tester,
              mockGoRouter: mockGoRouter,
            );

            await cancelCanNotPopHelper(
              tester: tester,
              mockGoRouter: mockGoRouter,
              business: false,
            );
          });
        });
      });
    });
  });
}
