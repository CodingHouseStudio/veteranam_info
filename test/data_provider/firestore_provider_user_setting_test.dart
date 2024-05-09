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
      late CollectionReference<Map<String, dynamic>> mockCollectionReference;
      late DocumentSnapshot<Map<String, dynamic>> mockDocumentSnapshot;

      late DocumentReference<Map<String, dynamic>> mockDocumentReference;
      setUp(() {
        mockCollectionReference = MockCollectionReference();
        mockFirebaseFirestore = MockFirebaseFirestore();

        mockDocumentSnapshot = MockDocumentSnapshot();
        mockDocumentReference = MockDocumentReference();

        when(
          mockFirebaseFirestore.collection(FirebaseCollectionName.userSettings),
        ).thenAnswer((realInvocation) => mockCollectionReference);

        when(
          mockCollectionReference.doc(KTestText.user.id),
        ).thenAnswer(
          (_) => mockDocumentReference,
        );

        when(
          mockDocumentReference.set(KTestText.userSetting.toJson()),
        ).thenAnswer(
          (_) async {},
        );

        when(
          mockDocumentReference.get(),
        ).thenAnswer(
          (_) async => mockDocumentSnapshot,
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
          mockDocumentReference.update(KTestText.userSetting.toJson()),
        ).thenAnswer(
          (_) async {},
        );

        FirestoreService.firebaseFirestore = mockFirebaseFirestore;
        firestoreService = FirestoreService();
      });
      test('get user setting', () async {
        expect(
          await firestoreService.getUserSetting(KTestText.user.id),
          KTestText.userSetting,
        );

        verify(
          mockFirebaseFirestore.collection(FirebaseCollectionName.userSettings),
        ).called(1);
        verify(
          mockCollectionReference.doc(KTestText.user.id),
        ).called(1);
        verify(
          mockDocumentReference.get(),
        ).called(1);
        verify(
          mockDocumentSnapshot.data(),
        ).called(1);
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
          mockDocumentReference.set(KTestText.userSetting.toJson()),
        ).called(1);
      });
      test('update user setting', () async {
        await firestoreService.updateUserSetting(
          KTestText.userSetting,
        );

        verify(
          mockFirebaseFirestore.collection(FirebaseCollectionName.userSettings),
        ).called(1);
        verify(
          mockCollectionReference.doc(KTestText.user.id),
        ).called(1);
        verify(
          mockDocumentReference.update(KTestText.userSetting.toJson()),
        ).called(1);
      });
    });
  });
}
