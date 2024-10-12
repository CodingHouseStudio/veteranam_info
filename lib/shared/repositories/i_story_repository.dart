import 'dart:typed_data' show Uint8List;

import 'package:dartz/dartz.dart';
import 'package:veteranam/shared/shared.dart';

abstract class IStoryRepository {
  Stream<List<StoryModel>> getStoryItems();
  Future<Either<SomeFailure, bool>> addStory({
    required StoryModel storyModel,
    required Uint8List? image,
  });
  Future<Either<SomeFailure, List<StoryModel>>> getStoriesByUserId(
    String userId,
  );
}
