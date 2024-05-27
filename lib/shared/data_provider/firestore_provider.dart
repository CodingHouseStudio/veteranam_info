// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:kozak/shared/shared.dart';

/// COMMENT: Class to get, update, delete or set values in firebase
@singleton
class FirestoreService {
  FirestoreService() {
    // Initialization logic can't use await directly in constructor
    _initFirestoreSettings();
  }
  // final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> _initFirestoreSettings() async {
    // Set settings for persistence based on platform
    // _db.settings = const Settings(
    //   persistenceEnabled: true,
    // );
  }

  Future<void> addFeedback(FeedbackModel feedback) {
    return Future.delayed(const Duration(seconds: 2));
    // return _db
    //     .collection(FirebaseCollectionName.feedback)
    //     .doc(feedback.id)
    //     .set(feedback.toJson());
  }

  Future<void> addQuestion(QuestionModel question) {
    return Future.delayed(const Duration(seconds: 2));
    // return _db
    //     .collection(FirebaseCollectionName.questions)
    //     .doc(question.id)
    //     .set(question.toJson());
  }

  Future<List<QuestionModel>> getQuestions() async {
    return [];
    // final docSnapshot =
    //     await _db.collection(FirebaseCollectionName.questions).get();

    // return docSnapshot.docs
    //     .map((doc) => QuestionModel.fromJson(doc.data()))
    //     .toList();

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
    return [];
    // final docSnapshot =
    //     await _db.collection(FirebaseCollectionName.funds).get();

    // return docSnapshot.docs
    //     .map((doc) => FundModel.fromJson(doc.data()))
    //     .toList();
  }

  Future<void> addFund(FundModel fund) {
    return Future.delayed(const Duration(seconds: 2));
    // return _db
    //     .collection(FirebaseCollectionName.funds)
    //     .doc(fund.id)
    //     .set(fund.toJson());
  }

  Future<void> updateUserSetting(UserSetting userSetting) {
    return Future.delayed(const Duration(seconds: 2));
    // return _db
    //     .collection(FirebaseCollectionName.userSettings)
    //     .doc(userSetting.id)
    //     .update(userSetting.toJson());
  }

  Future<void> setUserSetting({
    required UserSetting userSetting,
    required String userId,
  }) {
    return Future.delayed(const Duration(seconds: 2));
    // return _db
    //     .collection(FirebaseCollectionName.userSettings)
    //     .doc(userId)
    //     .set(userSetting.toJson());
  }

  Future<UserSetting> getUserSetting(String userId) async {
    // final docSnapshot = await _db
    //     .collection(FirebaseCollectionName.userSettings)
    //     .doc(userId)
    //     .get();
    // if (docSnapshot.exists) {
    //   return UserSetting.fromJson(docSnapshot.data()!);
    // } else {
    return UserSetting.empty;
    // }
  }

  Stream<List<InformationModel>> getInformations() => Stream.value([]);
  //  _db
  //         .collection(FirebaseCollectionName.information)
  //         .snapshots(includeMetadataChanges: true) // Enable caching
  //         .map(
  //       (snapshot) {
  //         for (final change in snapshot.docChanges) {
  //           if (change.type == DocumentChangeType.added) {
  //             final source =
  //                 (snapshot.metadata.isFromCache) ? 'local cache' : 'server';
  //             debugPrint('Data fetched from $source}');
  //           }
  //         }
  //         return snapshot.docs
  //             .map((doc) => InformationModel.fromJson(doc.data()))
  //             .toList();
  //       },
  //     );

  Future<void> addInformation(InformationModel information) {
    return Future.delayed(const Duration(seconds: 2));
    // return _db
    //     .collection(FirebaseCollectionName.information)
    //     .doc(information.id)
    //     .set(information.toJson());
  }

  Stream<List<WorkModel>> getWorks() => Stream.value([]);
  //  _db
  //         .collection(FirebaseCollectionName.work)
  //         .snapshots(includeMetadataChanges: true) // Enable caching
  //         .map(
  //       (snapshot) {
  //         for (final change in snapshot.docChanges) {
  //           if (change.type == DocumentChangeType.added) {
  //             final source =
  //                 (snapshot.metadata.isFromCache) ? 'local cache' : 'server';
  //             debugPrint('Data fetched from $source}');
  //           }
  //         }
  //         return snapshot.docs
  //             .map((doc) => WorkModel.fromJson(doc.data()))
  //             .toList();
  //       },
  //     );

  Future<void> addWork(WorkModel work) {
    return Future.delayed(const Duration(seconds: 2));
    // return _db
    //     .collection(FirebaseCollectionName.work)
    //     .doc(work.id)
    //     .set(work.toJson());
  }
}
