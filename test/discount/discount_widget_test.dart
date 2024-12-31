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
    setUp(() {
      mockDiscountRepository = MockIDiscountRepository();
      mockFirebaseRemoteConfigProvider = MockFirebaseRemoteConfigProvider();
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
            mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
          );

          await discountInitialHelper(tester: tester, cardIsEmpty: true);
        });
        group('${KGroupText.goTo} ', () {
          testWidgets('${KRoute.discounts.name} ', (tester) async {
            await discountPumpAppHelper(
              tester: tester,
              mockGoRouter: mockGoRouter,
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
      });
      testWidgets('${KGroupText.initial} ', (tester) async {
        await discountPumpAppHelper(
          tester: tester,
          mockDiscountRepository: mockDiscountRepository,
          mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
        );

        await discountInitialHelper(tester: tester);
      });

      testWidgets('Copy Phone Number', (tester) async {
        await discountPumpAppHelper(
          tester: tester,
          mockDiscountRepository: mockDiscountRepository,
          mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
        );

        await discountShowPhoneNumberHelper(tester);
      });

      testWidgets('Call Phone Number', (tester) async {
        PlatformEnumFlutter.isWebDesktop = false;

        await discountPumpAppHelper(
          tester: tester,
          mockDiscountRepository: mockDiscountRepository,
          mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
        );

        await discountShowPhoneNumberHelper(tester);
      });

      group('${KGroupText.goRouter} ', () {
        late MockGoRouter mockGoRouter;
        setUp(() => mockGoRouter = MockGoRouter());
        testWidgets('${KGroupText.initial} ', (tester) async {
          await discountPumpAppHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
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
