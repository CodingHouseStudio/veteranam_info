import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';
import '../helper/helper.dart';

void main() {
  setUpAll(configureDependenciesTest);

  setUp(resetTestVariables);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.investors} ', () {
    setUp(() {
      Config.testIsWeb = false;
      investorsWidgetTestRegister();

      when(
        mockInvestorsRepository.getFunds(
            // reportIdItems: KTestVariables.reportItems.getIdCard,
            ),
      ).thenAnswer(
        (invocation) async => Right(KTestVariables.fundItems),
      );
    });

    testWidgets('${KGroupText.initial} ', (tester) async {
      await investorsPumpAppHelper(
        tester,
      );

      await investorsInitialHelper(tester);
    });

    // testWidgets('${KGroupText.offlineNetwork} ', (tester) async {
    //   await networkMobHelper(
    //     tester: tester,
    //     pumpApp: () async => investorsPumpAppHelper(
    //       mockAppAuthenticationRepository: mockAppAuthenticationRepository,
    //       mockInvestorsRepository: mockInvestorsRepository,
    //       mockReportRepository: mockReportRepository,
    //       mockAuthenticationRepository: mockAuthenticationRepository,
    //       mockUrlRepository: mockUrlRepository,
    //       tester: tester,
    //     ),
    //   );
    // });

    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.initial} ', (tester) async {
        await investorsPumpAppHelper(
          tester,
          mockGoRouter: mockGoRouter,
        );

        await investorsInitialHelper(tester);
      });
    });
  });
}
