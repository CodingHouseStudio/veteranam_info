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
      '${KScreenBlocName.home} ${KScreenBlocName.firestoreService}'
      ' ${KGroupText.provider} ', () {
    late FirestoreService firestoreService;
    late FirebaseFirestore mockFirebaseFirestore;
    late CollectionReference<Map<String, dynamic>> mockCollectionReference;
    late QuerySnapshot<Map<String, dynamic>> mockQuerySnapshot;
    late List<QueryDocumentSnapshot<Map<String, dynamic>>>
        mockQueryDocumentSnapshot;
    late DocumentReference<Map<String, dynamic>> mockDocumentReference;
    late CacheClient mockCache;
    setUp(() {
      mockCollectionReference = MockCollectionReference();
      mockFirebaseFirestore = MockFirebaseFirestore();
      mockDocumentReference = MockDocumentReference();
      mockQuerySnapshot = MockQuerySnapshot();
      mockQueryDocumentSnapshot = [MockQueryDocumentSnapshot()];
      mockCache = MockCacheClient();

      when(
        mockFirebaseFirestore.collection(FirebaseCollectionName.questions),
      ).thenAnswer((realInvocation) => mockCollectionReference);

      when(
        mockCollectionReference.doc(KTestVariables.questionModelItems.first.id),
      ).thenAnswer(
        (_) => mockDocumentReference,
      );

      when(
        mockDocumentReference
            .set(KTestVariables.questionModelItems.first.toJson()),
      ).thenAnswer(
        (_) async {},
      );

      when(
        mockCollectionReference.get(FirestoreService.getOptions),
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
        (_) => KTestVariables.questionModelItems
            .map((e) => e.toJson())
            .toList()
            .first,
      );

      firestoreService = FirestoreService(
        cache: mockCache,
        firebaseFirestore: mockFirebaseFirestore,
      );
    });
    test('add question', () async {
      await firestoreService
          .addQuestion(KTestVariables.questionModelItems.first);

      verify(
        mockFirebaseFirestore.collection(FirebaseCollectionName.questions),
      ).called(1);
      verify(
        mockCollectionReference.doc(KTestVariables.questionModelItems.first.id),
      ).called(1);
      verify(
        mockDocumentReference
            .set(KTestVariables.questionModelItems.first.toJson()),
      ).called(1);
    });
    test('get questions', () async {
      expect(
        await firestoreService.getQuestions(),
        [KTestVariables.questionModelSHort],
      );

      verify(
        mockFirebaseFirestore.collection(FirebaseCollectionName.questions),
      ).called(1);
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
