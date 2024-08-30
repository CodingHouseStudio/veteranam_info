import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

enum AuthenticationStatus {
  unknown,
  anonymous,
  authenticated,
} //unauthenticated

@singleton
class AuthenticationRepository {
  AuthenticationRepository(
    this.iAppAuthenticationRepository,
  ) {
    // Listen to currentUser changes and emit auth status
    _authenticationStatuscontroller =
        StreamController<AuthenticationStatus>.broadcast(
      onListen: _onUserStreamListen,
      onCancel: _onUserStreamCancel,
    );
    _userSettingController = StreamController<UserSetting>.broadcast(
      onListen: _onUserStreamListen,
      onCancel: _onUserStreamCancel,
    );
  }

  final IAppAuthenticationRepository iAppAuthenticationRepository;
  late StreamController<AuthenticationStatus> _authenticationStatuscontroller;
  late StreamController<UserSetting> _userSettingController;
  StreamSubscription<User>? _statusUserSubscription;
  StreamSubscription<User>? _userSubscription;
  StreamSubscription<UserSetting>? _userSettingSubscription;

  void _onUserStreamListen() {
    _userSubscription ??=
        iAppAuthenticationRepository.user.listen((currentUser) {
      if (currentUser.isNotEmpty) {
        if (currentUserSetting.id != currentUser.id &&
            _userSettingSubscription != null) {
          _userSettingSubscription?.cancel();
          _userSettingSubscription = null;
        }
        var userSettingIsNew = _userSettingSubscription == null;
        _userSettingSubscription ??=
            iAppAuthenticationRepository.userSetting.listen(
          (currentUserSetting) {
            if (userSettingIsNew) {
              unawaited(_createUserSettingIfNeed());
              userSettingIsNew = false;
            }
            _userSettingController.add(
              currentUserSetting,
            );
          },
        );
        if (isAnonymously()) {
          _authenticationStatuscontroller.add(
            AuthenticationStatus.anonymous,
          );
          return;
        }
        _authenticationStatuscontroller.add(
          AuthenticationStatus.authenticated,
        );

        return;
      }
      unawaited(_logInAnonymously());
      _userSettingSubscription?.cancel();
      _userSettingSubscription = null;
    });
  }

  void _onUserStreamCancel() {
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
    final result = await iAppAuthenticationRepository.deleteUser();
    // resault.fold(
    //   (l) => debugPrint(l.toString()),
    //   (r) => debugPrint('ever reached here?'),
    // );
    return result;
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
        // debugPrint('error: $l');
        _authenticationStatuscontroller.add(
          AuthenticationStatus.anonymous,
        );
        return Left(l);
      },
      (r) {
        // debugPrint('authenticated');
        _authenticationStatuscontroller.add(AuthenticationStatus.authenticated);
        return Right(r);
      },
    );
  }

  Future<Either<SomeFailure, bool>> _createUserSettingIfNeed() async {
    final result = await iAppAuthenticationRepository.createUserSetting();
    return result.fold(
      (l) {
        // debugPrint('error: $l');
        return Left(l);
      },
      (r) {
        // debugPrint('created');
        return Right(r);
      },
    );
  }

  Future<Either<SomeFailure, bool>> _logInAnonymously() async {
    final result = await iAppAuthenticationRepository.logInAnonymously();
    return result.fold(
      (l) {
        // debugPrint('error: $l');
        return Left(l);
      },
      (r) {
        // debugPrint('authenticated');
        return Right(r);
      },
    );
  }

  Future<Either<SomeFailure, bool>> signUpWithGoogle() async {
    final result = await iAppAuthenticationRepository.signUpWithGoogle();
    return result.fold(
      (l) {
        // debugPrint('error: $l');
        _authenticationStatuscontroller.add(
          AuthenticationStatus.anonymous,
        );
        return Left(l);
      },
      (r) {
        // debugPrint('authenticated');
        _authenticationStatuscontroller.add(AuthenticationStatus.authenticated);
        return Right(r);
      },
    );
  }

  Future<Either<SomeFailure, bool>> logOut() async {
    final result = await iAppAuthenticationRepository.logOut();
    // resault.fold(
    //   (l) => debugPrint(l.toString()),
    //   (r) => debugPrint('ever reached here?'),
    // );
    return result;
  }

  Future<Either<SomeFailure, bool>> sendVerificationCodeToEmail({
    required String email,
  }) async {
    final result =
        await iAppAuthenticationRepository.sendVerificationCode(email: email);
    // result.fold(
    //   (failure) {
    //     debugPrint('Sending error: $failure');
    //   },
    //   (success) {
    //     debugPrint('Sending succeses $email');
    //   },
    // );
    return result;
  }

  Future<Either<SomeFailure, bool>> updateUserSetting({
    required UserSetting userSetting,
  }) async {
    final result =
        await iAppAuthenticationRepository.updateUserSetting(userSetting);
    // result.fold(
    //   (failure) {
    //     debugPrint('Sending error: $failure');
    //   },
    //   (success) {
    //     debugPrint('Sending succeses $userSetting');
    //   },
    // );
    return result;
  }

  bool isAnonymously() => iAppAuthenticationRepository.isAnonymously();

  bool isAnonymouslyOrEmty() =>
      iAppAuthenticationRepository.isAnonymously() || currentUser.isEmpty;

  // @disposeMethod
  void dispose() {
    _authenticationStatuscontroller.close();
    _statusUserSubscription?.cancel();

    _userSettingController.close();
    _userSettingSubscription?.cancel();
  }
}
