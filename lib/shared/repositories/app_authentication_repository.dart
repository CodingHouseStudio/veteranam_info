import 'dart:async';
import 'dart:developer' show log;

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart'
    show visibleForTesting;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
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
  })  : _secureStorageRepository = secureStorageRepository,
        _firebaseAuth = firebaseAuth,
        _googleSignIn = googleSignIn,
        _facebookSignIn = facebookSignIn,
        _cache = cache,
        _firestoreService = firestoreService,
        _deviceRepository = deviceRepository,
        _storageService = storageService,
        _googleAuthProvider = googleAuthProvider,
        _facebookAuthProvider = facebookAuthProvider {
    _updateAuthStatusBasedOnCache();
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
  Stream<User> get user => _firebaseAuth.authStateChanges().map(
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
    try {
      final credential = await _getGoogleAuthCredential();
      if (credential != null) {
        final userCredentional = await _firebaseAuth
            .signInWithCredential(authCredential ?? credential);

        return Right(userCredentional.user?.toUser);
      }
      return const Right(null);
    } on firebase_auth.FirebaseAuthException catch (e, stack) {
      final failure = SignUpWithGoogleFailure.fromCode(
        error: e,
        stack: stack,
        user: currentUser,
        userSetting: currentUserSetting,
        tag: 'signUpWithGoogle(${ErrorText.fromCode})',
        tagKey: ErrorText.appAuthenticationKey,
      ).status;
      if (failure != null) {
        return Left(
          failure,
        );
      }
      return const Right(null);
    } catch (_, stack) {
      return Left(
        SomeFailure.serverError(
          error: _,
          stack: stack,
          tag: 'signUpWithGoogle(${ErrorText.serverError})',
          tagKey: ErrorText.appAuthenticationKey,
          user: currentUser,
          userSetting: currentUserSetting,
        ),
      );
    } finally {
      _updateAuthStatusBasedOnCache();
      _updateUserSettingBasedOnCache();
    }
  }

  Future<firebase_auth.AuthCredential?> _getGoogleAuthCredential() async {
    if (Config.isWeb) {
      return _getGoogleAuthCredentialWeb();
    } else {
      return _getGoogleAuthCredentialMobile();
    }
  }

  Future<firebase_auth.AuthCredential?> _getGoogleAuthCredentialWeb() async {
    final userCredential = await _firebaseAuth.signInWithPopup(
      _googleAuthProvider,
    );
    return userCredential.credential;
  }

  Future<firebase_auth.AuthCredential?> _getGoogleAuthCredentialMobile() async {
    final googleUser = await _googleSignIn.signIn();
    // If user cancelled dialog
    if (googleUser == null) return null;
    log('fdsfdssfddfsdfsdfssdfdfssdffsdfsd $googleUser');
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
    try {
      final credential = await _getFacebookAuthCredential();
      if (credential != null) {
        final userCredentional = await _firebaseAuth
            .signInWithCredential(authCredential ?? credential);

        return Right(userCredentional.user?.toUser);
      }
      return const Right(null);
    } on firebase_auth.FirebaseAuthException catch (e, stack) {
      final failure = SignUpWithFacebookFailure.fromCode(
        error: e,
        stack: stack,
        user: currentUser,
        userSetting: currentUserSetting,
        tag: 'signUpWithFacebook(${ErrorText.fromCode})',
        tagKey: ErrorText.appAuthenticationKey,
      ).status;
      if (failure != null) {
        return Left(
          failure,
        );
      }
      return const Right(null);
    } catch (_, stack) {
      return Left(
        SomeFailure.serverError(
          error: _,
          stack: stack,
          tag: 'signUpWithFacebook(${ErrorText.serverError})',
          tagKey: ErrorText.appAuthenticationKey,
          user: currentUser,
          userSetting: currentUserSetting,
        ),
      );
    } finally {
      _updateAuthStatusBasedOnCache();
      _updateUserSettingBasedOnCache();
    }
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

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  @override
  Future<Either<SomeFailure, User?>> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async =>
      _handleAuthOperation(
        () => _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        ),
        ({required error, stack}) => LogInWithEmailAndPasswordFailure.fromCode(
          error: error,
          stack: stack,
          user: currentUser,
          userSetting: currentUserSetting,
          data: 'Email: $email | Password: $password',
          tag: 'logInWithEmailAndPassword(${ErrorText.fromCode})',
          tagKey: ErrorText.appAuthenticationKey,
        ).status,
      );

  /// Signs in with the anonymously.
  ///
  /// Throws a [SendFailure] if an exception occurs.
  @override
  Future<Either<SomeFailure, User?>> logInAnonymously() async =>
      _handleAuthOperation(
        () async => _firebaseAuth.signInAnonymously(),
        ({required error, stack}) => SendFailure.fromCode(
          error: error,
          stack: stack,
          user: currentUser,
          userSetting: currentUserSetting,
          tag: 'logInAnonymously(${ErrorText.fromCode})',
          tagKey: ErrorText.appAuthenticationKey,
        ).status,
      );

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpWithEmailAndPasswordFailure] if an exception occurs.
  @override
  Future<Either<SomeFailure, User?>> signUp({
    required String email,
    required String password,
  }) async =>
      _handleAuthOperation(
        () async {
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
        ({required error, stack}) => SignUpWithEmailAndPasswordFailure.fromCode(
          error: error,
          stack: stack,
          user: currentUser,
          userSetting: currentUserSetting,
          tag: 'signUp(${ErrorText.fromCode})',
          data: 'Email: $email | Password: $password',
          tagKey: ErrorText.appAuthenticationKey,
        ).status,
      );

  @override
  bool get isLoggedIn => currentUser != User.empty;

  @override
  bool get isAnonymously =>
      _firebaseAuth.currentUser != null &&
      _firebaseAuth.currentUser!.isAnonymous;

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  @override
  Future<Either<SomeFailure, bool>> logOut() async {
    try {
      _cache.clear();
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
        _facebookSignIn.logOut(),
        _secureStorageRepository.deleteAll(),
      ]);
      unawaited(logInAnonymously());
      return const Right(true);
    } on firebase_auth.FirebaseAuthException catch (e, stack) {
      return Left(
        LogOutFailure.fromCode(
          error: e,
          stack: stack,
          user: currentUser,
          userSetting: currentUserSetting,
          tag: 'logOut(${ErrorText.fromCode})',
          tagKey: ErrorText.appAuthenticationKey,
        ).status,
      );
    } catch (e, stack) {
      return Left(
        SomeFailure.serverError(
          error: e,
          stack: stack,
          tag: 'logOut(${ErrorText.serverError})',
          tagKey: ErrorText.appAuthenticationKey,
          user: currentUser,
          userSetting: currentUserSetting,
        ),
      );
    }
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

  Future<Either<SomeFailure, User?>> _handleAuthOperation(
    Future<firebase_auth.UserCredential> Function() operation,
    SomeFailure Function({
      required firebase_auth.FirebaseAuthException error,
      StackTrace? stack,
    }) exception,
  ) async {
    try {
      final userCredentional = await operation();
      return Right(userCredentional.user?.toUser);
    } on firebase_auth.FirebaseAuthException catch (e, stack) {
      return Left(
        exception(
          error: e,
          stack: stack,
        ),
      );
    } catch (e, stack) {
      return Left(
        SomeFailure.serverError(
          error: e,
          stack: stack,
          tag: '_handleAuthOperation operation(${ErrorText.serverError})',
          tagKey: ErrorText.appAuthenticationKey,
          user: currentUser,
          userSetting: currentUserSetting,
          data: 'Operation: $operation',
        ),
      );
    } finally {
      _updateAuthStatusBasedOnCache();
      _updateUserSettingBasedOnCache();
    }
  }

  void _updateAuthStatusBasedOnCache() {
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
    try {
      await _firebaseAuth.sendPasswordResetEmail(
        email: email,
        // actionCodeSettings: firebase_auth.ActionCodeSettings(
        //   url: '${Uri.base.origin}/${KRoute.login.path}',
        //   handleCodeInApp: true,
        // ),
      );
      return const Right(true);
    } on firebase_auth.FirebaseAuthException catch (e, stack) {
      return Left(
        SomeFailure.emailSendingFailed(
          error: e,
          stack: stack,
          tag: 'sendVerificationCode(emailSendingFailed)',
          tagKey: ErrorText.appAuthenticationKey,
          user: currentUser,
          userSetting: currentUserSetting,
          data: 'Email: $email',
        ),
      );
    } catch (e, stack) {
      return Left(
        SomeFailure.serverError(
          error: e,
          stack: stack,
          tag: 'sendVerificationCode(${ErrorText.serverError})',
          tagKey: ErrorText.appAuthenticationKey,
          user: currentUser,
          userSetting: currentUserSetting,
          data: 'Email: $email',
        ),
      );
    }
  }

  @override
  Future<Either<SomeFailure, bool>> checkVerificationCode(
    String? code,
  ) async {
    try {
      if (code == null) {
        return Left(SomeFailure.wrongVerifyCode());
      }
      final email = await _firebaseAuth.verifyPasswordResetCode(
        code,
        // actionCodeSettings: firebase_auth.ActionCodeSettings(
        //   url: '${Uri.base.origin}/${KRoute.login.path}',
        //   handleCodeInApp: true,
        // ),
      );
      return Right(email.isNotEmpty);
    } on firebase_auth.FirebaseAuthException catch (e, stack) {
      return Left(
        VerifyCodeFailure.fromCode(
          error: e,
          stack: stack,
          user: currentUser,
          userSetting: currentUserSetting,
          tag: 'checkVerificationCode(${ErrorText.fromCode})',
          tagKey: ErrorText.appAuthenticationKey,
          data: 'Code: $code',
        ).status,
      );
    } catch (e, stack) {
      return Left(
        SomeFailure.serverError(
          error: e,
          stack: stack,
          tag: 'checkVerificationCode(${ErrorText.serverError})',
          tagKey: ErrorText.appAuthenticationKey,
          user: currentUser,
          userSetting: currentUserSetting,
          data: 'Code: $code',
        ),
      );
    }
  }

  @override
  Future<Either<SomeFailure, bool>> resetPasswordUseCode({
    required String code,
    required String newPassword,
  }) async {
    try {
      await _firebaseAuth.confirmPasswordReset(
        code: code,
        newPassword: newPassword,
      );
      return const Right(true);
    } on firebase_auth.FirebaseAuthException catch (e, stack) {
      return Left(
        SomeFailure.serverError(
          error: e,
          stack: stack,
          tag: 'resetPasswordUseCode(${ErrorText.serverError})',
          tagKey: ErrorText.appAuthenticationKey,
          user: currentUser,
          userSetting: currentUserSetting,
        ),
      );
    } catch (e, stack) {
      return Left(
        SomeFailure.serverError(
          error: e,
          stack: stack,
          tag: 'resetPasswordUseCode(${ErrorText.serverError})',
          tagKey: ErrorText.appAuthenticationKey,
          user: currentUser,
          userSetting: currentUserSetting,
        ),
      );
    }
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
    resultUser.fold(
      (l) => failure = Left(l),
      Right.new,
    );

    final result = await logOut();
    // if (currentUser.photo != null && currentUser.photo!.isNotEmpty) {
    //   try {
    //     unawaited(_storageService.removeFile(currentUser.photo));
    //     // User can save own photo in another service
    //     // ignore: empty_catches
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
    try {
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
    } on firebase_core.FirebaseException catch (e, stack) {
      return Left(
        SendFailure.fromCode(
          error: e,
          stack: stack,
          user: currentUser,
          userSetting: currentUserSetting,
          tag: 'updateUserSetting(${ErrorText.fromCode})',
          tagKey: ErrorText.appAuthenticationKey,
          data: 'User Setting: $userSetting',
        ).status,
      );
    } catch (e, stack) {
      return Left(
        SomeFailure.serverError(
          error: e,
          stack: stack,
          user: currentUser,
          userSetting: currentUserSetting,
          data: 'User Setting: $userSetting',
        ),
      );
    } finally {
      _updateUserSettingBasedOnCache();
    }
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
    try {
      late var userPhoto = user.photo;
      await _firebaseAuth.currentUser?.updateDisplayName(user.name);

      if (image != null) {
        userPhoto = await _updatePhoto(image: image, userId: user.id);
        if (userPhoto != null && userPhoto.isNotEmpty) {
          try {
            unawaited(_storageService.removeFile(currentUser.photo));
            // User can save own photo in another service
            // ignore: empty_catches
          } catch (e) {}

          await _firebaseAuth.currentUser?.updatePhotoURL(userPhoto);
        }
      }

      return Right(user.copyWith(photo: userPhoto));
    } on firebase_auth.FirebaseAuthException catch (e, stack) {
      return Left(
        SomeFailure.serverError(
          error: e,
          stack: stack,
          tag: 'updateUserData(${ErrorText.serverError})',
          tagKey: ErrorText.appAuthenticationKey,
          user: currentUser,
          userSetting: currentUserSetting,
          data: 'User: $user| ${image.getErrorData}',
        ),
      );
    } catch (e, stack) {
      return Left(
        SomeFailure.serverError(
          error: e,
          stack: stack,
          tag: 'updateUserData(${ErrorText.serverError})',
          tagKey: ErrorText.appAuthenticationKey,
          user: currentUser,
          userSetting: currentUserSetting,
          data: 'User: $user| ${image.getErrorData}',
        ),
      );
    } finally {
      _updateAuthStatusBasedOnCache();
    }
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
