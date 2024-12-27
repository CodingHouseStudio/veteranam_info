import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseException;
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../test_dependency.dart';

/// COMMENT: exmaple for either repository
void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);

  group('FAQ ${KGroupText.repository} ', () {
    late IFaqRepository faqRepository;
    late FirestoreService mockFirestoreService;
    setUp(() {
      ExtendedDateTime.id = '';
      mockFirestoreService = MockFirestoreService();
    });
    group('${KGroupText.successfulGet} ', () {
      setUp(() {
        when(mockFirestoreService.getQuestions()).thenAnswer(
          (_) async => KTestVariables.questionModelItems,
        );
        when(
          mockFirestoreService
              .addQuestion(KTestVariables.questionModelItems.first),
        ).thenAnswer(
          (realInvocation) async {},
        );

        faqRepository = FaqRepository(firestoreService: mockFirestoreService);
      });
      test('questions', () async {
        expect(
          await faqRepository.getQuestions(),
          isA<Right<SomeFailure, List<QuestionModel>>>().having(
            (e) => e.value,
            'value',
            KTestVariables.questionModelItems,
          ),
        );
      });
      // test('mock', () async {
      //   faqRepository.addMockQuestions();
      //   verify(
      //     mockFirestoreService.addQuestion(
      //       KTestText.questionModelItems.first,
      //     ),
      //   ).called(1);
      // });
    });
    group('${KGroupText.failure} ', () {
      setUp(() {
        when(mockFirestoreService.getQuestions())
            .thenThrow(Exception(KGroupText.failureGet));

        faqRepository = FaqRepository(firestoreService: mockFirestoreService);
      });
      test('Get questions', () async {
        expect(
          await faqRepository.getQuestions(),
          isA<Left<SomeFailure, List<QuestionModel>>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   isA<SomeFailure>,
          // ),
        );
      });
    });
    group('${KGroupText.firebaseFailure} ', () {
      setUp(() {
        when(mockFirestoreService.getQuestions())
            .thenThrow(FirebaseException(plugin: KGroupText.failureGet));

        faqRepository = FaqRepository(firestoreService: mockFirestoreService);
      });
      test('Get questions', () async {
        expect(
          await faqRepository.getQuestions(),
          isA<Left<SomeFailure, List<QuestionModel>>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   isA<SomeFailure>,
          // ),
        );
      });
    });
  });
}
