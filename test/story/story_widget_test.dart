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
  group('${KScreenBlocName.story} ', () {
    late IStoryRepository mockStoryRepository;
    late AuthenticationRepository mockAuthenticationRepository;
    setUp(() {
      ExtendedDateTime.current = KTestVariables.dateTime;
      ExtendedDateTime.id = '';
      mockStoryRepository = MockIStoryRepository();
      mockAuthenticationRepository = MockAuthenticationRepository();
      when(mockAuthenticationRepository.currectAuthenticationStatus).thenAnswer(
        (realInvocation) => AuthenticationStatus.authenticated,
      );
    });
    group('${KGroupText.failure} ', () {
      setUp(() {
        when(mockStoryRepository.getStoryItems()).thenAnswer(
          (invocation) => Stream.error(Exception(KGroupText.failureGet)),
        );
      });
      testWidgets('${KGroupText.failureGet} ', (tester) async {
        await storyPumpAppHelper(
          mockAuthenticationRepository: mockAuthenticationRepository,
          mockStoryRepository: mockStoryRepository,
          tester: tester,
        );

        await storyFailureHelper(tester);
      });
    });
    group('${KGroupText.getList} ', () {
      setUp(() {
        when(mockStoryRepository.getStoryItems()).thenAnswer(
          (invocation) => Stream.value(KTestVariables.storyModelItems),
        );
      });
      testWidgets('${KGroupText.initial} ', (tester) async {
        await storyPumpAppHelper(
          tester: tester,
          mockStoryRepository: mockStoryRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
        );

        await storyInitialHelper(tester);
      });

      loadingList(
        (tester) async => storyPumpAppHelper(
          tester: tester,
          mockStoryRepository: mockStoryRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
        ),
        // lastCard: KWidgetkeys.screen.story.cardLast,
      );

      testWidgets('Stories list load ', (tester) async {
        await storyPumpAppHelper(
          mockStoryRepository: mockStoryRepository,
          tester: tester,
          mockAuthenticationRepository: mockAuthenticationRepository,
        );

        await listLoadHelper(tester);
      });
      group('${KGroupText.goRouter} ', () {
        late MockGoRouter mockGoRouter;
        setUp(() => mockGoRouter = MockGoRouter());
        testWidgets('${KGroupText.initial} ', (tester) async {
          await storyPumpAppHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
            mockStoryRepository: mockStoryRepository,
            mockAuthenticationRepository: mockAuthenticationRepository,
          );

          await storyInitialHelper(tester);
        });
        group('${KGroupText.goTo} ', () {
          testWidgets('${KRoute.storyAdd.name} ', (tester) async {
            await storyPumpAppHelper(
              tester: tester,
              mockGoRouter: mockGoRouter,
              mockStoryRepository: mockStoryRepository,
              mockAuthenticationRepository: mockAuthenticationRepository,
            );

            await storyAddNavigationHelper(
              tester: tester,
              mockGoRouter: mockGoRouter,
            );
          });
        });
      });
    });
  });
}
