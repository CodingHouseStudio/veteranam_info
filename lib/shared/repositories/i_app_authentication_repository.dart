import 'package:dartz/dartz.dart';
import 'package:kozak/shared/shared.dart';

abstract class IAppAuthenticationRepository {
  Stream<User> get user;

  User get currentUser;

  Future<Either<SomeFailure, bool>> signUpWithGoogle();

  Future<Either<SomeFailure, bool>> logInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<SomeFailure, bool>> signUp({
    required String email,
    required String password,
  });

  Future<bool> isLoggedIn();

  Future<Either<SomeFailure, bool>> logOut();

  Future<String?> getUser();

  Future<Either<SomeFailure, bool>> sendVerificationCode({
    required String email,
  });

  Future<Either<SomeFailure, bool>> deleteUser();

  Future<Either<SomeFailure, bool>> updateUserSetting(UserSetting userSetting);

  Future<Either<SomeFailure, UserSetting>> getUserSetting();
}
