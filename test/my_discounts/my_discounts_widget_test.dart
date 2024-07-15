import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared.dart';

import '../text_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.myDiscounts} ', () {
    late IDiscountRepository mockDiscountRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    setUp(() {
      mockDiscountRepository = MockIDiscountRepository();
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();

      when(mockAppAuthenticationRepository.currentUser)
          .thenAnswer((invocation) => KTestText.userWithoutPhoto);
      when(
        mockDiscountRepository
            .deleteDiscountsById(KTestText.userDiscountModelItems.first.id),
      ).thenAnswer(
        (invocation) async => const Right(true),
      );
    });
    group('${KGroupText.failure} ', () {
      testWidgets('${KGroupText.error} ', (tester) async {
        when(
          mockDiscountRepository
              .getDiscountsByUserId(KTestText.userWithoutPhoto.id),
        ).thenAnswer(
          (invocation) async => const Left(SomeFailure.serverError()),
        );
        await myDiscountsPumpAppHelper(
          mockDiscountRepository: mockDiscountRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          tester: tester,
        );

        await myDiscountFailureHelper(tester);
      });
      testWidgets('${KGroupText.failureNetwork} ', (tester) async {
        when(
          mockDiscountRepository
              .getDiscountsByUserId(KTestText.userWithoutPhoto.id),
        ).thenAnswer(
          (invocation) async => const Left(SomeFailure.network()),
        );
        await myDiscountsPumpAppHelper(
          mockDiscountRepository: mockDiscountRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          tester: tester,
        );

        await myDiscountFailureHelper(tester);
      });
      testWidgets('${KGroupText.failureGet} ', (tester) async {
        when(
          mockDiscountRepository
              .getDiscountsByUserId(KTestText.userWithoutPhoto.id),
        ).thenAnswer(
          (invocation) async => const Left(SomeFailure.get()),
        );
        await myDiscountsPumpAppHelper(
          mockDiscountRepository: mockDiscountRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          tester: tester,
        );

        await myDiscountFailureHelper(tester);
      });
    });

    group('${KGroupText.getList} ', () {
      setUp(() {
        when(
          mockDiscountRepository
              .getDiscountsByUserId(KTestText.userWithoutPhoto.id),
        ).thenAnswer(
          (invocation) async =>
              Right(KTestText.userDiscountModelItems.sublist(0, 1)),
        );
      });
      testWidgets('${KGroupText.intial} ', (tester) async {
        await myDiscountsPumpAppHelper(
          mockDiscountRepository: mockDiscountRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          tester: tester,
        );

        await myDiscountsInitialHelper(tester);
      });

      testWidgets('Delete discount', (tester) async {
        await myDiscountsPumpAppHelper(
          mockDiscountRepository: mockDiscountRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          tester: tester,
        );

        await deleteDiscountHelper(tester);
      });
      group('${KGroupText.goRouter} ', () {
        late MockGoRouter mockGoRouter;
        setUp(() => mockGoRouter = MockGoRouter());
        testWidgets('${KGroupText.intial} ', (tester) async {
          await myDiscountsPumpAppHelper(
            mockDiscountRepository: mockDiscountRepository,
            mockAppAuthenticationRepository: mockAppAuthenticationRepository,
            tester: tester,
            mockGoRouter: mockGoRouter,
          );

          await myDiscountsInitialHelper(tester);
        });
      });
    });
  });
}
