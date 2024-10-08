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
    // _authenticationStatuscontroller =
    //     StreamController<AuthenticationStatus>.broadcast(
    //   onListen: _onUserStreamListen,
    //   onCancel: _onUserStreamCancel,
    // );
    _userSettingController = StreamController<UserSetting>.broadcast(
      onListen: _onUserStreamListen,
      onCancel: _onUserStreamCancel,
    );
    _userController = StreamController<User>.broadcast(
      onListen: _onUserStreamListen,
      onCancel: _onUserStreamCancel,
    );
  }

  final IAppAuthenticationRepository iAppAuthenticationRepository;
  // late StreamController<AuthenticationStatus>
  // _authenticationStatuscontroller;
  late StreamController<UserSetting> _userSettingController;
  late StreamController<User> _userController;
  // StreamSubscription<User>? _statusUserSubscription;
  StreamSubscription<User>? _userSubscription;
  StreamSubscription<UserSetting>? _userSettingSubscription;

  void _onUserStreamListen() {
    _userSubscription ??=
        iAppAuthenticationRepository.user.listen((currentUser) {
      if (currentUser.isNotEmpty) {
        _userController.add(
          currentUser,
        );
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
              unawaited(_createFcmUserSetting());
              userSettingIsNew = false;
            }
            _userSettingController.add(
              currentUserSetting,
            );
          },
        );
        // if (isAnonymously()) {
        //   _authenticationStatuscontroller.add(
        //     AuthenticationStatus.anonymous,
        //   );
        //   return;
        // }
        // _authenticationStatuscontroller.add(
        //   AuthenticationStatus.authenticated,
        // );

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

  // Stream<AuthenticationStatus> get status =>
  //     _authenticationStatuscontroller.stream;
  Stream<UserSetting> get userSetting => _userSettingController.stream;
  Stream<User> get user => _userController.stream;

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
    return result.fold(
      (l) {
        return Left(l); // debugPrint(l.toString())
      },
      (r) {
        _userController.add(User.empty);
        return Right(r); //debugPrint('ever reached here?')
      },
    );
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
        // _authenticationStatuscontroller.add(
        //   AuthenticationStatus.anonymous,
        // );
        return Left(l);
      },
      (r) {
        // debugPrint('authenticated');
        if (r != null) {
          _userController.add(r);
        }
        return const Right(true);
      },
    );
  }

  Future<Either<SomeFailure, bool>> signUp({
    required String email,
    required String password,
  }) async {
    final result = await iAppAuthenticationRepository.signUp(
      email: email,
      password: password,
    );
    return result.fold(
      (l) {
        // debugPrint('error: $l');
        // _authenticationStatuscontroller.add(
        //   AuthenticationStatus.anonymous,
        // );
        return Left(l);
      },
      (r) {
        // debugPrint('authenticated');
        if (r != null) {
          _userController.add(r);
        }
        return const Right(true);
      },
    );
  }

  Future<Either<SomeFailure, bool>> _createFcmUserSetting() async {
    final result = await iAppAuthenticationRepository.createFcmUserSetting();
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
    unawaited(_createFcmUserSetting());
    return result.fold(
      (l) {
        // debugPrint('error: $l');
        // _authenticationStatuscontroller.add(AuthenticationStatus.unknown);
        return Left(l);
      },
      (r) {
        // debugPrint('authenticated');
        if (r != null) {
          _userController.add(r);
        }
        return const Right(true);
      },
    );
  }

  Future<Either<SomeFailure, bool>> signUpWithGoogle() async {
    final result = await iAppAuthenticationRepository.signUpWithGoogle();
    return result.fold(
      (l) {
        // debugPrint('error: $l');
        // _authenticationStatuscontroller.add(
        //   AuthenticationStatus.anonymous,
        // );
        return Left(l);
      },
      (r) {
        // debugPrint('authenticated');
        if (r != null) {
          _userController.add(r);
        }
        return const Right(true);
      },
    );
  }

  Future<Either<SomeFailure, bool>> signUpWithFacebook() async {
    final result = await iAppAuthenticationRepository.signUpWithFacebook();
    return result.fold(
      (l) {
        // debugPrint('error: $l');
        // _authenticationStatuscontroller.add(
        //   AuthenticationStatus.anonymous,
        // );
        return Left(l);
      },
      (r) {
        // debugPrint('authenticated');
        if (r != null) {
          _userController.add(r);
        }
        return const Right(true);
      },
    );
  }

  Future<Either<SomeFailure, bool>> logOut() async {
    final result = await iAppAuthenticationRepository.logOut();
    return result.fold(
      (l) {
        // debugPrint('error: $l');
        // _authenticationStatuscontroller.add(
        //   AuthenticationStatus.anonymous,
        // );
        return Left(l);
      },
      (r) {
        // debugPrint('authenticated');
        _userController.add(User.empty);

        return Right(r);
      },
    );
    // resault.fold(
    //   (l) => debugPrint(l.toString()),
    //   (r) => debugPrint('ever reached here?'),
    // );
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

  Future<Either<SomeFailure, bool>> checkVerificationCode({
    required String? code,
  }) async {
    final result =
        await iAppAuthenticationRepository.checkVerificationCode(code: code);
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

  Future<Either<SomeFailure, bool>> resetPasswordUseCode({
    required String code,
    required String newPassword,
  }) async {
    final result = await iAppAuthenticationRepository.resetPasswordUseCode(
      code: code,
      newPassword: newPassword,
    );
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
    result.fold(
      (failure) {
        // debugPrint('Sending error: $failure');
      },
      (success) {
        _userSettingController.add(userSetting);
        // debugPrint('Sending succeses $userSetting');
      },
    );
    return result;
  }

  Future<Either<SomeFailure, bool>> updateUserData({
    required User user,
    required ImageModel? image,
    required String? nickname,
  }) async {
    SomeFailure? failureValue;
    bool? right;

    if (image != null || user.name != currentUser.name) {
      final result = await iAppAuthenticationRepository.updateUserData(
        user: user,
        image: image,
      );

      result.fold(
        (failure) {
          failureValue = failure;
          // debugPrint('Sending error: $failure');
        },
        (success) {
          _userController.add(user);
          right = true;
          // debugPrint('Sending succeses $userSetting');
        },
      );
    }
    if (nickname != currentUserSetting.nickname) {
      final result = await updateUserSetting(
        userSetting: currentUserSetting.copyWith(nickname: nickname),
      );

      result.fold(
        (failure) {
          failureValue = failure;
          // debugPrint('Sending error: $failure');
        },
        (success) {
          right = true;
          // debugPrint('Sending succeses $userSetting');
        },
      );
    }

    if (failureValue != null) {
      return Left(failureValue!);
    } else {
      return Right(right ?? false);
    }
  }

  bool get isAnonymously => iAppAuthenticationRepository.isAnonymously;

  bool get isAnonymouslyOrEmty =>
      iAppAuthenticationRepository.isAnonymously || currentUser.isEmpty;

  // @disposeMethod
  void dispose() {
    _userController.close();
    _userSubscription?.cancel();

    _userSettingController.close();
    _userSettingSubscription?.cancel();
  }
}
