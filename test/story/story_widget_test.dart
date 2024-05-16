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
  group('${KScreenBlocName.story} ', () {
    late IStoryRepository mockStoryRepository;
    setUp(() {
      mockStoryRepository = MockIStoryRepository();
      when(mockStoryRepository.getStoryItems()).thenAnswer(
        (invocation) => Stream.value(KTestText.storyModelItems),
      );
    });
    testWidgets('${KGroupText.intial} ', (tester) async {
      await storyPumpAppHelper(
        tester: tester,
        mockStoryRepository: mockStoryRepository,
      );

      await storyInitialHelper(tester);
    });
    testWidgets('Stories list load ', (tester) async {
      await storyPumpAppHelper(
        mockStoryRepository: mockStoryRepository,
        tester: tester,
      );

      await listLoadHelper(tester);
    });
    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.intial} ', (tester) async {
        await storyPumpAppHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
          mockStoryRepository: mockStoryRepository,
        );

        await storyInitialHelper(tester);
      });
    });
  });
}
