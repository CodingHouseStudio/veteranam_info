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
    required ICompanyCacheRepository companyCacheRepository,
  })  : _appAuthenticationRepository = appAuthenticationRepository,
        _cache = cache,
        _firestoreService = firestoreService,
        _storageService = storageService,
        _companyCacheRepository = companyCacheRepository {
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
  final ICompanyCacheRepository _companyCacheRepository;

  late StreamController<CompanyModel> _userCompanyController;
  StreamSubscription<CompanyModel>? _userCompanySubscription;
  StreamSubscription<User>? _userSubscription;

  @visibleForTesting
  static const userCompanyCacheKey = '__user_company_cache_key__';

  void _onUserStreamListen() {
    tryGetCompanyFromCache();
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
          (currentUserCompanyValue) {
            _companyCacheRepository.saveToCache(
              company: currentUserCompanyValue,
              previousCompany: currentUserCompany,
            );
            _cache.write(
              key: userCompanyCacheKey,
              value: currentUserCompanyValue,
            );
            _userCompanyController.add(
              currentUserCompanyValue,
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

  void tryGetCompanyFromCache() {
    final cacheCompany = _companyCacheRepository.getFromCache;

    _cache.write(key: userCompanyCacheKey, value: cacheCompany);

    _userCompanyController.add(
      cacheCompany,
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

  @override
  Future<Either<SomeFailure, bool>> createUpdateCompany({
    required CompanyModel company,
    required FilePickerItem? imageItem,
  }) async {
    return eitherFutureHelper(
      () async {
        late var methodCompanyModel = company;
        if (!company.userEmails
                .contains(_appAuthenticationRepository.currentUser.email) &&
            (currentUserCompany.isNotAdmin ||
                currentUserCompany.id == company.id)) {
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
        if (currentUserCompany.isNotAdmin ||
            currentUserCompany.id == company.id) {
          _userCompanyController.add(methodCompanyModel);
        }
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
          _companyCacheRepository.cleanCache();

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
