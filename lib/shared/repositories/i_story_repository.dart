import 'package:kozak/shared/shared.dart';

// ignore: one_member_abstracts
abstract class IStoryRepository {
  Stream<List<StoryModel>> getStoryItems();
}
