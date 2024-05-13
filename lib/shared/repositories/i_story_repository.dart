import 'package:kozak/shared/shared.dart';

abstract class IStoryRepository {
  Stream<List<StoryModel>> getStoryItems();
  void addMockStoryItems();
}
