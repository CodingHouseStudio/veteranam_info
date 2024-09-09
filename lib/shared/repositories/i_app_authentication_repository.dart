import 'package:dartz/dartz.dart';
import 'package:veteranam/shared/shared.dart';

abstract class IAppAuthenticationRepository {
  Stream<User> get user;
  Stream<UserSetting> get userSetting;

  User get currentUser;
  UserSetting get currentUserSetting;

  Future<Either<SomeFailure, bool>> signUpWithGoogle();

  Future<Either<SomeFailure, bool>> signUpWithFacebook();

  Future<Either<SomeFailure, bool>> logInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<SomeFailure, bool>> logInAnonymously();

  Future<Either<SomeFailure, bool>> signUp({
    required String email,
    required String password,
  });

  bool isLoggedIn();
  bool isAnonymously();

  Future<Either<SomeFailure, bool>> logOut();

  Future<String?> getUser();

  Future<Either<SomeFailure, bool>> sendVerificationCode({
    required String email,
  });

  Future<Either<SomeFailure, bool>> deleteUser();

  Future<Either<SomeFailure, bool>> updateUserSetting(
    UserSetting userSetting,
  );

  Future<Either<SomeFailure, bool>> createFcmUserSetting();

  Future<Either<SomeFailure, bool>> sendSignInLinkToEmail(String email);
}
