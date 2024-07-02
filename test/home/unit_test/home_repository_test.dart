import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared.dart';

import '../../text_dependency.dart';

/// COMMENT: exmaple for either repository
void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group('${KScreenBlocName.home} ${KGroupText.repository} ', () {
    late IHomeRepository homeRepository;
    late FirestoreService mockFirestoreService;
    setUp(() {
      ExtendedDateTime.id = '';
      mockFirestoreService = MockFirestoreService();
    });
    group('${KGroupText.successfulGet} ', () {
      setUp(() {
        when(mockFirestoreService.getQuestions()).thenAnswer(
          (_) async => KTestText.questionModelItems,
        );
        when(
          mockFirestoreService.addQuestion(KTestText.questionModelItems.first),
        ).thenAnswer(
          (realInvocation) async {},
        );
        if (GetIt.I.isRegistered<FirestoreService>()) {
          GetIt.I.unregister<FirestoreService>();
        }
        GetIt.I.registerSingleton(mockFirestoreService);
        homeRepository = HomeRepository();
      });
      test('questions', () async {
        expect(
          await homeRepository.getQuestions(),
          isA<Right<SomeFailure, List<QuestionModel>>>()
              .having((e) => e.value, 'value', KTestText.questionModelItems),
        );
      });
      test('mock', () async {
        homeRepository.addMockQuestions();
        verify(
          mockFirestoreService.addQuestion(
            KTestText.questionModelItems.first.copyWith(navigationLink: null),
          ),
        ).called(1);
      });
    });
    group('${KGroupText.failureGet} ', () {
      setUp(() {
        when(mockFirestoreService.getQuestions())
            .thenThrow(FirebaseException(plugin: KGroupText.failureGet));
        if (GetIt.I.isRegistered<FirestoreService>()) {
          GetIt.I.unregister<FirestoreService>();
        }
        GetIt.I.registerSingleton(mockFirestoreService);
        homeRepository = HomeRepository();
      });
      test('questions', () async {
        expect(
          await homeRepository.getQuestions(),
          isA<Left<SomeFailure, List<QuestionModel>>>().having(
            (e) => e.value,
            'value',
            equals(const SomeFailure.serverError()),
          ),
        );
      });
    });
  });
}
