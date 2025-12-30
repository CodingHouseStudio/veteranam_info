import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:veteranam/shared/shared_dart.dart';

// import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseException;

@Singleton(as: IStoryRepository, env: [Config.development])
class StoryRepository implements IStoryRepository {
  StoryRepository({
    required FirestoreService firestoreService,
    required StorageService storageService,
  })  : _firestoreService = firestoreService,
        _storageService = storageService;
  final FirestoreService _firestoreService;
  final StorageService _storageService;

  @override
  Stream<List<StoryModel>> getStoryItems() => _firestoreService.getStories();

  @override
  Future<Either<SomeFailure, bool>> addStory({
    required StoryModel storyModel,
    required FilePickerItem? imageItem,
  }) async {
    return eitherFutureHelper(
      () async {
        late var methodStoryModel = storyModel;
        if (imageItem != null) {
          final downloadURL = await _storageService.saveFile(
            filePickerItem: imageItem,
            id: storyModel.id,
            collecltionName: FirebaseCollectionName.stroies,
          );
          if (downloadURL != null && downloadURL.isNotEmpty) {
            methodStoryModel = methodStoryModel.copyWith(
              image: imageItem.image(downloadURL),
            );
          }
        }
        await _firestoreService.addStory(methodStoryModel);
        return const Right(true);
      },
      methodName: 'Story(addStory)',
      className: ErrorText.repositoryKey,
      data: 'Story Model: $storyModel| ${imageItem.getErrorData}',
    );
  }

  @override
  Future<Either<SomeFailure, List<StoryModel>>> getStoriesByUserId(
    String userId,
  ) async {
    return eitherFutureHelper(
      () async {
        final userStoriesItems =
            await _firestoreService.getStoriesByUserId(userId);

        return Right(userStoriesItems);
      },
      methodName: 'Story(getStoriesByUserId)',
      className: ErrorText.repositoryKey,
      data: 'User ID: $userId',
      user: User(id: userId),
    );
  }
}
