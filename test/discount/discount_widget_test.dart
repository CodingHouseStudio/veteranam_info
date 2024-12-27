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
        // group('${KGroupText.goTo} ', () {
        //   group('${KGroupText.failureGet} ', () {
        //     setUp(() {
        //       when(
        //         mockDiscountRepository.getDiscount(
        //           id: KTestVariables.discountModelItems.first.id,
        //           showOnlyBusinessDiscounts: false,
        //         ),
        //       ).thenAnswer(
        //         (realInvocation) async =>
        //             Left(SomeFailure.notFound(error: KGroupText.failure)),
        //       );
        //     });
        //     testWidgets('Empty Card close', (tester) async {
        //       await discountCardPumpAppHelper(
        //         tester: tester,
        //         mockDiscountRepository: mockDiscountRepository,
        //         mockFirebaseRemoteConfigProvider:
        //             mockFirebaseRemoteConfigProvider,
        //         mockGoRouter: mockGoRouter,
        //       );

        //       await cardEmptyCloseHelper(
        //         tester: tester,
        //         mockGoRouter: mockGoRouter,
        //         routeName: KRoute.discounts.name,
        //       );
        //     });
        //   });
        //   testWidgets('${KRoute.discounts.name} ', (tester) async {
        //     await discountCardPumpAppHelper(
        //       tester: tester,
        //       mockGoRouter: mockGoRouter,
        //       mockDiscountRepository: mockDiscountRepository,
        //       mockFirebaseRemoteConfigProvider:
        //           mockFirebaseRemoteConfigProvider,
        //     );

        //     await cancelHelper(tester: tester, mockGoRouter: mockGoRouter);
        //   });
        // });
      });
    });
  });
}
