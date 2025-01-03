import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/extension/extension_flutter_constants.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../test_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.discountCard} ', () {
    late IDiscountRepository mockDiscountRepository;
    late FirebaseRemoteConfigProvider mockFirebaseRemoteConfigProvider;
    late IUrlRepository mockUrlRepository;
    late IReportRepository mockReportRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    setUp(() {
      mockDiscountRepository = MockIDiscountRepository();
      mockFirebaseRemoteConfigProvider = MockFirebaseRemoteConfigProvider();
      mockUrlRepository = MockIUrlRepository();
      mockReportRepository = MockIReportRepository();
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();

      when(
        mockUrlRepository.copy(
          KTestVariables.fullDiscount.phoneNumber!,
        ),
      ).thenAnswer(
        (realInvocation) async => const Right(true),
      );

      when(
        mockUrlRepository.launchUrl(
          url: KTestVariables.fullDiscount.phoneNumber!,
        ),
      ).thenAnswer(
        (realInvocation) async => const Right(true),
      );

      when(
        mockUrlRepository.share(
          '/discounts/${KTestVariables.id}',
        ),
      ).thenAnswer(
        (realInvocation) async => const Right(true),
      );
    });
    group('${KGroupText.failureGet} ', () {
      setUp(() {
        when(
          mockFirebaseRemoteConfigProvider.getBool(
            RemoteConfigKey.showOnlyBusinessDiscounts,
          ),
        ).thenAnswer(
          (realInvocation) => true,
        );
        when(
          mockDiscountRepository.getDiscount(
            id: KTestVariables.id,
            showOnlyBusinessDiscounts: true,
          ),
        ).thenAnswer(
          (realInvocation) async =>
              Left(SomeFailure.serverError(error: KGroupText.failure)),
        );
      });
      testWidgets('${KGroupText.initial} ', (tester) async {
        await discountPumpAppHelper(
          tester: tester,
          mockDiscountRepository: mockDiscountRepository,
          mockReportRepository: mockReportRepository,
          mockUrlRepository: mockUrlRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
        );

        await discountInitialHelper(tester: tester, cardIsEmpty: true);
      });
      group('${KGroupText.goRouter} ', () {
        late MockGoRouter mockGoRouter;
        setUp(() => mockGoRouter = MockGoRouter());
        testWidgets('${KGroupText.initial} ', (tester) async {
          await discountPumpAppHelper(
            tester: tester,
            mockDiscountRepository: mockDiscountRepository,
            mockReportRepository: mockReportRepository,
            mockUrlRepository: mockUrlRepository,
            mockAppAuthenticationRepository: mockAppAuthenticationRepository,
            mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
            mockGoRouter: mockGoRouter,
          );

          await discountInitialHelper(tester: tester, cardIsEmpty: true);
        });
        group('${KGroupText.goTo} ', () {
          testWidgets('${KRoute.discounts.name} ', (tester) async {
            await discountPumpAppHelper(
              tester: tester,
              mockGoRouter: mockGoRouter,
              mockReportRepository: mockReportRepository,
              mockUrlRepository: mockUrlRepository,
              mockAppAuthenticationRepository: mockAppAuthenticationRepository,
              mockDiscountRepository: mockDiscountRepository,
              mockFirebaseRemoteConfigProvider:
                  mockFirebaseRemoteConfigProvider,
            );

            await discountBackButtonHelper(
              tester: tester,
              mockGoRouter: mockGoRouter,
              cardIsEmpty: true,
            );
          });
        });
      });
    });
    group('${KGroupText.successfulGet} ', () {
      setUp(() {
        when(
          mockFirebaseRemoteConfigProvider.getBool(
            RemoteConfigKey.showOnlyBusinessDiscounts,
          ),
        ).thenAnswer(
          (realInvocation) => false,
        );
        when(
          mockDiscountRepository.getDiscount(
            id: KTestVariables.id,
            showOnlyBusinessDiscounts: false,
          ),
        ).thenAnswer(
          (realInvocation) async => Right(KTestVariables.fullDiscount),
        );
        Config.roleValue = Config.business;
      });
      testWidgets('${KGroupText.initial} ', (tester) async {
        await discountPumpAppHelper(
          tester: tester,
          mockDiscountRepository: mockDiscountRepository,
          mockReportRepository: mockReportRepository,
          mockUrlRepository: mockUrlRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
        );

        await discountInitialHelper(tester: tester);
      });

      testWidgets('${KGroupText.network} ', (tester) async {
        await networkHelper(
          tester: tester,
          pumpApp: () async => discountPumpAppHelper(
            tester: tester,
            mockDiscountRepository: mockDiscountRepository,
            mockReportRepository: mockReportRepository,
            mockUrlRepository: mockUrlRepository,
            mockAppAuthenticationRepository: mockAppAuthenticationRepository,
            mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
          ),
        );

        verify(
          mockDiscountRepository.getDiscount(
            id: KTestVariables.id,
            showOnlyBusinessDiscounts: false,
          ),
        ).called(2);
      });

      testWidgets('Copy Phone Number', (tester) async {
        PlatformEnumFlutter.isWebDesktop = true;
        await discountPumpAppHelper(
          tester: tester,
          mockDiscountRepository: mockDiscountRepository,
          mockReportRepository: mockReportRepository,
          mockUrlRepository: mockUrlRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
        );

        await discountShowPhoneNumberHelper(tester);
      });

      testWidgets('Call Phone Number', (tester) async {
        PlatformEnumFlutter.isWebDesktop = false;

        await discountPumpAppHelper(
          tester: tester,
          mockDiscountRepository: mockDiscountRepository,
          mockReportRepository: mockReportRepository,
          mockUrlRepository: mockUrlRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
        );

        await discountShowPhoneNumberHelper(tester);
      });

      testWidgets('Share', (tester) async {
        await discountPumpAppHelper(
          tester: tester,
          mockDiscountRepository: mockDiscountRepository,
          mockReportRepository: mockReportRepository,
          mockUrlRepository: mockUrlRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          discount: KTestVariables.fullDiscount,
          mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
        );

        await discountShareHelper(
          tester: tester,
          mockUrlRepository: mockUrlRepository,
        );
      });

      testWidgets('Complaint', (tester) async {
        await discountPumpAppHelper(
          tester: tester,
          mockDiscountRepository: mockDiscountRepository,
          mockReportRepository: mockReportRepository,
          mockUrlRepository: mockUrlRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          discount: KTestVariables.fullDiscount,
          mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
        );

        await discountComplaintHelper(tester);
      });

      // TODO(test): fix this test
      // testWidgets('Web Site', (tester) async {
      //   await discountPumpAppHelper(
      //     tester: tester,
      //     mockDiscountRepository: mockDiscountRepository,
      //   mockReportRepository: mockReportRepository,  mockUrlRepository:
      // mockUrlRepository,
      //     discount: KTestVariables.fullDiscount,
      //   mockAppAuthenticationRepository:mockAppAuthenticationRepository,
      // mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
      //   );

      //   await discountShareHelper(
      //     tester: tester,
      //     mockUrlRepository: mockUrlRepository,
      //   );
      // });

      group('${KGroupText.goRouter} ', () {
        late MockGoRouter mockGoRouter;
        setUp(() => mockGoRouter = MockGoRouter());
        testWidgets('${KGroupText.initial} ', (tester) async {
          await discountPumpAppHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
            mockReportRepository: mockReportRepository,
            mockUrlRepository: mockUrlRepository,
            mockAppAuthenticationRepository: mockAppAuthenticationRepository,
            mockDiscountRepository: mockDiscountRepository,
            mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
          );

          await discountInitialHelper(tester: tester);
        });
        group('${KGroupText.goTo} ', () {
          testWidgets('${KRoute.discounts.name} ', (tester) async {
            await discountPumpAppHelper(
              tester: tester,
              mockGoRouter: mockGoRouter,
              mockReportRepository: mockReportRepository,
              mockUrlRepository: mockUrlRepository,
              mockAppAuthenticationRepository: mockAppAuthenticationRepository,
              mockDiscountRepository: mockDiscountRepository,
              mockFirebaseRemoteConfigProvider:
                  mockFirebaseRemoteConfigProvider,
            );

            await discountBackButtonHelper(
              tester: tester,
              mockGoRouter: mockGoRouter,
              cardIsEmpty: false,
            );
          });
        });
      });
    });
  });
}
