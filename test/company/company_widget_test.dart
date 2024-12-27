import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../test_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.company} ', () {
    late UserRepository mockUserRepository;
    late IDataPickerRepository mockDataPickerRepository;
    late ICompanyRepository mockCompanyRepository;
    late IDiscountRepository mockDiscountRepository;
    late StreamController<CompanyModel> companyStream;
    // late XFile image;
    setUp(() {
      Config.roleValue = Config.business;
      mockUserRepository = MockUserRepository();
      mockDataPickerRepository = MockIDataPickerRepository();
      mockCompanyRepository = MockICompanyRepository();
      mockDiscountRepository = MockIDiscountRepository();
      companyStream = StreamController()..add(KTestVariables.pureCompanyModel);
      // image = XFile(KTestText.imageModels.downloadURL);
      // mockAppAuthenticationRepository = MockAppAuthenticationRepository();

      when(mockUserRepository.currentUser).thenAnswer(
        (realInvocation) => KTestVariables.userWithoutPhoto,
      );
      when(mockUserRepository.currentUserSetting).thenAnswer(
        (realInvocation) => KTestVariables.userSettingModel,
      );

      when(mockCompanyRepository.currentUserCompany).thenAnswer(
        (realInvocation) => KTestVariables.pureCompanyModel,
      );
      when(mockCompanyRepository.company).thenAnswer(
        (realInvocation) => companyStream.stream,
      );
      when(
        mockCompanyRepository.updateCompany(
          company: KTestVariables.fullCompanyModel,
          imageItem: KTestVariables.filePickerItem,
        ),
      ).thenAnswer(
        (realInvocation) async => const Right(true),
      );
      when(
        mockCompanyRepository.deleteCompany(),
      ).thenAnswer(
        (realInvocation) async => const Right(true),
      );
      when(
        mockDiscountRepository
            .companyHasDiscount(KTestVariables.pureCompanyModel.id),
      ).thenAnswer(
        (realInvocation) async => false,
      );

      // when(imagePickerValue.pickImage(source: ImageSource.gallery)).
      // thenAnswer(
      //   (realInvocation) async => image,
      // );

      when(
        mockDataPickerRepository.getImage,
      ).thenAnswer(
        (realInvocation) async => KTestVariables.filePickerItem,
      );

      // when(mockUserRepository.isAnonymously).thenAnswer(
      //   (realInvocation) => false,
      // );
    });
    testWidgets('${KGroupText.initial} ', (tester) async {
      await companyPumpAppHelper(
        tester: tester,
        mockCompanyRepository: mockCompanyRepository,
        mockDiscountRepository: mockDiscountRepository,
        mockUserRepository: mockUserRepository,
        mockDataPickerRepository: mockDataPickerRepository,
      );

      await companyInitialHelper(tester);
    });

    testWidgets('Show log out dialog', (tester) async {
      await companyPumpAppHelper(
        tester: tester,
        mockCompanyRepository: mockCompanyRepository,
        mockDiscountRepository: mockDiscountRepository,
        mockUserRepository: mockUserRepository,
        mockDataPickerRepository: mockDataPickerRepository,
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
          tester: tester,
          mockCompanyRepository: mockCompanyRepository,
          mockDiscountRepository: mockDiscountRepository,
          mockUserRepository: mockUserRepository,
          mockDataPickerRepository: mockDataPickerRepository,
        );

        await companyInitialHelper(tester);
      });
    });

    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.initial} ', (tester) async {
        await companyPumpAppHelper(
          tester: tester,
          mockCompanyRepository: mockCompanyRepository,
          mockDiscountRepository: mockDiscountRepository,
          mockGoRouter: mockGoRouter,
          mockUserRepository: mockUserRepository,
          mockDataPickerRepository: mockDataPickerRepository,
        );

        await companyInitialHelper(tester);
      });

      testWidgets('Log out desk dialog unconfirm button pop', (tester) async {
        await companyPumpAppHelper(
          tester: tester,
          mockCompanyRepository: mockCompanyRepository,
          mockDiscountRepository: mockDiscountRepository,
          mockGoRouter: mockGoRouter,
          mockUserRepository: mockUserRepository,
          mockDataPickerRepository: mockDataPickerRepository,
        );
        await logOutUnconfirmButtonlHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
          icon: false,
          deskOpen: true,
        );
      });
      testWidgets('Log out mob dialog cancel icon pop', (tester) async {
        await companyPumpAppHelper(
          tester: tester,
          mockCompanyRepository: mockCompanyRepository,
          mockDiscountRepository: mockDiscountRepository,
          mockGoRouter: mockGoRouter,
          mockUserRepository: mockUserRepository,
          mockDataPickerRepository: mockDataPickerRepository,
        );

        await logOutUnconfirmButtonlHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
          icon: true,
        );
      });

      testWidgets('Log out dialog confirm button pop', (tester) async {
        await companyPumpAppHelper(
          tester: tester,
          mockCompanyRepository: mockCompanyRepository,
          mockDiscountRepository: mockDiscountRepository,
          mockGoRouter: mockGoRouter,
          mockDataPickerRepository: mockDataPickerRepository,
          mockUserRepository: mockUserRepository,
        );

        await logOutConfirmButtonlHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
        );
      });

      testWidgets('Send correct company data', (tester) async {
        await companyPumpAppHelper(
          tester: tester,
          mockCompanyRepository: mockCompanyRepository,
          mockDiscountRepository: mockDiscountRepository,
          mockUserRepository: mockUserRepository,
          mockDataPickerRepository: mockDataPickerRepository,
        );

        await companyFormsCorrectSaveHelper(tester);
      });

      testWidgets('Send incorrect company data', (tester) async {
        await companyPumpAppHelper(
          tester: tester,
          mockCompanyRepository: mockCompanyRepository,
          mockDiscountRepository: mockDiscountRepository,
          mockUserRepository: mockUserRepository,
          mockDataPickerRepository: mockDataPickerRepository,
        );

        companyStream.add(KTestVariables.pureCompanyModel.copyWith(id: 'none'));

        await companyFormsIncorrectSaveHelper(tester);
      });

      group('Delete button is Enabled', () {
        setUp(() => companyStream.add(KTestVariables.fullCompanyModel));

        testWidgets('Delete account desk dialog unconfirm button pop',
            (tester) async {
          await companyPumpAppHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
            mockUserRepository: mockUserRepository,
            mockDataPickerRepository: mockDataPickerRepository,
            mockCompanyRepository: mockCompanyRepository,
            mockDiscountRepository: mockDiscountRepository,
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
            tester: tester,
            mockGoRouter: mockGoRouter,
            mockUserRepository: mockUserRepository,
            mockCompanyRepository: mockCompanyRepository,
            mockDiscountRepository: mockDiscountRepository,
            mockDataPickerRepository: mockDataPickerRepository,
          );

          await deleteAccountUnconfirmButtonlHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
            icon: true,
          );
        });

        testWidgets('Delete account dialog confirm button pop', (tester) async {
          await companyPumpAppHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
            mockUserRepository: mockUserRepository,
            mockDataPickerRepository: mockDataPickerRepository,
            mockCompanyRepository: mockCompanyRepository,
            mockDiscountRepository: mockDiscountRepository,
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
            tester: tester,
            mockGoRouter: mockGoRouter,
            mockUserRepository: mockUserRepository,
            mockCompanyRepository: mockCompanyRepository,
            mockDiscountRepository: mockDiscountRepository,
            mockDataPickerRepository: mockDataPickerRepository,
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
