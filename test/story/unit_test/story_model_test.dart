import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/constants/dimensions/min_max_size_constants.dart';
import 'package:veteranam/shared/models/models.dart';

import '../../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.story} ${KGroupText.model} ', () {
    final fullJson = {
      StoryModelJsonField.id: KTestVariables.storyModelItems.last.id,
      StoryModelJsonField.userName:
          KTestVariables.storyModelItems.last.userName,
      StoryModelJsonField.userId: KTestVariables.storyModelItems.last.userId,
      StoryModelJsonField.story: KTestVariables.storyModelItems.last.story,
      StoryModelJsonField.date:
          KTestVariables.storyModelItems.last.date.toIso8601String(),
      StoryModelJsonField.userPhoto: [
        KTestVariables.storyModelItems.last.userPhoto!.toJson(),
      ],
      StoryModelJsonField.image: [
        KTestVariables.storyModelItems.last.image!.toJson(),
      ],
    };
    final nullableJson = {
      StoryModelJsonField.id: KTestVariables.storyModelItems.last.id,
      StoryModelJsonField.userName: null,
      StoryModelJsonField.userId: KTestVariables.storyModelItems.last.userId,
      StoryModelJsonField.story: KTestVariables.storyModelItems.last.story,
      StoryModelJsonField.date:
          KTestVariables.storyModelItems.last.date.toIso8601String(),
      StoryModelJsonField.userPhoto: null,
      StoryModelJsonField.image: null,
    };
    final convertorJson = {
      StoryModelJsonField.id: KTestVariables.storyModelItems.last.id,
      StoryModelJsonField.userName:
          KTestVariables.storyModelItems.last.userName,
      StoryModelJsonField.userId: KTestVariables.storyModelItems.last.userId,
      StoryModelJsonField.story: List.generate(
        KMinMaxSize.subtitleMaxLength,
        (_) => KTestVariables.storyModelItems.last.story
            .split(KTestVariables.storyModelItems.last.story),
      ).join(),
      StoryModelJsonField.date:
          KTestVariables.storyModelItems.last.date.toIso8601String(),
      StoryModelJsonField.userPhoto: [
        KTestVariables.storyModelItems.last.userPhoto!.toJson(),
      ],
      StoryModelJsonField.image: [
        KTestVariables.storyModelItems.last.image!.toJson(),
      ],
    };

    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.full} ', () {
        final storyModel = StoryModel.fromJson(fullJson);

        expect(
          storyModel.id,
          KTestVariables.storyModelItems.last.id,
        );
        expect(
          storyModel.userName,
          KTestVariables.storyModelItems.last.userName,
        );
        expect(
          storyModel.story,
          KTestVariables.storyModelItems.last.story,
        );
        expect(
          storyModel.date,
          KTestVariables.storyModelItems.last.date,
        );
        expect(
          storyModel.image,
          KTestVariables.storyModelItems.last.image,
        );
        expect(
          storyModel.userPhoto,
          KTestVariables.storyModelItems.last.userPhoto,
        );
      });

      test('${KGroupText.nullable} ', () {
        final storyModel = StoryModel.fromJson(nullableJson);

        expect(
          storyModel.id,
          KTestVariables.storyModelItems.last.id,
        );
        expect(
          storyModel.userName,
          null,
        );
        expect(
          storyModel.story,
          KTestVariables.storyModelItems.last.story,
        );
        expect(
          storyModel.date,
          KTestVariables.storyModelItems.last.date,
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
          StoryModelJsonField.userName:
              KTestVariables.storyModelItems.last.userName,
          StoryModelJsonField.userId:
              KTestVariables.storyModelItems.last.userId,
          StoryModelJsonField.story: KTestVariables.storyModelItems.last.story,
          StoryModelJsonField.date:
              KTestVariables.storyModelItems.last.date.toIso8601String(),
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
          KTestVariables.storyModelItems.last.id,
        );
        expect(
          storyModel.userName,
          KTestVariables.storyModelItems.last.userName,
        );
        expect(
          storyModel.story.length,
          KMinMaxSize.subtitleMaxLength,
        );
        expect(
          storyModel.date,
          KTestVariables.storyModelItems.last.date,
        );
        expect(
          storyModel.image,
          KTestVariables.storyModelItems.last.image,
        );
        expect(
          storyModel.userPhoto,
          KTestVariables.storyModelItems.last.userPhoto,
        );
      });
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.full} ', () {
        final storyModelJson = KTestVariables.storyModelItems.last.toJson();

        expect(storyModelJson, fullJson);
      });

      test('${KGroupText.nullable} ', () {
        final storyModelJson = KTestVariables.storyModelItems.last
            .copyWith(image: null, userPhoto: null, userName: null)
            .toJson();

        expect(storyModelJson, nullableJson);
      });
      test('${KGroupText.convertor} ', () {
        final storyModelJson = KTestVariables.storyModelItems.last
            .copyWith(
              story: List.generate(
                KMinMaxSize.subtitleMaxLength,
                (_) => KTestVariables.storyModelItems.last.story
                    .split(KTestVariables.storyModelItems.last.story),
              ).join(),
            )
            .toJson();

        expect(storyModelJson, convertorJson);
      });
    });
  });
}
