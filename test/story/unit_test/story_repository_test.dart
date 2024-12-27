import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart' show FirebaseException;
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);

  group('${KScreenBlocName.story} ${KGroupText.repository} ', () {
    late IStoryRepository mockStoryRepository;
    late FirestoreService mockFirestoreService;
    late StorageService mockStorageService;
    setUp(() {
      ExtendedDateTime.id = '';
      mockFirestoreService = MockFirestoreService();
      mockStorageService = MockStorageService();
    });
    group('${KGroupText.successful} ', () {
      setUp(() {
        when(mockFirestoreService.getStories()).thenAnswer(
          (_) => Stream.value(KTestVariables.storyModelItems),
        );
        when(
          mockFirestoreService.addStory(KTestVariables.storyModelItems.first),
        ).thenAnswer(
          (_) async {},
        );
        when(mockFirestoreService.getStoriesByUserId(KTestVariables.user.id))
            .thenAnswer(
          (_) async => KTestVariables.storyModelItems,
        );
        when(
          mockStorageService.saveFile(
            filePickerItem: KTestVariables.filePickerItem,
            collecltionName: FirebaseCollectionName.stroies,
            id: KTestVariables.storyModelItems.first.id,
          ),
        ).thenAnswer(
          (_) async => KTestVariables.storyModelItems.first.image!.downloadURL,
        );

        mockStoryRepository = StoryRepository(
          firestoreService: mockFirestoreService,
          storageService: mockStorageService,
        );
      });
      test('Get Story', () async {
        expect(
          mockStoryRepository.getStoryItems(),
          emits(KTestVariables.storyModelItems),
        );
      });
      test('Get Story by user id', () async {
        expect(
          await mockStoryRepository.getStoriesByUserId(KTestVariables.user.id),
          isA<Right<SomeFailure, List<StoryModel>>>()
              .having((e) => e.value, 'value', KTestVariables.storyModelItems),
        );
      });
      test('Add story', () async {
        expect(
          await mockStoryRepository.addStory(
            imageItem: KTestVariables.filePickerItem,
            storyModel: KTestVariables.storyModelItems.last,
          ),
          isA<Right<SomeFailure, bool>>().having((e) => e.value, 'value', true),
        );
      });
    });
    group('${KGroupText.failure} ', () {
      setUp(() {
        when(mockFirestoreService.getStories()).thenAnswer(
          (realInvocation) => Stream.error(
            KGroupText.failureGet,
          ),
        );
        when(
          mockStorageService.saveFile(
            filePickerItem: KTestVariables.filePickerItem,
            collecltionName: FirebaseCollectionName.stroies,
            id: KTestVariables.storyModelItems.first.id,
          ),
        ).thenThrow(
          Exception(KGroupText.failureSend),
        );
        when(
          mockFirestoreService.addStory(KTestVariables.storyModelItems.first),
        ).thenThrow(
          Exception(KGroupText.failureSend),
        );
        when(mockFirestoreService.getStoriesByUserId(KTestVariables.user.id))
            .thenThrow(
          Exception(KGroupText.failureGet),
        );

        mockStoryRepository = StoryRepository(
          firestoreService: mockFirestoreService,
          storageService: mockStorageService,
        );
      });
      test('Get Story', () async {
        expect(
          mockStoryRepository.getStoryItems(),
          emitsError(KGroupText.failureGet),
        );
      });
      test('Get Story by user id', () async {
        expect(
          await mockStoryRepository.getStoriesByUserId(KTestVariables.user.id),
          isA<Left<SomeFailure, List<StoryModel>>>(),
        );
      });
      test('Add story', () async {
        expect(
          await mockStoryRepository.addStory(
            imageItem: KTestVariables.filePickerItem,
            storyModel: KTestVariables.storyModelItems.first,
          ),
          isA<Left<SomeFailure, bool>>(),
        );
      });
    });
    group('${KGroupText.failureGet} ', () {
      setUp(() {
        when(mockFirestoreService.getStories()).thenAnswer(
          (realInvocation) => Stream.error(
            KGroupText.failureGet,
          ),
        );
        when(
          mockStorageService.saveFile(
            filePickerItem: KTestVariables.filePickerItem,
            collecltionName: FirebaseCollectionName.stroies,
            id: KTestVariables.storyModelItems.first.id,
          ),
        ).thenThrow(
          FirebaseException(plugin: KGroupText.failureSend),
        );
        when(
          mockFirestoreService.addStory(KTestVariables.storyModelItems.first),
        ).thenThrow(
          FirebaseException(plugin: KGroupText.failureSend),
        );
        when(mockFirestoreService.getStoriesByUserId(KTestVariables.user.id))
            .thenThrow(
          FirebaseException(plugin: KGroupText.failureGet),
        );

        mockStoryRepository = StoryRepository(
          firestoreService: mockFirestoreService,
          storageService: mockStorageService,
        );
      });
      test('Get Story', () async {
        expect(
          mockStoryRepository.getStoryItems(),
          emitsError(KGroupText.failureGet),
        );
      });
      test('Get Story by user id', () async {
        expect(
          await mockStoryRepository.getStoriesByUserId(KTestVariables.user.id),
          isA<Left<SomeFailure, List<StoryModel>>>(),
        );
      });
      test('Add story', () async {
        expect(
          await mockStoryRepository.addStory(
            imageItem: KTestVariables.filePickerItem,
            storyModel: KTestVariables.storyModelItems.first,
          ),
          isA<Left<SomeFailure, bool>>(),
        );
      });
    });
  });
}
