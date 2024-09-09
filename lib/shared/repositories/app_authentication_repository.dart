import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/foundation.dart'
    show kIsWeb, visibleForTesting; //debugPrint
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

@Singleton(as: IAppAuthenticationRepository)
class AppAuthenticationRepository implements IAppAuthenticationRepository {
  AppAuthenticationRepository(
    // super.dioClient,
    this._secureStorageRepository,
    this._firebaseAuth,
    this._googleSignIn,
    this._cache,
    this._facebookSignIn,
  ) {
    _updateAuthStatusBasedOnCache();
    _updateUserSettingBasedOnCache();
  }

  final IStorage _secureStorageRepository;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookAuth _facebookSignIn;
  final CacheClient _cache;
  final FirestoreService _firestoreService = GetIt.I.get<FirestoreService>();
  final IDeviceRepository _deviceRepository = GetIt.I.get<IDeviceRepository>();

  /// Whether or not the current environment is web
  /// Should only be overridden for testing purposes. Otherwise,
  /// defaults to [kIsWeb]
  @visibleForTesting
  bool isWeb = kIsWeb;
  @visibleForTesting
  firebase_auth.GoogleAuthProvider googleAuthProvider =
      firebase_auth.GoogleAuthProvider();
  @visibleForTesting
  firebase_auth.FacebookAuthProvider facebookAuthProvider =
      firebase_auth.FacebookAuthProvider();

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
        (firebaseUser) {
          // debugPrint('================================================');
          if (firebaseUser != null) {
            // debugPrint('Firebase Auth State Changed: User is authenticated');
            // debugPrint('Firebase User Details: $firebaseUser');
            final user = firebaseUser.toUser;
            _cache.write(key: userCacheKey, value: user);
            return user;
          } else {
            // debugPrint('Firebase Auth State Changed: '
            //     'User is unauthenticated (User.empty)');
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
        (firebaseUserSetting) {
          if (firebaseUserSetting.isNotEmpty) {
            // debugPrint('================================================');
            // debugPrint('Firebase Auth State Changed: User is authenticated');
            // debugPrint('Firebase User Details: $firebaseUserSetting');
            _cache.write(key: userSettingCacheKey, value: firebaseUserSetting);
          } else {
            // debugPrint('Firebase Auth State Changed: '
            //     'User is unauthenticated (User.empty)');
          }
          return firebaseUserSetting;
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
  Future<Either<SomeFailure, bool>> signUpWithGoogle() async {
    try {
      final credential = await _getGoogleAuthCredential();
      if (credential != null) {
        await _firebaseAuth.signInWithCredential(credential);

        return const Right(true);
      }
      return const Right(false);
    } on firebase_auth.FirebaseAuthException catch (e, stack) {
      return Left(
        SignUpWithGoogleFailure.fromCode(error: e, stack: stack).status,
      );
    } catch (_, stack) {
      return Left(SomeFailure.serverError(error: _, stack: stack));
    } finally {
      _updateAuthStatusBasedOnCache();
      _updateUserSettingBasedOnCache();
    }
  }

  Future<firebase_auth.AuthCredential?> _getGoogleAuthCredential() async {
    if (isWeb) {
      return _getGoogleAuthCredentialWeb();
    } else {
      return _getGoogleAuthCredentialMobile();
    }
  }

  Future<firebase_auth.AuthCredential?> _getGoogleAuthCredentialWeb() async {
    final userCredential = await _firebaseAuth.signInWithPopup(
      googleAuthProvider,
    );
    return userCredential.credential;
  }

  Future<firebase_auth.AuthCredential> _getGoogleAuthCredentialMobile() async {
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    return firebase_auth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
  }

  /// Starts the Sign In with Facebook Flow.
  ///
  /// Throws a [signUpWithFacebook] if an exception occurs.
  @override
  Future<Either<SomeFailure, bool>> signUpWithFacebook() async {
    try {
      final credential = await _getFacebookAuthCredential();
      if (credential != null) {
        await _firebaseAuth.signInWithCredential(credential);

        return const Right(true);
      }
      return const Right(false);
    } on firebase_auth.FirebaseAuthException catch (e, stack) {
      return Left(
        SignUpWithFacebookFailure.fromCode(error: e, stack: stack).status,
      );
    } catch (_, stack) {
      return Left(SomeFailure.serverError(error: _, stack: stack));
    } finally {
      _updateAuthStatusBasedOnCache();
      _updateUserSettingBasedOnCache();
    }
  }

  Future<firebase_auth.AuthCredential?> _getFacebookAuthCredential() async {
    if (isWeb) {
      return _getFacebookAuthCredentialWeb();
    } else {
      return _getFacebookAuthCredentialMobile();
    }
  }

  Future<firebase_auth.AuthCredential?> _getFacebookAuthCredentialWeb() async {
    final userCredential = await _firebaseAuth.signInWithPopup(
      facebookAuthProvider,
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
  Future<Either<SomeFailure, bool>> logInWithEmailAndPassword({
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
        ).status,
      );

  /// Signs in with the anonymously.
  ///
  /// Throws a [SendFailure] if an exception occurs.
  @override
  Future<Either<SomeFailure, bool>> logInAnonymously() async =>
      _handleAuthOperation(
        () async => _firebaseAuth.signInAnonymously(),
        ({required error, stack}) =>
            SendFailure.fromCode(error: error, stack: stack).status,
      );

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpWithEmailAndPasswordFailure] if an exception occurs.
  @override
  Future<Either<SomeFailure, bool>> signUp({
    required String email,
    required String password,
  }) async {
    return _handleAuthOperation(
      () async {
        if (currentUser.isEmpty) {
          await _firebaseAuth.createUserWithEmailAndPassword(
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
          await _firebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
        }
      },
      ({required error, stack}) =>
          SignUpWithEmailAndPasswordFailure.fromCode(error: error, stack: stack)
              .status,
    );
  }

  @override
  bool isLoggedIn() => currentUser != User.empty;

  @override
  bool isAnonymously() =>
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
      return logInAnonymously();
    } on firebase_auth.FirebaseAuthException catch (e, stack) {
      // debugPrint('Firebase Auth Error: ${e.message}');
      return Left(LogOutFailure.fromCode(error: e, stack: stack).status);
    } catch (e, stack) {
      // debugPrint('Logout error: $e');
      return Left(SomeFailure.serverError(error: e, stack: stack));
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

  Future<Either<SomeFailure, bool>> _handleAuthOperation(
    Future<void> Function() operation,
    SomeFailure Function({
      required firebase_auth.FirebaseAuthException error,
      StackTrace? stack,
    }) exception,
  ) async {
    try {
      await operation();
      return const Right(true);
    } on firebase_auth.FirebaseAuthException catch (e, stack) {
      // debugPrint('Firebase Auth Error: ${e.message}');
      return Left(exception(error: e, stack: stack));
    } catch (e, stack) {
      // debugPrint('General Auth Error: $e');
      return Left(SomeFailure.serverError(error: e, stack: stack));
    } finally {
      _updateAuthStatusBasedOnCache();
      _updateUserSettingBasedOnCache();
    }
  }

  void _updateAuthStatusBasedOnCache() {
    // debugPrint('Updating auth status based on cache');
    // ignore: unused_local_variable
    final user = currentUser.isEmpty;
    // debugPrint('Current user inside '
    //     '_updateAuthStatusBasedOnCache : $currentUser');
    // debugPrint('user is $user');
  }

  void _updateUserSettingBasedOnCache() {
    // debugPrint('Updating user setting based on cache');
    // ignore: unused_local_variable
    final userSetting = currentUserSetting.isEmpty;
    // debugPrint('Current user setting inside '
    //     '_updateAuthStatusBasedOnCache : $currentUserSetting');
    // debugPrint('userSertting is $userSetting');
  }

  @override
  Future<Either<SomeFailure, bool>> sendVerificationCode({
    required String email,
  }) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return const Right(true);
    } on firebase_auth.FirebaseAuthException catch (e, stack) {
      // debugPrint('Sendig error: ${e.message}');
      return Left(SomeFailure.emailSendingFailed(error: e, stack: stack));
    } catch (e, stack) {
      // debugPrint('Unknown error: $e');
      return Left(SomeFailure.serverError(error: e, stack: stack));
    }
  }

  @override
  Future<Either<SomeFailure, bool>> deleteUser() async {
    try {
      await _firestoreService.deleteUserSetting(currentUser.id);
      await _firebaseAuth.currentUser?.delete();
      _cache.clear(); // Clear the cache after user deletion
      return logInAnonymously();
    } on firebase_auth.FirebaseAuthException catch (e, stack) {
      // debugPrint('Firebase Auth Error: ${e.message}');
      return Left(SomeFailure.serverError(error: e, stack: stack));
    } catch (e, stack) {
      // debugPrint('General Auth Error: $e');
      return Left(SomeFailure.serverError(error: e, stack: stack));
    }
    // finally {
    //   _updateAuthStatusBasedOnCache();
    //   _updateUserSettingBasedOnCache();
    // }
  }

  @override
  Future<Either<SomeFailure, bool>> updateUserSetting(
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
        return const Right(true);
      }
      return const Right(false);
    } on firebase_core.FirebaseException catch (e, stack) {
      return Left(SendFailure.fromCode(error: e, stack: stack).status);
    } catch (e, stack) {
      return Left(SomeFailure.serverError(error: e, stack: stack));
    } finally {
      _updateUserSettingBasedOnCache();
    }
  }

  @override
  Future<Either<SomeFailure, bool>> createFcmUserSetting() async {
    final result = await _deviceRepository.getDevice(
      initialList: currentUserSetting.devicesInfo,
    );

    return result.fold(
      Left.new,
      (r) {
        if (r == null) {
          return const Right(false);
        }
        final devicesInfo =
            List<DeviceInfoModel>.of(currentUserSetting.devicesInfo ?? [])
              ..removeWhere(
                (deviceInfo) => deviceInfo.deviceId == r.deviceId,
              )
              ..add(r);
        final userSetting = currentUserSetting.copyWith(
          id: currentUser.id,
          devicesInfo: devicesInfo,
        );
        return updateUserSetting(userSetting);
      },
    );
  }

  @override
  Future<Either<SomeFailure, bool>> sendSignInLinkToEmail(String email) async {
    try {
      await _firebaseAuth.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: firebase_auth.ActionCodeSettings(
          url: 'http://veteranam.info/login',
          androidPackageName: KAppText.androidInstallUrl,
          handleCodeInApp: true,
          // TODO(iOSBundleId): set value
          iOSBundleId: 'com.yourapp.bundle', // Replace with your iOS bundle ID
        ),
      );
      return const Right(true);
    } on firebase_core.FirebaseException catch (e, stack) {
      return Left(SendFailure.fromCode(error: e, stack: stack).status);
    } catch (e, stack) {
      return Left(SomeFailure.serverError(error: e, stack: stack));
    } finally {
      _updateAuthStatusBasedOnCache();
      _updateUserSettingBasedOnCache();
    }
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
