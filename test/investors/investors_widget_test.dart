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
  group('${KScreenBlocName.investors} ', () {
    late IInvestorsRepository mockInvestorsRepository;
    setUp(
      () => mockInvestorsRepository = MockIInvestorsRepository(),
    );
    group('${KGroupText.failure} ', () {
      testWidgets('${KGroupText.error} ', (tester) async {
        when(mockInvestorsRepository.getFunds()).thenAnswer(
          (invocation) async => const Left(SomeFailure.serverError()),
        );
        await investorsPumpAppHelper(
          mockInvestorsRepository: mockInvestorsRepository,
          tester: tester,
        );

        await investorsFailureHelper(tester);
      });
      testWidgets('${KGroupText.failureNetwork} ', (tester) async {
        when(mockInvestorsRepository.getFunds()).thenAnswer(
          (invocation) async => const Left(SomeFailure.network()),
        );
        await investorsPumpAppHelper(
          mockInvestorsRepository: mockInvestorsRepository,
          tester: tester,
        );

        await investorsFailureHelper(tester);
      });
      testWidgets('${KGroupText.failureGet} ', (tester) async {
        when(mockInvestorsRepository.getFunds()).thenAnswer(
          (invocation) async => const Left(SomeFailure.get()),
        );
        await investorsPumpAppHelper(
          mockInvestorsRepository: mockInvestorsRepository,
          tester: tester,
        );

        await investorsFailureHelper(tester);
      });
    });
    group('${KGroupText.getEmptyList} ', () {
      setUp(() {
        when(mockInvestorsRepository.getFunds()).thenAnswer(
          (invocation) async => const Right([]),
        );

        when(mockInvestorsRepository.addMockFunds()).thenAnswer(
          (invocation) {},
        );
        if (GetIt.I.isRegistered<IInvestorsRepository>()) {
          GetIt.I.unregister<IInvestorsRepository>();
        }
        GetIt.I.registerSingleton<IInvestorsRepository>(
          mockInvestorsRepository,
        );
      });
      testWidgets('${KGroupText.mockButton} ', (tester) async {
        await investorsPumpAppHelper(
          mockInvestorsRepository: mockInvestorsRepository,
          tester: tester,
        );

        await investorsMockButtonHelper(tester);
      });
    });
    group(KGroupText.getList, () {
      setUp(() {
        when(mockInvestorsRepository.getFunds()).thenAnswer(
          (invocation) async => Right(KTestText.fundItems),
        );
      });

      testWidgets('${KGroupText.intial} ', (tester) async {
        await investorsPumpAppHelper(
          mockInvestorsRepository: mockInvestorsRepository,
          tester: tester,
        );

        await investorsInitialHelper(tester);
      });

      group('${KGroupText.goRouter} ', () {
        late MockGoRouter mockGoRouter;
        setUp(() => mockGoRouter = MockGoRouter());
        testWidgets('${KGroupText.intial} ', (tester) async {
          await investorsPumpAppHelper(
            mockInvestorsRepository: mockInvestorsRepository,
            tester: tester,
            mockGoRouter: mockGoRouter,
          );

          await investorsInitialHelper(tester);
        });
      });
    });
  });
}
