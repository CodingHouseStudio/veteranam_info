import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';
import '../helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.discountsEdit} ', () {
    setUp(discountAddEditRegister);
    group('Discount id wrong', () {
      late StreamController<CompanyModel> companyStreamController;
      setUp(() {
        companyStreamController = StreamController()
          ..add(KTestVariables.fullCompanyModel);
        when(
          mockCompanyRepository.company,
        ).thenAnswer(
          (_) => companyStreamController.stream,
        );
        when(
          mockDiscountRepository.getCompanyDiscount(
            id: KTestVariables.sendDiscountModel.id,
            companyId: KTestVariables.fullCompanyModel.id,
          ),
        ).thenAnswer(
          (invocation) async => const Left(SomeFailure.serverError),
        );
        when(
          mockDiscountRepository.getCompanyDiscount(
            id: KTestVariables.secondId,
            companyId: KTestVariables.pureCompanyModel.id,
          ),
        ).thenAnswer(
          (invocation) async => const Left(SomeFailure.serverError),
        );
      });
      testWidgets('${KGroupText.initial} ', (tester) async {
        await discountsAddPumpAppHelper(
          tester,
          discountId: KTestVariables.sendDiscountModel.id,
        );

        companyStreamController.add(
          KTestVariables.fullCompanyModel.copyWith(id: KTestVariables.secondId),
        );

        await discountsEditIdWrongInitialHelper(tester);
      });
      group('${KGroupText.goRouter} ', () {
        late MockGoRouter mockGoRouter;
        setUp(() => mockGoRouter = MockGoRouter());
        testWidgets('${KGroupText.initial} ', (tester) async {
          await discountsAddPumpAppHelper(
            tester,
            mockGoRouter: mockGoRouter,
            discountId: KTestVariables.sendDiscountModel.id,
          );

          await discountsEditIdWrongInitialHelper(tester);
        });
        group('${KGroupText.goTo} ', () {
          testWidgets('${KRoute.myDiscounts.name} ', (tester) async {
            await discountsAddPumpAppHelper(
              tester,
              mockGoRouter: mockGoRouter,
              discountId: KTestVariables.sendDiscountModel.id,
            );

            await discountsEditIdWrongNavHelper(
              tester: tester,
              mockGoRouter: mockGoRouter,
            );
          });
        });
      });
    });
    group('discount id not empty', () {
      setUp(() {
        when(
          mockDiscountRepository.getCompanyDiscount(
            id: KTestVariables.sendDiscountModel.id,
            companyId: KTestVariables.fullCompanyModel.id,
          ),
        ).thenAnswer(
          (invocation) async => Right(KTestVariables.sendDiscountModel),
        );
      });
      testWidgets('${KGroupText.initial} ', (tester) async {
        await discountsAddPumpAppHelper(
          tester,
          discountId: KTestVariables.sendDiscountModel.id,
        );

        await discountsAddInitialHelper(tester: tester, isEdit: true);
      });
      group('${KGroupText.goRouter} ', () {
        late MockGoRouter mockGoRouter;
        setUp(() => mockGoRouter = MockGoRouter());
        testWidgets('${KGroupText.initial} ', (tester) async {
          await discountsAddPumpAppHelper(
            tester,
            mockGoRouter: mockGoRouter,
            discountId: KTestVariables.sendDiscountModel.id,
          );

          await discountsAddInitialHelper(tester: tester, isEdit: true);
        });
        testWidgets('Discount not enter anything and tap on send button',
            (tester) async {
          await discountsAddPumpAppHelper(
            tester,
            mockGoRouter: mockGoRouter,
            discountId: KTestVariables.sendDiscountModel.id,
          );

          await discountsEditFormHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
        testWidgets('Discount enter correct', (tester) async {
          await discountsAddPumpAppHelper(
            tester,
            mockGoRouter: mockGoRouter,
            discountId: KTestVariables.sendDiscountModel.id,
          );

          await discountsAddCorectHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
            isEdit: true,
          );
        });
      });
    });
    group('discount extra not empty', () {
      testWidgets('${KGroupText.initial} ', (tester) async {
        await discountsAddPumpAppHelper(
          tester,
          discount: KTestVariables.sendDiscountModel.copyWith(link: ''),
          discountId: KTestVariables.sendDiscountModel.id,
        );

        await discountsAddInitialHelper(tester: tester, isEdit: true);
      });
      group('${KGroupText.goRouter} ', () {
        late MockGoRouter mockGoRouter;
        setUp(() => mockGoRouter = MockGoRouter());
        testWidgets('${KGroupText.initial} ', (tester) async {
          await discountsAddPumpAppHelper(
            tester,
            mockGoRouter: mockGoRouter,
            discount: KTestVariables.sendDiscountModel.copyWith(link: ''),
            discountId: KTestVariables.sendDiscountModel.id,
          );

          await discountsAddInitialHelper(tester: tester, isEdit: true);
        });
        testWidgets('Discount not enter anything and tap on send button',
            (tester) async {
          await discountsAddPumpAppHelper(
            tester,
            mockGoRouter: mockGoRouter,
            discount: KTestVariables.widgetSendDiscountModel,
            discountId: KTestVariables.sendDiscountModel.id,
          );

          await discountsEditFormHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
        testWidgets('Discount enter correct', (tester) async {
          await discountsAddPumpAppHelper(
            tester,
            mockGoRouter: mockGoRouter,
            discount: KTestVariables.sendDiscountModel
                .copyWith(subLocation: SubLocation.online),
            discountId: KTestVariables.sendDiscountModel.id,
          );

          await discountsAddCorectHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
            isEdit: true,
          );
        });
      });
    });
  });
}
