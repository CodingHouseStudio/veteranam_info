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
  group('${KScreenBlocName.profileMyStory} ', () {
    late IStoryRepository mockStoryRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    setUp(() {
      mockStoryRepository = MockIStoryRepository();
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();

      when(mockAppAuthenticationRepository.currentUser)
          .thenAnswer((invocation) => KTestVariables.userWithoutPhoto);
    });

    group('${KGroupText.failure} ', () {
      testWidgets('${KGroupText.error} ', (tester) async {
        when(
          mockStoryRepository
              .getStoriesByUserId(KTestVariables.userWithoutPhoto.id),
        ).thenAnswer(
          (invocation) async => const Left(SomeFailure.serverError),
        );
        await myStoryPumpAppHelper(
          mockStoryRepository: mockStoryRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          tester: tester,
        );

        await myStoryFailureHelper(tester);
      });
      testWidgets('${KGroupText.failureNetwork} ', (tester) async {
        when(
          mockStoryRepository
              .getStoriesByUserId(KTestVariables.userWithoutPhoto.id),
        ).thenAnswer(
          (invocation) async => const Left(SomeFailure.network),
        );
        await myStoryPumpAppHelper(
          mockStoryRepository: mockStoryRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          tester: tester,
        );

        await myStoryFailureHelper(tester);
      });
      testWidgets('${KGroupText.failureGet} ', (tester) async {
        when(
          mockStoryRepository
              .getStoriesByUserId(KTestVariables.userWithoutPhoto.id),
        ).thenAnswer(
          (invocation) async => const Left(SomeFailure.get),
        );
        await myStoryPumpAppHelper(
          mockStoryRepository: mockStoryRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          tester: tester,
        );

        await myStoryFailureHelper(tester);
      });
    });

    group('${KGroupText.getList} ', () {
      setUp(() {
        when(
          mockStoryRepository
              .getStoriesByUserId(KTestVariables.userWithoutPhoto.id),
        ).thenAnswer(
          (invocation) async => Right(
            KTestVariables.storyModelItems,
          ),
        );
      });
      testWidgets('${KGroupText.initial} ', (tester) async {
        await myStoryPumpAppHelper(
          mockStoryRepository: mockStoryRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          tester: tester,
        );

        await myStoryInitialHelper(tester);
      });
      group('${KGroupText.goRouter} ', () {
        late MockGoRouter mockGoRouter;
        setUp(() => mockGoRouter = MockGoRouter());
        testWidgets('${KGroupText.initial} ', (tester) async {
          await myStoryPumpAppHelper(
            mockStoryRepository: mockStoryRepository,
            mockAppAuthenticationRepository: mockAppAuthenticationRepository,
            tester: tester,
            mockGoRouter: mockGoRouter,
          );

          await myStoryInitialHelper(tester);
        });
      });
    });
  });
}
