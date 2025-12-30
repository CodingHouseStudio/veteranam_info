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
      'use setting ${KScreenBlocName.firestoreService}'
      ' ${KGroupText.provider} ', () {
    late FirestoreService firestoreService;
    late FirebaseFirestore mockFirebaseFirestore;
    late CollectionReference<Map<String, dynamic>> mockCollectionReference;
    late DocumentSnapshot<Map<String, dynamic>> mockDocumentSnapshot;
    late DocumentSnapshot<Map<String, dynamic>> mockEmptyDocumentSnapshot;
    late MockDocumentReference<Map<String, dynamic>> mockEmptyDocumentReference;
    late SnapshotMetadata mockSnapshotMetadata;

    late DocumentReference<Map<String, dynamic>> mockDocumentReference;
    late CacheClient mockCache;
    setUp(() {
      ExtendedDateTime.current = KTestVariables.dateTime;
      mockCollectionReference = MockCollectionReference();
      mockFirebaseFirestore = MockFirebaseFirestore();
      mockDocumentReference = MockDocumentReference();
      mockDocumentSnapshot = MockDocumentSnapshot();
      mockSnapshotMetadata = MockSnapshotMetadata();
      mockEmptyDocumentReference = MockDocumentReference();
      mockEmptyDocumentSnapshot = MockDocumentSnapshot();
      mockCache = MockCacheClient();

      when(
        mockFirebaseFirestore.collection(FirebaseCollectionName.userSettings),
      ).thenAnswer((realInvocation) => mockCollectionReference);

      when(
        mockCollectionReference.doc(KTestVariables.user.id),
      ).thenAnswer(
        (_) => mockDocumentReference,
      );
      when(
        mockCollectionReference.doc(KTestVariables.fieldEmpty),
      ).thenAnswer(
        (_) => mockEmptyDocumentReference,
      );

      when(
        mockDocumentReference.set(
          KTestVariables.userSetting.toJson(),
          FirestoreService.setMergeOptions,
        ),
      ).thenAnswer(
        (_) async {},
      );

      when(
        mockDocumentReference.snapshots(
          includeMetadataChanges: true,
        ),
      ).thenAnswer(
        (_) => Stream.value(mockDocumentSnapshot),
      );

      when(
        mockEmptyDocumentReference.snapshots(
          includeMetadataChanges: true,
        ),
      ).thenAnswer(
        (_) => Stream.value(mockEmptyDocumentSnapshot),
      );

      when(
        mockDocumentSnapshot.data(),
      ).thenAnswer(
        (_) => KTestVariables.userSetting.toJson(),
      );
      when(
        mockDocumentSnapshot.exists,
      ).thenAnswer(
        (_) => true,
      );
      when(
        mockEmptyDocumentSnapshot.exists,
      ).thenAnswer(
        (_) => false,
      );

      when(
        mockCollectionReference.doc(KTestVariables.fieldEmpty),
      ).thenAnswer(
        (_) => mockEmptyDocumentReference,
      );

      when(
        mockDocumentSnapshot.metadata,
      ).thenAnswer(
        (_) => mockSnapshotMetadata,
      );

      when(
        mockSnapshotMetadata.isFromCache,
      ).thenAnswer(
        (_) => false,
      );

      when(
        mockDocumentReference.delete(),
      ).thenAnswer(
        (_) async {},
      );

      when(
        mockDocumentReference.update(
          KTestVariables.userSetting
              .copyWith(deletedOn: KTestVariables.dateTime)
              .toJson(),
        ),
      ).thenAnswer(
        (_) async {},
      );

      firestoreService = FirestoreService(
        cache: mockCache,
        firebaseFirestore: mockFirebaseFirestore,
      );
    });
    test('get user setting', () async {
      await expectLater(
        firestoreService.getUserSetting(KTestVariables.user.id),
        emitsInOrder([
          KTestVariables.userSetting,
        ]),
        reason: 'Wait for getting user setting',
      );

      verify(
        mockFirebaseFirestore.collection(FirebaseCollectionName.userSettings),
      ).called(1);
      verify(
        mockCollectionReference.doc(KTestVariables.user.id),
      ).called(1);
      verify(
        mockDocumentReference.snapshots(
          includeMetadataChanges: true,
        ),
      ).called(1);
      verify(
        mockDocumentSnapshot.data(),
      ).called(1);
      verify(
        mockDocumentSnapshot.exists,
      ).called(1);
      verify(
        mockDocumentSnapshot.metadata,
      ).called(1);
      verify(
        mockSnapshotMetadata.isFromCache,
      ).called(1);

      // expect(
      //   firestoreService.getUserSetting(KTestVariables.user.id),
      //   emits(KTestVariables.userSetting),
      // );
    });
    test('get empty user setting', () async {
      await expectLater(
        firestoreService.getUserSetting(KTestVariables.fieldEmpty),
        emitsInOrder([
          UserSetting.empty,
        ]),
        reason: 'Wait for getting user setting',
      );

      verify(
        mockFirebaseFirestore.collection(FirebaseCollectionName.userSettings),
      ).called(1);
      verify(
        mockCollectionReference.doc(KTestVariables.fieldEmpty),
      ).called(1);
      verify(
        mockEmptyDocumentReference.snapshots(
          includeMetadataChanges: true,
        ),
      ).called(1);
      verify(
        mockEmptyDocumentSnapshot.exists,
      ).called(1);
      verifyNever(
        mockEmptyDocumentSnapshot.data(),
      );
      verifyNever(
        mockDocumentSnapshot.metadata,
      );
      verifyNever(
        mockSnapshotMetadata.isFromCache,
      );

      // expect(
      //   firestoreService.getUserSetting(KTestVariables.fieldEmpty),
      //   emits(UserSetting.empty),
      // );
    });

    test('set user setting', () async {
      await firestoreService.setUserSetting(
        userSetting: KTestVariables.userSetting,
        userId: KTestVariables.user.id,
      );

      verify(
        mockFirebaseFirestore.collection(FirebaseCollectionName.userSettings),
      ).called(1);
      verify(
        mockCollectionReference.doc(KTestVariables.user.id),
      ).called(1);
      verify(
        mockDocumentReference.set(
          KTestVariables.userSetting.toJson(),
          FirestoreService.setMergeOptions,
        ),
      ).called(1);
    });
    // test('update user setting', () async {
    //   await firestoreService.updateUserSetting(
    //     KTestVariables.userSetting,
    //   );

    //   verify(
    //     mockFirebaseFirestore.collection(FirebaseCollectionName.
    // userSettings),
    //   ).called(1);
    //   verify(
    //     mockCollectionReference.doc(KTestVariables.user.id),
    //   ).called(1);
    //   verify(
    //     mockDocumentReference.update(KTestVariables.userSetting.toJson()),
    //   ).called(1);
    // });

    // test('delete user setting', () async {
    //   await firestoreService.deleteUserSetting(
    //     KTestVariables.userSetting,
    //   );

    //   verify(
    //     mockFirebaseFirestore.collection(FirebaseCollectionName.
    // userSettings),
    //   ).called(1);
    //   verify(
    //     mockCollectionReference.doc(KTestVariables.user.id),
    //   ).called(1);
    //   verify(
    //     mockDocumentReference.update(
    //       KTestVariables.userSetting
    //           .copyWith(deletedOn: KTestVariables.dateTime)
    //           .toJson(),
    //     ),
    //   ).called(1);
    // });
  });
}
