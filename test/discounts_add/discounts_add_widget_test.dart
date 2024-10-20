import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../test_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.discountsAdd} ', () {
    late IDiscountRepository mockDiscountRepository;
    late ICompanyRepository mockCompanyRepository;
    late ICitiesRepository mockCitiesRepository;
    setUp(() {
      Config.roleValue = Config.business;
      ExtendedDateTime.id = KTestText.discountModelItems.first.id;
      ExtendedDateTime.current = KTestText.sendDiscountModel.dateVerified;
      DiscountsAddBloc.sendDiscountModel = KTestText.sendDiscountModel;
      ContextExtensions.textPieckerData = KTestText.dateTime;
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
        (_) => const CompanyModel(id: '1', userEmails: []),
      );
    });
    testWidgets('${KGroupText.initial} ', (tester) async {
      await discountsAddPumpAppHelper(
        tester: tester,
        mockDiscountRepository: mockDiscountRepository,
        mockCompanyRepository: mockCompanyRepository,
        mockCitiesRepository: mockCitiesRepository,
      );

      await discountsAddInitialHelper(tester);
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
        );

        await discountsAddInitialHelper(tester);
      });
      testWidgets('Discount enter correct', (tester) async {
        await discountsAddPumpAppHelper(
          tester: tester,
          mockDiscountRepository: mockDiscountRepository,
          mockCompanyRepository: mockCompanyRepository,
          mockCitiesRepository: mockCitiesRepository,
          mockGoRouter: mockGoRouter,
        );

        await discountsAddCorectHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
        );
      });
      testWidgets('Discount enter uncorrect', (tester) async {
        await discountsAddPumpAppHelper(
          tester: tester,
          mockDiscountRepository: mockDiscountRepository,
          mockCompanyRepository: mockCompanyRepository,
          mockCitiesRepository: mockCitiesRepository,
          mockGoRouter: mockGoRouter,
        );

        await discountsAddUncorectHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
        );
      });

      testWidgets('Cancel dialog unconfirm button pop', (tester) async {
        await discountsAddPumpAppHelper(
          tester: tester,
          mockDiscountRepository: mockDiscountRepository,
          mockCompanyRepository: mockCompanyRepository,
          mockCitiesRepository: mockCitiesRepository,
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
          tester: tester,
          mockDiscountRepository: mockDiscountRepository,
          mockCompanyRepository: mockCompanyRepository,
          mockCitiesRepository: mockCitiesRepository,
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
