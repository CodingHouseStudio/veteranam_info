// ignore_for_file: unused_import

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

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
          (_) async => const Right(true),
        );
        when(
          mockAppAuthenticationRepository.logInWithEmailAndPassword(
            email: KTestText.userEmail,
            password: KTestText.passwordCorrect,
          ),
        ).thenAnswer(
          (_) async => const Right(true),
        );
        when(mockAppAuthenticationRepository.signUpWithGoogle()).thenAnswer(
          (_) async => const Right(true),
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
          (_) async => const Right(true),
        );
        when(
          mockAppAuthenticationRepository.deleteUser(),
        ).thenAnswer(
          (_) async => const Right(true),
        );
        when(
          mockAppAuthenticationRepository.isAnonymously(),
        ).thenAnswer(
          (_) => false,
        );
        when(
          mockAppAuthenticationRepository.createFcmUserSetting(),
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
      test('Sign up with google', () async {
        expect(
          await authenticationRepository.signUpWithGoogle(),
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
          authenticationRepository.isAnonymously(),
          false,
        );
      });
      test('Is Anonymously Or Emty', () async {
        expect(
          authenticationRepository.isAnonymouslyOrEmty(),
          true,
        );
      });
    });
    group('${KGroupText.failure} ', () {
      setUp(() {
        when(
          mockAppAuthenticationRepository.logInAnonymously(),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError()),
        );
        authenticationRepository =
            AuthenticationRepository(mockAppAuthenticationRepository);
        when(
          mockAppAuthenticationRepository.logInWithEmailAndPassword(
            email: KTestText.userEmail,
            password: KTestText.passwordCorrect,
          ),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError()),
        );
        when(mockAppAuthenticationRepository.signUpWithGoogle()).thenAnswer(
          (_) async => const Left(SomeFailure.serverError()),
        );
        when(mockAppAuthenticationRepository.logOut()).thenAnswer(
          (_) async => const Left(SomeFailure.serverError()),
        );
        when(
          mockAppAuthenticationRepository.sendVerificationCode(
            email: KTestText.userEmailIncorrect,
          ),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError()),
        );
        when(
          mockAppAuthenticationRepository.updateUserSetting(
            KTestText.userSetting,
          ),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError()),
        );
        when(
          mockAppAuthenticationRepository.deleteUser(),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError()),
        );
      });
      test('Log in', () async {
        expect(
          await authenticationRepository.logIn(
            email: KTestText.userEmail,
            password: KTestText.passwordCorrect,
          ),
          isA<Left<SomeFailure, bool>>().having(
            (e) => e.value,
            'value',
            const SomeFailure.serverError(),
          ),
        );
      });
      test('Sign up with google', () async {
        expect(
          await authenticationRepository.signUpWithGoogle(),
          isA<Left<SomeFailure, bool>>().having(
            (e) => e.value,
            'value',
            const SomeFailure.serverError(),
          ),
        );
      });
      test('Log Out', () async {
        expect(
          await authenticationRepository.logOut(),
          isA<Left<SomeFailure, bool>>().having(
            (e) => e.value,
            'value',
            const SomeFailure.serverError(),
          ),
        );
      });
      test('Send Verification Code To Email', () async {
        expect(
          await authenticationRepository.sendVerificationCodeToEmail(
            email: KTestText.userEmailIncorrect,
          ),
          isA<Left<SomeFailure, bool>>().having(
            (e) => e.value,
            'value',
            const SomeFailure.serverError(),
          ),
        );
      });
      test('Update User Setting', () async {
        expect(
          await authenticationRepository.updateUserSetting(
            userSetting: KTestText.userSetting,
          ),
          isA<Left<SomeFailure, bool>>().having(
            (e) => e.value,
            'value',
            const SomeFailure.serverError(),
          ),
        );
      });
      test('Delete User', () async {
        expect(
          await authenticationRepository.deleteUser(),
          isA<Left<SomeFailure, bool>>().having(
            (e) => e.value,
            'value',
            const SomeFailure.serverError(),
          ),
        );
      });
    });
  });
}
