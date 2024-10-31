import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/constants/dimensions/min_max_size_constants.dart';
import 'package:veteranam/shared/models/models.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.story} ${KGroupText.model} ', () {
    final fullJson = {
      StoryModelJsonField.id: KTestText.storyModelItems.last.id,
      StoryModelJsonField.userName: KTestText.storyModelItems.last.userName,
      StoryModelJsonField.userId: KTestText.storyModelItems.last.userId,
      StoryModelJsonField.story: KTestText.storyModelItems.last.story,
      StoryModelJsonField.date:
          KTestText.storyModelItems.last.date.toIso8601String(),
      StoryModelJsonField.userPhoto: [
        KTestText.storyModelItems.last.userPhoto!.toJson(),
      ],
      StoryModelJsonField.image: [
        KTestText.storyModelItems.last.image!.toJson(),
      ],
    };
    final nullableJson = {
      StoryModelJsonField.id: KTestText.storyModelItems.last.id,
      StoryModelJsonField.userName: null,
      StoryModelJsonField.userId: KTestText.storyModelItems.last.userId,
      StoryModelJsonField.story: KTestText.storyModelItems.last.story,
      StoryModelJsonField.date:
          KTestText.storyModelItems.last.date.toIso8601String(),
      StoryModelJsonField.userPhoto: null,
      StoryModelJsonField.image: null,
    };
    final convertorJson = {
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
        KTestText.storyModelItems.last.userPhoto!.toJson(),
      ],
      StoryModelJsonField.image: [
        KTestText.storyModelItems.last.image!.toJson(),
      ],
    };

    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.full} ', () {
        final storyModel = StoryModel.fromJson(fullJson);

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

      test('${KGroupText.nullable} ', () {
        final storyModel = StoryModel.fromJson(nullableJson);

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

      test('${KGroupText.failure} ', () {
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
      test('${KGroupText.convertor} ', () {
        final storyModel = StoryModel.fromJson(convertorJson);

        expect(
          storyModel.id,
          KTestText.storyModelItems.last.id,
        );
        expect(
          storyModel.userName,
          KTestText.storyModelItems.last.userName,
        );
        expect(
          storyModel.story.length,
          KMinMaxSize.subtitleMaxLength,
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
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.full} ', () {
        final storyModelJson = KTestText.storyModelItems.last.toJson();

        expect(storyModelJson, fullJson);
      });

      test('${KGroupText.nullable} ', () {
        final storyModelJson = KTestText.storyModelItems.last
            .copyWith(image: null, userPhoto: null, userName: null)
            .toJson();

        expect(storyModelJson, nullableJson);
      });
      test('${KGroupText.convertor} ', () {
        final storyModelJson = KTestText.storyModelItems.last
            .copyWith(
              story: List.generate(
                KMinMaxSize.subtitleMaxLength,
                (_) => KTestText.storyModelItems.last.story
                    .split(KTestText.storyModelItems.last.story),
              ).join(),
            )
            .toJson();

        expect(storyModelJson, convertorJson);
      });
    });
  });
}
