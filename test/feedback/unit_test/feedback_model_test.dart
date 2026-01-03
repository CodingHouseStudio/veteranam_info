import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/models/models.dart';

import '../../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.feedback} ${KGroupText.model} ', () {
    final fullJson = {
      FeedbackModelJsonField.id: KTestVariables.feedbackModel.id,
      FeedbackModelJsonField.guestId: KTestVariables.feedbackModel.guestId,
      FeedbackModelJsonField.guestName: KTestVariables.feedbackModel.guestName,
      FeedbackModelJsonField.email: KTestVariables.feedbackModel.email,
      FeedbackModelJsonField.timestamp:
          KTestVariables.feedbackModel.timestamp.toIso8601String(),
      FeedbackModelJsonField.message: KTestVariables.feedbackModel.message,
      FeedbackModelJsonField.status:
          _$FeedbackStatusEnumMap[KTestVariables.feedbackModel.status],
      FeedbackModelJsonField.image: [
        KTestVariables.imageModel.toJson(),
      ],
    };
    final nullableJson = {
      FeedbackModelJsonField.id: KTestVariables.feedbackModel.id,
      FeedbackModelJsonField.guestId: KTestVariables.feedbackModel.guestId,
      FeedbackModelJsonField.guestName: null,
      FeedbackModelJsonField.email: KTestVariables.feedbackModel.email,
      FeedbackModelJsonField.timestamp:
          KTestVariables.feedbackModel.timestamp.toIso8601String(),
      FeedbackModelJsonField.message: KTestVariables.feedbackModel.message,
      FeedbackModelJsonField.status:
          _$FeedbackStatusEnumMap[KTestVariables.feedbackModel.status],
      FeedbackModelJsonField.image: null,
    };
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.full} ', () {
        final feedbackModel = FeedbackModel.fromJson(fullJson);

        expect(feedbackModel.id, KTestVariables.feedbackModel.id);
        expect(feedbackModel.email, KTestVariables.feedbackModel.email);
        expect(feedbackModel.guestId, KTestVariables.feedbackModel.guestId);
        expect(feedbackModel.guestName, KTestVariables.feedbackModel.guestName);
        expect(feedbackModel.message, KTestVariables.feedbackModel.message);
        expect(
          feedbackModel.status,
          KTestVariables.feedbackModel.status,
        );
        expect(
          feedbackModel.timestamp,
          KTestVariables.feedbackModel.timestamp,
        );
        expect(
          feedbackModel.image,
          KTestVariables.imageModel,
        );
      });
      test('${KGroupText.nullable} ', () {
        final feedbackModel = FeedbackModel.fromJson(nullableJson);

        expect(feedbackModel.id, KTestVariables.feedbackModel.id);
        expect(feedbackModel.email, KTestVariables.feedbackModel.email);
        expect(feedbackModel.guestId, KTestVariables.feedbackModel.guestId);
        expect(feedbackModel.guestName, null);
        expect(feedbackModel.message, KTestVariables.feedbackModel.message);
        expect(
          feedbackModel.status,
          KTestVariables.feedbackModel.status,
        );
        expect(
          feedbackModel.timestamp,
          KTestVariables.feedbackModel.timestamp,
        );
        expect(
          feedbackModel.image,
          null,
        );
      });

      test('${KGroupText.failure} ', () {
        final json = {
          // id is missing

          FeedbackModelJsonField.guestId: KTestVariables.feedbackModel.guestId,
          FeedbackModelJsonField.guestName:
              KTestVariables.feedbackModel.guestName,
          FeedbackModelJsonField.email: KTestVariables.feedbackModel.email,
          FeedbackModelJsonField.timestamp:
              KTestVariables.feedbackModel.timestamp.toIso8601String(),
          FeedbackModelJsonField.message: KTestVariables.feedbackModel.message,
          FeedbackModelJsonField.status:
              _$FeedbackStatusEnumMap[KTestVariables.feedbackModel.status],
          FeedbackModelJsonField.image: [
            KTestVariables.feedbackImageModel.image!.toJson(),
          ],
        };

        expect(
          () => FeedbackModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.full} ', () {
        final feedbackModelJson = KTestVariables.feedbackModel
            .copyWith(image: KTestVariables.imageModel)
            .toJson();

        expect(feedbackModelJson, fullJson);
      });
      test('${KGroupText.nullable} ', () {
        final feedbackModelJson = KTestVariables.feedbackImageModel
            .copyWith(
              image: null,
              guestName: null,
            )
            .toJson();

        expect(feedbackModelJson, nullableJson);
      });
    });
  });
}

const _$FeedbackStatusEnumMap = {
  FeedbackStatus.isNew: 'isNew',
  FeedbackStatus.responseRequired: 'responseRequired',
  FeedbackStatus.resolved: 'resolved',
  FeedbackStatus.ideas: 'ideas',
};
