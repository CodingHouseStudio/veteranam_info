import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../../text_dependency.dart';

void main() {
  group(
      '${KScreenBlocName.work} ${KScreenBlocName.firestoreService}'
      ' ${KGroupText.provider} ', () {
    late FirestoreService firestoreService;
    late FirebaseFirestore mockFirebaseFirestore;
    late CollectionReference<Map<String, dynamic>> mockCollectionReference;
    late QuerySnapshot<Map<String, dynamic>> mockQuerySnapshot;
    late List<QueryDocumentSnapshot<Map<String, dynamic>>>
        mockQueryDocumentSnapshot;
    late DocumentReference<Map<String, dynamic>> mockDocumentReference;
    late List<DocumentChange<Map<String, dynamic>>> mockDocumentChange;
    late SnapshotMetadata mockSnapshotMetadata;
    setUp(() {
      mockCollectionReference = MockCollectionReference();
      mockFirebaseFirestore = MockFirebaseFirestore();
      mockDocumentReference = MockDocumentReference();
      mockQuerySnapshot = MockQuerySnapshot();
      mockQueryDocumentSnapshot = [MockQueryDocumentSnapshot()];
      mockDocumentChange = [MockDocumentChange()];
      mockSnapshotMetadata = MockSnapshotMetadata();

      when(
        mockFirebaseFirestore.collection(FirebaseCollectionName.work),
      ).thenAnswer((realInvocation) => mockCollectionReference);

      when(
        mockCollectionReference.doc(KTestText.workModelItems.first.id),
      ).thenAnswer(
        (_) => mockDocumentReference,
      );

      when(
        mockDocumentReference.set(KTestText.workModelItems.first.toJson()),
      ).thenAnswer(
        (_) async {},
      );

      when(
        mockCollectionReference.snapshots(
          includeMetadataChanges: true,
        ),
      ).thenAnswer(
        (_) => Stream.value(mockQuerySnapshot),
      );

      when(
        mockQuerySnapshot.docs,
      ).thenAnswer(
        (_) => mockQueryDocumentSnapshot,
      );

      when(
        mockQueryDocumentSnapshot.first.data(),
      ).thenAnswer(
        (_) => KTestText.workModelItems.map((e) => e.toJson()).toList().first,
      );

      when(
        mockQuerySnapshot.docChanges,
      ).thenAnswer(
        (_) => mockDocumentChange,
      );

      when(
        mockDocumentChange.first.type,
      ).thenAnswer(
        (_) => DocumentChangeType.added,
      );

      when(
        mockQuerySnapshot.metadata,
      ).thenAnswer(
        (_) => mockSnapshotMetadata,
      );

      when(
        mockSnapshotMetadata.isFromCache,
      ).thenAnswer(
        (_) => false,
      );

      FirestoreService.firebaseFirestore = mockFirebaseFirestore;
      firestoreService = FirestoreService();
    });
    test('add work', () async {
      await firestoreService.addWork(KTestText.workModelItems.first);

      verify(
        mockFirebaseFirestore.collection(FirebaseCollectionName.work),
      ).called(1);
      verify(
        mockCollectionReference.doc(KTestText.workModelItems.first.id),
      ).called(1);
      verify(
        mockDocumentReference.set(KTestText.workModelItems.first.toJson()),
      ).called(1);
    });
    test('get work', () async {
      await expectLater(
        firestoreService.getWorks(),
        emitsInOrder([
          [KTestText.workModelItems.first],
        ]),
        reason: 'Wait for getting work',
      );

      verify(
        mockFirebaseFirestore.collection(FirebaseCollectionName.work),
      ).called(1);
      verify(
        mockCollectionReference.snapshots(
          includeMetadataChanges: true,
        ),
      ).called(1);
      verify(
        mockQuerySnapshot.docs,
      ).called(1);
      verify(
        mockQueryDocumentSnapshot.first.data(),
      ).called(1);
      verify(
        mockQuerySnapshot.metadata,
      ).called(1);
      verify(
        mockSnapshotMetadata.isFromCache,
      ).called(1);

      expect(
        firestoreService.getWorks(),
        emits([KTestText.workModelItems.first]),
      );
    });
  });
}
