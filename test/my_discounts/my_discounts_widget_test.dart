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
  group('${KScreenBlocName.profileMyStory} ', () {
    late IDiscountRepository mockDiscountRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    setUp(() {
      mockDiscountRepository = MockIDiscountRepository();
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();

      when(mockAppAuthenticationRepository.currentUser)
          .thenAnswer((invocation) => KTestText.userWithoutPhoto);
      when(
        mockDiscountRepository.getDiscountsById(KTestText.userWithoutPhoto.id),
      ).thenAnswer((invocation) async => Right(KTestText.discountModelItems));
    });

    testWidgets('${KGroupText.intial} ', (tester) async {
      await myDiscountsPumpAppHelper(
        mockDiscountRepository: mockDiscountRepository,
        mockAppAuthenticationRepository: mockAppAuthenticationRepository,
        tester: tester,
      );

      await myDiscountsInitialHelper(tester);
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
