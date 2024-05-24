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
          StoryModelJsonField.id: KTestText.storyModelItems.last.id,
          StoryModelJsonField.userName: KTestText.storyModelItems.last.userName,
          StoryModelJsonField.userId: KTestText.storyModelItems.last.userId,
          StoryModelJsonField.story: KTestText.storyModelItems.last.story,
          StoryModelJsonField.date:
              KTestText.storyModelItems.last.date.toIso8601String(),
          StoryModelJsonField.userPhoto: [
            KTestText.storyModelItems.last.userPhoto!.first.toJson(),
          ],
          StoryModelJsonField.image: [
            KTestText.storyModelItems.last.image!.first.toJson(),
          ],
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
          StoryModelJsonField.id: KTestText.storyModelItems.last.id,
          StoryModelJsonField.userName: KTestText.storyModelItems.last.userName,
          StoryModelJsonField.userId: KTestText.storyModelItems.last.userId,
          StoryModelJsonField.story: List.generate(
            KMinMaxSize.subtitleMaxLength,
            (_) => KTestText.storyModelItems.last.story
                .split(KTestText.storyModelItems.last.story),
          ).join(),
          StoryModelJsonField.date:
              KTestText.storyModelItems.last.date.toIso8601String(),
          StoryModelJsonField.userPhoto: [
            KTestText.storyModelItems.last.userPhoto!.first.toJson(),
          ],
          StoryModelJsonField.image: [
            KTestText.storyModelItems.last.image!.first.toJson(),
          ],
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
          List.generate(
            KMinMaxSize.subtitleMaxLength,
            (_) => KTestText.storyModelItems.last.story
                .split(KTestText.storyModelItems.last.story),
          ).join().substring(
                0,
                KMinMaxSize.subtitleMaxLength,
              ),
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
          StoryModelJsonField.id: KTestText.storyModelItems.last.id,
          StoryModelJsonField.userId: KTestText.storyModelItems.last.userId,
          StoryModelJsonField.story: KTestText.storyModelItems.last.story,
          StoryModelJsonField.date:
              KTestText.storyModelItems.last.date.toIso8601String(),
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
          StoryModelJsonField.userName: KTestText.storyModelItems.last.userName,
          StoryModelJsonField.userId: KTestText.storyModelItems.last.userId,
          StoryModelJsonField.story: KTestText.storyModelItems.last.story,
          StoryModelJsonField.date:
              KTestText.storyModelItems.last.date.toIso8601String(),
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
          StoryModelJsonField.id: KTestText.storyModelItems.last.id,
          StoryModelJsonField.userName: KTestText.storyModelItems.last.userName,
          StoryModelJsonField.userId: KTestText.storyModelItems.last.userId,
          StoryModelJsonField.story: KTestText.storyModelItems.last.story,
          StoryModelJsonField.date:
              KTestText.storyModelItems.last.date.toIso8601String(),
          StoryModelJsonField.userPhoto: [
            KTestText.storyModelItems.last.userPhoto!.first.toJson(),
          ],
          StoryModelJsonField.image: [
            KTestText.storyModelItems.last.image!.first.toJson(),
          ],
        };

        final storyModelJson = KTestText.storyModelItems.last.toJson();

        expect(storyModelJson, json);
      });

      test('${KGroupText.shouldBe} ', () {
        final json = {
          StoryModelJsonField.id: KTestText.storyModelItems.last.id,
          StoryModelJsonField.userName: null,
          StoryModelJsonField.userId: KTestText.storyModelItems.last.userId,
          StoryModelJsonField.story: KTestText.storyModelItems.last.story,
          StoryModelJsonField.date:
              KTestText.storyModelItems.last.date.toIso8601String(),
          StoryModelJsonField.userPhoto: null,
          StoryModelJsonField.image: null,
        };

        final storyModelJson = KTestText.storyModelItems.last
            .copyWith(image: null, userPhoto: null, userName: null)
            .toJson();

        expect(storyModelJson, json);
      });
      test('${KGroupText.shouldBe} ', () {
        final json = {
          StoryModelJsonField.id: KTestText.storyModelItems.last.id,
          StoryModelJsonField.userName: KTestText.storyModelItems.last.userName,
          StoryModelJsonField.userId: KTestText.storyModelItems.last.userId,
          StoryModelJsonField.story: List.generate(
            KMinMaxSize.subtitleMaxLength,
            (_) => KTestText.storyModelItems.last.story
                .split(KTestText.storyModelItems.last.story),
          ).join().substring(0, KMinMaxSize.subtitleMaxLength),
          StoryModelJsonField.date:
              KTestText.storyModelItems.last.date.toIso8601String(),
          StoryModelJsonField.userPhoto: [
            KTestText.storyModelItems.last.userPhoto!.first.toJson(),
          ],
          StoryModelJsonField.image: [
            KTestText.storyModelItems.last.image!.first.toJson(),
          ],
        };

        final storyModelJson = KTestText.storyModelItems.last
            .copyWith(
              story: List.generate(
                KMinMaxSize.subtitleMaxLength,
                (_) => KTestText.storyModelItems.last.story
                    .split(KTestText.storyModelItems.last.story),
              ).join(),
            )
            .toJson();

        expect(storyModelJson, json);
      });
    });
  });
}
