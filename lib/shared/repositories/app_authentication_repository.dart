import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/foundation.dart'
    show kIsWeb, visibleForTesting; //debugPrint
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
  ) {
    _updateAuthStatusBasedOnCache();
    _updateUserSettingBasedOnCache();
  }

  final IStorage _secureStorageRepository;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
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
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Left(SignUpWithGoogleFailure.fromCode(e).status);
    } catch (_) {
      return const Left(SomeFailure.serverError());
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
        (e) => LogInWithEmailAndPasswordFailure.fromCode(e).status,
      );

  /// Signs in with the anonymously.
  ///
  /// Throws a [SendFailure] if an exception occurs.
  @override
  Future<Either<SomeFailure, bool>> logInAnonymously() async =>
      _handleAuthOperation(
        () async => _firebaseAuth.signInAnonymously(),
        (e) => SendFailure.fromCode(e).status,
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
      (e) => SignUpWithEmailAndPasswordFailure.fromCode(e).status,
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
        _secureStorageRepository.deleteAll(),
      ]);
      return logInAnonymously();
    } on firebase_auth.FirebaseAuthException {
      // debugPrint('Firebase Auth Error: ${e.message}');
      return Left(const LogOutFailure().status);
    } catch (e) {
      // debugPrint('Logout error: $e');
      return const Left(SomeFailure.serverError());
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
    SomeFailure Function(firebase_auth.FirebaseAuthException error) exception,
  ) async {
    try {
      await operation();
      return const Right(true);
    } on firebase_auth.FirebaseAuthException catch (e) {
      // debugPrint('Firebase Auth Error: ${e.message}');
      return Left(exception(e));
    } catch (e) {
      // debugPrint('General Auth Error: $e');
      return const Left(SomeFailure.serverError());
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
    } on firebase_auth.FirebaseAuthException {
      // debugPrint('Sendig error: ${e.message}');
      return const Left(SomeFailure.emailSendingFailed());
    } catch (e) {
      // debugPrint('Unknown error: $e');
      return const Left(SomeFailure.serverError());
    }
  }

  @override
  Future<Either<SomeFailure, bool>> deleteUser() async {
    try {
      await _firestoreService.deleteUserSetting(currentUser.id);
      await _firebaseAuth.currentUser?.delete();
      _cache.clear(); // Clear the cache after user deletion
      return logInAnonymously();
    } on firebase_auth.FirebaseAuthException {
      // debugPrint('Firebase Auth Error: ${e.message}');
      return const Left(SomeFailure.serverError());
    } catch (e) {
      // debugPrint('General Auth Error: $e');
      return const Left(SomeFailure.serverError());
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
    } on firebase_core.FirebaseException catch (e) {
      return Left(SendFailure.fromCode(e).status);
    } catch (e) {
      return const Left(SomeFailure.serverError());
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
