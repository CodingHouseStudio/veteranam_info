import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group('${KScreenBlocName.storyAdd} ${KGroupText.repository} ', () {
    late IStoryRepository mockStoryRepository;
    late FirestoreService mockFirestoreService;
    late StorageService mockStorageService;
    setUp(() {
      ExtendedDateTime.id = '';
      ExtendedDateTime.current = KTestText.dateTime;
      mockFirestoreService = MockFirestoreService();
      mockStorageService = MockStorageService();
    });
    group('${KGroupText.successfulGet} ', () {
      setUp(() {
        when(
          mockFirestoreService.addStory(
            KTestText.storyModelItems.last,
          ),
        ).thenAnswer(
          (realInvocation) async {},
        );
        when(
          mockFirestoreService.addStory(
            KTestText.storyModelItems.first,
          ),
        ).thenAnswer(
          (realInvocation) async {},
        );
        when(
          mockStorageService.saveStoryImage(
            imageModel: KTestText.storyModelItems.last.image!,
            storyId: KTestText.storyModelItems.last.id,
          ),
        ).thenAnswer(
          (realInvocation) async => KTestText.downloadURL,
        );
        if (GetIt.I.isRegistered<FirestoreService>()) {
          GetIt.I.unregister<FirestoreService>();
        }
        GetIt.I.registerSingleton(mockFirestoreService);
        if (GetIt.I.isRegistered<StorageService>()) {
          GetIt.I.unregister<StorageService>();
        }
        GetIt.I.registerSingleton(mockStorageService);

        mockStoryRepository = StoryRepository();
      });
      test('Add Story(has image)', () async {
        expect(
          await mockStoryRepository.addStory(KTestText.storyModelItems.last),
          isA<Right<SomeFailure, bool>>().having(
            (e) => e.value,
            'value',
            isTrue,
          ),
        );
      });
      test('Add Story(without image)', () async {
        expect(
          await mockStoryRepository.addStory(KTestText.storyModelItems.first),
          isA<Right<SomeFailure, bool>>().having(
            (e) => e.value,
            'value',
            isTrue,
          ),
        );
      });
    });
    group('${KGroupText.failureGet} ', () {
      setUp(() {
        when(
          mockFirestoreService.addStory(
            KTestText.storyModelItems.last,
          ),
        ).thenAnswer(
          (realInvocation) async {},
        );
        when(
          mockFirestoreService.addStory(
            KTestText.storyModelItems.first,
          ),
        ).thenThrow(FirebaseException(plugin: KGroupText.failure));
        when(
          mockStorageService.saveStoryImage(
            imageModel: KTestText.storyModelItems.last.image!,
            storyId: KTestText.storyModelItems.last.id,
          ),
        ).thenThrow(FirebaseException(plugin: KGroupText.failure));
        if (GetIt.I.isRegistered<FirestoreService>()) {
          GetIt.I.unregister<FirestoreService>();
        }
        GetIt.I.registerSingleton(mockFirestoreService);
        if (GetIt.I.isRegistered<StorageService>()) {
          GetIt.I.unregister<StorageService>();
        }
        GetIt.I.registerSingleton(mockStorageService);

        mockStoryRepository = StoryRepository();
      });
      test('Add Story(has image)', () async {
        expect(
          await mockStoryRepository.addStory(KTestText.storyModelItems.last),
          isA<Left<SomeFailure, bool>>().having(
            (e) => e.value,
            'value',
            const SomeFailure.serverError(),
          ),
        );
      });
      test('Add Story(without image)', () async {
        expect(
          await mockStoryRepository.addStory(KTestText.storyModelItems.first),
          isA<Left<SomeFailure, bool>>().having(
            (e) => e.value,
            'value',
            const SomeFailure.serverError(),
          ),
        );
      });
    });
  });
}
