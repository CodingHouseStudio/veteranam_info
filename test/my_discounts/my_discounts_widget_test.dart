import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

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
        mockDiscountRepository.getDiscountsById(KTestText.userWithoutPhoto.id),
      ).thenAnswer(
        (invocation) async => Right(KTestText.userDiscountModelItems),
      );
      when(
        mockDiscountRepository
            .deleteDiscountsById(KTestText.userDiscountModelItems.first.id),
      ).thenAnswer(
        (invocation) async => const Right(true),
      );
      when(
        mockDiscountRepository.deleteDiscountsById(
          KTestText.userDiscountModelItems.elementAt(1).id,
        ),
      ).thenAnswer(
        (invocation) async => const Right(true),
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
}
