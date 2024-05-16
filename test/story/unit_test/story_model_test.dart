import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group('${KScreenBlocName.story} ${KGroupText.model} ', () {
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.shouldBe} ', () {
        final json = {
          'id': KTestText.storyModelItems.last.id,
          'userName': KTestText.storyModelItems.last.userName,
          'userId': KTestText.storyModelItems.last.userId,
          'story': KTestText.storyModelItems.last.story,
          'date': KTestText.storyModelItems.last.date.toIso8601String(),
          'userPhoto': KTestText.storyModelItems.last.userPhoto,
          'image': [KTestText.storyModelItems.last.image!.first.toJson()],
        };

        final storyModel = StoryModel.fromJson(json);

        expect(
          storyModel.id,
          KTestText.storyModelItems.last.id,
        );
        expect(
          storyModel.userName,
          KTestText.storyModelItems.last.userName,
        );
        expect(
          storyModel.story,
          KTestText.storyModelItems.last.story,
        );
        expect(
          storyModel.date,
          KTestText.storyModelItems.last.date,
        );
        expect(
          storyModel.image,
          KTestText.storyModelItems.last.image,
        );
        expect(
          storyModel.userPhoto,
          KTestText.storyModelItems.last.userPhoto,
        );
      });

      test('${KGroupText.shouldBe} ', () {
        final json = {
          'id': KTestText.storyModelItems.last.id,
          'userId': KTestText.storyModelItems.last.userId,
          'story': KTestText.storyModelItems.last.story,
          'date': KTestText.storyModelItems.last.date.toIso8601String(),
        };

        final storyModel = StoryModel.fromJson(json);

        expect(
          storyModel.id,
          KTestText.storyModelItems.last.id,
        );
        expect(
          storyModel.userName,
          null,
        );
        expect(
          storyModel.story,
          KTestText.storyModelItems.last.story,
        );
        expect(
          storyModel.date,
          KTestText.storyModelItems.last.date,
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

      test('${KGroupText.shouldNotBe} ', () {
        final json = {
          // id is missing
          'userName': KTestText.storyModelItems.last.userName,
          'userId': KTestText.storyModelItems.last.userId,
          'story': KTestText.storyModelItems.last.story,
          'date': KTestText.storyModelItems.last.date.toIso8601String(),
        };

        expect(
          () => StoryModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.shouldBe} ', () {
        final json = {
          'id': KTestText.storyModelItems.last.id,
          'userName': KTestText.storyModelItems.last.userName,
          'userId': KTestText.storyModelItems.last.userId,
          'story': KTestText.storyModelItems.last.story,
          'date': KTestText.storyModelItems.last.date.toIso8601String(),
          'userPhoto': KTestText.storyModelItems.last.userPhoto,
          'image': [KTestText.storyModelItems.last.image!.first.toJson()],
        };

        final imageModelJson = KTestText.storyModelItems.last.toJson();

        expect(imageModelJson, json);
      });

      test('${KGroupText.shouldBe} ', () {
        final json = {
          'id': KTestText.storyModelItems.last.id,
          'userName': null,
          'userId': KTestText.storyModelItems.last.userId,
          'story': KTestText.storyModelItems.last.story,
          'date': KTestText.storyModelItems.last.date.toIso8601String(),
          'userPhoto': null,
          'image': null,
        };

        final imageModelJson = KTestText.storyModelItems.last
            .copyWith(image: null, userPhoto: null, userName: null)
            .toJson();

        expect(imageModelJson, json);
      });
    });
  });
}
