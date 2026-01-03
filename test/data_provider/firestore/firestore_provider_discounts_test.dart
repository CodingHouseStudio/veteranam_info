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
      '${KScreenBlocName.discount} ${KScreenBlocName.firestoreService}'
      ' ${KGroupText.provider} ', () {
    late FirestoreService firestoreService;
    late FirebaseFirestore mockFirebaseFirestore;
    late CollectionReference<Map<String, dynamic>> mockCollectionReference;
    late DocumentReference<Map<String, dynamic>> mockDocumentReference;
    late Query<Map<String, dynamic>> mockQuery;
    late QuerySnapshot<Map<String, dynamic>> mockQuerySnapshot;
    late List<QueryDocumentSnapshot<Map<String, dynamic>>>
        mockQueryDocumentSnapshot;
    late SnapshotMetadata mockSnapshotMetadata;
    late List<DocumentChange<Map<String, dynamic>>> mockDocumentChange;
    late CacheClient mockCache;
    setUp(() {
      mockCollectionReference = MockCollectionReference();
      mockFirebaseFirestore = MockFirebaseFirestore();
      mockDocumentReference = MockDocumentReference();
      mockQuery = MockQuery();
      mockQuerySnapshot = MockQuerySnapshot();
      mockQueryDocumentSnapshot = [MockQueryDocumentSnapshot()];
      mockSnapshotMetadata = MockSnapshotMetadata();
      mockDocumentChange = [MockDocumentChange()];
      mockCache = MockCacheClient();

      when(
        mockFirebaseFirestore.collection(FirebaseCollectionName.discount),
      ).thenAnswer((realInvocation) => mockCollectionReference);

      when(
        mockCollectionReference.orderBy(
          DiscountModelJsonField.dateVerified,
          descending: true,
        ),
      ).thenAnswer((realInvocation) => mockQuery);
      when(
        mockQuery.where(
          DiscountModelJsonField.id,
          whereNotIn: null,
        ),
      ).thenAnswer((realInvocation) => mockQuery);

      when(
        mockCollectionReference.doc(KTestVariables.discountModelItems.last.id),
      ).thenAnswer(
        (_) => mockDocumentReference,
      );

      when(
        mockCollectionReference.where(
          DiscountModelJsonField.userId,
          isEqualTo: KTestVariables.user.id,
        ),
      ).thenAnswer(
        (_) => mockQuery,
      );

      when(
        mockQuery.get(),
      ).thenAnswer(
        (_) async => mockQuerySnapshot,
      );

      when(
        mockQuery.snapshots(
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
        mockQuerySnapshot.docChanges,
      ).thenAnswer(
        (_) => mockDocumentChange,
      );

      when(
        mockDocumentChange.last.type,
      ).thenAnswer(
        (_) => DocumentChangeType.added,
      );

      when(
        mockQueryDocumentSnapshot.last.data(),
      ).thenAnswer(
        (_) => KTestVariables.discountModelItems
            .map((e) => e.toJson())
            .toList()
            .last,
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

      when(
        mockDocumentReference
            .set(KTestVariables.discountModelItems.last.toJson()),
      ).thenAnswer(
        (_) async {},
      );

      when(
        mockDocumentReference.delete(),
      ).thenAnswer(
        (_) async {},
      );

      firestoreService = FirestoreService(
        cache: mockCache,
        firebaseFirestore: mockFirebaseFirestore,
      );
    });

    test('get discounts', () async {
      await expectLater(
        firestoreService.getDiscounts(
          showOnlyBusinessDiscounts: false, //null
        ),
        emitsInOrder([
          [KTestVariables.discountModelItems.last],
        ]),
        reason: 'Wait for getting discounts',
      );

      verify(
        mockFirebaseFirestore.collection(FirebaseCollectionName.discount),
      ).called(1);
      verify(
        mockCollectionReference.orderBy(
          DiscountModelJsonField.dateVerified,
          descending: true,
        ),
      ).called(1);
      // verify(
      //   mockQuery.where(DiscountModelJsonField.id, whereNotIn: null),
      // ).called(1);
      verify(
        mockQuery.snapshots(
          includeMetadataChanges: true,
        ),
      ).called(1);
      verify(
        mockQuerySnapshot.docs,
      ).called(1);
      verify(
        mockQueryDocumentSnapshot.last.data(),
      ).called(1);
      verify(
        mockQuerySnapshot.metadata,
      ).called(1);
      verify(
        mockSnapshotMetadata.isFromCache,
      ).called(1);

      // expect(
      //   firestoreService.getDiscounts(null),
      //   emits([KTestVariables.discountModelItems.last]),
      // );
    });
    test('add discount', () async {
      await firestoreService
          .addDiscount(KTestVariables.discountModelItems.last);

      verify(
        mockFirebaseFirestore.collection(FirebaseCollectionName.discount),
      ).called(1);
      verify(
        mockCollectionReference.doc(KTestVariables.discountModelItems.last.id),
      ).called(1);
      verify(
        mockDocumentReference
            .set(KTestVariables.discountModelItems.last.toJson()),
      ).called(1);
    });
    test('add discount', () async {
      await firestoreService
          .deleteDiscountById(KTestVariables.discountModelItems.last.id);

      verify(
        mockFirebaseFirestore.collection(FirebaseCollectionName.discount),
      ).called(1);
      verify(
        mockCollectionReference.doc(KTestVariables.discountModelItems.last.id),
      ).called(1);
      verify(
        mockDocumentReference.delete(),
      ).called(1);
    });
  });
}
