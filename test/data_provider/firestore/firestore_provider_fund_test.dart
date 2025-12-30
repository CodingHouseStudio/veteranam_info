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
      '${KScreenBlocName.investors} ${KScreenBlocName.firestoreService}'
      ' ${KGroupText.provider} ', () {
    late FirestoreService firestoreService;
    late FirebaseFirestore mockFirebaseFirestore;
    late CollectionReference<Map<String, dynamic>> mockCollectionReference;
    late QuerySnapshot<Map<String, dynamic>> mockQuerySnapshot;
    late List<QueryDocumentSnapshot<Map<String, dynamic>>>
        mockQueryDocumentSnapshot;
    late Query<Map<String, dynamic>> mockQuery;
    late DocumentReference<Map<String, dynamic>> mockDocumentReference;
    late CacheClient mockCache;
    setUp(() {
      mockCollectionReference = MockCollectionReference();
      mockFirebaseFirestore = MockFirebaseFirestore();
      mockDocumentReference = MockDocumentReference();
      mockQuerySnapshot = MockQuerySnapshot();
      mockQueryDocumentSnapshot = [MockQueryDocumentSnapshot()];
      mockQuery = MockQuery();
      mockCache = MockCacheClient();

      when(
        mockFirebaseFirestore.collection(FirebaseCollectionName.funds),
      ).thenAnswer((realInvocation) => mockCollectionReference);

      when(
        mockCollectionReference.where(FundModelJsonField.id, whereIn: null),
      ).thenAnswer((realInvocation) => mockQuery);

      when(
        mockCollectionReference.doc(KTestVariables.fundItemsWithImage.first.id),
      ).thenAnswer(
        (_) => mockDocumentReference,
      );

      when(
        mockDocumentReference
            .set(KTestVariables.fundItemsWithImage.first.toJson()),
      ).thenAnswer(
        (_) async {},
      );

      when(
        mockCollectionReference.get(FirestoreService.getOptions), //mockQuery
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
        (_) => KTestVariables.fundItemsWithImage
            .map((e) => e.toJson())
            .toList()
            .first,
      );

      firestoreService = FirestoreService(
        cache: mockCache,
        firebaseFirestore: mockFirebaseFirestore,
      );
    });
    test('add fund', () async {
      await firestoreService.addFund(KTestVariables.fundItemsWithImage.first);

      verify(
        mockFirebaseFirestore.collection(FirebaseCollectionName.funds),
      ).called(1);
      verify(
        mockCollectionReference.doc(KTestVariables.fundItemsWithImage.first.id),
      ).called(1);
      verify(
        mockDocumentReference
            .set(KTestVariables.fundItemsWithImage.first.toJson()),
      ).called(1);
    });

    test('get funds', () async {
      expect(
        await firestoreService.getFunds(//null
            ),
        [KTestVariables.fundItemsWithImage.first],
      );

      verify(
        mockFirebaseFirestore.collection(FirebaseCollectionName.funds),
      ).called(1);
      // verify(
      //   mockCollectionReference.where(FundModelJsonField.id, whereIn: null),
      // ).called(1);
      verify(
        mockCollectionReference.get(FirestoreService.getOptions),
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
