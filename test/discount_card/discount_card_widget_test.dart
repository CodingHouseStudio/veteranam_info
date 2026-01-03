import 'package:dartz/dartz.dart';
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
  group('${KScreenBlocName.discountCard} ', () {
    setUp(discountCardTestWIdgetRegister);
    group('${KGroupText.failureGet} ', () {
      setUp(() {
        when(
          mockDiscountRepository.getDiscount(
            id: KTestVariables.discountModelItems.first.id,
            showOnlyBusinessDiscounts: false,
          ),
        ).thenAnswer(
          (realInvocation) async => const Left(SomeFailure.serverError),
        );
      });
      testWidgets('${KGroupText.initial} ', (tester) async {
        await discountCardPumpAppHelper(
          tester: tester,
          mockDiscountRepository: mockDiscountRepository,
        );

        await discountCardInitialHelper(tester: tester, cardIsEmpty: true);
      });
    });
    group('${KGroupText.successfulGet} ', () {
      setUp(() {
        when(
          mockDiscountRepository.getDiscount(
            id: KTestVariables.discountModelItems.first.id,
            showOnlyBusinessDiscounts: false,
          ),
        ).thenAnswer(
          (realInvocation) async =>
              Right(KTestVariables.discountModelItems.first),
        );
      });
      testWidgets('${KGroupText.initial} ', (tester) async {
        await discountCardPumpAppHelper(
          tester: tester,
          mockDiscountRepository: mockDiscountRepository,
        );

        await discountCardInitialHelper(tester: tester);
      });

      group('${KGroupText.goRouter} ', () {
        late MockGoRouter mockGoRouter;
        setUp(() => mockGoRouter = MockGoRouter());
        testWidgets('${KGroupText.initial} ', (tester) async {
          await discountCardPumpAppHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
            mockDiscountRepository: mockDiscountRepository,
          );

          await discountCardInitialHelper(tester: tester);
        });
        group('${KGroupText.goTo} ', () {
          group('${KRoute.discount.name} ', () {
            setUp(() {
              when(
                mockDiscountRepository.getDiscount(
                  id: KTestVariables.discountModelItems.first.id,
                  showOnlyBusinessDiscounts: false,
                ),
              ).thenAnswer(
                (realInvocation) async => Right(
                  KTestVariables.moreDiscountModel,
                ),
              );
            });

            testWidgets('discount card navigation ', (tester) async {
              await discountCardPumpAppHelper(
                tester: tester,
                mockDiscountRepository: mockDiscountRepository,
                mockGoRouter: mockGoRouter,
              );

              await discountCardNavigationHelper(
                tester: tester,
                mockGoRouter: mockGoRouter,
              );
            });
          });
          group('${KGroupText.failureGet} ', () {
            setUp(() {
              when(
                mockDiscountRepository.getDiscount(
                  id: KTestVariables.discountModelItems.first.id,
                  showOnlyBusinessDiscounts: false,
                ),
              ).thenAnswer(
                (realInvocation) async => const Left(SomeFailure.dataNotFound),
              );
            });
            testWidgets('Empty Card close', (tester) async {
              await discountCardPumpAppHelper(
                tester: tester,
                mockDiscountRepository: mockDiscountRepository,
                mockGoRouter: mockGoRouter,
              );

              await cardEmptyCloseHelper(
                tester: tester,
                mockGoRouter: mockGoRouter,
                routeName: KRoute.discounts.name,
              );
            });
          });
          testWidgets('${KRoute.discounts.name} ', (tester) async {
            await discountCardPumpAppHelper(
              tester: tester,
              mockGoRouter: mockGoRouter,
              mockDiscountRepository: mockDiscountRepository,
            );

            await cancelHelper(tester: tester, mockGoRouter: mockGoRouter);
          });
        });
      });
    });
  });
}
