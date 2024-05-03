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
      group('${KGroupText.successfulSet} ', () {
        setUp(() {
          mockFirebaseFirestore = MockFirebaseFirestore();
          when(mockFirebaseFirestore.collection(any))
              .thenReturn(MockCollectionReference());
          when(
            mockFirebaseFirestore
                .collection(FirebaseCollectionName.feedback)
                .doc(KTestText.feedbackModel.id)
                .set(KTestText.feedbackModel.toJson()),
          ).thenAnswer(
            (_) async {},
          );
          firestoreService = FirestoreService()
            ..firebaseFirestore = mockFirebaseFirestore;
        });
        test('write one(true)', () async {
          await firestoreService.addFeedback(KTestText.feedbackModel);

          verify(
            mockFirebaseFirestore
                .collection(FirebaseCollectionName.feedback)
                .doc(KTestText.feedbackModel.id)
                .set(KTestText.feedbackModel.toJson()),
          ).called(1);
        });
      });
    });
  });
}
