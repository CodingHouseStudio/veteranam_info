import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:kozak/shared/shared.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

@Singleton()
class AuthenticationRepository {
  AuthenticationRepository(
    this.iAppAuthenticationRepository,
  ) {
    // Listen to currentUser changes and emit auth status
    _authenticationStatuscontroller =
        StreamController<AuthenticationStatus>.broadcast(
      onListen: _onStatusStreamListen,
      onCancel: _onStatusStreamCancel,
    );
    _userSettingController = StreamController<UserSetting>.broadcast(
      onListen: _onUserSettingStreamListen,
      onCancel: _onUserSettingStreamCancel,
    );
  }

  final IAppAuthenticationRepository iAppAuthenticationRepository;
  late StreamController<AuthenticationStatus> _authenticationStatuscontroller;
  late StreamController<UserSetting> _userSettingController;
  StreamSubscription<User>? _statusUserSubscription;
  StreamSubscription<User>? _userSubscription;
  StreamSubscription<UserSetting>? _userSettingSubscription;

  void _onStatusStreamListen() {
    _statusUserSubscription ??= iAppAuthenticationRepository.user.listen(
      (currentUser) {
        if (currentUser.isNotAnonymously) {
          _authenticationStatuscontroller.add(
            AuthenticationStatus.authenticated,
          );
        } else {
          _authenticationStatuscontroller.add(
            AuthenticationStatus.unauthenticated,
          );
        }
      },
    );
  }

  void _onUserSettingStreamListen() {
    _userSubscription ??=
        iAppAuthenticationRepository.user.listen((currentUser) {
      if (currentUser.isNotEmpty) {
        _userSettingSubscription ??=
            iAppAuthenticationRepository.userSetting.listen(
          (currentUserSetting) {
            _userSettingController.add(
              currentUserSetting,
            );
          },
        );
      } else {
        _userSettingSubscription?.cancel();
        _userSettingSubscription = null;
      }
    });
  }

  void _onStatusStreamCancel() {
    _statusUserSubscription?.cancel();
    _statusUserSubscription = null;
  }

  void _onUserSettingStreamCancel() {
    _userSettingSubscription?.cancel();
    _userSubscription?.cancel();
    _userSettingSubscription = null;
    _userSubscription = null;
  }

  Stream<AuthenticationStatus> get status =>
      _authenticationStatuscontroller.stream;
  Stream<UserSetting> get userSetting => _userSettingController.stream;

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

  User get currentUser {
    return iAppAuthenticationRepository.currentUser;
  }

  Future<Either<SomeFailure, bool>> deleteUser() async {
    return iAppAuthenticationRepository.deleteUser();
  }

  UserSetting get currentUserSetting {
    return iAppAuthenticationRepository.currentUserSetting;
  }

  Future<Either<SomeFailure, bool>> logIn({
    required String email,
    required String password,
  }) async {
    final result = await iAppAuthenticationRepository.logInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.fold(
      (l) {
        debugPrint('error: $l');
        _authenticationStatuscontroller.add(
          AuthenticationStatus.unauthenticated,
        );
        return Left(l);
      },
      (r) {
        debugPrint('authenticated');
        _authenticationStatuscontroller.add(AuthenticationStatus.authenticated);
        return Right(r);
      },
    );
  }

  Future<Either<SomeFailure, bool>> logInAnonymously() async {
    final result = await iAppAuthenticationRepository.logInAnonymously();
    return result.fold(
      (l) {
        debugPrint('error: $l');
        return Left(l);
      },
      (r) {
        debugPrint('authenticated');
        return Right(r);
      },
    );
  }

  Future<Either<SomeFailure, bool>> signUpWithGoogle() async {
    final result = await iAppAuthenticationRepository.signUpWithGoogle();
    return result.fold(
      (l) {
        debugPrint('error: $l');
        _authenticationStatuscontroller.add(
          AuthenticationStatus.unauthenticated,
        );
        return Left(l);
      },
      (r) {
        debugPrint('authenticated');
        _authenticationStatuscontroller.add(AuthenticationStatus.authenticated);
        return Right(r);
      },
    );
  }

  Future<Either<SomeFailure, bool>> logOut() async {
    final resault = await iAppAuthenticationRepository.logOut();
    resault.fold((l) => debugPrint(l.toString()), (r) {
      debugPrint('ever reached here?');
      _authenticationStatuscontroller.add(AuthenticationStatus.unauthenticated);
    });
    return resault;
  }

  Future<Either<SomeFailure, bool>> sendVerificationCodeToEmail({
    required String email,
  }) async {
    final result =
        await iAppAuthenticationRepository.sendVerificationCode(email: email);
    result.fold(
      (failure) {
        debugPrint('Sending error: $failure');
      },
      (success) {
        debugPrint('Sending succeses $email');
      },
    );
    return result;
  }

  Future<Either<SomeFailure, bool>> updateUserSetting({
    required UserSetting userSetting,
  }) async {
    final result =
        await iAppAuthenticationRepository.updateUserSetting(userSetting);
    result.fold(
      (failure) {
        debugPrint('Sending error: $failure');
      },
      (success) {
        debugPrint('Sending succeses $userSetting');
      },
    );
    return result;
  }

  void dispose() {
    _authenticationStatuscontroller.close();
    _statusUserSubscription?.cancel();

    _userSettingController.close();
    _userSettingSubscription?.cancel();
  }
}
