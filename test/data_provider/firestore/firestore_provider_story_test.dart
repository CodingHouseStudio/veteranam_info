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
      '${KScreenBlocName.story} ${KScreenBlocName.firestoreService}'
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
        mockFirebaseFirestore.collection(FirebaseCollectionName.stroies),
      ).thenAnswer((realInvocation) => mockCollectionReference);

      when(
        mockCollectionReference.doc(KTestVariables.storyModelItems.first.id),
      ).thenAnswer(
        (_) => mockDocumentReference,
      );

      when(
        mockDocumentReference
            .set(KTestVariables.storyModelItems.first.toJson()),
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
        (_) => KTestVariables.storyModelItems
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
      when(
        mockCollectionReference.where(
          StoryModelJsonField.userId,
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

      firestoreService = FirestoreService(
        cache: mockCache,
        firebaseFirestore: mockFirebaseFirestore,
      );
    });
    test('add story', () async {
      await firestoreService.addStory(KTestVariables.storyModelItems.first);

      verify(
        mockFirebaseFirestore.collection(FirebaseCollectionName.stroies),
      ).called(1);
      verify(
        mockCollectionReference.doc(KTestVariables.storyModelItems.first.id),
      ).called(1);
      verify(
        mockDocumentReference
            .set(KTestVariables.storyModelItems.first.toJson()),
      ).called(1);
    });
    test('get stories', () async {
      await expectLater(
        firestoreService.getStories(),
        emitsInOrder([
          [KTestVariables.storyModelItems.first],
        ]),
        reason: 'Wait for getting information',
      );

      verify(
        mockFirebaseFirestore.collection(FirebaseCollectionName.stroies),
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

      // expect(
      //   firestoreService.getStories(),
      //   emits([KTestVariables.storyModelItems.first]),
      // );
    });
    test('Get User Story', () async {
      expect(
        await firestoreService.getStoriesByUserId(KTestVariables.user.id),
        [KTestVariables.storyModelItems.first],
      );

      verify(
        mockFirebaseFirestore.collection(FirebaseCollectionName.stroies),
      ).called(1);
      verify(
        mockCollectionReference.where(
          StoryModelJsonField.userId,
          isEqualTo: KTestVariables.user.id,
        ),
      ).called(1);
      verify(
        mockQuery.get(),
      ).called(1);
      verify(
        mockQuerySnapshot.docs,
      ).called(1);
      verify(
        mockQueryDocumentSnapshot.last.data(),
      ).called(1);
    });
  });
}
