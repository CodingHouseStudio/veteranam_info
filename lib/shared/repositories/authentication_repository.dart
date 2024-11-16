import 'dart:async';
import 'dart:developer' show log;

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

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
  }

  final IAppAuthenticationRepository iAppAuthenticationRepository;
  late StreamController<AuthenticationStatus> _authenticationStatuscontroller;
  StreamSubscription<User>? _userSubscription;

  void _onUserStreamListen() {
    _userSubscription ??=
        iAppAuthenticationRepository.user.listen((currentUser) {
      if (currentUser.isNotEmpty) {
        if (iAppAuthenticationRepository.isAnonymously) {
          _authenticationStatuscontroller.add(
            AuthenticationStatus.anonymous,
          );
        } else {
          _authenticationStatuscontroller.add(
            AuthenticationStatus.authenticated,
          );
        }
      } else {
        unawaited(_logInAnonymously());
        _authenticationStatuscontroller.add(
          AuthenticationStatus.unknown,
        );
      }
    });
  }

  void _onUserStreamCancel() {
    _userSubscription?.cancel();
    _userSubscription = null;
  }

  Stream<AuthenticationStatus> get status =>
      _authenticationStatuscontroller.stream;

  Future<Either<SomeFailure, bool>> deleteUser() async {
    final result = await iAppAuthenticationRepository.deleteUser();
    return result.fold(
      (l) {
        return Left(l);
      },
      (r) {
        _authenticationStatuscontroller.add(AuthenticationStatus.unknown);
        log('User deleted');
        return Right(r);
      },
    );
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
        _authenticationStatuscontroller.add(
          AuthenticationStatus.unknown,
        );
        return Left(l);
      },
      (r) {
        log('authenticated');
        if (r != null) {
          _authenticationStatuscontroller
              .add(AuthenticationStatus.authenticated);
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
        _authenticationStatuscontroller.add(
          AuthenticationStatus.unknown,
        );
        return Left(l);
      },
      (r) {
        log('authenticated');
        if (r != null) {
          _authenticationStatuscontroller
              .add(AuthenticationStatus.authenticated);
        }
        return const Right(true);
      },
    );
  }

  Future<Either<SomeFailure, bool>> signUpWithGoogle() async {
    final result = await iAppAuthenticationRepository.signUpWithGoogle();
    return result.fold(
      (l) {
        _authenticationStatuscontroller.add(
          AuthenticationStatus.unknown,
        );
        return Left(l);
      },
      (r) {
        log('authenticated');
        if (r != null) {
          _authenticationStatuscontroller
              .add(AuthenticationStatus.authenticated);
        }
        return const Right(true);
      },
    );
  }

  Future<Either<SomeFailure, bool>> signUpWithFacebook() async {
    final result = await iAppAuthenticationRepository.signUpWithFacebook();
    return result.fold(
      (l) {
        _authenticationStatuscontroller.add(
          AuthenticationStatus.unknown,
        );
        return Left(l);
      },
      (r) {
        log('authenticated');
        if (r != null) {
          _authenticationStatuscontroller
              .add(AuthenticationStatus.authenticated);
        }
        return const Right(true);
      },
    );
  }

  Future<Either<SomeFailure, bool>> logOut() async {
    final result = await iAppAuthenticationRepository.logOut();
    return result.fold(
      (l) {
        _authenticationStatuscontroller.add(
          AuthenticationStatus.unknown,
        );
        return Left(l);
      },
      (r) {
        log('Log out', name: 'Log Out');
        _authenticationStatuscontroller.add(AuthenticationStatus.unknown);

        return Right(r);
      },
    );
  }

  Future<void> _logInAnonymously() async {
    final result = await iAppAuthenticationRepository.logInAnonymously();
    result.fold(
      (l) {},
      (r) {
        log('created anonymously user');
        if (r != null) {
          _authenticationStatuscontroller.add(AuthenticationStatus.anonymous);
        }
      },
    );
  }

  AuthenticationStatus get currectAuthenticationStatus {
    if (iAppAuthenticationRepository.isAnonymously) {
      return AuthenticationStatus.anonymous;
    } else if (iAppAuthenticationRepository.currentUser.isEmpty) {
      return AuthenticationStatus.unknown;
    } else {
      return AuthenticationStatus.authenticated;
    }
  }

  // @disposeMethod
  void dispose() {
    _authenticationStatuscontroller.close();
    _userSubscription?.cancel();
  }
}
