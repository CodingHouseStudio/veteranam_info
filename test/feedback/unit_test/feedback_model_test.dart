import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.feedback} ${KGroupText.model} ', () {
    final fullJson = {
      FeedbackModelJsonField.id: KTestText.feedbackModel.id,
      FeedbackModelJsonField.guestId: KTestText.feedbackModel.guestId,
      FeedbackModelJsonField.guestName: KTestText.feedbackModel.guestName,
      FeedbackModelJsonField.email: KTestText.feedbackModel.email,
      FeedbackModelJsonField.timestamp:
          KTestText.feedbackModel.timestamp.toIso8601String(),
      FeedbackModelJsonField.message: KTestText.feedbackModel.message,
      FeedbackModelJsonField.status:
          _$FeedbackStatusEnumMap[KTestText.feedbackModel.status],
      FeedbackModelJsonField.image: [
        KTestText.imageModel.toJson(),
      ],
    };
    final nullableJson = {
      FeedbackModelJsonField.id: KTestText.feedbackModel.id,
      FeedbackModelJsonField.guestId: KTestText.feedbackModel.guestId,
      FeedbackModelJsonField.guestName: null,
      FeedbackModelJsonField.email: null,
      FeedbackModelJsonField.timestamp:
          KTestText.feedbackModel.timestamp.toIso8601String(),
      FeedbackModelJsonField.message: KTestText.feedbackModel.message,
      FeedbackModelJsonField.status:
          _$FeedbackStatusEnumMap[KTestText.feedbackModel.status],
      FeedbackModelJsonField.image: null,
    };
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.full} ', () {
        final feedbackModel = FeedbackModel.fromJson(fullJson);

        expect(feedbackModel.id, KTestText.feedbackModel.id);
        expect(feedbackModel.email, KTestText.feedbackModel.email);
        expect(feedbackModel.guestId, KTestText.feedbackModel.guestId);
        expect(feedbackModel.guestName, KTestText.feedbackModel.guestName);
        expect(feedbackModel.message, KTestText.feedbackModel.message);
        expect(
          feedbackModel.status,
          KTestText.feedbackModel.status,
        );
        expect(
          feedbackModel.timestamp,
          KTestText.feedbackModel.timestamp,
        );
        expect(
          feedbackModel.image,
          KTestText.imageModel,
        );
      });
      test('${KGroupText.nullable} ', () {
        final feedbackModel = FeedbackModel.fromJson(nullableJson);

        expect(feedbackModel.id, KTestText.feedbackModel.id);
        expect(feedbackModel.email, null);
        expect(feedbackModel.guestId, KTestText.feedbackModel.guestId);
        expect(feedbackModel.guestName, null);
        expect(feedbackModel.message, KTestText.feedbackModel.message);
        expect(
          feedbackModel.status,
          KTestText.feedbackModel.status,
        );
        expect(
          feedbackModel.timestamp,
          KTestText.feedbackModel.timestamp,
        );
        expect(
          feedbackModel.image,
          null,
        );
      });

      test('${KGroupText.failure} ', () {
        final json = {
          // id is missing

          FeedbackModelJsonField.guestId: KTestText.feedbackModel.guestId,
          FeedbackModelJsonField.guestName: KTestText.feedbackModel.guestName,
          FeedbackModelJsonField.email: KTestText.feedbackModel.email,
          FeedbackModelJsonField.timestamp:
              KTestText.feedbackModel.timestamp.toIso8601String(),
          FeedbackModelJsonField.message: KTestText.feedbackModel.message,
          FeedbackModelJsonField.status:
              _$FeedbackStatusEnumMap[KTestText.feedbackModel.status],
          FeedbackModelJsonField.image: [
            KTestText.feedbackImageModel.image!.toJson(),
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
        final feedbackModelJson = KTestText.feedbackModel
            .copyWith(image: KTestText.imageModel)
            .toJson();

        expect(feedbackModelJson, fullJson);
      });
      test('${KGroupText.nullable} ', () {
        final feedbackModelJson =
            KTestText.feedbackImageModel.copyWith(image: null).toJson();

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
