import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../../text_dependency.dart';

void main() {
  group('${KScreenBlocName.feedback} ${KGroupText.repository} ', () {
    late IFeedbackRepository mockFeedbackRepository;
    late FirestoreService mockFirestoreService;
    setUp(() {
      mockFirestoreService = MockFirestoreService();
      when(mockFirestoreService.addFeedback(KTestText.feedbackModel))
          .thenAnswer(
        (_) async {},
      );
      when(
        mockFirestoreService.addFeedback(KTestText.feedbackModelIncorect),
      ).thenThrow(Exception(KGroupText.failureSet));
      when(
        mockFirestoreService.addFeedback(
          KTestText.feedbackModelIncorect
              .copyWith(message: KTestText.fieldEmpty),
        ),
      ).thenThrow(FirebaseException(plugin: KGroupText.failureSet));
      if (GetIt.I.isRegistered<FirestoreService>()) {
        GetIt.I.unregister<FirestoreService>();
      }
      GetIt.I.registerSingleton(mockFirestoreService);
      mockFeedbackRepository = FeedbackRepository();
    });
    test('${KGroupText.successfulSet} feedback', () async {
      expect(
        await mockFeedbackRepository.sendFeedback(KTestText.feedbackModel),
        isA<Right<SomeFailure, bool>>().having((e) => e.value, 'value', isTrue),
      );
    });
    test('${KGroupText.failureSet} feedback', () async {
      expect(
        await mockFeedbackRepository
            .sendFeedback(KTestText.feedbackModelIncorect),
        isA<Left<SomeFailure, bool>>().having(
          (e) => e.value,
          'value',
          const SomeFailure.serverError(),
        ),
      );
    });
    test('${KGroupText.failureSet} firebase feedback', () async {
      expect(
        await mockFeedbackRepository.sendFeedback(
          KTestText.feedbackModelIncorect
              .copyWith(message: KTestText.fieldEmpty),
        ),
        isA<Left<SomeFailure, bool>>().having(
          (e) => e.value,
          'value',
          const SomeFailure.serverError(),
        ),
      );
    });
  });
}
