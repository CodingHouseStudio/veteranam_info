import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/extension/extension_flutter_constants.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';
import '../helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.discountCard} ', () {
    setUp(discountWidgetTestRegister);
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
          (realInvocation) async => const Left(SomeFailure.serverError),
        );
      });
      testWidgets('${KGroupText.initial} ', (tester) async {
        await discountPumpAppHelper(
          tester,
        );

        await discountInitialHelper(tester: tester, cardIsEmpty: true);
      });
      group('${KGroupText.goRouter} ', () {
        late MockGoRouter mockGoRouter;
        setUp(() => mockGoRouter = MockGoRouter());
        testWidgets('${KGroupText.initial} ', (tester) async {
          await discountPumpAppHelper(
            tester,
            mockGoRouter: mockGoRouter,
          );

          await discountInitialHelper(tester: tester, cardIsEmpty: true);
        });
        group('${KGroupText.goTo} ', () {
          testWidgets('${KRoute.discounts.name} ', (tester) async {
            await discountPumpAppHelper(
              tester,
              mockGoRouter: mockGoRouter,
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
        // Config.roleValue = Config.business;
      });
      testWidgets('${KGroupText.initial} ', (tester) async {
        await discountPumpAppHelper(
          tester,
        );

        await discountInitialHelper(tester: tester);
      });

      testWidgets('${KGroupText.network} ', (tester) async {
        await networkHelper(
          tester: tester,
          pumpApp: () async => discountPumpAppHelper(
            tester,
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
          tester,
        );

        await discountShowPhoneNumberHelper(tester);
      });

      testWidgets('Call Phone Number', (tester) async {
        PlatformEnumFlutter.isWebDesktop = false;

        await discountPumpAppHelper(
          tester,
        );

        await discountShowPhoneNumberHelper(tester);
      });

      testWidgets('Share', (tester) async {
        await discountPumpAppHelper(
          tester,
          discount: KTestVariables.fullDiscount,
        );

        await discountShareHelper(
          tester: tester,
          mockUrlRepository: mockUrlRepository,
        );
      });

      testWidgets('Complaint', (tester) async {
        await discountPumpAppHelper(
          tester,
          discount: KTestVariables.fullDiscount,
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
            tester,
            mockGoRouter: mockGoRouter,
          );

          await discountInitialHelper(tester: tester);
        });
        group('${KGroupText.goTo} ', () {
          testWidgets('${KRoute.discounts.name} ', (tester) async {
            await discountPumpAppHelper(
              tester,
              mockGoRouter: mockGoRouter,
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
