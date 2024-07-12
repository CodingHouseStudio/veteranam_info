import 'package:dartz/dartz.dart';
import 'package:veteranam/shared/shared.dart';

abstract class IStoryRepository {
  Stream<List<StoryModel>> getStoryItems();
  Future<Either<SomeFailure, bool>> addStory(StoryModel storyModel);
  Future<Either<SomeFailure, List<StoryModel>>> getStoriesById(String userId);
}
