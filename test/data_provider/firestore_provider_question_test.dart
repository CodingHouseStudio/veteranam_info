import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../text_dependency.dart';

void main() {
  group('${KScreenBlocName.firestoreService} ', () {
    group(' ${KGroupText.provider} ', () {
      late FirestoreService firestoreService;
      late FirebaseFirestore mockFirebaseFirestore;
      late CollectionReference<Map<String, dynamic>> mockCollectionReference;
      late QuerySnapshot<Map<String, dynamic>> mockQuerySnapshot;
      late List<QueryDocumentSnapshot<Map<String, dynamic>>>
          mockQueryDocumentSnapshot;
      late DocumentReference<Map<String, dynamic>> mockDocumentReference;
      setUp(() {
        mockCollectionReference = MockCollectionReference();
        mockFirebaseFirestore = MockFirebaseFirestore();
        mockDocumentReference = MockDocumentReference();
        mockQuerySnapshot = MockQuerySnapshot();
        mockQueryDocumentSnapshot = [MockQueryDocumentSnapshot()];

        when(
          mockFirebaseFirestore.collection(FirebaseCollectionName.questions),
        ).thenAnswer((realInvocation) => mockCollectionReference);

        when(
          mockCollectionReference.doc(KTestText.questionModelItems.first.id),
        ).thenAnswer(
          (_) => mockDocumentReference,
        );

        when(
          mockDocumentReference
              .set(KTestText.questionModelItems.first.toJson()),
        ).thenAnswer(
          (_) async {},
        );

        when(
          mockCollectionReference.get(),
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
          (_) => KTestText.questionModelItems
              .map((e) => e.toJson())
              .toList()
              .first,
        );

        FirestoreService.firebaseFirestore = mockFirebaseFirestore;
        firestoreService = FirestoreService();
      });
      test('add question', () async {
        await firestoreService.addQuestion(KTestText.questionModelItems.first);

        verify(
          mockFirebaseFirestore.collection(FirebaseCollectionName.questions),
        ).called(1);
        verify(
          mockCollectionReference.doc(KTestText.questionModelItems.first.id),
        ).called(1);
        verify(
          mockDocumentReference
              .set(KTestText.questionModelItems.first.toJson()),
        ).called(1);
      });
      test('get questions', () async {
        expect(
          await firestoreService.getQuestions(),
          [KTestText.questionModelItems.first],
        );

        verify(
          mockFirebaseFirestore.collection(FirebaseCollectionName.questions),
        ).called(1);
        verify(
          mockCollectionReference.get(),
        ).called(1);
        verify(
          mockQuerySnapshot.docs,
        ).called(1);
        verify(
          mockQueryDocumentSnapshot.first.data(),
        ).called(1);
      });
    });
  });
}
