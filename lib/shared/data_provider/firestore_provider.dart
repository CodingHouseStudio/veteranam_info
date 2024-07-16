import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

/// COMMENT: Class to get, update, delete or set values in firebase
@singleton
class FirestoreService {
  FirestoreService() {
    // Initialization logic can't use await directly in constructor
    _initFirestoreSettings();
  }

  final FirebaseFirestore _db = firebaseFirestore;

  @visibleForTesting
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @visibleForTesting
  static const getOptions = GetOptions();
  @visibleForTesting
  static const getCahseOptions = GetOptions(source: Source.cache);

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

  Future<List<FeedbackModel>> getUserFeedback(String userId) async {
    final snapshot = await _db
        .collection(FirebaseCollectionName.feedback)
        .where(FeedbackModelJsonField.guestId, isEqualTo: userId)
        .get();
    return snapshot.docs
        .map((doc) => FeedbackModel.fromJson(doc.data()))
        .toList();
  }

  Future<void> addQuestion(QuestionModel question) {
    return _db
        .collection(FirebaseCollectionName.questions)
        .doc(question.id)
        .set(question.toJson());
  }

  Future<List<QuestionModel>> getQuestions() async {
    try {
      // Try to get the data from the server first
      final docSnapshot = await _db
          .collection(FirebaseCollectionName.questions)
          .get(getOptions);

      // If the server fetch is successful, return the data
      return docSnapshot.docs
          .map((doc) => QuestionModel.fromJson(doc.data()))
          .toList();
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable') {
        // If the server is unavailable, fall back to the cache
        final docSnapshot = await _db
            .collection(FirebaseCollectionName.questions)
            .get(getCahseOptions);

        return docSnapshot.docs
            .map((doc) => QuestionModel.fromJson(doc.data()))
            .toList();
      } else {
        rethrow;
      }
    }
  }

  Future<List<FundModel>> getFunds() async {
    try {
      // Try to get the data from the server first
      final docSnapshot =
          await _db.collection(FirebaseCollectionName.funds).get(getOptions);

      // If the server fetch is successful, return the data
      return docSnapshot.docs
          .map((doc) => FundModel.fromJson(doc.data()))
          .where((e) => e.image != null || Config.isDevelopment)
          .toList();
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable') {
        // If the server is unavailable, fall back to the cache
        final docSnapshot = await _db
            .collection(FirebaseCollectionName.funds)
            .get(getCahseOptions);

        return docSnapshot.docs
            .map((doc) => FundModel.fromJson(doc.data()))
            .toList();
      } else {
        rethrow;
      }
    }
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

  Stream<List<InformationModel>> getInformations() => _db
          .collection(FirebaseCollectionName.information)
          .snapshots(includeMetadataChanges: true) // Enable caching
          .map(
        (snapshot) {
          for (final change in snapshot.docChanges) {
            if (change.type == DocumentChangeType.added) {
              // ignore: unused_local_variable
              final source =
                  (snapshot.metadata.isFromCache) ? 'local cache' : 'server';
              // debugPrint('Data fetched from $source}');
            }
          }
          return snapshot.docs
              .map((doc) => InformationModel.fromJson(doc.data()))
              .toList();
        },
      );

  Future<InformationModel> getInformation(String id) async {
    final docSnapshot =
        await _db.collection(FirebaseCollectionName.information).doc(id).get();

    if (docSnapshot.exists) {
      return InformationModel.fromJson(docSnapshot.data()!);
    } else {
      throw FirebaseException(code: 'not-found', plugin: 'not-found');
    }
  }

  Future<void> addInformation(InformationModel information) {
    return _db
        .collection(FirebaseCollectionName.information)
        .doc(information.id)
        .set(information.toJson());
  }

  Future<void> setUserSetting({
    required UserSetting userSetting,
    required String userId,
  }) {
    return _db
        .collection(FirebaseCollectionName.userSettings)
        .doc(userId)
        .set(userSetting.copyWith(id: userId).toJson());
  }

  Stream<UserSetting> getUserSetting(String userId) => _db
          .collection(FirebaseCollectionName.userSettings)
          .doc(userId)
          .snapshots(includeMetadataChanges: true) // Enable caching
          .map(
        (snapshot) {
          if (snapshot.exists) {
            // ignore: unused_local_variable
            final source =
                (snapshot.metadata.isFromCache) ? 'local cache' : 'server';
            // debugPrint('Data fetched from $source}');
            return UserSetting.fromJson(snapshot.data()!);
          } else {
            return UserSetting.empty;
          }
        },
      );

  Future<void> deleteUserSetting(
    String userId,
  ) {
    return _db
        .collection(FirebaseCollectionName.userSettings)
        .doc(userId)
        .delete();
  }

  Stream<List<WorkModel>> getWorks() => _db
          .collection(FirebaseCollectionName.work)
          .snapshots(includeMetadataChanges: true) // Enable caching
          .map(
        (snapshot) {
          for (final change in snapshot.docChanges) {
            if (change.type == DocumentChangeType.added) {
              // ignore: unused_local_variable
              final source =
                  (snapshot.metadata.isFromCache) ? 'local cache' : 'server';
              // debugPrint('Data fetched from $source}');
            }
          }
          return snapshot.docs
              .map((doc) => WorkModel.fromJson(doc.data()))
              .toList();
        },
      );

  Future<void> addWork(WorkModel work) {
    return _db
        .collection(FirebaseCollectionName.work)
        .doc(work.id)
        .set(work.toJson());
  }

  Stream<List<StoryModel>> getStories() => _db
          .collection(FirebaseCollectionName.stroies)
          .snapshots(includeMetadataChanges: true) // Enable caching
          .map(
        (snapshot) {
          for (final change in snapshot.docChanges) {
            if (change.type == DocumentChangeType.added) {
              // ignore: unused_local_variable
              final source =
                  (snapshot.metadata.isFromCache) ? 'local cache' : 'server';
              // debugPrint('Data fetched from $source}');
            }
          }
          return snapshot.docs
              .map((doc) => StoryModel.fromJson(doc.data()))
              .toList();
        },
      );

  Future<void> addStory(StoryModel story) {
    return _db
        .collection(FirebaseCollectionName.stroies)
        .doc(story.id)
        .set(story.toJson());
  }

  Future<List<StoryModel>> getStoriesByUserId(String userId) async {
    final querySnapshot = await _db
        .collection(FirebaseCollectionName.stroies)
        .where(StoryModelJsonField.userId, isEqualTo: userId)
        .get();

    return querySnapshot.docs
        .map((doc) => StoryModel.fromJson(doc.data()))
        .toList();
  }

  Stream<List<DiscountModel>> getDiscounts() {
    return _db
        .collection(FirebaseCollectionName.discount)
        .snapshots(includeMetadataChanges: true) // Enable caching
        .map(
      (snapshot) {
        for (final change in snapshot.docChanges) {
          if (change.type == DocumentChangeType.added) {
            // ignore: unused_local_variable
            final source =
                (snapshot.metadata.isFromCache) ? 'local cache' : 'server';
            // debugPrint('Data fetched from $source');
          }
        }
        return snapshot.docs
            .map((doc) => DiscountModel.fromJson(doc.data()))
            .toList();
      },
    );
  }

  Future<DiscountModel> getDiscount(String id) async {
    final docSnapshot =
        await _db.collection(FirebaseCollectionName.discount).doc(id).get();

    if (docSnapshot.exists) {
      return DiscountModel.fromJson(docSnapshot.data()!);
    } else {
      throw FirebaseException(code: 'not-found', plugin: 'not-found');
    }
  }

  Future<void> addDiscount(DiscountModel discount) {
    return _db
        .collection(FirebaseCollectionName.discount)
        .doc(discount.id)
        .set(discount.toJson());
  }

  // Stream<List<TagModel>> getTags() => _db
  //         .collection(FirebaseCollectionName.tags)
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
  //             .map((doc) => TagModel.fromJson(doc.data()))
  //             .toList();
  //       },
  //     );

  // Future<void> addTags(TagModel tags) {
  //   return _db
  //       .collection(FirebaseCollectionName.tags)
  //       .doc(tags.id)
  //       .set(tags.toJson());
  // }

  Future<List<DiscountModel>> getDiscountsByUserId(String userId) async {
    final querySnapshot = await _db
        .collection(FirebaseCollectionName.discount)
        .where(DiscountModelJsonField.userId, isEqualTo: userId)
        .get();

    return querySnapshot.docs
        .map((doc) => DiscountModel.fromJson(doc.data()))
        .toList();
  }

  Future<void> deleteDiscountById(String discountId) {
    return _db
        .collection(FirebaseCollectionName.discount)
        .doc(discountId)
        .delete();
  }

  Future<void> addReport(ReportModel report) {
    return _db
        .collection(FirebaseCollectionName.report)
        .doc(report.id)
        .set(report.toJson());
  }

  Future<void> updateInformationModel(
    InformationModel informationModel,
  ) async {
    return _db
        .collection(FirebaseCollectionName.information)
        .doc(informationModel.id)
        .update(informationModel.toJson());
  }

  Future<List<ReportModel>> getCardReportByUserId({
    required CardEnum cardEnum,
    required String userId,
  }) async {
    final querySnapshot = await _db
        .collection(FirebaseCollectionName.report)
        .where(ReportModelJsonField.card, isEqualTo: cardEnum.getValue)
        .where(ReportModelJsonField.userId, isEqualTo: userId)
        .get();

    return querySnapshot.docs
        .map((doc) => ReportModel.fromJson(doc.data()))
        .toList();
  }

  Future<void> sendRespond(EmployeeRespondModel respondModel) => _db
      .collection(FirebaseCollectionName.respond)
      .doc(respondModel.id)
      .set(respondModel.toJson());
}
