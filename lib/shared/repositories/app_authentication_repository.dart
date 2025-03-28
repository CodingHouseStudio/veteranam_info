import 'dart:async';
import 'dart:developer' show log;

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
// import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart'
    show visibleForTesting;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:veteranam/shared/shared_dart.dart';

@Singleton(as: IAppAuthenticationRepository)
class AppAuthenticationRepository implements IAppAuthenticationRepository {
  AppAuthenticationRepository({
    // super.dioClient,
    required IStorage secureStorageRepository,
    required firebase_auth.FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
    required CacheClient cache,
    required FacebookAuth facebookSignIn,
    required FirestoreService firestoreService,
    required IDeviceRepository deviceRepository,
    required StorageService storageService,
    required firebase_auth.GoogleAuthProvider googleAuthProvider,
    required firebase_auth.FacebookAuthProvider facebookAuthProvider,
    required firebase_auth.AppleAuthProvider appleAuthProvider,
  })  : _secureStorageRepository = secureStorageRepository,
        _firebaseAuth = firebaseAuth,
        _googleSignIn = googleSignIn,
        _facebookSignIn = facebookSignIn,
        _cache = cache,
        _firestoreService = firestoreService,
        _deviceRepository = deviceRepository,
        _storageService = storageService,
        _googleAuthProvider = googleAuthProvider,
        _facebookAuthProvider = facebookAuthProvider,
        _appleAuthProvider = appleAuthProvider {
    _updateUserBasedOnCache();
    _updateUserSettingBasedOnCache();
  }

  final IStorage _secureStorageRepository;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookAuth _facebookSignIn;
  final CacheClient _cache;
  final FirestoreService _firestoreService;
  final IDeviceRepository _deviceRepository;
  final StorageService _storageService;
  final firebase_auth.GoogleAuthProvider _googleAuthProvider;
  final firebase_auth.FacebookAuthProvider _facebookAuthProvider;
  final firebase_auth.AppleAuthProvider _appleAuthProvider;

  /// Whether or not the current environment is web
  /// Should only be overridden for testing purposes. Otherwise,
  @visibleForTesting
  static firebase_auth.AuthCredential? authCredential;

  /// User cache key.
  /// Should only be used for testing purposes.
  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';
  @visibleForTesting
  static const userSettingCacheKey = '__user_setting_cache_key__';

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [User.empty] if the user is not authenticated.
  @override
  Stream<User> get user => _firebaseAuth.userChanges().map(
        (userCredentional) {
          log('================================================');
          if (userCredentional != null) {
            log('Firebase Auth State Changed: User is authenticated');
            log(
              'Firebase User Details: $userCredentional',
              name: 'User',
              sequenceNumber: 1,
            );
            final user = userCredentional.toUser;
            _cache.write(key: userCacheKey, value: user);
            return user;
          } else {
            log('Firebase Auth State Changed: '
                'User is unauthenticated (User.empty)');
            return User.empty;
          }
        },
      );
  @override
  Stream<UserSetting> get userSetting => _firestoreService
          .getUserSetting(
        _firebaseAuth.currentUser?.uid ?? currentUser.id,
      )
          .map(
        (userCredentionalSetting) {
          if (userCredentionalSetting.isNotEmpty) {
            log('================================================');
            log('Firebase User Setting Changed');
            log('Firebase User Setting: $userCredentionalSetting');
            _cache.write(
              key: userSettingCacheKey,
              value: userCredentionalSetting,
            );
          } else {
            log('Firebase User Settting is empty');
          }
          return userCredentionalSetting;
        },
      );

  //
  // /// Returns the current cached user.
  // /// Defaults to [User.empty] if there is no cached user.
  @override
  User get currentUser => _cache.read<User>(key: userCacheKey) ?? User.empty;
  @override
  UserSetting get currentUserSetting =>
      _cache.read<UserSetting>(key: userSettingCacheKey) ?? UserSetting.empty;

  // /// Returns the current auth status.
  // /// Defaults to [AuthStatus.unknown] if there is no cached auth status.

  static const String tokenKey = KAppText.authTokenKey;
  static const String url = KAppText.backendString;

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [signUpWithGoogle] if an exception occurs.
  @override
  Future<Either<SomeFailure, User?>> signUpWithGoogle() async {
    return eitherFutureHelper(
      () async {
        final credential = await _getGoogleAuthCredential();
        if (credential != null) {
          final userCredentional = await _firebaseAuth
              .signInWithCredential(authCredential ?? credential);

          return Right(userCredentional.user?.toUser);
        }
        return const Right(null);
      },
      methodName: 'signUpWithGoogle',
      className: ErrorText.appAuthenticationKey,
      user: currentUser,
      userSetting: currentUserSetting,
      finallyFunction: () {
        _updateUserBasedOnCache();
        _updateUserSettingBasedOnCache();
      },
    );
  }

  Future<firebase_auth.AuthCredential?> _getGoogleAuthCredential() async {
    if (Config.isWeb) {
      return _getGoogleAuthCredentialWeb();
    } else {
      return _getGoogleAuthCredentialMobile();
    }
  }

  Future<firebase_auth.AuthCredential?> _getGoogleAuthCredentialWeb() async {
    firebase_auth.UserCredential? userCredential;
    try {
      userCredential = await _firebaseAuth.signInWithPopup(
        _googleAuthProvider,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (!e.code.contains('popup-closed-by-user')) rethrow;
      userCredential = null;
    }
    return userCredential?.credential;
  }

  Future<firebase_auth.AuthCredential?> _getGoogleAuthCredentialMobile() async {
    final googleUser = await _googleSignIn.signIn();
    // If user cancelled dialog
    if (googleUser == null) return null;
    final googleAuth = await googleUser.authentication;
    return firebase_auth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
  }

  /// Starts the Sign In with Facebook Flow.
  ///
  /// Throws a [signUpWithFacebook] if an exception occurs.
  @override
  Future<Either<SomeFailure, User?>> signUpWithFacebook() async {
    return eitherFutureHelper(
      () async {
        final credential = await _getFacebookAuthCredential();
        if (credential != null) {
          final userCredentional = await _firebaseAuth
              .signInWithCredential(authCredential ?? credential);

          return Right(userCredentional.user?.toUser);
        }
        return const Right(null);
      },
      methodName: 'signUpWithFacebook',
      className: ErrorText.appAuthenticationKey,
      user: currentUser,
      userSetting: currentUserSetting,
      finallyFunction: () {
        _updateUserBasedOnCache();
        _updateUserSettingBasedOnCache();
      },
    );
  }

  Future<firebase_auth.AuthCredential?> _getFacebookAuthCredential() async {
    if (Config.isWeb) {
      return _getFacebookAuthCredentialWeb();
    } else {
      return _getFacebookAuthCredentialMobile();
    }
  }

  Future<firebase_auth.AuthCredential?> _getFacebookAuthCredentialWeb() async {
    final userCredential = await _firebaseAuth.signInWithPopup(
      _facebookAuthProvider,
    );
    return userCredential.credential;
  }

  Future<firebase_auth.AuthCredential?>
      _getFacebookAuthCredentialMobile() async {
    // Trigger the sign-in flow
    final loginResult = await _facebookSignIn.login();

    if (loginResult.accessToken == null) {
      return null;
    }

    // Create a credential from the access token
    return firebase_auth.FacebookAuthProvider.credential(
      loginResult.accessToken!.tokenString,
    );
  }

  /// Starts the Sign In with Apple Flow.
  ///
  /// Throws a [signUpWithApple] if an exception occurs.
  @override
  Future<Either<SomeFailure, User?>> signUpWithApple() async {
    return eitherFutureHelper(
      () async {
        final credential = await _getAppleAuthCredential();
        if (credential != null) {
          final userCredentional = await _firebaseAuth
              .signInWithCredential(authCredential ?? credential);

          return Right(userCredentional.user?.toUser);
        }
        return const Right(null);
      },
      methodName: 'signUpWithApple',
      className: ErrorText.appAuthenticationKey,
      user: currentUser,
      userSetting: currentUserSetting,
      finallyFunction: () {
        _updateUserBasedOnCache();
        _updateUserSettingBasedOnCache();
      },
    );
  }

  Future<firebase_auth.AuthCredential?> _getAppleAuthCredential() async {
    if (Config.isWeb) {
      return _getAppleAuthCredentialWeb();
    } else {
      return _getAppleAuthCredentialMobile();
    }
  }

  Future<firebase_auth.AuthCredential?> _getAppleAuthCredentialWeb() async {
    firebase_auth.UserCredential? userCredential;
    try {
      userCredential = await _firebaseAuth.signInWithPopup(
        _appleAuthProvider,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (!e.code.contains('popup-closed-by-user')) rethrow;
      userCredential = null;
    }
    return userCredential?.credential;
  }

  Future<firebase_auth.AuthCredential?> _getAppleAuthCredentialMobile() async {
    AuthorizationCredentialAppleID? appleCredential;
    // Trigger the Apple Sign-In flow using the 'sign_in_with_apple' plugin
    try {
      appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
    } on SignInWithAppleAuthorizationException catch (e) {
      log('apple authentication error: $e');
      if (e.code == AuthorizationErrorCode.failed) rethrow;
    }

    if (appleCredential == null) {
      return null;
    }

    // Create a credential from the Apple Sign-In result
    final firebaseCredential =
        firebase_auth.OAuthProvider('apple.com').credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );

    return firebaseCredential;
  }

  /// Signs in with the provided [email] and [password].
  @override
  Future<Either<SomeFailure, User?>> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async =>
      _handleAuthOperation(
        operation: () async => _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        ),
        methodName: 'logInWithEmailAndPassword',
        data: 'Email: $email | Password: $password',
      );

  /// Signs in with the anonymously.
  @override
  Future<Either<SomeFailure, User?>> logInAnonymously() async =>
      _handleAuthOperation(
        operation: () async => _firebaseAuth.signInAnonymously(),
        methodName: 'logInAnonymously',
      );

  /// Creates a new user with the provided [email] and [password].
  @override
  Future<Either<SomeFailure, User?>> signUp({
    required String email,
    required String password,
  }) async =>
      _handleAuthOperation(
        operation: () async {
          if (currentUser.isEmpty) {
            return _firebaseAuth.createUserWithEmailAndPassword(
              email: email,
              password: password,
            );
          } else {
            await _firebaseAuth.currentUser?.linkWithCredential(
              firebase_auth.EmailAuthProvider.credential(
                email: email,
                password: password,
              ),
            );
            return _firebaseAuth.signInWithEmailAndPassword(
              email: email,
              password: password,
            );
          }
        },
        methodName: 'signUp',
        data: 'Email: $email | Password: $password',
      );

  @override
  bool get isLoggedIn => currentUser != User.empty;

  @override
  bool get isAnonymously =>
      _firebaseAuth.currentUser != null &&
      _firebaseAuth.currentUser!.isAnonymous;

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  @override
  Future<Either<SomeFailure, bool>> logOut() async {
    return eitherFutureHelper(
      () async {
        _cache.clear();
        await Future.wait([
          _firebaseAuth.signOut(),
          _googleSignIn.signOut(),
          _facebookSignIn.logOut(),
          _secureStorageRepository.deleteAll(),
        ]);
        unawaited(logInAnonymously());
        return const Right(true);
      },
      methodName: 'logOut',
      className: ErrorText.appAuthenticationKey,
      user: currentUser,
      userSetting: currentUserSetting,
    );
    // finally {
    //   _updateAuthStatusBasedOnCache();
    //   _updateUserSettingBasedOnCache();
    // }
  }

  @override
  Future<String?> getUser() async {
    final token = await _secureStorageRepository.readOne(
      keyItem: KAppText.usernameToken,
    );
    return token;
  }

  Future<Either<SomeFailure, User?>> _handleAuthOperation({
    required Future<firebase_auth.UserCredential> Function() operation,
    required String methodName,
    String? data,
  }) async {
    return eitherFutureHelper(
      () async {
        final userCredentional = await operation();
        return Right(userCredentional.user?.toUser);
      },
      methodName: methodName,
      className: ErrorText.appAuthenticationKey,
      data: data,
      user: currentUser,
      userSetting: currentUserSetting,
      finallyFunction: () {
        _updateUserBasedOnCache();
        _updateUserSettingBasedOnCache();
      },
    );
  }

  void _updateUserBasedOnCache() {
    log('Updating auth status based on cache');
    final user = currentUser.isEmpty;
    log('Current user inside '
        '_updateAuthStatusBasedOnCache : $currentUser');
    log('user is $user', name: 'Cache User', level: 1);
  }

  void _updateUserSettingBasedOnCache() {
    log('Updating user setting based on cache');
    final userSetting = currentUserSetting.isEmpty;
    log('Current user setting inside '
        '_updateAuthStatusBasedOnCache : $currentUserSetting');
    log('userSertting is $userSetting', name: 'Cache User Setting', level: 1);
  }

  @override
  Future<Either<SomeFailure, bool>> sendVerificationCode({
    required String email,
  }) async {
    return eitherFutureHelper(
      () async {
        final baseUrl = UriExtension.baseUrl;
        await _firebaseAuth.sendPasswordResetEmail(
          email: email,
          actionCodeSettings: baseUrl == KAppText.site
              ? null
              : firebase_auth.ActionCodeSettings(
                  url: '$baseUrl/${KRoute.login.path}',
                ),
        );
        return const Right(true);
      },
      methodName: 'sendVerificationCode',
      className: ErrorText.appAuthenticationKey,
      user: currentUser,
      userSetting: currentUserSetting,
      data: 'Email: $email',
    );
  }

  @override
  Future<Either<SomeFailure, bool>> checkVerificationCode(
    String? code,
  ) async {
    return eitherFutureHelper(
      () async {
        if (code == null) {
          return Left(
            SomeFailure.value(
              error: 'Code is null',
              tag: 'checkVerificationCode(${ErrorText.wrongVerifyCodeError})',
              tagKey: ErrorText.appAuthenticationKey,
              user: currentUser,
              userSetting: currentUserSetting,
              data: 'Code: $code',
            ),
          );
        }
        final email = await _firebaseAuth.verifyPasswordResetCode(
          code,
          // actionCodeSettings: firebase_auth.ActionCodeSettings(
          //   url: '${Uri.base.origin}/${KRoute.login.path}',
          //   handleCodeInApp: true,
          // ),
        );
        return Right(email.isNotEmpty);
      },
      methodName: 'checkVerificationCode',
      className: ErrorText.appAuthenticationKey,
      user: currentUser,
      userSetting: currentUserSetting,
      data: 'Code: $code',
    );
  }

  @override
  Future<Either<SomeFailure, bool>> resetPasswordUseCode({
    required String code,
    required String newPassword,
  }) async {
    return eitherFutureHelper(
      () async {
        await _firebaseAuth.confirmPasswordReset(
          code: code,
          newPassword: newPassword,
        );
        return const Right(true);
      },
      methodName: 'resetPasswordUseCode',
      className: ErrorText.appAuthenticationKey,
      user: currentUser,
      userSetting: currentUserSetting,
    );
  }

  @override
  Future<Either<SomeFailure, bool>> deleteUser() async {
    /// every thirty days, all documents where KAppText.deletedFieldId
    /// older than 30 days will be deleted automatically and user with the
    /// same
    /// UID (firebase function)
    Left<SomeFailure, bool>? failure;
    final resultUser = await updateUserSetting(
      currentUserSetting.copyWith(deletedOn: ExtendedDateTime.current),
    );
    resultUser.leftMap(
      (l) => failure = Left(l),
    );

    final result = await logOut();
    // if (currentUser.photo != null && currentUser.photo!.isNotEmpty) {
    //   try {
    //     unawaited(_storageService.removeFile(currentUser.photo));
    //     // User can save own photo in another service
    //   } catch (e) {}
    // }
    return failure ?? result;
    // finally {
    //   _updateAuthStatusBasedOnCache();
    //   _updateUserSettingBasedOnCache();
    // }
  }

  @override
  Future<Either<SomeFailure, UserSetting>> updateUserSetting(
    UserSetting userSetting,
  ) async {
    return eitherFutureHelper(
      () async {
        if (currentUser.isNotEmpty) {
          // if (currentUserSetting.id.isEmpty ||
          //     currentUserSetting.id != currentUser.id) {
          await _firestoreService.setUserSetting(
            userSetting: userSetting,
            userId: currentUser.id,
          );
          // } else {
          //   await _firestoreService.updateUserSetting(
          //     userSetting,
          //   );
          // }
          return Right(userSetting);
        }
        return Right(userSetting);
      },
      methodName: 'updateUserSetting',
      data: 'User Setting: $userSetting',
      className: ErrorText.appAuthenticationKey,
      user: currentUser,
      userSetting: currentUserSetting,
      finallyFunction: _updateUserSettingBasedOnCache,
    );
  }

  @override
  Future<Either<SomeFailure, bool>>
      createFcmUserSettingAndRemoveDeletePameter() async {
    final result = await _deviceRepository.getDevice(
      initialList: currentUserSetting.devicesInfo,
    );

    return result.fold(
      Left.new,
      (r) async {
        var userSetting = currentUserSetting;
        if (currentUserSetting.deletedOn != null) {
          userSetting = userSetting.copyWith(deletedOn: null);
        }
        if (r != null) {
          final devicesInfo =
              List<DeviceInfoModel>.of(currentUserSetting.devicesInfo ?? [])
                ..removeWhere(
                  (deviceInfo) => deviceInfo.deviceId == r.deviceId,
                )
                ..add(r);
          userSetting = userSetting.copyWith(
            id: currentUser.id,
            devicesInfo: devicesInfo,
          );
        }
        if (userSetting == currentUserSetting) {
          return const Right(false);
        }
        final result = await updateUserSetting(userSetting);
        return result.fold(
          Left.new,
          (r) => const Right(true),
        );
      },
    );
  }

  @override
  Future<Either<SomeFailure, User>> updateUserData({
    required User user,
    required FilePickerItem? image,
  }) async {
    return eitherFutureHelper(
      () async {
        late var userPhoto = user.photo;
        await _firebaseAuth.currentUser?.updateDisplayName(user.name);

        if (image != null) {
          log(currentUser.name.toString());
          userPhoto = await _updatePhoto(image: image, userId: user.id);
          if (userPhoto != null && userPhoto.isNotEmpty) {
            try {
              unawaited(_storageService.removeFile(currentUser.photo));
              // User can save own photo in another service
            } catch (e) {
              log('photo remove error - $e');
            }

            await _firebaseAuth.currentUser?.updatePhotoURL(userPhoto);
          }
        }

        return Right(user.copyWith(photo: userPhoto));
      },
      methodName: 'updateUserData',
      data: 'User: $user| ${image.getErrorData}',
      className: ErrorText.appAuthenticationKey,
      user: currentUser,
      userSetting: currentUserSetting,
      finallyFunction: _updateUserBasedOnCache,
    );
  }

  Future<String?> _updatePhoto({
    required FilePickerItem image,
    required String userId,
  }) async {
    final downloadURL = await _storageService.saveFile(
      filePickerItem: image,
      id: userId,
      collecltionName: FirebaseCollectionName.user,
    );
    return downloadURL;
  }
}

extension on firebase_auth.User {
  User get toUser => User(
        id: uid,
        email: email,
        name: displayName,
        photo: photoURL,
        phoneNumber: phoneNumber,
      );
}
