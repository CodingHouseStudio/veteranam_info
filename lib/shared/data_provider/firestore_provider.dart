import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

enum MobMode {
  online,
  offline;

  bool get isOffline => this == MobMode.offline;
  MobMode get switchMode => isOffline ? MobMode.online : MobMode.offline;
}

/// COMMENT: Class to get, update, delete or set values in firebase
@Singleton(order: -1)
class FirestoreService {
  FirestoreService(
    // this.appNetworkRepository,
    this._cache,
  ) {
    // Initialization logic can't use await directly in constructor
    _initFirestoreSettings();
  }
  // final IAppNetworkRepository appNetworkRepository;
  // final IAppNetworkRepository appNetworkRepository = AppNetworkRepository(
  //   Connectivity(),
  //   CacheClient(),
  // );
  final FirebaseFirestore _db = firebaseFirestore;
  final CacheClient _cache;
  late var _offlineMode = MobMode.offline;

  MobMode get offlineMode =>
      _cache.read<MobMode>(key: offlineModeCacheKey) ?? _offlineMode;

  @visibleForTesting
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @visibleForTesting
  static const getOptions = GetOptions();
  @visibleForTesting
  static const getCacheOptions = GetOptions(source: Source.cache);
  @visibleForTesting
  static final setMergeOptions = SetOptions(merge: true);
  @visibleForTesting
  static const offlineModeCacheKey = '__offline_mode_cache_key__';

  void _initFirestoreSettings() {
    // Set settings for persistence based on platform
    if (Config.isWeb) {
      _db.settings = const Settings(
        persistenceEnabled: true,
      );
    } else {
      _offlineMode = offlineMode;
      _db.settings = Settings(
        persistenceEnabled: _offlineMode.isOffline,
      );
    }
    // await appNetworkRepository.updateCacheConnectivityResults();
  }

  MobMode get switchOfflineMode {
    _offlineMode = _offlineMode.switchMode;
    // Set settings for persistence based on platform
    _db.settings = Settings(
      persistenceEnabled: _offlineMode.isOffline,
    );
    _cache.write(key: offlineModeCacheKey, value: _offlineMode);
    return _offlineMode;
    // await appNetworkRepository.updateCacheConnectivityResults();
  }

  Future<void> addFeedback(FeedbackModel feedback) {
    return _db
        .collection(FirebaseCollectionName.feedback)
        .doc(feedback.id)
        .set(feedback.toJson());
  }

  Future<void> addMobFeedback(FeedbackModel feedback) {
    return _db
        .collection(FirebaseCollectionName.mobFeedback)
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
      if (e.code == 'unavailable' && offlineMode.isOffline) {
        // If the server is unavailable, fall back to the cache
        final docSnapshot = await _db
            .collection(FirebaseCollectionName.questions)
            .get(getCacheOptions);

        return docSnapshot.docs
            .map((doc) => QuestionModel.fromJson(doc.data()))
            .toList();
      } else {
        rethrow;
      }
    }
  }

  Future<List<FundModel>> getFunds(
      // List<String>? reportIdItems,
      ) async {
    try {
      // Try to get the data from the server first
      late QuerySnapshot<Map<String, dynamic>> docSnapshot;
      if (Config.isDevelopment) {
        docSnapshot = await _db
            .collection(FirebaseCollectionName.funds)
            // .where(DiscountModelJsonField.id, whereNotIn: reportIdItems?
            // .toSet())
            .get(getOptions);
      } else {
        docSnapshot = await _db
            .collection(FirebaseCollectionName.funds)
            .where(FundModelJsonField.image, isNotEqualTo: null)
            .where(FundModelJsonField.image, isNotEqualTo: [])
            // .where(DiscountModelJsonField.id, whereNotIn: reportIdItems?
            // .toSet())
            .get(getOptions);
      }

      // If the server fetch is successful, return the data
      return docSnapshot.docs
          .map((doc) => FundModel.fromJson(doc.data()))
          // .where((e) => e.image != null || !Config.isProduction)
          .toList();
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable' && offlineMode.isOffline) {
        // If the server is unavailable, fall back to the cache
        final docSnapshot = await _db
            .collection(FirebaseCollectionName.funds)
            .get(getCacheOptions);

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

  // Future<void> updateUserSetting(UserSetting userSetting) {
  //   return _db
  //       .collection(FirebaseCollectionName.userSettings)
  //       .doc(userSetting.id)
  //       .update(userSetting.toJson());
  // }

  Stream<List<InformationModel>> getInformations(List<String>? reportIdItems) =>
      _db
          .collection(FirebaseCollectionName.information)
          // .where(DiscountModelJsonField.id, whereNotIn: reportIdItems?.
          // toSet())
          .snapshots(
            includeMetadataChanges: offlineMode.isOffline,
          ) // Enable caching
          .map(
        (snapshot) {
          late var isFromCache = false;
          for (final change in snapshot.docChanges) {
            if (change.type == DocumentChangeType.added) {
              isFromCache = snapshot.metadata.isFromCache;
              // ignore: unused_local_variable
              // final source = (snapshot.metadata.isFromCache)
              //     ? KAppText.cache
              //     : KAppText.server;
              // debugPrint('Data fetched from $source}');
            }
          }
          return _tryCatchForCache(
            isFromCache: isFromCache,
            event: () => snapshot.docs
                .map((doc) => InformationModel.fromJson(doc.data()))
                .toList(),
          );
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
    return _db.collection(FirebaseCollectionName.userSettings).doc(userId).set(
          userSetting.copyWith(id: userId).toJson(),
          setMergeOptions,
        );
  }

  Stream<UserSetting> getUserSetting(String userId) => _db
          .collection(FirebaseCollectionName.userSettings)
          .doc(userId)
          .snapshots(
            includeMetadataChanges: offlineMode.isOffline,
          ) // Enable caching
          .map(
        (snapshot) {
          if (snapshot.exists) {
            // ignore: unused_local_variable
            final source = (snapshot.metadata.isFromCache)
                ? KAppText.cache
                : KAppText.server;
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
          .snapshots(
            includeMetadataChanges: offlineMode.isOffline,
          ) // Enable caching
          .map(
        (snapshot) {
          late var isFromCache = false;
          for (final change in snapshot.docChanges) {
            if (change.type == DocumentChangeType.added) {
              isFromCache = snapshot.metadata.isFromCache;
              // ignore: unused_local_variable
              // final source = (snapshot.metadata.isFromCache)
              //     ? KAppText.cache
              //     : KAppText.server;
              // debugPrint('Data fetched from $source}');
            }
          }
          return _tryCatchForCache<WorkModel>(
            event: () => snapshot.docs
                .map((doc) => WorkModel.fromJson(doc.data()))
                .toList(),
            isFromCache: isFromCache,
          );
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
          .snapshots(
            includeMetadataChanges: offlineMode.isOffline,
          ) // Enable caching
          .map(
        (snapshot) {
          late var isFromCache = false;
          for (final change in snapshot.docChanges) {
            if (change.type == DocumentChangeType.added) {
              isFromCache = snapshot.metadata.isFromCache;
              // ignore: unused_local_variable
              // final source = (snapshot.metadata.isFromCache)
              //     ? KAppText.cache
              //     : KAppText.server;
              // debugPrint('Data fetched from $source}');
            }
          }
          return _tryCatchForCache(
            isFromCache: isFromCache,
            event: () => snapshot.docs
                .map((doc) => StoryModel.fromJson(doc.data()))
                .toList(),
          );
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

  Stream<List<DiscountModel>> getDiscounts(
      // List<String>? reportIdItems,
      ) {
    var query = _db
        .collection(FirebaseCollectionName.discount)
        .orderBy(DiscountModelJsonField.dateVerified, descending: true);
    if (Config.isProduction) {
      query = query.where(
        DiscountModelJsonField.status,
        isEqualTo: DiscountState.published.enumString,
      );
    }

    // .where(DiscountModelJsonField.id, whereNotIn: reportIdItems?.toSet
    //())

    return query
        .snapshots(
      includeMetadataChanges: offlineMode.isOffline,
    ) // Enable caching
        .map(
      (snapshot) {
        late var isFromCache = false;
        for (final change in snapshot.docChanges) {
          if (change.type == DocumentChangeType.added) {
            isFromCache = snapshot.metadata.isFromCache;

            // ignore: unused_local_variable
            // final source = (snapshot.metadata.isFromCache)
            //     ? KAppText.cache
            //     : KAppText.server;
            // debugPrint('Data fetched from $source');
          }
        }

        return _tryCatchForCache<DiscountModel>(
          event: () => snapshot.docs
              .map((doc) => DiscountModel.fromJson(doc.data()))
              .toList(),
          isFromCache: isFromCache,
        );
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

  Future<void> sendLink(
    LinkModel discountLink,
  ) async =>
      _db
          .collection(FirebaseCollectionName.discountLink)
          .doc(discountLink.id)
          .set(discountLink.toJson());

  Future<void> sendEmail(
    EmailModel userEmail,
  ) async =>
      _db
          .collection(FirebaseCollectionName.discountUserEmail)
          .doc(userEmail.id)
          .set(userEmail.toJson());

  Future<List<LinkModel>> getUserDiscountsLink(
    String userId,
  ) async {
    final querySnapshot = await _db
        .collection(FirebaseCollectionName.discountLink)
        .where(LinkModelJsonField.userId, isEqualTo: userId)
        .get();

    return querySnapshot.docs
        .map((doc) => LinkModel.fromJson(doc.data()))
        .toList();
  }

  Future<List<EmailModel>> getUserDiscountsEmail(
    String userId,
  ) async {
    final querySnapshot = await _db
        .collection(FirebaseCollectionName.discountUserEmail)
        .where(EmailModelJsonField.userId, isEqualTo: userId)
        .get();

    return querySnapshot.docs
        .map((doc) => EmailModel.fromJson(doc.data()))
        .toList();
  }

  Future<void> addDiscount(DiscountModel discount) {
    return _db
        .collection(FirebaseCollectionName.discount)
        .doc(discount.id)
        .set(discount.toJson());
  }

  // Stream<List<TagModel>> getTags() => _db
  //         .collection(FirebaseCollectionName.tags)
  //         .snapshots(includeMetadataChanges: offlineMode.isOffline) // Enable caching
  //         .map(
  //       (snapshot) {
  //         for (final change in snapshot.docChanges) {
  //           if (change.type == DocumentChangeType.added) {
  //             final source =
  //                 (snapshot.metadata.isFromCache) ? KAppText.cache :
  // KAppText.server;
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
    try {
      // If cache is not successful or not used, try to get data from server
      final querySnapshot = await _db
          .collection(FirebaseCollectionName.report)
          .where(ReportModelJsonField.card, isEqualTo: cardEnum.getValue)
          .where(ReportModelJsonField.userId, isEqualTo: userId)
          .get(getOptions);

      return querySnapshot.docs
          .map((doc) => ReportModel.fromJson(doc.data()))
          .toList();
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable' && offlineMode.isOffline) {
        // If the server is unavailable and cache has not been tried, attempt
        // to get data from cache
        final cacheSnapshot = await _db
            .collection(FirebaseCollectionName.report)
            .where(ReportModelJsonField.card, isEqualTo: cardEnum.getValue)
            .where(ReportModelJsonField.userId, isEqualTo: userId)
            .get(getCacheOptions);

        return cacheSnapshot.docs
            .map((doc) => ReportModel.fromJson(doc.data()))
            .toList();
      } else {
        rethrow;
      }
    }
  }

  Future<void> sendRespond(EmployeeRespondModel respondModel) => _db
      .collection(FirebaseCollectionName.respond)
      .doc(respondModel.id)
      .set(respondModel.toJson());

  List<T> _tryCatchForCache<T>({
    required bool isFromCache,
    required List<T> Function() event,
  }) {
    if (isFromCache
        // &&
        //     appNetworkRepository.currentConnectivityResults.hasNetwork
        ) {
      try {
        return event();
      } catch (e) {
        return [];
      }
    } else {
      return event();
    }
  }

  Future<List<CityModel>> getCities() async {
    try {
      // Try to get the data from the server first
      final docSnapshot = await _db
          .collection(FirebaseCollectionName.cities)
          .where('type', isEqualTo: 'CITY')
          //TODO: CAPITAP CITY
          .get(getOptions);

      // If the server fetch is successful, return the data
      return docSnapshot.docs
          .map((doc) => CityModel.fromJson(doc.data()))
          .toList();
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable' && offlineMode.isOffline) {
        // If the server is unavailable, fall back to the cache
        final docSnapshot = await _db
            .collection(FirebaseCollectionName.questions)
            .get(getCacheOptions);

        return docSnapshot.docs
            .map((doc) => CityModel.fromJson(doc.data()))
            .toList();
      } else {
        rethrow;
      }
    }
  }
}
