import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart' show FirebaseException;
import 'package:freezed_annotation/freezed_annotation.dart'
    show visibleForTesting;
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

@Singleton(
  as: ICompanyRepository,
  env: [Config.business],
  // signalsReady: true,
)
class CompanyRepository implements ICompanyRepository {
  CompanyRepository(
    this._iAppAuthenticationRepository,
    this._cache,
  ) {
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

  final IAppAuthenticationRepository _iAppAuthenticationRepository;
  late StreamController<CompanyModel> _userCompanyController;
  StreamSubscription<CompanyModel>? _userCompanySubscription;
  StreamSubscription<User>? _userSubscription;
  final CacheClient _cache;
  final FirestoreService _firestoreService = GetIt.I.get<FirestoreService>();
  final StorageService _storageService = GetIt.I.get<StorageService>();

  @visibleForTesting
  static const userCompanyCacheKey = '__user_company_cache_key__';

  void _onUserStreamListen() {
    _userSubscription ??=
        _iAppAuthenticationRepository.user.listen((currentUser) {
      if (currentUser.isNotEmpty &&
          !_iAppAuthenticationRepository.isAnonymously) {
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

  @override
  Future<Either<SomeFailure, bool>> updateCompany({
    required CompanyModel company,
    required FilePickerItem? imageItem,
  }) async {
    try {
      late var methodCompanyModel = company;
      if (!company.userEmails
          .contains(_iAppAuthenticationRepository.currentUser.email)) {
        methodCompanyModel = methodCompanyModel.copyWith(
          userEmails: List.from(methodCompanyModel.userEmails)
            ..add(_iAppAuthenticationRepository.currentUser.email!),
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
          // unawaited(_storageService.removeFile(company.image?.downloadURL));
          methodCompanyModel = methodCompanyModel.copyWith(
            image: imageItem.image(downloadURL),
          );
        }
      }
      await _firestoreService.updateCompany(methodCompanyModel);
      _userCompanyController.add(methodCompanyModel);
      return const Right(true);
    } on FirebaseException catch (e, stack) {
      return Left(GetFailur.fromCode(error: e, stack: stack).status);
    } catch (e, stack) {
      return Left(
        SomeFailure.serverError(
          error: e,
          stack: stack,
          tag: 'Company(updateCompany)',
          tagKey: ErrorText.repositoryKey,
        ),
      );
    }
  }

  @override
  Future<Either<SomeFailure, bool>> deleteCompany() async {
    try {
      if (currentUserCompany.id.isNotEmpty) {
        await _firestoreService.deleteCompany(currentUserCompany.id);
        _userCompanyController.add(CompanyModel.empty);
        await _iAppAuthenticationRepository.logOut();
      }
      // if (iAppAuthenticationRepository.currentUser.isNotEmpty) {
      //   await iAppAuthenticationRepository.deleteUser();
      // }

      return const Right(true);
    } on FirebaseException catch (e, stack) {
      return Left(GetFailur.fromCode(error: e, stack: stack).status);
    } catch (e, stack) {
      return Left(
        SomeFailure.serverError(
          error: e,
          stack: stack,
          tag: 'Company(deleteCompany)',
          tagKey: ErrorText.repositoryKey,
        ),
      );
    }
  }

  // @disposeMethod
  @override
  void dispose() {
    _userSubscription?.cancel();
    _userCompanySubscription?.cancel();

    _userCompanyController.close();
  }
}
