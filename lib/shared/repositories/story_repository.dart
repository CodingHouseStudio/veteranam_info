import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:kozak/shared/shared.dart';

@Singleton(as: IStoryRepository)
class StoryRepository implements IStoryRepository {
  final FirestoreService _firestoreService = GetIt.I.get<FirestoreService>();

  @override
  Stream<List<StoryModel>> getStoryItems() => _firestoreService.getStories();

  @override
  void addMockStoryItems() {
    for (var i = 0; i < KMockText.tags.length; i++) {
      _firestoreService.addStory(
        StoryModel(
          id: '${ExtendedDateTime.id}$i',
          date: ExtendedDateTime.current,
          image: i > KMockText.tags.length - 2 ? KMockText.image : null,
          story: KMockText.cardData,
          userName: KMockText.userNameAnonim,
        ),
      );
    }
  }
}
