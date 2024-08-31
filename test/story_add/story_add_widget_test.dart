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
  group('${KScreenBlocName.storyAdd} ', () {
    late IStoryRepository mockStoryRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    setUp(() {
      ExtendedDateTime.current = KTestText.storyModelItems.first.date;
      ExtendedDateTime.id = KTestText.storyModelItems.first.id;
      mockStoryRepository = MockIStoryRepository();
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
      when(mockStoryRepository.addStory(KTestText.storyModelItems.first))
          .thenAnswer(
        (invocation) async => const Right(true),
      );
      when(mockAppAuthenticationRepository.currentUser).thenAnswer(
        (invocation) => KTestText.userWithoutPhoto,
      );
    });
    group('${KGroupText.failure} ', () {
      testWidgets('${KGroupText.error} ', (tester) async {
        when(mockStoryRepository.addStory(KTestText.storyModelItems.first))
            .thenAnswer(
          (invocation) async => Left(
            SomeFailure.serverError(
              error: null,
            ),
          ),
        );
        await storyAddPumpAppHelper(
          tester: tester,
          mockStoryRepository: mockStoryRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
        );

        await storyAddFailureHelper(tester);
      });
      testWidgets('${KGroupText.failureNetwork} ', (tester) async {
        when(mockStoryRepository.addStory(KTestText.storyModelItems.first))
            .thenAnswer(
          (invocation) async => Left(SomeFailure.network(error: null)),
        );
        await storyAddPumpAppHelper(
          tester: tester,
          mockStoryRepository: mockStoryRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
        );

        await storyAddFailureHelper(tester);
      });
      testWidgets('${KGroupText.failureSend} ', (tester) async {
        when(mockStoryRepository.addStory(KTestText.storyModelItems.first))
            .thenAnswer(
          (invocation) async => Left(SomeFailure.send(error: null)),
        );
        await storyAddPumpAppHelper(
          tester: tester,
          mockStoryRepository: mockStoryRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
        );

        await storyAddFailureHelper(tester);
      });
    });
    testWidgets('${KGroupText.intial} ', (tester) async {
      await storyAddPumpAppHelper(
        tester: tester,
        mockStoryRepository: mockStoryRepository,
        mockAppAuthenticationRepository: mockAppAuthenticationRepository,
      );

      await storyAddInitialHelper(tester);
    });
    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.intial} ', (tester) async {
        await storyAddPumpAppHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
          mockStoryRepository: mockStoryRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
        );

        await storyAddInitialHelper(tester);
      });
      testWidgets('Story field enter uncorrect data and send', (tester) async {
        await storyAddPumpAppHelper(
          tester: tester,
          mockStoryRepository: mockStoryRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockGoRouter: mockGoRouter,
        );

        await fieldUncorrectHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
        );
      });
      testWidgets('Story field enter correct data and send', (tester) async {
        await storyAddPumpAppHelper(
          tester: tester,
          mockStoryRepository: mockStoryRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockGoRouter: mockGoRouter,
        );

        await submitedHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
        );
      });
    });
  });
}
