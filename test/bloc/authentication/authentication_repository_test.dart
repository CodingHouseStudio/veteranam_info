// ignore_for_file: unused_import

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

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
        when(mockAppAuthenticationRepository.signUpWithGoogle()).thenAnswer(
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
            KTestText.userSetting,
          ),
        ).thenAnswer(
          (_) async => Left(SomeFailure.serverError(error: null)),
        );
        when(
          mockAppAuthenticationRepository.deleteUser(),
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
            userSetting: KTestText.userSetting,
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
    });
  });
}
