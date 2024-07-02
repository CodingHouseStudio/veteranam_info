import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared.dart';

import '../../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group('${KScreenBlocName.story} ${KGroupText.repository} ', () {
    late IStoryRepository mockStoryRepository;
    late FirestoreService mockFirestoreService;
    late StorageService mockStorageService;
    setUp(() {
      ExtendedDateTime.id = '';
      mockFirestoreService = MockFirestoreService();
      mockStorageService = MockStorageService();
    });
    group('${KGroupText.successfulGet} ', () {
      setUp(() {
        when(mockFirestoreService.getStoriesByUserId(KTestText.user.id))
            .thenAnswer(
          (_) async => KTestText.storyModelItems,
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
      test('Get Story by id', () async {
        expect(
          await mockStoryRepository.getStoriesById(KTestText.user.id),
          isA<Right<SomeFailure, List<StoryModel>>>()
              .having((e) => e.value, 'value', KTestText.storyModelItems),
        );
      });
    });
    group('${KGroupText.failureGet} ', () {
      setUp(() {
        when(mockFirestoreService.getStoriesByUserId(KTestText.user.id))
            .thenThrow(
          FirebaseException(
            plugin: KGroupText.failureGet,
          ),
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
      test('Get Story by id', () async {
        expect(
          await mockStoryRepository.getStoriesById(KTestText.user.id),
          isA<Left<SomeFailure, List<StoryModel>>>().having(
            (e) => e.value,
            'value',
            equals(const SomeFailure.serverError()),
          ),
        );
      });
    });
  });
}
