import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared.dart';

import '../text_dependency.dart';

void userSetting() {
  final FirebaseFirestore mockFirebaseFirestore = MockFirebaseFirestore();
  final CollectionReference<Map<String, dynamic>> mockCollectionReference =
      MockCollectionReference();
  final mockDocumentReference = MockDocumentReference<Map<String, dynamic>>();
  final DocumentSnapshot<Map<String, dynamic>> mockDocumentSnapshot =
      MockDocumentSnapshot();

  when(
    mockFirebaseFirestore.collection(FirebaseCollectionName.userSettings),
  ).thenAnswer((realInvocation) => mockCollectionReference);

  when(
    mockCollectionReference.doc(KTestText.fieldEmpty),
  ).thenAnswer(
    (_) => mockDocumentReference,
  );

  when(
    mockDocumentReference.snapshots(
      includeMetadataChanges: true,
    ),
  ).thenAnswer(
    (_) => Stream.value(mockDocumentSnapshot),
  );
  when(
    mockDocumentSnapshot.exists,
  ).thenAnswer(
    (_) => false,
  );
  FirestoreService.firebaseFirestore = mockFirebaseFirestore;
}
