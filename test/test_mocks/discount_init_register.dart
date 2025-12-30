import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/mockito.dart';

import 'package:veteranam/shared/shared_dart.dart';
import '../test_dependency.dart';

void discountInit(FirebaseFirestore mockFirebaseFirestore) {
  final CollectionReference<Map<String, dynamic>> mockCollectionReference =
      MockCollectionReference();
  final mockDocumentReference = MockDocumentReference<Map<String, dynamic>>();
  final DocumentSnapshot<Map<String, dynamic>> mockDocumentSnapshot =
      MockDocumentSnapshot();
  final Query<Map<String, dynamic>> mockQuery = MockQuery();
  final QuerySnapshot<Map<String, dynamic>> mockQuerySnapshot =
      MockQuerySnapshot();
  final mockQueryDocumentSnapshot =
      <QueryDocumentSnapshot<Map<String, dynamic>>>[
    MockQueryDocumentSnapshot(),
  ];

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
      DiscountModelJsonField.status,
      isEqualTo: DiscountState.published.enumString,
    ),
  ).thenAnswer((realInvocation) => mockQuery);

  when(
    mockQuery.where(
      DiscountModelJsonField.userName,
      isNull: false,
    ),
  ).thenAnswer((realInvocation) => mockQuery);

  when(
    mockQuery.snapshots(
      includeMetadataChanges: true,
    ),
  ).thenAnswer(
    (_) => Stream.value(mockQuerySnapshot),
  );

  when(
    mockDocumentReference.snapshots(
      includeMetadataChanges: true,
    ),
  ).thenAnswer(
    (_) => Stream.value(mockDocumentSnapshot),
  );
  when(
    mockQuerySnapshot.docs,
  ).thenAnswer(
    (_) => mockQueryDocumentSnapshot,
  );

  when(
    mockQueryDocumentSnapshot.last.data(),
  ).thenAnswer(
    (_) =>
        KTestVariables.discountModelItems.map((e) => e.toJson()).toList().last,
  );
}
