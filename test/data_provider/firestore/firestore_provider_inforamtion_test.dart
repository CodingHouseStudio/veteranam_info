import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import 'package:veteranam/shared/shared_dart.dart';
import '../../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  tearDownAll(GetIt.I.reset);
  group(
      '${KScreenBlocName.information} ${KScreenBlocName.firestoreService}'
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
    late Query<Map<String, dynamic>> mockQuery;
    late CacheClient mockCache;
    setUp(() {
      mockCollectionReference = MockCollectionReference();
      mockFirebaseFirestore = MockFirebaseFirestore();
      mockDocumentReference = MockDocumentReference();
      mockQuerySnapshot = MockQuerySnapshot();
      mockQueryDocumentSnapshot = [MockQueryDocumentSnapshot()];
      mockDocumentChange = [MockDocumentChange()];
      mockSnapshotMetadata = MockSnapshotMetadata();
      mockQuery = MockQuery();
      mockCache = MockCacheClient();

      when(
        mockFirebaseFirestore.collection(FirebaseCollectionName.information),
      ).thenAnswer((realInvocation) => mockCollectionReference);

      when(
        mockCollectionReference.where(
          InformationModelJsonField.id,
          whereIn: null,
        ),
      ).thenAnswer((realInvocation) => mockQuery);

      when(
        mockCollectionReference
            .doc(KTestVariables.informationModelItems.first.id),
      ).thenAnswer(
        (_) => mockDocumentReference,
      );

      when(
        mockDocumentReference
            .set(KTestVariables.informationModelItems.first.toJson()),
      ).thenAnswer(
        (_) async {},
      );

      when(
        mockCollectionReference.snapshots(
          //mockQuery
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
        (_) => KTestVariables.informationModelItems
            .map((e) => e.toJson())
            .toList()
            .first,
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

      firestoreService = FirestoreService(
        cache: mockCache,
        firebaseFirestore: mockFirebaseFirestore,
      );
    });
    test('add information', () async {
      await firestoreService
          .addInformation(KTestVariables.informationModelItems.first);

      verify(
        mockFirebaseFirestore.collection(FirebaseCollectionName.information),
      ).called(1);
      verify(
        mockCollectionReference
            .doc(KTestVariables.informationModelItems.first.id),
      ).called(1);
      verify(
        mockDocumentReference
            .set(KTestVariables.informationModelItems.first.toJson()),
      ).called(1);
    });
    test('get information', () async {
      await expectLater(
        firestoreService.getInformations(null),
        emitsInOrder([
          [KTestVariables.informationModelItems.first],
        ]),
        reason: 'Wait for getting information',
      );

      verify(
        mockFirebaseFirestore.collection(FirebaseCollectionName.information),
      ).called(1);
      // verify(
      //   mockCollectionReference.where(
      //     InformationModelJsonField.id,
      //     whereIn: null,
      //   ),
      // ).called(1);
      verify(
        mockCollectionReference.snapshots(
          //mockQuery
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
        firestoreService.getInformations(null),
        emits([KTestVariables.informationModelItems.first]),
      );
    });
  });
}
