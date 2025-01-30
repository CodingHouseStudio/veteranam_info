import 'dart:async';

import 'package:dartz/dartz.dart';
// import 'package:firebase_storage/firebase_storage.dart' show FirebaseException;
import 'package:freezed_annotation/freezed_annotation.dart'
    show visibleForTesting;
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

@Singleton(
  as: ICompanyRepository,
  env: [Config.business],
  // signalsReady: true,
)
class CompanyRepository implements ICompanyRepository {
  CompanyRepository({
    required IAppAuthenticationRepository appAuthenticationRepository,
    required CacheClient cache,
    required FirestoreService firestoreService,
    required StorageService storageService,
    required ISharedPrefencesRepository sharedPrefencesRepository,
  })  : _appAuthenticationRepository = appAuthenticationRepository,
        _cache = cache,
        _firestoreService = firestoreService,
        _storageService = storageService,
        _sharedPrefencesRepository = sharedPrefencesRepository {
    // Listen to currentUser changes and emit auth status
    // _authenticationStatuscontroller =
    //     StreamController<AuthenticationStatus>.broadcast(
    //   onListen: _onUserStreamListen,
    //   onCancel: _onUserStreamCancel,
    // );
    _userCompanyController = StreamController<CompanyModel>.broadcast(
      onListen: _onUserStreamListen,
      onCancel: _onUserStreamCancel,
    );
  }

  final IAppAuthenticationRepository _appAuthenticationRepository;
  final CacheClient _cache;
  final FirestoreService _firestoreService;
  final StorageService _storageService;
  final ISharedPrefencesRepository _sharedPrefencesRepository;

  late StreamController<CompanyModel> _userCompanyController;
  StreamSubscription<CompanyModel>? _userCompanySubscription;
  StreamSubscription<User>? _userSubscription;

  static const companySharedPreferencesId = 'compnay_shared_preferences_id';

  @visibleForTesting
  static const userCompanyCacheKey = '__user_company_cache_key__';
  @visibleForTesting
  static const userCompanyUserEmailsCacheKey =
      '__user_company_user_emails_cache_key__';
  @visibleForTesting
  static const userCompanyNameCacheKey = '__user_company_name_cache_key__';
  @visibleForTesting
  static const userCompanyPublicNameCacheKey =
      '__user_company_public_name_cache_key__';
  @visibleForTesting
  static const userCompanyCodeCacheKey = '__user_company_code_cache_key__';
  @visibleForTesting
  static const userCompanyLinkCacheKey = '__user_company_link_cache_key__';

  void _onUserStreamListen() {
    _userSubscription ??=
        _appAuthenticationRepository.user.listen((currentUser) {
      if (currentUser.isNotEmpty &&
          !_appAuthenticationRepository.isAnonymously) {
        if (!currentUserCompany.userEmails.contains(currentUser.email) &&
            _userCompanySubscription != null) {
          _userCompanySubscription?.cancel();
          _userCompanySubscription = null;
        }
        _userCompanySubscription ??=
            _firestoreService.getUserCompany(currentUser.email!).listen(
          (currentUserCompany) {
            _cache.write(key: userCompanyCacheKey, value: currentUserCompany);
            _userCompanyController.add(
              currentUserCompany,
            );
            _removeDeleteParameter();
          },
        );

        return;
      }
      if (_userCompanySubscription != null) {
        _userCompanySubscription?.cancel();
        _userCompanySubscription = null;
      }
    });
  }

  Future<void> getUserLanguageFromCash() async {
    await _sharedPrefencesRepository.initWait();
    final userEmails =
        _sharedPrefencesRepository.getStringList(userCompanyUserEmailsCacheKey);
    final companyName =
        _sharedPrefencesRepository.getString(userCompanyNameCacheKey);
    final publicName =
        _sharedPrefencesRepository.getString(userCompanyPublicNameCacheKey);
    final code = _sharedPrefencesRepository.getString(userCompanyCodeCacheKey);
    final link = _sharedPrefencesRepository.getString(userCompanyLinkCacheKey);

    _userCompanyController.add(
      currentUserCompany.copyWith(
        id: currentUserCompany.id.isEmpty
            ? companySharedPreferencesId
            : currentUserCompany.id,
        userEmails: userEmails ?? currentUserCompany.userEmails,
        companyName: companyName ?? currentUserCompany.companyName,
        publicName: publicName ?? currentUserCompany.publicName,
        code: code ?? currentUserCompany.code,
        link: link ?? currentUserCompany.link,
      ),
    );
  }

  void _onUserStreamCancel() {
    _userSubscription?.cancel();
    _userCompanySubscription?.cancel();
    _userCompanySubscription = null;
    _userSubscription = null;
  }

  @override
  Stream<CompanyModel> get company => _userCompanyController.stream;

  @override
  CompanyModel get currentUserCompany =>
      _cache.read<CompanyModel>(key: userCompanyCacheKey) ?? CompanyModel.empty;
  // Stream<UserSetting> get userSetting => _userCompanyController.stream;

  // /// Stream of [User] which will emit the current user when
  // /// the authentication state changes.
  // ///
  // /// Emits [User.empty] if the user is not authenticated.
  // Stream<User> get user {
  //   return firebaseAuth.authStateChanges().map((firebaseUser) {
  //     final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
  //     cache.write(key: userCacheKey, value: user);
  //     return user;
  //   });
  // }

  // User get currentUser {
  //   return iAppAuthenticationRepository.currentUser;
  // }

  void _removeDeleteParameter() {
    if (currentUserCompany.deletedOn != null) {
      _firestoreService.updateCompany(
        currentUserCompany.copyWith(deletedOn: null),
      );
    }
  }

  void _saveCompanyDataToCache(CompanyModel company) {
    if (company.userEmails != currentUserCompany.userEmails) {
      _sharedPrefencesRepository.setStringList(
        key: userCompanyUserEmailsCacheKey,
        value: company.userEmails,
      );
    }
    if (company.companyName != null &&
        company.companyName != currentUserCompany.companyName) {
      _sharedPrefencesRepository.setString(
        key: userCompanyNameCacheKey,
        value: company.companyName!,
      );
    }
    if (company.code != null && company.code != currentUserCompany.code) {
      _sharedPrefencesRepository.setString(
        key: userCompanyCodeCacheKey,
        value: company.code!,
      );
    }
    if (company.publicName != null &&
        company.publicName != currentUserCompany.publicName) {
      _sharedPrefencesRepository.setString(
        key: userCompanyPublicNameCacheKey,
        value: company.publicName!,
      );
    }
    if (company.link != null && company.link != currentUserCompany.link) {
      _sharedPrefencesRepository.setString(
        key: userCompanyLinkCacheKey,
        value: company.link!,
      );
    }
  }

  @override
  Future<Either<SomeFailure, bool>> updateCompany({
    required CompanyModel company,
    required FilePickerItem? imageItem,
  }) async {
    _saveCompanyDataToCache(company);
    return eitherFutureHelper(
      () async {
        late var methodCompanyModel = company;
        if (!company.userEmails
            .contains(_appAuthenticationRepository.currentUser.email)) {
          methodCompanyModel = methodCompanyModel.copyWith(
            userEmails: List.from(methodCompanyModel.userEmails)
              ..add(_appAuthenticationRepository.currentUser.email!),
          );
        }
        if (imageItem != null) {
          final downloadURL = await _storageService.saveFile(
            filePickerItem: imageItem,
            id: company.id,
            collecltionName: FirebaseCollectionName.companies,
          );
          if (downloadURL != null && downloadURL.isNotEmpty) {
            // We will now have a problem if we delete the company's photo
            // because we don't change it at the same time on discounts.
            // unawaited(_storageService.removeFile(company.image?.
            // downloadURL));
            methodCompanyModel = methodCompanyModel.copyWith(
              image: imageItem.image(downloadURL),
            );
          }
        }
        await _firestoreService.updateCompany(methodCompanyModel);
        _userCompanyController.add(methodCompanyModel);
        return const Right(true);
      },
      methodName: 'Company(updateCompany)',
      className: ErrorText.repositoryKey,
      user: User(
        id: currentUserCompany.id,
        name: currentUserCompany.companyName,
        email: _appAuthenticationRepository.currentUser.email,
      ),
      userSetting: _appAuthenticationRepository.currentUserSetting,
      data: 'Compnay: $company| ${imageItem.getErrorData}',
    );
  }

  @override
  Future<Either<SomeFailure, bool>> deleteCompany() async {
    return eitherFutureHelper(
      () async {
        if (currentUserCompany.id.isNotEmpty) {
          /// every thirty days, all documents where KAppText.deletedFieldId
          /// older than 30 days will be deleted automatically
          /// (firebase function)
          await _firestoreService.updateCompany(
            currentUserCompany.copyWith(deletedOn: ExtendedDateTime.current),
          );
          _userCompanyController.add(CompanyModel.empty);
          await _appAuthenticationRepository.logOut();
        }
        // if (iAppAuthenticationRepository.currentUser.isNotEmpty) {
        //   await iAppAuthenticationRepository.deleteUser();
        // }

        return const Right(true);
      },
      methodName: 'Company(deleteCompany)',
      className: ErrorText.repositoryKey,
      user: User(
        id: currentUserCompany.id,
        name: currentUserCompany.companyName,
        email: _appAuthenticationRepository.currentUser.email,
      ),
      userSetting: _appAuthenticationRepository.currentUserSetting,
    );
  }

  // @disposeMethod
  @override
  void dispose() {
    _userSubscription?.cancel();
    _userCompanySubscription?.cancel();

    _userCompanyController.close();
  }
}
