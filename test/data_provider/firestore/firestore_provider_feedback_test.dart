// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  tearDown(GetIt.I.reset);
  group(
      '${KScreenBlocName.feedback} ${KScreenBlocName.firestoreService}'
      ' ${KGroupText.provider} ', () {
    late FirestoreService firestoreService;
    late FirebaseFirestore mockFirebaseFirestore;
    late CollectionReference<Map<String, dynamic>> mockCollectionReference;
    late DocumentReference<Map<String, dynamic>> mockDocumentReference;
    late Query<Map<String, dynamic>> mockQuery;
    late QuerySnapshot<Map<String, dynamic>> mockQuerySnapshot;
    late List<QueryDocumentSnapshot<Map<String, dynamic>>>
        mockQueryDocumentSnapshot;
    late CacheClient mockCacheClient;
    setUp(() {
      mockCollectionReference = MockCollectionReference();
      mockFirebaseFirestore = MockFirebaseFirestore();
      mockDocumentReference = MockDocumentReference();
      mockQuery = MockQuery();
      mockQuerySnapshot = MockQuerySnapshot();
      mockQueryDocumentSnapshot = [MockQueryDocumentSnapshot()];
      mockCacheClient = MockCacheClient();

      when(
        mockFirebaseFirestore.collection(FirebaseCollectionName.feedback),
      ).thenAnswer((realInvocation) => mockCollectionReference);

      when(
        mockCollectionReference.doc(KTestText.feedbackModel.id),
      ).thenAnswer(
        (_) => mockDocumentReference,
      );

      when(
        mockCollectionReference.where(
          FeedbackModelJsonField.guestId,
          isEqualTo: KTestText.user.id,
        ),
      ).thenAnswer(
        (_) => mockQuery,
      );

      when(
        mockDocumentReference.set(KTestText.feedbackModel.toJson()),
      ).thenAnswer(
        (_) async {},
      );

      when(
        mockQuery.get(),
      ).thenAnswer(
        (_) async => mockQuerySnapshot,
      );

      when(
        mockQuerySnapshot.docs,
      ).thenAnswer(
        (_) => mockQueryDocumentSnapshot,
      );

      when(
        mockQueryDocumentSnapshot.first.data(),
      ).thenAnswer(
        (_) => [KTestText.feedbackModel].map((e) => e.toJson()).toList().first,
      );

      FirestoreService.firebaseFirestore = mockFirebaseFirestore;
      firestoreService = FirestoreService(mockCacheClient);
    });
    test('Add Feedback', () async {
      await firestoreService.addFeedback(KTestText.feedbackModel);

      verify(
        mockFirebaseFirestore.collection(FirebaseCollectionName.feedback),
      ).called(1);
      verify(
        mockCollectionReference.doc(KTestText.feedbackModel.id),
      ).called(1);
      verify(
        mockDocumentReference.set(KTestText.feedbackModel.toJson()),
      ).called(1);
    });
    test('Get User Feedback', () async {
      expect(
        await firestoreService.getUserFeedback(KTestText.user.id),
        [KTestText.feedbackModel],
      );

      verify(
        mockFirebaseFirestore.collection(FirebaseCollectionName.feedback),
      ).called(1);
      verify(
        mockCollectionReference.where(
          FeedbackModelJsonField.guestId,
          isEqualTo: KTestText.user.id,
        ),
      ).called(1);
      verify(
        mockQuery.get(),
      ).called(1);
      verify(
        mockQuerySnapshot.docs,
      ).called(1);
      verify(
        mockQueryDocumentSnapshot.first.data(),
      ).called(1);
    });
  });
}
