import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:kozak/shared/shared.dart';

/// COMMENT: Class to get, update, delete or set values in firebase
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

  Future<List<FundModel>> getFunds() async {
    final docSnapshot =
        await _db.collection(FirebaseCollectionName.funds).get();

    return docSnapshot.docs
        .map((doc) => FundModel.fromJson(doc.data()))
        .toList();
  }

  Future<void> addFund(FundModel fund) {
    return _db
        .collection(FirebaseCollectionName.funds)
        .doc(fund.id)
        .set(fund.toJson());
  }

  Future<void> updateUserSetting(UserSetting userSetting) {
    return _db
        .collection(FirebaseCollectionName.userSettings)
        .doc(userSetting.id)
        .update(userSetting.toJson());
  }

  Future<void> setUserSetting({
    required UserSetting userSetting,
    required String userId,
  }) {
    return _db
        .collection(FirebaseCollectionName.userSettings)
        .doc(userId)
        .set(userSetting.toJson());
  }

  Future<UserSetting> getUserSetting(String userId) async {
    final docSnapshot = await _db
        .collection(FirebaseCollectionName.userSettings)
        .doc(userId)
        .get();
    if (docSnapshot.exists) {
      return UserSetting.fromJson(docSnapshot.data()!);
    } else {
      return UserSetting.empty;
    }
  }
}
