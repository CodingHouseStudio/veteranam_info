import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../test_dependency.dart';

void userSetting(FirebaseFirestore mockFirebaseFirestore) {
  final CollectionReference<Map<String, dynamic>> mockCollectionReference =
      MockCollectionReference();
  final mockDocumentReference = MockDocumentReference<Map<String, dynamic>>();
  final DocumentSnapshot<Map<String, dynamic>> mockDocumentSnapshot =
      MockDocumentSnapshot();

  when(
    mockFirebaseFirestore.collection(FirebaseCollectionName.userSettings),
  ).thenAnswer((realInvocation) => mockCollectionReference);

  when(
    mockCollectionReference.doc(KTestVariables.fieldEmpty),
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
}
