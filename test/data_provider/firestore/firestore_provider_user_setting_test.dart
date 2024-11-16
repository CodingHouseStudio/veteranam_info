import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  tearDown(GetIt.I.reset);
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
      ExtendedDateTime.current = KTestText.dateTime;
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
        mockCollectionReference.doc(KTestText.user.id),
      ).thenAnswer(
        (_) => mockDocumentReference,
      );
      when(
        mockCollectionReference.doc(KTestText.fieldEmpty),
      ).thenAnswer(
        (_) => mockEmptyDocumentReference,
      );

      when(
        mockDocumentReference.set(
          KTestText.userSetting.toJson(),
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
        (_) => KTestText.userSetting.toJson(),
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
        mockCollectionReference.doc(KTestText.fieldEmpty),
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
          KTestText.userSetting
              .copyWith(deletedOn: KTestText.dateTime)
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
        firestoreService.getUserSetting(KTestText.user.id),
        emitsInOrder([
          KTestText.userSetting,
        ]),
        reason: 'Wait for getting user setting',
      );

      verify(
        mockFirebaseFirestore.collection(FirebaseCollectionName.userSettings),
      ).called(1);
      verify(
        mockCollectionReference.doc(KTestText.user.id),
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
      //   firestoreService.getUserSetting(KTestText.user.id),
      //   emits(KTestText.userSetting),
      // );
    });
    test('get empty user setting', () async {
      await expectLater(
        firestoreService.getUserSetting(KTestText.fieldEmpty),
        emitsInOrder([
          UserSetting.empty,
        ]),
        reason: 'Wait for getting user setting',
      );

      verify(
        mockFirebaseFirestore.collection(FirebaseCollectionName.userSettings),
      ).called(1);
      verify(
        mockCollectionReference.doc(KTestText.fieldEmpty),
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
      //   firestoreService.getUserSetting(KTestText.fieldEmpty),
      //   emits(UserSetting.empty),
      // );
    });

    test('set user setting', () async {
      await firestoreService.setUserSetting(
        userSetting: KTestText.userSetting,
        userId: KTestText.user.id,
      );

      verify(
        mockFirebaseFirestore.collection(FirebaseCollectionName.userSettings),
      ).called(1);
      verify(
        mockCollectionReference.doc(KTestText.user.id),
      ).called(1);
      verify(
        mockDocumentReference.set(
          KTestText.userSetting.toJson(),
          FirestoreService.setMergeOptions,
        ),
      ).called(1);
    });
    // test('update user setting', () async {
    //   await firestoreService.updateUserSetting(
    //     KTestText.userSetting,
    //   );

    //   verify(
    //     mockFirebaseFirestore.collection(FirebaseCollectionName.
    // userSettings),
    //   ).called(1);
    //   verify(
    //     mockCollectionReference.doc(KTestText.user.id),
    //   ).called(1);
    //   verify(
    //     mockDocumentReference.update(KTestText.userSetting.toJson()),
    //   ).called(1);
    // });

    // test('delete user setting', () async {
    //   await firestoreService.deleteUserSetting(
    //     KTestText.userSetting,
    //   );

    //   verify(
    //     mockFirebaseFirestore.collection(FirebaseCollectionName.
    // userSettings),
    //   ).called(1);
    //   verify(
    //     mockCollectionReference.doc(KTestText.user.id),
    //   ).called(1);
    //   verify(
    //     mockDocumentReference.update(
    //       KTestText.userSetting
    //           .copyWith(deletedOn: KTestText.dateTime)
    //           .toJson(),
    //     ),
    //   ).called(1);
    // });
  });
}
