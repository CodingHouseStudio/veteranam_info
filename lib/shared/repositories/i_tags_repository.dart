import 'package:kozak/shared/shared.dart';

// ignore: one_member_abstracts
abstract class ITagsRepository {
  Stream<List<TagModel>> getTags();
}
