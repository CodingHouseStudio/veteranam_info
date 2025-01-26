import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../test_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUpAll(configureDependenciesTest);

  setUp(resetTestVariables);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.company} ', () {
    setUp(companyWidgetTestRegister);
    testWidgets('${KGroupText.initial} ', (tester) async {
      await companyPumpAppHelper(
        tester,
      );

      await companyInitialHelper(tester);
    });

    testWidgets('Show log out dialog', (tester) async {
      await companyPumpAppHelper(
        tester,
      );

      await companyLogOutHelper(tester);
    });

    group('Company has Discounts', () {
      setUp(() {
        companyStream.add(KTestVariables.fullCompanyModel);

        when(
          mockDiscountRepository
              .companyHasDiscount(KTestVariables.pureCompanyModel.id),
        ).thenAnswer(
          (realInvocation) async => true,
        );
      });
      testWidgets('${KGroupText.initial} ', (tester) async {
        await companyPumpAppHelper(
          tester,
        );

        await companyInitialHelper(tester);
      });
    });

    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.initial} ', (tester) async {
        await companyPumpAppHelper(
          tester,
          mockGoRouter: mockGoRouter,
        );

        await companyInitialHelper(tester);
      });

      testWidgets('Log out desk dialog unconfirm button pop', (tester) async {
        await companyPumpAppHelper(
          tester,
          mockGoRouter: mockGoRouter,
        );
        await logOutUnconfirmButtonlHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
          icon: false,
        );
      });
      testWidgets('Log out mob dialog cancel icon pop', (tester) async {
        await companyPumpAppHelper(
          tester,
          mockGoRouter: mockGoRouter,
        );

        await logOutUnconfirmButtonlHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
          icon: true,
        );
      });

      testWidgets('Log out dialog confirm button pop', (tester) async {
        await companyPumpAppHelper(
          tester,
          mockGoRouter: mockGoRouter,
        );

        await logOutConfirmButtonlHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
        );
      });

      testWidgets('Send correct company data', (tester) async {
        await companyPumpAppHelper(
          tester,
        );

        await companyFormsCorrectSaveHelper(tester);
      });

      testWidgets('Send incorrect company data', (tester) async {
        await companyPumpAppHelper(
          tester,
        );

        companyStream.add(KTestVariables.pureCompanyModel.copyWith(id: 'none'));

        await companyFormsIncorrectSaveHelper(tester);
      });

      group('Delete button is Enabled', () {
        setUp(() => companyStream.add(KTestVariables.fullCompanyModel));

        testWidgets('Delete account desk dialog unconfirm button pop',
            (tester) async {
          await companyPumpAppHelper(
            tester,
            mockGoRouter: mockGoRouter,
          );

          await deleteAccountUnconfirmButtonlHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
            icon: false,
            deskOpen: true,
          );
        });

        testWidgets('Delete account dialog cancel icon pop', (tester) async {
          await companyPumpAppHelper(
            tester,
            mockGoRouter: mockGoRouter,
          );

          await deleteAccountUnconfirmButtonlHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
            icon: true,
          );
        });

        testWidgets('Delete account dialog confirm button pop', (tester) async {
          await companyPumpAppHelper(
            tester,
            mockGoRouter: mockGoRouter,
          );

          await deleteAccountConfirmButtonlHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
      });

      group('${KGroupText.goTo} ', () {
        testWidgets('${KRoute.myDiscounts.name} ', (tester) async {
          await companyPumpAppHelper(
            tester,
            mockGoRouter: mockGoRouter,
          );

          await companyMyDiscountsHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
      });
    });
    tearDown(() async => companyStream.close());
  });
}
