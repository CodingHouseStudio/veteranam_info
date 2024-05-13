import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group('${KScreenBlocName.story} ${KGroupText.model} ', () {
    test('${KGroupText.shouldBe} ${KGroupText.modelJson}', () {
      final json = {
        'id': KTestText.storyModelItems.elementAt(0).id,
        'userName': KTestText.storyModelItems.elementAt(0).userName,
        'story': KTestText.storyModelItems.elementAt(0).story,
        'date': KTestText.storyModelItems.elementAt(0).date.toIso8601String(),
        'userPhoto': KTestText.storyModelItems.elementAt(0).userPhoto,
        'image': KTestText.storyModelItems.elementAt(0).image,
      };

      final storyModel = StoryModel.fromJson(json);

      expect(
        storyModel.id,
        KTestText.storyModelItems.elementAt(0).id,
      );
      expect(
        storyModel.userName,
        KTestText.storyModelItems.elementAt(0).userName,
      );
      expect(
        storyModel.story,
        KTestText.storyModelItems.elementAt(0).story,
      );
      expect(
        storyModel.date,
        KTestText.storyModelItems.elementAt(0).date,
      );
      expect(
        storyModel.image,
        KTestText.storyModelItems.elementAt(0).image,
      );
      expect(
        storyModel.userPhoto,
        KTestText.storyModelItems.elementAt(0).userPhoto,
      );
    });

    test('${KGroupText.shouldBe} ${KGroupText.modelJson}', () {
      final json = {
        'id': KTestText.storyModelItems.elementAt(0).id,
        'userName': KTestText.storyModelItems.elementAt(0).userName,
        'story': KTestText.storyModelItems.elementAt(0).story,
        'date': KTestText.storyModelItems.elementAt(0).date.toIso8601String(),
      };

      final storyModel = StoryModel.fromJson(json);

      expect(
        storyModel.id,
        KTestText.storyModelItems.elementAt(0).id,
      );
      expect(
        storyModel.userName,
        KTestText.storyModelItems.elementAt(0).userName,
      );
      expect(
        storyModel.story,
        KTestText.storyModelItems.elementAt(0).story,
      );
      expect(
        storyModel.date,
        KTestText.storyModelItems.elementAt(0).date,
      );
      expect(
        storyModel.image,
        null,
      );
      expect(
        storyModel.userPhoto,
        null,
      );
    });

    test('${KGroupText.shouldNotBe} ${KGroupText.modelJson}', () {
      final json = {
        'id': KTestText.storyModelItems.elementAt(0).id,
        // userName is missing
        'story': KTestText.storyModelItems.elementAt(0).story,
        'date': KTestText.storyModelItems.elementAt(0).date.toIso8601String(),
      };

      expect(
        () => StoryModel.fromJson(json),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
