import 'package:dartz/dartz.dart';
import 'package:veteranam/shared/shared_dart.dart';

abstract class IStoryRepository {
  Stream<List<StoryModel>> getStoryItems();
  Future<Either<SomeFailure, bool>> addStory({
    required StoryModel storyModel,
    required FilePickerItem? imageItem,
  });
  Future<Either<SomeFailure, List<StoryModel>>> getStoriesByUserId(
    String userId,
  );
}
