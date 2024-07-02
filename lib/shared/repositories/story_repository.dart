import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

@Singleton(as: IStoryRepository)
class StoryRepository implements IStoryRepository {
  final FirestoreService _firestoreService = GetIt.I.get<FirestoreService>();
  final StorageService _storageService = GetIt.I.get<StorageService>();

  @override
  Stream<List<StoryModel>> getStoryItems() => _firestoreService.getStories();

  @override
  Future<Either<SomeFailure, bool>> addStory(StoryModel storyModel) async {
    try {
      late var methodStoryModel = storyModel;
      if (methodStoryModel.image != null) {
        final downloadURL = await _storageService.saveStoryImage(
          imageModel: methodStoryModel.image!,
          storyId: storyModel.id,
        );
        if (downloadURL.isNotEmpty) {
          methodStoryModel = methodStoryModel.copyWith(
            image: methodStoryModel.image!.copyWith(downloadURL: downloadURL),
          );
        }
      }
      await _firestoreService.addStory(methodStoryModel);
      return const Right(true);
    } catch (e) {
      return const Left(SomeFailure.serverError());
    }
  }

  @override
  Future<Either<SomeFailure, List<StoryModel>>> getStoriesById(
    String userId,
  ) async {
    try {
      final userStoriesItems =
          await _firestoreService.getStoriesByUserId(userId);

      return Right(userStoriesItems);
    } on FirebaseException catch (e) {
      return Left(GetFailur.fromCode(e).status);
    } catch (e) {
      return const Left(SomeFailure.serverError());
    }
  }
}
