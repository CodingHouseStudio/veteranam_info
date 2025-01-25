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
          (_) async => const Right(KTestVariables.userAnonymous),
        );
        when(
          mockAppAuthenticationRepository.logInWithEmailAndPassword(
            email: KTestVariables.userEmail,
            password: KTestVariables.passwordCorrect,
          ),
        ).thenAnswer(
          (_) async => const Right(KTestVariables.user),
        );
        when(
          mockAppAuthenticationRepository.signUp(
            email: KTestVariables.userEmail,
            password: KTestVariables.passwordCorrect,
          ),
        ).thenAnswer(
          (_) async => const Right(KTestVariables.user),
        );
        when(mockAppAuthenticationRepository.signUpWithGoogle()).thenAnswer(
          (_) async => const Right(KTestVariables.user),
        );
        when(mockAppAuthenticationRepository.signUpWithFacebook()).thenAnswer(
          (_) async => const Right(KTestVariables.user),
        );
        when(mockAppAuthenticationRepository.currentUserSetting).thenAnswer(
          (_) => const UserSetting(id: KTestVariables.field),
        );
        when(mockAppAuthenticationRepository.currentUser).thenAnswer(
          (_) => User.empty,
        );
        when(mockAppAuthenticationRepository.user).thenAnswer(
          (_) => Stream.value(KTestVariables.user),
        );
        when(mockAppAuthenticationRepository.logOut()).thenAnswer(
          (_) async => const Right(true),
        );
        when(
          mockAppAuthenticationRepository.sendVerificationCode(
            email: KTestVariables.userEmail,
          ),
        ).thenAnswer(
          (_) async => const Right(true),
        );
        when(
          mockAppAuthenticationRepository.updateUserSetting(
            KTestVariables.userSetting,
          ),
        ).thenAnswer(
          (_) async => const Right(KTestVariables.repositoryUserSetting),
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
        //   (_) => KTestVariables.userSettingModel,
        // );
        when(
          mockAppAuthenticationRepository.updateUserData(
            user: KTestVariables.profileUser,
            image: KTestVariables.filePickerItem,
          ),
        ).thenAnswer(
          (_) async => const Right(KTestVariables.profileUser),
        );
        when(
          mockAppAuthenticationRepository.updateUserData(
            user: KTestVariables.profileUser,
            image: null,
          ),
        ).thenAnswer(
          (_) async => const Right(KTestVariables.profileUser),
        );
        when(
          mockAppAuthenticationRepository.checkVerificationCode(
            KTestVariables.code,
          ),
        ).thenAnswer(
          (_) async => const Right(true),
        );
        when(
          mockAppAuthenticationRepository.resetPasswordUseCode(
            code: KTestVariables.code,
            newPassword: KTestVariables.passwordCorrect,
          ),
        ).thenAnswer(
          (_) async => const Right(true),
        );

        authenticationRepository = AuthenticationRepository(
          appAuthenticationRepository: mockAppAuthenticationRepository,
        );
      });
      test('Log in', () async {
        expect(
          await authenticationRepository.logIn(
            email: KTestVariables.userEmail,
            password: KTestVariables.passwordCorrect,
          ),
          isA<Right<SomeFailure, bool>>()
              .having((e) => e.value, 'value', isTrue),
        );
      });
      test('Log in', () async {
        expect(
          await authenticationRepository.signUp(
            email: KTestVariables.userEmail,
            password: KTestVariables.passwordCorrect,
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
      // test('get user setting', () async {
      //   expect(
      //     authenticationRepository.currentUserSetting,
      //     const UserSetting(id: KTestVariables.field),
      //   );
      // });
      test('Log Out', () async {
        expect(
          await authenticationRepository.logOut(),
          isA<Right<SomeFailure, bool>>()
              .having((e) => e.value, 'value', isTrue),
        );
      });
      // test('Send Verification Code To Email', () async {
      //   expect(
      //     await authenticationRepository.sendVerificationCodeToEmail(
      //       email: KTestVariables.userEmail,
      //     ),
      //     isA<Right<SomeFailure, bool>>()
      //         .having((e) => e.value, 'value', isTrue),
      //   );
      // });
      // test('Update User Setting', () async {
      //   expect(
      //     await authenticationRepository.updateUserSetting(
      //       userSetting: KTestVariables.userSetting,
      //     ),
      //     isA<Right<SomeFailure, bool>>()
      //         .having((e) => e.value, 'value', isTrue),
      //   );
      // });
      test('Delete User', () async {
        expect(
          await authenticationRepository.deleteUser(),
          isA<Right<SomeFailure, bool>>()
              .having((e) => e.value, 'value', isTrue),
        );
      });
      // test('Is Anonymously', () async {
      //   expect(
      //     authenticationRepository.isAnonymously,
      //     false,
      //   );
      // });
      // test('Is Anonymously Or Emty', () async {
      //   expect(
      //     authenticationRepository.isAnonymouslyOrEmty,
      //     true,
      //   );
      // });
      // test('Update user data', () async {
      //   when(
      //     mockAppAuthenticationRepository.updateUserSetting(
      //       KTestVariables.repositoryUserSetting,
      //     ),
      //   ).thenAnswer(
      //     (_) async => const Right(
      //       KTestVariables.repositoryUserSetting,
      //     ),
      //   );
      //   expect(
      //     await authenticationRepository.updateUserData(
      //       user: KTestVariables.profileUser,
      //       image: KTestVariables.filePickerItem,
      //       nickname: KTestVariables.nicknameCorrect,
      //     ),
      //     isA<Right<SomeFailure, bool>>()
      //         .having((e) => e.value, 'value', isTrue),
      //   );
      // });

      // test('Update user data', () async {
      //   when(
      //     mockAppAuthenticationRepository.updateUserSetting(
      //       const UserSetting(
      //         id: KTestVariables.field,
      //         nickname: KTestVariables.nicknameCorrect,
      //       ),
      //     ),
      //   ).thenAnswer(
      //     (_) async => const Right(KTestVariables.repositoryUserSetting),
      //   );
      //   expect(
      //     await authenticationRepository.updateUserData(
      //       user: KTestVariables.profileUser,
      //       image: null,
      //       nickname: KTestVariables.nicknameCorrect,
      //     ),
      //     isA<Right<SomeFailure, bool>>()
      //         .having((e) => e.value, 'value', isTrue),
      //   );
      // });
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
      // test('Update user settings', () async {
      //   when(mockAppAuthenticationRepository.currentUserSetting).thenAnswer(
      //     (_) => KTestVariables.userSettingModel,
      //   );

      //   expect(
      //     await authenticationRepository.updateUserSetting(
      //       userSetting: KTestVariables.userSetting,
      //     ),
      //     isA<Right<SomeFailure, bool>>()
      //         .having((e) => e.value, 'value', isTrue),
      //   );
      // });

      // test('Check verification code', () async {
      //   expect(
      //     await authenticationRepository.checkVerificationCode(
      //       KTestVariables.code,
      //     ),
      //     isA<Right<SomeFailure, bool>>()
      //         .having((e) => e.value, 'value', isTrue),
      //   );
      // });

      // test('Reset password use code', () async {
      //   expect(
      //     await authenticationRepository.resetPasswordUseCode(
      //       code: KTestVariables.code,
      //       newPassword: KTestVariables.passwordCorrect,
      //     ),
      //     isA<Right<SomeFailure, bool>>()
      //         .having((e) => e.value, 'value', isTrue),
      //   );
      // });
    });
    group('${KGroupText.failure} ', () {
      setUp(() {
        when(
          mockAppAuthenticationRepository.logInAnonymously(),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        );
        authenticationRepository = AuthenticationRepository(
          appAuthenticationRepository: mockAppAuthenticationRepository,
        );
        when(
          mockAppAuthenticationRepository.logInWithEmailAndPassword(
            email: KTestVariables.userEmail,
            password: KTestVariables.passwordCorrect,
          ),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        );
        when(
          mockAppAuthenticationRepository.signUp(
            email: KTestVariables.userEmail,
            password: KTestVariables.passwordCorrect,
          ),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        );
        when(mockAppAuthenticationRepository.signUpWithGoogle()).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        );
        when(mockAppAuthenticationRepository.signUpWithFacebook()).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        );
        when(mockAppAuthenticationRepository.logOut()).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        );
        when(
          mockAppAuthenticationRepository.sendVerificationCode(
            email: KTestVariables.userEmailIncorrect,
          ),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        );
        when(
          mockAppAuthenticationRepository.updateUserSetting(
            KTestVariables.userSettingModel,
          ),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        );
        when(
          mockAppAuthenticationRepository.deleteUser(),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        );
        when(mockAppAuthenticationRepository.currentUserSetting).thenAnswer(
          (_) => KTestVariables.userSettingModelIncorrect,
        );
        when(
          mockAppAuthenticationRepository.updateUserData(
            user: KTestVariables.profileUser,
            image: KTestVariables.filePickerItem,
          ),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        );
        when(
          mockAppAuthenticationRepository.checkVerificationCode(
            KTestVariables.code,
          ),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        );
        when(
          mockAppAuthenticationRepository.resetPasswordUseCode(
            code: KTestVariables.code,
            newPassword: KTestVariables.passwordCorrect,
          ),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        );
      });
      test('Log in', () async {
        expect(
          await authenticationRepository.logIn(
            email: KTestVariables.userEmail,
            password: KTestVariables.passwordCorrect,
          ),
          isA<Left<SomeFailure, bool>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError,
          // ),
        );
      });
      test('Log in', () async {
        expect(
          await authenticationRepository.signUp(
            email: KTestVariables.userEmail,
            password: KTestVariables.passwordCorrect,
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
          //   SomeFailure.serverError,
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
          //   SomeFailure.serverError,
          // ),
        );
      });
      // test('Send Verification Code To Email', () async {
      //   expect(
      //     await authenticationRepository.sendVerificationCodeToEmail(
      //       email: KTestVariables.userEmailIncorrect,
      //     ),
      //     isA<Left<SomeFailure, bool>>(),
      //     // .having(
      //     //   (e) => e.value,
      //     //   'value',
      //     //   SomeFailure.serverError,
      //     // ),
      //   );
      // });
      // test('Update User Setting', () async {
      //   expect(
      //     await authenticationRepository.updateUserSetting(
      //       userSetting: KTestVariables.userSettingModel,
      //     ),
      //     isA<Left<SomeFailure, bool>>(),
      //     // .having(
      //     //   (e) => e.value,
      //     //   'value',
      //     //   SomeFailure.serverError,
      //     // ),
      //   );
      // });
      test('Delete User', () async {
        expect(
          await authenticationRepository.deleteUser(),
          isA<Left<SomeFailure, bool>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError,
          // ),
        );
      });
      // test('Update user data', () async {
      //   when(
      //     mockAppAuthenticationRepository.updateUserSetting(
      //       const UserSetting(
      //         id: KTestVariables.field,
      //         nickname: KTestVariables.nicknameCorrect,
      //       ),
      //     ),
      //   ).thenAnswer(
      //     (_) async => const Left(SomeFailure.serverError),
      //   );
      //   expect(
      //     await authenticationRepository.updateUserData(
      //       user: KTestVariables.profileUser,
      //       image: KTestVariables.filePickerItem,
      //       nickname: KTestVariables.nicknameCorrect,
      //     ),
      //     isA<Left<SomeFailure, bool>>(),
      //   );
      // });

      // test('Check verification code', () async {
      //   expect(
      //     await authenticationRepository.checkVerificationCode(
      //       KTestVariables.code,
      //     ),
      //     isA<Left<SomeFailure, bool>>(),
      //   );
      // });

      // test('Reset password use code', () async {
      //   expect(
      //     await authenticationRepository.resetPasswordUseCode(
      //       code: KTestVariables.code,
      //       newPassword: KTestVariables.passwordCorrect,
      //     ),
      //     isA<Left<SomeFailure, bool>>(),
      //   );
      // });
    });
  });
}
