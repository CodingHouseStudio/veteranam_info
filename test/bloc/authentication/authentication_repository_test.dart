import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  group('${KScreenBlocName.authentication} ${KGroupText.repository} ', () {
    late AuthenticationRepository authenticationRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    group('${KGroupText.successful} ', () {
      setUp(() {
        mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
        authenticationRepository =
            AuthenticationRepository(mockAppAuthenticationRepository);
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
        when(mockAppAuthenticationRepository.getUserSetting()).thenAnswer(
          (_) async => const UserSetting(id: KTestText.field),
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
          await authenticationRepository.getUserSetting(),
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
    });
    group('${KGroupText.failure} ', () {
      setUp(() {
        mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
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
    });
  });
}
