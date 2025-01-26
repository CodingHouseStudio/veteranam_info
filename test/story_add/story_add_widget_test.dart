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
  group('${KScreenBlocName.storyAdd} ', () {
    setUp(storyAddWidgetTestRegister);
    group('${KGroupText.failure} ', () {
      testWidgets('${KGroupText.error} ', (tester) async {
        when(
          mockStoryRepository.addStory(
            imageItem: KTestVariables.filePickerItem,
            storyModel: KTestVariables.storyModelItems.first,
          ),
        ).thenAnswer(
          (invocation) async => const Left(SomeFailure.serverError),
        );
        await storyAddPumpAppHelper(
          tester,
        );

        await storyAddFailureHelper(tester);
      });
      testWidgets('${KGroupText.failureNetwork} ', (tester) async {
        when(
          mockStoryRepository.addStory(
            imageItem: KTestVariables.filePickerItem,
            storyModel: KTestVariables.storyModelItems.first,
          ),
        ).thenAnswer(
          (invocation) async => const Left(SomeFailure.network),
        );
        await storyAddPumpAppHelper(
          tester,
        );

        await storyAddFailureHelper(tester);
      });
      testWidgets('${KGroupText.failureSend} ', (tester) async {
        when(
          mockStoryRepository.addStory(
            imageItem: KTestVariables.filePickerItem,
            storyModel: KTestVariables.storyModelItems.first,
          ),
        ).thenAnswer(
          (invocation) async => const Left(SomeFailure.send),
        );
        await storyAddPumpAppHelper(
          tester,
        );

        await storyAddFailureHelper(tester);
      });
    });
    testWidgets('${KGroupText.initial} ', (tester) async {
      await storyAddPumpAppHelper(
        tester,
      );

      await storyAddInitialHelper(tester);
    });
    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.initial} ', (tester) async {
        await storyAddPumpAppHelper(
          tester,
          mockGoRouter: mockGoRouter,
        );

        await storyAddInitialHelper(tester);
      });
      testWidgets('Story field enter uncorrect data and send', (tester) async {
        await storyAddPumpAppHelper(
          tester,
          mockGoRouter: mockGoRouter,
        );

        await fieldUncorrectHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
        );
      });
      testWidgets('Story field enter correct data and send', (tester) async {
        await storyAddPumpAppHelper(
          tester,
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
