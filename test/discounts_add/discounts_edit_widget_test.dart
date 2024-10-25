import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared.dart';

import '../test_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.discountsEdit} ', () {
    late IDiscountRepository mockDiscountRepository;
    late ICompanyRepository mockCompanyRepository;
    late ICitiesRepository mockCitiesRepository;
    setUp(() {
      Config.roleValue = Config.business;
      ExtendedDateTime.id = KTestText.discountModelItems.first.id;
      ExtendedDateTime.current = KTestText.sendDiscountModel.dateVerified;
      ContextExtensions.pickerDate = KTestText.nextDateTime;
      mockDiscountRepository = MockIDiscountRepository();
      mockCompanyRepository = MockICompanyRepository();
      mockCitiesRepository = MockICitiesRepository();

      when(
        mockDiscountRepository.addDiscount(
          KTestText.sendDiscountModel,
        ),
      ).thenAnswer((invocation) async => const Right(true));

      when(
        mockDiscountRepository.getDiscountItems(),
      ).thenAnswer((invocation) => Stream.value(KTestText.discountModelItems));
      when(
        mockCitiesRepository.getCities(),
      ).thenAnswer(
        (_) async => Right(KTestText.cityModelItems),
      );

      when(
        mockCompanyRepository.currentUserCompany,
      ).thenAnswer(
        (_) => KTestText.fullCompanyModel,
      );
    });
    group('Discount id wrong', () {
      late StreamController<CompanyModel> companyStreamController;
      setUp(() {
        companyStreamController = StreamController()
          ..add(KTestText.fullCompanyModel);
        when(
          mockCompanyRepository.company,
        ).thenAnswer(
          (_) => companyStreamController.stream,
        );
        when(
          mockDiscountRepository.getCompanyDiscount(
            id: KTestText.sendDiscountModel.id,
            companyId: KTestText.fullCompanyModel.id,
          ),
        ).thenAnswer(
          (invocation) async => Left(SomeFailure.serverError(error: null)),
        );
        when(
          mockDiscountRepository.getCompanyDiscount(
            id: KTestText.secondId,
            companyId: KTestText.pureCompanyModel.id,
          ),
        ).thenAnswer(
          (invocation) async => Left(SomeFailure.serverError(error: null)),
        );
      });
      testWidgets('${KGroupText.initial} ', (tester) async {
        await discountsAddPumpAppHelper(
          tester: tester,
          mockDiscountRepository: mockDiscountRepository,
          mockCompanyRepository: mockCompanyRepository,
          mockCitiesRepository: mockCitiesRepository,
          discountId: KTestText.sendDiscountModel.id,
        );

        companyStreamController
            .add(KTestText.fullCompanyModel.copyWith(id: KTestText.secondId));

        await discountsEditIdWrongInitialHelper(tester);
      });
      group('${KGroupText.goRouter} ', () {
        late MockGoRouter mockGoRouter;
        setUp(() => mockGoRouter = MockGoRouter());
        testWidgets('${KGroupText.initial} ', (tester) async {
          await discountsAddPumpAppHelper(
            tester: tester,
            mockDiscountRepository: mockDiscountRepository,
            mockCompanyRepository: mockCompanyRepository,
            mockCitiesRepository: mockCitiesRepository,
            mockGoRouter: mockGoRouter,
            discountId: KTestText.sendDiscountModel.id,
          );

          await discountsEditIdWrongInitialHelper(tester);
        });
        group('${KGroupText.goTo} ', () {
          testWidgets('${KRoute.myDiscounts.name} ', (tester) async {
            await discountsAddPumpAppHelper(
              tester: tester,
              mockDiscountRepository: mockDiscountRepository,
              mockCompanyRepository: mockCompanyRepository,
              mockCitiesRepository: mockCitiesRepository,
              mockGoRouter: mockGoRouter,
              discountId: KTestText.sendDiscountModel.id,
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
            id: KTestText.sendDiscountModel.id,
            companyId: KTestText.fullCompanyModel.id,
          ),
        ).thenAnswer((invocation) async => Right(KTestText.sendDiscountModel));
      });
      testWidgets('${KGroupText.initial} ', (tester) async {
        await discountsAddPumpAppHelper(
          tester: tester,
          mockDiscountRepository: mockDiscountRepository,
          mockCompanyRepository: mockCompanyRepository,
          mockCitiesRepository: mockCitiesRepository,
          discountId: KTestText.sendDiscountModel.id,
        );

        await discountsAddInitialHelper(tester: tester, isEdit: true);
      });
      group('${KGroupText.goRouter} ', () {
        late MockGoRouter mockGoRouter;
        setUp(() => mockGoRouter = MockGoRouter());
        testWidgets('${KGroupText.initial} ', (tester) async {
          await discountsAddPumpAppHelper(
            tester: tester,
            mockDiscountRepository: mockDiscountRepository,
            mockCompanyRepository: mockCompanyRepository,
            mockCitiesRepository: mockCitiesRepository,
            mockGoRouter: mockGoRouter,
            discountId: KTestText.sendDiscountModel.id,
          );

          await discountsAddInitialHelper(tester: tester, isEdit: true);
        });
        testWidgets('Discount not enter anything and tap on send button',
            (tester) async {
          await discountsAddPumpAppHelper(
            tester: tester,
            mockDiscountRepository: mockDiscountRepository,
            mockCompanyRepository: mockCompanyRepository,
            mockCitiesRepository: mockCitiesRepository,
            mockGoRouter: mockGoRouter,
            discountId: KTestText.sendDiscountModel.id,
          );

          await discountsEditFormHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
        testWidgets('Discount enter correct', (tester) async {
          await discountsAddPumpAppHelper(
            tester: tester,
            mockDiscountRepository: mockDiscountRepository,
            mockCompanyRepository: mockCompanyRepository,
            mockCitiesRepository: mockCitiesRepository,
            mockGoRouter: mockGoRouter,
            discountId: KTestText.sendDiscountModel.id,
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
          tester: tester,
          mockDiscountRepository: mockDiscountRepository,
          mockCompanyRepository: mockCompanyRepository,
          mockCitiesRepository: mockCitiesRepository,
          discount: KTestText.sendDiscountModel.copyWith(link: ''),
          discountId: KTestText.sendDiscountModel.id,
        );

        await discountsAddInitialHelper(tester: tester, isEdit: true);
      });
      group('${KGroupText.goRouter} ', () {
        late MockGoRouter mockGoRouter;
        setUp(() => mockGoRouter = MockGoRouter());
        testWidgets('${KGroupText.initial} ', (tester) async {
          await discountsAddPumpAppHelper(
            tester: tester,
            mockDiscountRepository: mockDiscountRepository,
            mockCompanyRepository: mockCompanyRepository,
            mockCitiesRepository: mockCitiesRepository,
            mockGoRouter: mockGoRouter,
            discount: KTestText.sendDiscountModel.copyWith(link: ''),
            discountId: KTestText.sendDiscountModel.id,
          );

          await discountsAddInitialHelper(tester: tester, isEdit: true);
        });
        testWidgets('Discount not enter anything and tap on send button',
            (tester) async {
          await discountsAddPumpAppHelper(
            tester: tester,
            mockDiscountRepository: mockDiscountRepository,
            mockCompanyRepository: mockCompanyRepository,
            mockCitiesRepository: mockCitiesRepository,
            mockGoRouter: mockGoRouter,
            discount: KTestText.sendDiscountModel.copyWith(link: ''),
            discountId: KTestText.sendDiscountModel.id,
          );

          await discountsEditFormHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
        testWidgets('Discount enter correct', (tester) async {
          await discountsAddPumpAppHelper(
            tester: tester,
            mockDiscountRepository: mockDiscountRepository,
            mockCompanyRepository: mockCompanyRepository,
            mockCitiesRepository: mockCitiesRepository,
            mockGoRouter: mockGoRouter,
            discount: KTestText.sendDiscountModel
                .copyWith(subLocation: SubLocation.online),
            discountId: KTestText.sendDiscountModel.id,
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
