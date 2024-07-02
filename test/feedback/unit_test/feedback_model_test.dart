import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../text_dependency.dart';

void main() {
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
        };

        expect(
          () => FeedbackModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.full} ', () {
        final feedbackModelJson = KTestText.feedbackModel.toJson();

        expect(feedbackModelJson, fullJson);
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
