import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);

  group('${KScreenBlocName.authentication} ${KGroupText.repository} ', () {
    late AuthenticationRepository authenticationRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    setUp(() {
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
    });
    group('${KGroupText.successful} ', () {
      setUp(() {
        when(
          mockAppAuthenticationRepository.logInAnonymously(),
        ).thenAnswer(
          (_) async => const Right(KTestText.userAnonymous),
        );
        when(
          mockAppAuthenticationRepository.logInWithEmailAndPassword(
            email: KTestText.userEmail,
            password: KTestText.passwordCorrect,
          ),
        ).thenAnswer(
          (_) async => const Right(KTestText.user),
        );
        when(
          mockAppAuthenticationRepository.signUp(
            email: KTestText.userEmail,
            password: KTestText.passwordCorrect,
          ),
        ).thenAnswer(
          (_) async => const Right(KTestText.user),
        );
        when(mockAppAuthenticationRepository.signUpWithGoogle()).thenAnswer(
          (_) async => const Right(KTestText.user),
        );
        when(mockAppAuthenticationRepository.signUpWithFacebook()).thenAnswer(
          (_) async => const Right(KTestText.user),
        );
        when(mockAppAuthenticationRepository.currentUserSetting).thenAnswer(
          (_) => const UserSetting(id: KTestText.field),
        );
        when(mockAppAuthenticationRepository.currentUser).thenAnswer(
          (_) => User.empty,
        );
        when(mockAppAuthenticationRepository.user).thenAnswer(
          (_) => Stream.value(KTestText.user),
        );
        when(mockAppAuthenticationRepository.logOut()).thenAnswer(
          (_) async => const Right(true),
        );
        when(
          mockAppAuthenticationRepository.sendVerificationCode(
            email: KTestText.userEmail,
          ),
        ).thenAnswer(
          (_) async => const Right(true),
        );
        when(
          mockAppAuthenticationRepository.updateUserSetting(
            KTestText.userSetting,
          ),
        ).thenAnswer(
          (_) async => const Right(KTestText.repositoryUserSetting),
        );
        when(
          mockAppAuthenticationRepository.deleteUser(),
        ).thenAnswer(
          (_) async => const Right(true),
        );
        when(
          mockAppAuthenticationRepository.isAnonymously,
        ).thenAnswer(
          (_) => false,
        );
        when(
          mockAppAuthenticationRepository
              .createFcmUserSettingAndRemoveDeletePameter(),
        ).thenAnswer(
          (_) async => const Right(true),
        );
        // when(mockAppAuthenticationRepository.currentUserSetting).thenAnswer(
        //   (_) => KTestText.userSettingModel,
        // );
        when(
          mockAppAuthenticationRepository.updateUserData(
            user: KTestText.profileUser,
            image: KTestText.filePickerItem,
          ),
        ).thenAnswer(
          (_) async => const Right(KTestText.profileUser),
        );
        when(
          mockAppAuthenticationRepository.updateUserData(
            user: KTestText.profileUser,
            image: null,
          ),
        ).thenAnswer(
          (_) async => const Right(KTestText.profileUser),
        );
        when(
          mockAppAuthenticationRepository.checkVerificationCode(
            KTestText.code,
          ),
        ).thenAnswer(
          (_) async => const Right(true),
        );
        when(
          mockAppAuthenticationRepository.resetPasswordUseCode(
            code: KTestText.code,
            newPassword: KTestText.passwordCorrect,
          ),
        ).thenAnswer(
          (_) async => const Right(true),
        );

        authenticationRepository =
            AuthenticationRepository(mockAppAuthenticationRepository);
      });
      test('Log in', () async {
        expect(
          await authenticationRepository.logIn(
            email: KTestText.userEmail,
            password: KTestText.passwordCorrect,
          ),
          isA<Right<SomeFailure, bool>>()
              .having((e) => e.value, 'value', isTrue),
        );
      });
      test('Log in', () async {
        expect(
          await authenticationRepository.signUp(
            email: KTestText.userEmail,
            password: KTestText.passwordCorrect,
          ),
          isA<Right<SomeFailure, bool>>()
              .having((e) => e.value, 'value', isTrue),
        );
      });
      test('Sign up with google', () async {
        expect(
          await authenticationRepository.signUpWithGoogle(),
          isA<Right<SomeFailure, bool>>()
              .having((e) => e.value, 'value', isTrue),
        );
      });
      test('Sign up with facebook', () async {
        expect(
          await authenticationRepository.signUpWithFacebook(),
          isA<Right<SomeFailure, bool>>()
              .having((e) => e.value, 'value', isTrue),
        );
      });
      test('get user setting', () async {
        expect(
          authenticationRepository.currentUserSetting,
          const UserSetting(id: KTestText.field),
        );
      });
      test('Log Out', () async {
        expect(
          await authenticationRepository.logOut(),
          isA<Right<SomeFailure, bool>>()
              .having((e) => e.value, 'value', isTrue),
        );
      });
      test('Send Verification Code To Email', () async {
        expect(
          await authenticationRepository.sendVerificationCodeToEmail(
            email: KTestText.userEmail,
          ),
          isA<Right<SomeFailure, bool>>()
              .having((e) => e.value, 'value', isTrue),
        );
      });
      test('Update User Setting', () async {
        expect(
          await authenticationRepository.updateUserSetting(
            userSetting: KTestText.userSetting,
          ),
          isA<Right<SomeFailure, bool>>()
              .having((e) => e.value, 'value', isTrue),
        );
      });
      test('Delete User', () async {
        expect(
          await authenticationRepository.deleteUser(),
          isA<Right<SomeFailure, bool>>()
              .having((e) => e.value, 'value', isTrue),
        );
      });
      test('Is Anonymously', () async {
        expect(
          authenticationRepository.isAnonymously,
          false,
        );
      });
      test('Is Anonymously Or Emty', () async {
        expect(
          authenticationRepository.isAnonymouslyOrEmty,
          true,
        );
      });
      test('Update user data', () async {
        when(
          mockAppAuthenticationRepository.updateUserSetting(
            KTestText.repositoryUserSetting,
          ),
        ).thenAnswer(
          (_) async => const Right(
            KTestText.repositoryUserSetting,
          ),
        );
        expect(
          await authenticationRepository.updateUserData(
            user: KTestText.profileUser,
            image: KTestText.filePickerItem,
            nickname: KTestText.nicknameCorrect,
          ),
          isA<Right<SomeFailure, bool>>()
              .having((e) => e.value, 'value', isTrue),
        );
      });

      test('Update user data', () async {
        when(
          mockAppAuthenticationRepository.updateUserSetting(
            const UserSetting(
              id: KTestText.field,
              nickname: KTestText.nicknameCorrect,
            ),
          ),
        ).thenAnswer(
          (_) async => const Right(KTestText.repositoryUserSetting),
        );
        expect(
          await authenticationRepository.updateUserData(
            user: KTestText.profileUser,
            image: null,
            nickname: KTestText.nicknameCorrect,
          ),
          isA<Right<SomeFailure, bool>>()
              .having((e) => e.value, 'value', isTrue),
        );
      });
      // test('Update data unmodify data', () async {
      //   expect(
      //     await authenticationRepository.updateUserData(
      //       user: User.empty,
      //       image: null,
      //       nickname: null,
      //     ),
      //     isA<Right<SomeFailure, bool>>()
      //         .having((e) => e.value, 'value', isFalse),
      //   );
      // });
      test('Update user settings', () async {
        when(mockAppAuthenticationRepository.currentUserSetting).thenAnswer(
          (_) => KTestText.userSettingModel,
        );

        expect(
          await authenticationRepository.updateUserSetting(
            userSetting: KTestText.userSetting,
          ),
          isA<Right<SomeFailure, bool>>()
              .having((e) => e.value, 'value', isTrue),
        );
      });

      test('Check verification code', () async {
        expect(
          await authenticationRepository.checkVerificationCode(
            KTestText.code,
          ),
          isA<Right<SomeFailure, bool>>()
              .having((e) => e.value, 'value', isTrue),
        );
      });

      test('Reset password use code', () async {
        expect(
          await authenticationRepository.resetPasswordUseCode(
            code: KTestText.code,
            newPassword: KTestText.passwordCorrect,
          ),
          isA<Right<SomeFailure, bool>>()
              .having((e) => e.value, 'value', isTrue),
        );
      });
    });
    group('${KGroupText.failure} ', () {
      setUp(() {
        when(
          mockAppAuthenticationRepository.logInAnonymously(),
        ).thenAnswer(
          (_) async => Left(SomeFailure.serverError(error: null)),
        );
        authenticationRepository =
            AuthenticationRepository(mockAppAuthenticationRepository);
        when(
          mockAppAuthenticationRepository.logInWithEmailAndPassword(
            email: KTestText.userEmail,
            password: KTestText.passwordCorrect,
          ),
        ).thenAnswer(
          (_) async => Left(SomeFailure.serverError(error: null)),
        );
        when(
          mockAppAuthenticationRepository.signUp(
            email: KTestText.userEmail,
            password: KTestText.passwordCorrect,
          ),
        ).thenAnswer(
          (_) async => Left(SomeFailure.serverError(error: null)),
        );
        when(mockAppAuthenticationRepository.signUpWithGoogle()).thenAnswer(
          (_) async => Left(SomeFailure.serverError(error: null)),
        );
        when(mockAppAuthenticationRepository.signUpWithFacebook()).thenAnswer(
          (_) async => Left(SomeFailure.serverError(error: null)),
        );
        when(mockAppAuthenticationRepository.logOut()).thenAnswer(
          (_) async => Left(SomeFailure.serverError(error: null)),
        );
        when(
          mockAppAuthenticationRepository.sendVerificationCode(
            email: KTestText.userEmailIncorrect,
          ),
        ).thenAnswer(
          (_) async => Left(SomeFailure.serverError(error: null)),
        );
        when(
          mockAppAuthenticationRepository.updateUserSetting(
            KTestText.userSettingModel,
          ),
        ).thenAnswer(
          (_) async => Left(SomeFailure.serverError(error: null)),
        );
        when(
          mockAppAuthenticationRepository.deleteUser(),
        ).thenAnswer(
          (_) async => Left(SomeFailure.serverError(error: null)),
        );
        when(mockAppAuthenticationRepository.currentUserSetting).thenAnswer(
          (_) => KTestText.userSettingModelIncorrect,
        );
        when(
          mockAppAuthenticationRepository.updateUserData(
            user: KTestText.profileUser,
            image: KTestText.filePickerItem,
          ),
        ).thenAnswer(
          (_) async => Left(SomeFailure.serverError(error: null)),
        );
        when(
          mockAppAuthenticationRepository.checkVerificationCode(
            KTestText.code,
          ),
        ).thenAnswer(
          (_) async => Left(SomeFailure.serverError(error: null)),
        );
        when(
          mockAppAuthenticationRepository.resetPasswordUseCode(
            code: KTestText.code,
            newPassword: KTestText.passwordCorrect,
          ),
        ).thenAnswer(
          (_) async => Left(SomeFailure.serverError(error: null)),
        );
      });
      test('Log in', () async {
        expect(
          await authenticationRepository.logIn(
            email: KTestText.userEmail,
            password: KTestText.passwordCorrect,
          ),
          isA<Left<SomeFailure, bool>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError(error: null),
          // ),
        );
      });
      test('Log in', () async {
        expect(
          await authenticationRepository.signUp(
            email: KTestText.userEmail,
            password: KTestText.passwordCorrect,
          ),
          isA<Left<SomeFailure, bool>>(),
        );
      });
      test('Sign up with google', () async {
        expect(
          await authenticationRepository.signUpWithGoogle(),
          isA<Left<SomeFailure, bool>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError(error: null),
          // ),
        );
      });
      test('Sign up with facebook', () async {
        expect(
          await authenticationRepository.signUpWithFacebook(),
          isA<Left<SomeFailure, bool>>(),
        );
      });
      test('Log Out', () async {
        expect(
          await authenticationRepository.logOut(),
          isA<Left<SomeFailure, bool>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError(error: null),
          // ),
        );
      });
      test('Send Verification Code To Email', () async {
        expect(
          await authenticationRepository.sendVerificationCodeToEmail(
            email: KTestText.userEmailIncorrect,
          ),
          isA<Left<SomeFailure, bool>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError(error: null),
          // ),
        );
      });
      test('Update User Setting', () async {
        expect(
          await authenticationRepository.updateUserSetting(
            userSetting: KTestText.userSettingModel,
          ),
          isA<Left<SomeFailure, bool>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError(error: null),
          // ),
        );
      });
      test('Delete User', () async {
        expect(
          await authenticationRepository.deleteUser(),
          isA<Left<SomeFailure, bool>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError(error: null),
          // ),
        );
      });
      test('Update user data', () async {
        when(
          mockAppAuthenticationRepository.updateUserSetting(
            const UserSetting(
              id: KTestText.field,
              nickname: KTestText.nicknameCorrect,
            ),
          ),
        ).thenAnswer(
          (_) async => Left(SomeFailure.serverError(error: null)),
        );
        expect(
          await authenticationRepository.updateUserData(
            user: KTestText.profileUser,
            image: KTestText.filePickerItem,
            nickname: KTestText.nicknameCorrect,
          ),
          isA<Left<SomeFailure, bool>>(),
        );
      });

      test('Check verification code', () async {
        expect(
          await authenticationRepository.checkVerificationCode(
            KTestText.code,
          ),
          isA<Left<SomeFailure, bool>>(),
        );
      });

      test('Reset password use code', () async {
        expect(
          await authenticationRepository.resetPasswordUseCode(
            code: KTestText.code,
            newPassword: KTestText.passwordCorrect,
          ),
          isA<Left<SomeFailure, bool>>(),
        );
      });
    });
  });
}
