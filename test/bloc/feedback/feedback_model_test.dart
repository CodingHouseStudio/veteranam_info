import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

void main() {
  group('${KScreenBlocName.feedback} ${KGroupText.model} ', () {
    test('${KGroupText.shouldBe} ${KGroupText.modelJson}', () {
      final json = {
        'id': KTestText.feedbackModel.id,
        'guestId': KTestText.feedbackModel.guestId,
        'guestName': KTestText.feedbackModel.guestName,
        'email': KTestText.feedbackModel.email,
        'timestamp': KTestText.feedbackModel.timestamp.toIso8601String(),
        'message': KTestText.feedbackModel.message,
        'status': _$FeedbackStatusEnumMap[KTestText.feedbackModel.status],
      };

      final feedbackModel = FeedbackModel.fromJson(json);

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

    test('${KGroupText.shouldNotBe} ${KGroupText.modelJson}', () {
      final json = {
        // id is missing
        'guestId': KTestText.feedbackModel.guestId,
        'guestName': KTestText.feedbackModel.guestName,
        'email': KTestText.feedbackModel.email,
        'timestamp': KTestText.feedbackModel.timestamp.toIso8601String(),
        'message': KTestText.feedbackModel.message,
        'status': _$FeedbackStatusEnumMap[KTestText.feedbackModel.status],
      };

      expect(
        () => FeedbackModel.fromJson(json),
        throwsA(isA<TypeError>()),
      );
    });
  });
}

const _$FeedbackStatusEnumMap = {
  FeedbackStatus.isNew: 'isNew',
  FeedbackStatus.responseRequired: 'responseRequired',
  FeedbackStatus.resolved: 'resolved',
  FeedbackStatus.ideas: 'ideas',
};
