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
        mockCollectionReference.doc(KTestText.discountModelItems.last.id),
      ).thenAnswer(
        (_) => mockDocumentReference,
      );

      when(
        mockCollectionReference.where(
          DiscountModelJsonField.userId,
          isEqualTo: KTestText.user.id,
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
        (_) =>
            KTestText.discountModelItems.map((e) => e.toJson()).toList().last,
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
        mockDocumentReference.set(KTestText.discountModelItems.last.toJson()),
      ).thenAnswer(
        (_) async {},
      );

      when(
        mockDocumentReference.delete(),
      ).thenAnswer(
        (_) async {},
      );

      FirestoreService.firebaseFirestore = mockFirebaseFirestore;
      firestoreService = FirestoreService(mockCache);
    });

    test('get discounts', () async {
      await expectLater(
        firestoreService.getDiscounts(//null
            ),
        emitsInOrder([
          [KTestText.discountModelItems.last],
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
      //   emits([KTestText.discountModelItems.last]),
      // );
    });
    test('add discount', () async {
      await firestoreService.addDiscount(KTestText.discountModelItems.last);

      verify(
        mockFirebaseFirestore.collection(FirebaseCollectionName.discount),
      ).called(1);
      verify(
        mockCollectionReference.doc(KTestText.discountModelItems.last.id),
      ).called(1);
      verify(
        mockDocumentReference.set(KTestText.discountModelItems.last.toJson()),
      ).called(1);
    });
    test('add discount', () async {
      await firestoreService
          .deleteDiscountById(KTestText.discountModelItems.last.id);

      verify(
        mockFirebaseFirestore.collection(FirebaseCollectionName.discount),
      ).called(1);
      verify(
        mockCollectionReference.doc(KTestText.discountModelItems.last.id),
      ).called(1);
      verify(
        mockDocumentReference.delete(),
      ).called(1);
    });
  });
}
