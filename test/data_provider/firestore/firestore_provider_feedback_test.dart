import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../../text_dependency.dart';

void main() {
  group('${KScreenBlocName.firestoreService} ', () {
    group(' ${KGroupText.provider} ', () {
      late FirestoreService firestoreService;
      late FirebaseFirestore mockFirebaseFirestore;
      late CollectionReference<Map<String, dynamic>> mockCollectionReference;
      late DocumentReference<Map<String, dynamic>> mockDocumentReference;
      setUp(() {
        mockCollectionReference = MockCollectionReference();
        mockFirebaseFirestore = MockFirebaseFirestore();
        mockDocumentReference = MockDocumentReference();

        when(
          mockFirebaseFirestore.collection(FirebaseCollectionName.feedback),
        ).thenAnswer((realInvocation) => mockCollectionReference);

        when(
          mockCollectionReference.doc(KTestText.feedbackModel.id),
        ).thenAnswer(
          (_) => mockDocumentReference,
        );

        when(
          mockDocumentReference.set(KTestText.feedbackModel.toJson()),
        ).thenAnswer(
          (_) async {},
        );

        FirestoreService.firebaseFirestore = mockFirebaseFirestore;
        firestoreService = FirestoreService();
      });
      test('add feedback', () async {
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
    });
  });
}
