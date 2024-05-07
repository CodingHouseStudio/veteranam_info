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
      late CollectionReference<Map<String, dynamic>>
          mockFundCollectionReference;
      late CollectionReference<Map<String, dynamic>>
          mockQuestionCollectionReference;
      late CollectionReference<Map<String, dynamic>>
          mockInformationCollectionReference;
      late CollectionReference<Map<String, dynamic>>
          mockWorkCollectionReference;
      late CollectionReference<Map<String, dynamic>>
          mockUserSettingCollectionReference;
      late QuerySnapshot<Map<String, dynamic>> mockFundQuerySnapshot;
      late QuerySnapshot<Map<String, dynamic>> mockQuestionQuerySnapshot;
      late QuerySnapshot<Map<String, dynamic>> mockInformationQuerySnapshot;
      late QuerySnapshot<Map<String, dynamic>> mockWorkQuerySnapshot;
      late List<QueryDocumentSnapshot<Map<String, dynamic>>>
          mockFundQueryDocumentSnapshot;
      late List<QueryDocumentSnapshot<Map<String, dynamic>>>
          mockQuestionQueryDocumentSnapshot;
      late List<QueryDocumentSnapshot<Map<String, dynamic>>>
          mockInformationQueryDocumentSnapshot;
      late List<QueryDocumentSnapshot<Map<String, dynamic>>>
          mockWorkQueryDocumentSnapshot;
      late DocumentSnapshot<Map<String, dynamic>>
          mockUserSettingDocumentSnapshot;
      late DocumentReference<Map<String, dynamic>> mockDocumentReference;
      late DocumentReference<Map<String, dynamic>>
          mockUserSettingDocumentReference;
      late List<DocumentChange<Map<String, dynamic>>> mockDocumentChange;
      setUp(() {
        mockCollectionReference = MockCollectionReference();
        mockFundCollectionReference = MockCollectionReference();
        mockQuestionCollectionReference = MockCollectionReference();
        mockInformationCollectionReference = MockCollectionReference();
        mockWorkCollectionReference = MockCollectionReference();
        mockUserSettingCollectionReference = MockCollectionReference();
        mockFirebaseFirestore = MockFirebaseFirestore();
        mockDocumentReference = MockDocumentReference();
        mockFundQuerySnapshot = MockQuerySnapshot();
        mockQuestionQuerySnapshot = MockQuerySnapshot();
        mockInformationQuerySnapshot = MockQuerySnapshot();
        mockWorkQuerySnapshot = MockQuerySnapshot();
        mockFundQueryDocumentSnapshot = [MockQueryDocumentSnapshot()];
        mockQuestionQueryDocumentSnapshot = [MockQueryDocumentSnapshot()];
        mockInformationQueryDocumentSnapshot = [MockQueryDocumentSnapshot()];
        mockWorkQueryDocumentSnapshot = [MockQueryDocumentSnapshot()];
        mockUserSettingDocumentSnapshot = MockDocumentSnapshot();
        mockUserSettingDocumentReference = MockDocumentReference();
        mockDocumentChange = [MockDocumentChange()];

        when(
          mockFirebaseFirestore.collection(FirebaseCollectionName.feedback),
        ).thenAnswer((realInvocation) => mockCollectionReference);
        when(
          mockFirebaseFirestore.collection(FirebaseCollectionName.funds),
        ).thenAnswer((realInvocation) => mockFundCollectionReference);
        when(
          mockFirebaseFirestore.collection(FirebaseCollectionName.information),
        ).thenAnswer((realInvocation) => mockInformationCollectionReference);
        when(
          mockFirebaseFirestore.collection(FirebaseCollectionName.questions),
        ).thenAnswer((realInvocation) => mockQuestionCollectionReference);
        when(
          mockFirebaseFirestore.collection(FirebaseCollectionName.work),
        ).thenAnswer((realInvocation) => mockWorkCollectionReference);
        when(
          mockFirebaseFirestore.collection(FirebaseCollectionName.userSettings),
        ).thenAnswer((realInvocation) => mockUserSettingCollectionReference);

        when(
          mockCollectionReference.doc(KTestText.feedbackModel.id),
        ).thenAnswer(
          (_) => mockDocumentReference,
        );
        when(
          mockFundCollectionReference.doc(KTestText.fundItems.first.id),
        ).thenAnswer(
          (_) => mockDocumentReference,
        );
        when(
          mockInformationCollectionReference
              .doc(KTestText.informationModelItems.first.id),
        ).thenAnswer(
          (_) => mockDocumentReference,
        );
        when(
          mockQuestionCollectionReference
              .doc(KTestText.questionModelItems.first.id),
        ).thenAnswer(
          (_) => mockDocumentReference,
        );
        when(
          mockWorkCollectionReference.doc(KTestText.workModelItems.first.id),
        ).thenAnswer(
          (_) => mockDocumentReference,
        );
        when(
          mockUserSettingCollectionReference.doc(KTestText.user.id),
        ).thenAnswer(
          (_) => mockUserSettingDocumentReference,
        );

        when(
          mockDocumentReference.set(KTestText.feedbackModel.toJson()),
        ).thenAnswer(
          (_) async {},
        );
        when(
          mockDocumentReference.set(KTestText.fundItems.first.toJson()),
        ).thenAnswer(
          (_) async {},
        );
        when(
          mockDocumentReference
              .set(KTestText.informationModelItems.first.toJson()),
        ).thenAnswer(
          (_) async {},
        );
        when(
          mockDocumentReference
              .set(KTestText.questionModelItems.first.toJson()),
        ).thenAnswer(
          (_) async {},
        );
        when(
          mockDocumentReference.set(KTestText.workModelItems.first.toJson()),
        ).thenAnswer(
          (_) async {},
        );
        when(
          mockUserSettingDocumentReference.set(KTestText.userSetting.toJson()),
        ).thenAnswer(
          (_) async {},
        );

        when(
          mockFundCollectionReference.get(),
        ).thenAnswer(
          (_) async => mockFundQuerySnapshot,
        );
        when(
          mockQuestionCollectionReference.get(),
        ).thenAnswer(
          (_) async => mockQuestionQuerySnapshot,
        );
        when(
          mockInformationCollectionReference.snapshots(
            includeMetadataChanges: true,
          ),
        ).thenAnswer(
          (_) => Stream.value(mockInformationQuerySnapshot),
        );
        when(
          mockWorkCollectionReference.snapshots(
            includeMetadataChanges: true,
          ),
        ).thenAnswer(
          (_) => Stream.value(mockWorkQuerySnapshot),
        );

        when(
          mockFundQuerySnapshot.docs,
        ).thenAnswer(
          (_) => mockFundQueryDocumentSnapshot,
        );
        when(
          mockQuestionQuerySnapshot.docs,
        ).thenAnswer(
          (_) => mockQuestionQueryDocumentSnapshot,
        );
        when(
          mockInformationQuerySnapshot.docs,
        ).thenAnswer(
          (_) => mockInformationQueryDocumentSnapshot,
        );
        when(
          mockWorkQuerySnapshot.docs,
        ).thenAnswer(
          (_) => mockWorkQueryDocumentSnapshot,
        );
        when(
          mockUserSettingDocumentReference.get(),
        ).thenAnswer(
          (_) async => mockUserSettingDocumentSnapshot,
        );

        when(
          mockFundQueryDocumentSnapshot.first.data(),
        ).thenAnswer(
          (_) => KTestText.fundItems.map((e) => e.toJson()).toList().first,
        );
        when(
          mockQuestionQueryDocumentSnapshot.first.data(),
        ).thenAnswer(
          (_) => KTestText.questionModelItems
              .map((e) => e.toJson())
              .toList()
              .first,
        );
        when(
          mockInformationQueryDocumentSnapshot.first.data(),
        ).thenAnswer(
          (_) => KTestText.informationModelItems
              .map((e) => e.toJson())
              .toList()
              .first,
        );
        when(
          mockWorkQueryDocumentSnapshot.first.data(),
        ).thenAnswer(
          (_) => KTestText.workModelItems.map((e) => e.toJson()).toList().first,
        );

        when(
          mockInformationQuerySnapshot.docChanges,
        ).thenAnswer(
          (_) => mockDocumentChange,
        );
        when(
          mockWorkQuerySnapshot.docChanges,
        ).thenAnswer(
          (_) => mockDocumentChange,
        );

        when(
          mockDocumentChange.first.type,
        ).thenAnswer(
          (_) => DocumentChangeType.modified,
        );

        when(
          mockUserSettingDocumentSnapshot.data(),
        ).thenAnswer(
          (_) => KTestText.userSetting.toJson(),
        );
        when(
          mockUserSettingDocumentSnapshot.exists,
        ).thenAnswer(
          (_) => true,
        );

        when(
          mockUserSettingDocumentReference
              .update(KTestText.userSetting.toJson()),
        ).thenAnswer(
          (_) async {},
        );

        FirestoreService.firebaseFirestore = mockFirebaseFirestore;
        firestoreService = FirestoreService();
      });
      test('add feedback', () async {
        await firestoreService.addFeedback(KTestText.feedbackModel);

        verify(
          mockFirebaseFirestore.collection(FirebaseCollectionName.feedback),
        ).called(1);
        verify(
          mockCollectionReference.doc(KTestText.feedbackModel.id),
        ).called(1);
        verify(
          mockDocumentReference.set(KTestText.feedbackModel.toJson()),
        ).called(1);
      });
      test('add fund', () async {
        await firestoreService.addFund(KTestText.fundItems.first);

        verify(
          mockFirebaseFirestore.collection(FirebaseCollectionName.funds),
        ).called(1);
        verify(
          mockFundCollectionReference.doc(KTestText.fundItems.first.id),
        ).called(1);
        verify(
          mockDocumentReference.set(KTestText.fundItems.first.toJson()),
        ).called(1);
      });
      test('add information', () async {
        await firestoreService
            .addInformation(KTestText.informationModelItems.first);

        verify(
          mockFirebaseFirestore.collection(FirebaseCollectionName.information),
        ).called(1);
        verify(
          mockInformationCollectionReference
              .doc(KTestText.informationModelItems.first.id),
        ).called(1);
        verify(
          mockDocumentReference
              .set(KTestText.informationModelItems.first.toJson()),
        ).called(1);
      });
      test('add question', () async {
        await firestoreService.addQuestion(KTestText.questionModelItems.first);

        verify(
          mockFirebaseFirestore.collection(FirebaseCollectionName.questions),
        ).called(1);
        verify(
          mockQuestionCollectionReference
              .doc(KTestText.questionModelItems.first.id),
        ).called(1);
        verify(
          mockDocumentReference
              .set(KTestText.questionModelItems.first.toJson()),
        ).called(1);
      });
      test('add work', () async {
        await firestoreService.addWork(KTestText.workModelItems.first);

        verify(
          mockFirebaseFirestore.collection(FirebaseCollectionName.work),
        ).called(1);
        verify(
          mockWorkCollectionReference.doc(KTestText.workModelItems.first.id),
        ).called(1);
        verify(
          mockDocumentReference.set(KTestText.workModelItems.first.toJson()),
        ).called(1);
      });

      test('get funds', () async {
        expect(
          await firestoreService.getFunds(),
          [KTestText.fundItems.first],
        );

        verify(
          mockFirebaseFirestore.collection(FirebaseCollectionName.funds),
        ).called(1);
        verify(
          mockFundCollectionReference.get(),
        ).called(1);
        verify(
          mockFundQuerySnapshot.docs,
        ).called(1);
        verify(
          mockFundQueryDocumentSnapshot.first.data(),
        ).called(1);
      });
      test('get questions', () async {
        expect(
          await firestoreService.getQuestions(),
          [KTestText.questionModelItems.first],
        );

        verify(
          mockFirebaseFirestore.collection(FirebaseCollectionName.questions),
        ).called(1);
        verify(
          mockQuestionCollectionReference.get(),
        ).called(1);
        verify(
          mockQuestionQuerySnapshot.docs,
        ).called(1);
        verify(
          mockQuestionQueryDocumentSnapshot.first.data(),
        ).called(1);
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
          mockUserSettingCollectionReference.doc(KTestText.user.id),
        ).called(1);
        verify(
          mockUserSettingDocumentReference.get(),
        ).called(1);
        verify(
          mockUserSettingDocumentSnapshot.data(),
        ).called(1);
      });
      test('get information', () async {
        await expectLater(
          firestoreService.getInformations(),
          emitsInOrder([
            [KTestText.informationModelItems.first],
          ]),
          reason: 'Wait for getting information',
        );

        verify(
          mockFirebaseFirestore.collection(FirebaseCollectionName.information),
        ).called(1);
        verify(
          mockInformationCollectionReference.snapshots(
            includeMetadataChanges: true,
          ),
        ).called(1);
        verify(
          mockInformationQuerySnapshot.docs,
        ).called(1);
        verify(
          mockInformationQueryDocumentSnapshot.first.data(),
        ).called(1);

        expect(
          firestoreService.getInformations(),
          emits([KTestText.informationModelItems.first]),
        );
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
          mockWorkCollectionReference.snapshots(
            includeMetadataChanges: true,
          ),
        ).called(1);
        verify(
          mockWorkQuerySnapshot.docs,
        ).called(1);
        verify(
          mockWorkQueryDocumentSnapshot.first.data(),
        ).called(1);

        expect(
          firestoreService.getWorks(),
          emits([KTestText.workModelItems.first]),
        );
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
          mockUserSettingCollectionReference.doc(KTestText.user.id),
        ).called(1);
        verify(
          mockUserSettingDocumentReference.set(KTestText.userSetting.toJson()),
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
          mockUserSettingCollectionReference.doc(KTestText.user.id),
        ).called(1);
        verify(
          mockUserSettingDocumentReference
              .update(KTestText.userSetting.toJson()),
        ).called(1);
      });
    });
  });
}
