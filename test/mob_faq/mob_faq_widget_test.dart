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
  group('${KScreenBlocName.mobFaq} ', () {
    late IFaqRepository mockFaqRepository;
    setUp(() {
      KTest.testIsWeb = false;
      ExtendedDateTime.current = KTestText.dateTime;
      ExtendedDateTime.id = KTestText.feedbackModel.id;
      KPlatformConstants.isWebDesktop = true;
      mockFaqRepository = MockIFaqRepository();
    });
    group('${KGroupText.failure} ', () {
      testWidgets('${KGroupText.error} ', (tester) async {
        when(mockFaqRepository.getQuestions()).thenAnswer(
          (invocation) async => const Left(SomeFailure.serverError()),
        );
        await mobFaqPumpAppHelper(
          mockFaqRepository: mockFaqRepository,
          tester: tester,
        );

        await mobFaqFailureHelper(tester);
      });
      testWidgets('${KGroupText.failureNetwork} ', (tester) async {
        when(mockFaqRepository.getQuestions()).thenAnswer(
          (invocation) async => const Left(SomeFailure.network()),
        );
        await mobFaqPumpAppHelper(
          mockFaqRepository: mockFaqRepository,
          tester: tester,
        );

        await mobFaqFailureHelper(tester);
      });
      testWidgets('${KGroupText.failureGet} ', (tester) async {
        when(mockFaqRepository.getQuestions()).thenAnswer(
          (invocation) async => const Left(SomeFailure.get()),
        );
        await mobFaqPumpAppHelper(
          mockFaqRepository: mockFaqRepository,
          tester: tester,
        );

        await mobFaqFailureHelper(tester);
      });
    });
    group('${KGroupText.getEmptyList} ', () {
      setUp(() {
        when(mockFaqRepository.getQuestions()).thenAnswer(
          (invocation) async => const Right([]),
        );
        when(mockFaqRepository.addMockQuestions()).thenAnswer(
          (invocation) {},
        );
        if (GetIt.I.isRegistered<IFaqRepository>()) {
          GetIt.I.unregister<IFaqRepository>();
        }
        GetIt.I.registerSingleton<IFaqRepository>(mockFaqRepository);
      });
      testWidgets('${KGroupText.mockButton} ', (tester) async {
        await mobFaqPumpAppHelper(
          mockFaqRepository: mockFaqRepository,
          tester: tester,
        );

        await mobFaqMockButtonHelper(tester);
      });
    });
    group('${KGroupText.getList} ', () {
      setUp(() {
        when(mockFaqRepository.getQuestions()).thenAnswer(
          (invocation) async => Right(KTestText.questionModelItems),
        );
      });

      testWidgets('${KGroupText.intial} ', (tester) async {
        await mobFaqPumpAppHelper(
          mockFaqRepository: mockFaqRepository,
          tester: tester,
        );

        await mobFaqInitialHelper(tester);
      });

      group('${KGroupText.goRouter} ', () {
        late MockGoRouter mockGoRouter;
        setUp(() => mockGoRouter = MockGoRouter());
        testWidgets('${KGroupText.intial} ', (tester) async {
          await mobFaqPumpAppHelper(
            mockFaqRepository: mockFaqRepository,
            tester: tester,
            mockGoRouter: mockGoRouter,
          );

          await mobFaqInitialHelper(tester);
        });

        group('${KGroupText.goTo} ', () {
          testWidgets('nawbar back button pop() navigation', (tester) async {
            await mobFaqPumpAppHelper(
              mockFaqRepository: mockFaqRepository,
              tester: tester,
              mockGoRouter: mockGoRouter,
            );

            await nawbarBackButtonHelper(
              tester: tester,
              mockGoRouter: mockGoRouter,
            );
          });
        });
      });
    });
  });
}