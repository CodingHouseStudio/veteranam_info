import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseException;
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import 'package:veteranam/shared/shared_dart.dart';
import '../../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDownAll(GetIt.I.reset);

  group('${KScreenBlocName.storyAdd} ${KGroupText.repository} ', () {
    late IStoryRepository mockStoryRepository;
    late FirestoreService mockFirestoreService;
    late StorageService mockStorageService;
    setUp(() {
      ExtendedDateTime.id = '';
      ExtendedDateTime.current = KTestVariables.dateTime;
      mockFirestoreService = MockFirestoreService();
      mockStorageService = MockStorageService();
    });
    group('${KGroupText.successfulGet} ', () {
      setUp(() {
        when(
          mockFirestoreService.addStory(
            KTestVariables.storyModelItems.last,
          ),
        ).thenAnswer(
          (realInvocation) async {},
        );
        when(
          mockFirestoreService.addStory(
            KTestVariables.storyModelItems.first,
          ),
        ).thenAnswer(
          (realInvocation) async {},
        );
        when(
          mockStorageService.saveFile(
            filePickerItem: KTestVariables.filePickerItem,
            id: KTestVariables.storyModelItems.last.id,
            collecltionName: FirebaseCollectionName.stroies,
          ),
        ).thenAnswer(
          (realInvocation) async => KTestVariables.downloadURL,
        );

        mockStoryRepository = StoryRepository(
          firestoreService: mockFirestoreService,
          storageService: mockStorageService,
        );
      });
      test('Add Story(has image)', () async {
        expect(
          await mockStoryRepository.addStory(
            imageItem: KTestVariables.filePickerItem,
            storyModel: KTestVariables.storyModelItems.last,
          ),
          isA<Right<SomeFailure, bool>>().having(
            (e) => e.value,
            'value',
            isTrue,
          ),
        );
      });
      test('Add Story(without image)', () async {
        expect(
          await mockStoryRepository.addStory(
            imageItem: KTestVariables.filePickerItem,
            storyModel: KTestVariables.storyModelItems.first,
          ),
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
            KTestVariables.storyModelItems.last,
          ),
        ).thenAnswer(
          (realInvocation) async {},
        );
        when(
          mockFirestoreService.addStory(
            KTestVariables.storyModelItems.first,
          ),
        ).thenThrow(FirebaseException(plugin: KGroupText.failure));
        when(
          mockStorageService.saveFile(
            filePickerItem: KTestVariables.filePickerItem,
            id: KTestVariables.storyModelItems.last.id,
            collecltionName: FirebaseCollectionName.stroies,
          ),
        ).thenThrow(FirebaseException(plugin: KGroupText.failure));

        mockStoryRepository = StoryRepository(
          firestoreService: mockFirestoreService,
          storageService: mockStorageService,
        );
      });
      test('Add Story(has image)', () async {
        expect(
          await mockStoryRepository.addStory(
            imageItem: KTestVariables.filePickerItem,
            storyModel: KTestVariables.storyModelItems.last,
          ),
          isA<Left<SomeFailure, bool>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError,
          // ),
        );
      });
      test('Add Story(without image)', () async {
        expect(
          await mockStoryRepository.addStory(
            imageItem: KTestVariables.filePickerItem,
            storyModel: KTestVariables.storyModelItems.last,
          ),
          isA<Left<SomeFailure, bool>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError,
          // ),
        );
      });
    });
  });
}
