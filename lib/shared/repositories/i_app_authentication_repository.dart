import 'package:dartz/dartz.dart';
import 'package:veteranam/shared/shared_dart.dart';

abstract class IAppAuthenticationRepository {
  Stream<User> get user;
  Stream<UserSetting> get userSetting;

  User get currentUser;
  UserSetting get currentUserSetting;

  Future<Either<SomeFailure, User?>> signUpWithGoogle();

  Future<Either<SomeFailure, User?>> signUpWithFacebook();

  Future<Either<SomeFailure, User?>> signUpWithApple();

  Future<Either<SomeFailure, User?>> logInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<SomeFailure, User?>> logInAnonymously();

  Future<Either<SomeFailure, User?>> signUp({
    required String email,
    required String password,
  });

  bool get isLoggedIn;
  bool get isAnonymously;

  Future<Either<SomeFailure, bool>> logOut();

  Future<String?> getUser();

  Future<Either<SomeFailure, bool>> sendVerificationCode({
    required String email,
  });

  Future<Either<SomeFailure, bool>> checkVerificationCode(
    String? code,
  );

  Future<Either<SomeFailure, bool>> resetPasswordUseCode({
    required String code,
    required String newPassword,
  });

  Future<Either<SomeFailure, bool>> deleteUser();

  Future<Either<SomeFailure, UserSetting>> updateUserSetting(
    UserSetting userSetting,
  );

  Future<Either<SomeFailure, bool>>
      createFcmUserSettingAndRemoveDeletePameter();

  Future<Either<SomeFailure, User>> updateUserData({
    required User user,
    required FilePickerItem? image,
  });
}
