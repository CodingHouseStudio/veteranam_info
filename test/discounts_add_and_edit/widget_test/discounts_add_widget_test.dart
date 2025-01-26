import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import '../../test_dependency.dart';
import '../helper/helper.dart';

void main() {
  setUpAll(configureDependenciesTest);

  setUp(resetTestVariables);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.discountsAdd} ', () {
    setUp(discountAddEditRegister);
    testWidgets('${KGroupText.initial} ', (tester) async {
      await discountsAddPumpAppHelper(
        tester,
      );

      await discountsAddInitialHelper(tester: tester);
    });
    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.initial} ', (tester) async {
        await discountsAddPumpAppHelper(
          tester,
          mockGoRouter: mockGoRouter,
        );

        await discountsAddInitialHelper(tester: tester);
      });
      testWidgets('Discount enter correct(Mobile)', (tester) async {
        await discountsAddPumpAppHelper(
          tester,
          mockGoRouter: mockGoRouter,
        );

        await discountsAddCorectHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
        );
      });
      testWidgets('Discount enter correct(Desk)', (tester) async {
        await discountsAddPumpAppHelper(
          tester,
          mockGoRouter: mockGoRouter,
        );

        await changeWindowSizeHelper(
          tester: tester,
          test: () async => discountsAddCorectHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          ),
        );
      });
      testWidgets('Discount enter uncorrect', (tester) async {
        await discountsAddPumpAppHelper(
          tester,
          mockGoRouter: mockGoRouter,
        );

        await discountsAddUncorectHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
        );
      });

      testWidgets('Cancel dialog unconfirm button pop', (tester) async {
        await discountsAddPumpAppHelper(
          tester,
          mockGoRouter: mockGoRouter,
        );

        await discountsAddUnconfirmButtonlHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
          icon: false,
        );
      });
      testWidgets('Cancel dialog cancel icon pop', (tester) async {
        await discountsAddPumpAppHelper(
          tester,
          mockGoRouter: mockGoRouter,
        );
        await discountsAddUnconfirmButtonlHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
          icon: true,
        );
      });
    });
  });
}
