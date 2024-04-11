import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:kozak/shared/shared.dart';

@singleton
class FirestoreService {
  FirestoreService() {
    // Initialization logic can't use await directly in constructor
    _initFirestoreSettings();
  }
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> _initFirestoreSettings() async {
    // Set settings for persistence based on platform
    _db.settings = const Settings(
      persistenceEnabled: true,
    );
  }

  Future<void> addFeedback(FeedbackModel feedback) {
    return _db
        .collection(FirebaseCollectionName.feedback)
        .doc(feedback.id)
        .set(feedback.toJson());
  }

  Future<void> addQuestion(QuestionModel question) {
    return _db
        .collection(FirebaseCollectionName.questions)
        .doc(question.id)
        .set(question.toJson());
  }

  Future<List<QuestionModel>> getQuestions() async {
    final docSnapshot =
        await _db.collection(FirebaseCollectionName.questions).get();

    return docSnapshot.docs
        .map((doc) => QuestionModel.fromJson(doc.data()))
        .toList();

    //     .snapshots(includeMetadataChanges: true)
    //     .map((snapshot) {
    //   for (final change in snapshot.docChanges) {
    //     if (change.type == DocumentChangeType.added) {
    //       final source =
    //           (snapshot.metadata.isFromCache) ? 'local cache' : 'server';
    //       debugPrint('Data fetched from $source}');
    //     }
    //   }
    //   return snapshot.docs
    //       .map((doc) => QuestionModel.fromJson(doc.data()))
    //       .toList();
    // });
  }
}
