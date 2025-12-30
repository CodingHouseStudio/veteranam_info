import 'dart:developer' show log;

import 'package:cloud_firestore/cloud_firestore.dart'
    show
        DocumentChangeType,
        FirebaseException,
        FirebaseFirestore,
        GetOptions,
        QuerySnapshot,
        SetOptions,
        Settings,
        Source;
import 'package:freezed_annotation/freezed_annotation.dart'
    show visibleForTesting;
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';
// import 'package:flutter/widgets.dart';

/// COMMENT: Class to get, update, delete or set values in firebase
@Singleton(order: -1)
class FirestoreService {
  FirestoreService({
    required FirebaseFirestore firebaseFirestore,
    required CacheClient cache,
  })  : _db = firebaseFirestore,
        _cache = cache {
    // Initialization logic can't use await directly in constructor
    _initFirestoreSettings();
  }
  final FirebaseFirestore _db;
  final CacheClient _cache;
  var _offlineMode = MobMode.offline;

  MobMode get offlineMode =>
      _cache.read<MobMode>(key: offlineModeCacheKey) ?? _offlineMode;

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
    final items = snapshot.docs;
    return List.generate(
      items.length,
      (index) => FeedbackModel.fromJson(items.elementAt(index).data()),
      growable: false,
    );
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
      final items = docSnapshot.docs;
      return List.generate(
        items.length,
        (index) => QuestionModel.fromJson(items.elementAt(index).data()),
        growable: false,
      );
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable' && offlineMode.isOffline) {
        // If the server is unavailable, fall back to the cache
        final docSnapshot = await _db
            .collection(FirebaseCollectionName.questions)
            .get(getCacheOptions);

        final items = docSnapshot.docs;
        return List.generate(
          items.length,
          (index) => QuestionModel.fromJson(
            items.elementAt(index).data(),
          ),
          growable: false,
        );
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

      final items = docSnapshot.docs;
      // If the server fetch is successful, return the data
      return List.generate(
        items.length,
        (index) => FundModel.fromJson(items.elementAt(index).data()),
        growable: false,
      );
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable' && offlineMode.isOffline) {
        // If the server is unavailable, fall back to the cache
        final docSnapshot = await _db
            .collection(FirebaseCollectionName.funds)
            .get(getCacheOptions);

        final items = docSnapshot.docs;
        return List.generate(
          items.length,
          (index) => FundModel.fromJson(items.elementAt(index).data()),
          growable: false,
        );
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
              log('Data fetched from ${isFromCache._source}}');
            }
          }
          return _tryCatchForCache(
            isFromCache: isFromCache,
            event: () {
              final items = snapshot.docs;
              return List.generate(
                items.length,
                (index) => InformationModel.fromJson(
                  items.elementAt(index).data(),
                ),
                growable: false,
              );
            },
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
    final userSettingJson = userSetting.toJson();
    userSettingJson[UserSettingModelJsonField.id] = userId;
    return _db.collection(FirebaseCollectionName.userSettings).doc(userId).set(
          userSettingJson,
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
            final source = snapshot.metadata.isFromCache._source;
            log('Data fetched from $source');
            return UserSetting.fromJson(snapshot.data()!);
          } else {
            return UserSetting.empty;
          }
        },
      );

  Stream<CompanyModel> getUserCompany(String email) => _db
          .collection(FirebaseCollectionName.companies)
          .where(CompanyModelJsonField.userEmails, arrayContains: email)
          .snapshots(
            includeMetadataChanges: offlineMode.isOffline,
          ) // Enable caching
          .map(
        (snapshot) {
          if (snapshot.docs.isNotEmpty) {
            // final source = snapshot.metadata.isFromCache._source;
            final data = snapshot.docs.first.data();

            // Convert Firestore Timestamps to ISO8601 strings for DateTime fields
            final convertedData = _convertTimestampsToStrings(data);

            return CompanyModel.fromJson(convertedData);
          } else {
            return CompanyModel.empty;
          }
        },
      );

  Map<String, dynamic> _convertTimestampsToStrings(Map<String, dynamic> data) {
    final converted = Map<String, dynamic>.from(data);

    // List of DateTime fields in CompanyModel
    const dateTimeFields = [
      'deletedOn',
      'trialStartedAt',
      'trialExpiresAt',
      'subscriptionStartedAt',
      'subscriptionExpiresAt',
      'termsAcceptedAt',
      'canceledAt',
    ];

    for (final field in dateTimeFields) {
      final value = converted[field];
      if (value != null && value is! String) {
        try {
          final timestamp = value as dynamic;
          converted[field] = (timestamp.toDate() as DateTime).toIso8601String();
        } catch (e) {
          log('Error converting timestamp field $field: $e');
        }
      }
    }

    return converted;
  }

  Future<void> updateCompany(CompanyModel company) {
    return _db.collection(FirebaseCollectionName.companies).doc(company.id).set(
          company.toJson(),
          setMergeOptions,
        );
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
              log('Data fetched from ${isFromCache._source}}');
            }
          }
          return _tryCatchForCache<WorkModel>(
            event: () {
              final items = snapshot.docs;
              return List.generate(
                items.length,
                (index) => WorkModel.fromJson(items.elementAt(index).data()),
                growable: false,
              );
            },
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
              log('Data fetched from ${isFromCache._source}}');
            }
          }
          return _tryCatchForCache(
            isFromCache: isFromCache,
            event: () {
              final items = snapshot.docs;
              return List.generate(
                items.length,
                (index) => StoryModel.fromJson(items.elementAt(index).data()),
                growable: false,
              );
            },
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

    final items = querySnapshot.docs;
    return List.generate(
      items.length,
      (index) => StoryModel.fromJson(items.elementAt(index).data()),
      growable: false,
    );
  }

  Stream<List<DiscountModel>> getDiscounts(
      // List<String>? reportIdItems,
      {
    required bool showOnlyBusinessDiscounts,
    String? userId,
  }) {
    var query = _db
        .collection(FirebaseCollectionName.discount)
        .orderBy(DiscountModelJsonField.dateVerified, descending: true);
    if (userId != null) {
      if (KAppText.adminCompanyID != userId) {
        query = query.where(
          DiscountModelJsonField.userId,
          isEqualTo: userId,
        );
      }
    } else if (Config.isProduction) {
      query = query.where(
        DiscountModelJsonField.status,
        isEqualTo: DiscountState.published.enumString,
      );
    }

    if (!Config.isWeb && showOnlyBusinessDiscounts) {
      query = query.where(
        DiscountModelJsonField.isVerified,
        isEqualTo: true,
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

            log('Data fetched from ${isFromCache._source}}');
          }
        }

        return _tryCatchForCache<DiscountModel>(
          event: () {
            final items = snapshot.docs;
            return List.generate(
              items.length,
              (index) => DiscountModel.fromJson(items.elementAt(index).data()),
              growable: false,
            );
          },
          isFromCache: isFromCache,
        );
      },
    );
  }

  Future<DiscountModel> getDiscount({
    required String id,
    required bool showOnlyBusinessDiscounts,
    String? companyId,
  }) async {
    final docSnapshot =
        await _db.collection(FirebaseCollectionName.discount).doc(id).get();

    if (docSnapshot.exists) {
      final discount = docSnapshot.data();
      if (discount != null &&
          (Config.isDevelopment ||
              Config.isBusiness ||
              discount[DiscountModelJsonField.status] ==
                  DiscountState.published.enumString)) {
        if (companyId == null ||
            discount[DiscountModelJsonField.userId] == companyId ||
            companyId == '1') {
          if (!showOnlyBusinessDiscounts ||
              Config.isWeb ||
              discount[DiscountModelJsonField.isVerified] == true) {
            return DiscountModel.fromJson(discount);
          }
        }
      }
    }
    throw FirebaseException(code: 'not-found', plugin: 'not-found');
  }

  Future<bool> companyHasDiscounts(
    String companyId,
  ) async {
    final docSnapshot = await _db
        .collection(FirebaseCollectionName.discount)
        .where(DiscountModelJsonField.userId, isEqualTo: companyId)
        .get();

    return docSnapshot.docs.isNotEmpty;
  }

  Future<void> updateDiscountModel(
    DiscountModel discountModel,
  ) async {
    return _db
        .collection(FirebaseCollectionName.discount)
        .doc(discountModel.id)
        .update(discountModel.toJson());
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

    final items = querySnapshot.docs;
    return List.generate(
      items.length,
      (index) => LinkModel.fromJson(items.elementAt(index).data()),
      growable: false,
    );
  }

  Future<List<EmailModel>> getUserDiscountsEmail(
    String userId,
  ) async {
    final querySnapshot = await _db
        .collection(FirebaseCollectionName.discountUserEmail)
        .where(EmailModelJsonField.userId, isEqualTo: userId)
        .get();

    final items = querySnapshot.docs;
    return List.generate(
      items.length,
      (index) => EmailModel.fromJson(items.elementAt(index).data()),
      growable: false,
    );
  }

  Future<void> addDiscount(DiscountModel discount) {
    return _db
        .collection(FirebaseCollectionName.discount)
        .doc(discount.id)
        .set(discount.toJson());
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

      final items = querySnapshot.docs;
      return List.generate(
        items.length,
        (index) => ReportModel.fromJson(items.elementAt(index).data()),
        growable: false,
      );
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable' && offlineMode.isOffline) {
        // If the server is unavailable and cache has not been tried, attempt
        // to get data from cache
        final cacheSnapshot = await _db
            .collection(FirebaseCollectionName.report)
            .where(ReportModelJsonField.card, isEqualTo: cardEnum.getValue)
            .where(ReportModelJsonField.userId, isEqualTo: userId)
            .get(getCacheOptions);

        final items = cacheSnapshot.docs;
        return List.generate(
          items.length,
          (index) => ReportModel.fromJson(
            items.elementAt(index).data(),
          ),
          growable: false,
        );
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
          .get(getOptions);

      final items = docSnapshot.docs;
      // If the server fetch is successful, return the data
      return List.generate(
        items.length,
        (index) => CityModel.fromJson(items.elementAt(index).data()),
        growable: false,
      );
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable' && offlineMode.isOffline) {
        // If the server is unavailable, fall back to the cache
        final docSnapshot = await _db
            .collection(FirebaseCollectionName.questions)
            .get(getCacheOptions);

        final items = docSnapshot.docs;
        return List.generate(
          items.length,
          (index) => CityModel.fromJson(items.elementAt(index).data()),
          growable: false,
        );
      } else {
        rethrow;
      }
    }
  }
}

extension _SourceExtension on bool {
  String get _source => this ? KAppText.cache : KAppText.server;
}
