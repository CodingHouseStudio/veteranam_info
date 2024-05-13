import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group('${KScreenBlocName.story} ${KGroupText.repository} ', () {
    late IStoryRepository mockStoryRepository;
    late FirestoreService mockFirestoreService;
    group('${KGroupText.successfulGet} ', () {
      setUp(() {
        ExtendedDateTime.id = '';
        ExtendedDateTime.customTime = KTestText.dateTime;
        mockFirestoreService = MockFirestoreService();
        mockStoryRepository = MockIStoryRepository();
        when(mockFirestoreService.getStories()).thenAnswer(
          (_) => Stream.value(KTestText.storyModelItems),
        );
        when(
          mockFirestoreService.addStory(
            KTestText.storyModelItems.first,
          ),
        ).thenAnswer(
          (realInvocation) async {},
        );
        if (GetIt.I.isRegistered<FirestoreService>()) {
          GetIt.I.unregister<FirestoreService>();
        }
        GetIt.I.registerSingleton(mockFirestoreService);

        mockStoryRepository = StoryRepository();
      });
      test('Story', () async {
        expect(
          mockStoryRepository.getStoryItems(),
          emits(KTestText.storyModelItems),
        );
      });
    });
    group('${KGroupText.failureGet} ', () {
      setUp(() {
        ExtendedDateTime.id = '';
        mockFirestoreService = MockFirestoreService();
        when(mockFirestoreService.getStories()).thenAnswer(
          (realInvocation) => Stream.error(
            KGroupText.failureGet,
          ),
        );

        if (GetIt.I.isRegistered<FirestoreService>()) {
          GetIt.I.unregister<FirestoreService>();
        }
        GetIt.I.registerSingleton(mockFirestoreService);

        mockStoryRepository = StoryRepository();
      });
      test('Story', () async {
        expect(
          mockStoryRepository.getStoryItems(),
          emitsError(KGroupText.failureGet),
        );
      });
    });
  });
}
