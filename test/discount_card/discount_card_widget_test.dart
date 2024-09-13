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
  group('${KScreenBlocName.discountCard} ', () {
    late IDiscountRepository mockDiscountRepository;
    setUp(() {
      mockDiscountRepository = MockIDiscountRepository();
    });
    group('${KGroupText.failureGet} ', () {
      setUp(() {
        when(
          mockDiscountRepository
              .getDiscount(KTestText.discountModelItems.first.id),
        ).thenAnswer(
          (realInvocation) async =>
              Left(SomeFailure.serverError(error: KGroupText.failure)),
        );
      });
      testWidgets('${KGroupText.intial} ', (tester) async {
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
          mockDiscountRepository
              .getDiscount(KTestText.discountModelItems.first.id),
        ).thenAnswer(
          (realInvocation) async => Right(KTestText.discountModelItems.first),
        );
      });
      testWidgets('${KGroupText.intial} ', (tester) async {
        await discountCardPumpAppHelper(
          tester: tester,
          mockDiscountRepository: mockDiscountRepository,
        );

        await discountCardInitialHelper(tester: tester);
      });

      group('${KGroupText.goRouter} ', () {
        late MockGoRouter mockGoRouter;
        setUp(() => mockGoRouter = MockGoRouter());
        testWidgets('${KGroupText.intial} ', (tester) async {
          await discountCardPumpAppHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
            mockDiscountRepository: mockDiscountRepository,
          );

          await discountCardInitialHelper(tester: tester);
        });
        group('${KGroupText.goTo} ', () {
          group('${KGroupText.failureGet} ', () {
            setUp(() {
              when(
                mockDiscountRepository
                    .getDiscount(KTestText.discountModelItems.first.id),
              ).thenAnswer(
                (realInvocation) async =>
                    Left(SomeFailure.notFound(error: KGroupText.failure)),
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
