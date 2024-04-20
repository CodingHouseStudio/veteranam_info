import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../text_dependency.dart';

void main() {
  group('${KScreenBlocName.iAppAuthenticationRepository} ', () {
    group('${KGroupText.model} ', () {
      test('${KGroupText.shouldBe} ${KGroupText.modelJson}', () {
        final json = {
          'id': KTestText.user.id,
          'email': KTestText.user.email,
          'name': KTestText.user.name,
          'photo': KTestText.user.photo,
          'phoneNumber': KTestText.user.phoneNumber,
        };

        final user = User.fromJson(json);

        expect(user.id, KTestText.user.id);
        expect(user.email, KTestText.user.email);
        expect(user.name, KTestText.user.name);
        expect(user.phoneNumber, KTestText.user.phoneNumber);
        expect(user.photo, KTestText.user.photo);
      });
      test('${KGroupText.shouldBe} ${KGroupText.modelJson}', () {
        final json = {
          'id': KTestText.user.id,
        };

        final user = User.fromJson(json);

        expect(user.id, KTestText.user.id);
        expect(user.email, isNull);
        expect(user.name, isNull);
        expect(user.phoneNumber, isNull);
        expect(user.photo, isNull);
      });

      test('${KGroupText.shouldNotBe} ${KGroupText.modelJson}', () {
        final json = {
          'email': KTestText.user.email,
          'name': KTestText.user.name,
          'photo': KTestText.user.photo,
          'phoneNumber': KTestText.user.phoneNumber,
        };

        expect(
          () => QuestionModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group(' ${KGroupText.repository} ', () {
      late IAppAuthenticationRepository mockAppAuthenticationRepository;
      group('${KGroupText.successfulSet} ', () {
        setUp(() {
          mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
          when(mockAppAuthenticationRepository.signUpWithGoogle()).thenAnswer(
            (_) async => const Right(true),
          );
          when(
            mockAppAuthenticationRepository.logInWithEmailAndPassword(
              email: KTestText.useremail,
              password: KTestText.passwordCorrect,
            ),
          ).thenAnswer(
            (_) async => const Right(true),
          );
          when(
            mockAppAuthenticationRepository.signUp(
              email: KTestText.useremail,
              password: KTestText.passwordCorrect,
            ),
          ).thenAnswer(
            (_) async => const Right(true),
          );
          when(
            mockAppAuthenticationRepository.isLoggedIn(),
          ).thenAnswer(
            (_) async => true,
          );
          when(
            mockAppAuthenticationRepository.logOut(),
          ).thenAnswer(
            (_) async => const Right(true),
          );
          when(
            mockAppAuthenticationRepository.getUser(),
          ).thenAnswer(
            (_) async => KTestText.useremail,
          );
          when(
            mockAppAuthenticationRepository.sendVerificationCode(
              email: KTestText.useremail,
            ),
          ).thenAnswer(
            (_) async => const Right(true),
          );
          when(
            mockAppAuthenticationRepository.deleteUser(),
          ).thenAnswer(
            (_) async => const Right(true),
          );
        });
        test('Sign up with google', () async {
          expect(
            await mockAppAuthenticationRepository.signUpWithGoogle(),
            isA<Right<SomeFailure, bool>>()
                .having((e) => e.value, 'value', isTrue),
          );
        });
        test('LogIn with email and password', () async {
          expect(
            await mockAppAuthenticationRepository.logInWithEmailAndPassword(
              email: KTestText.useremail,
              password: KTestText.passwordCorrect,
            ),
            isA<Right<SomeFailure, bool>>()
                .having((e) => e.value, 'value', isTrue),
          );
        });
        test('Sign up', () async {
          expect(
            await mockAppAuthenticationRepository.signUp(
              email: KTestText.useremail,
              password: KTestText.passwordCorrect,
            ),
            isA<Right<SomeFailure, bool>>()
                .having((e) => e.value, 'value', isTrue),
          );
        });
        test('Is logged in', () async {
          expect(
            await mockAppAuthenticationRepository.isLoggedIn(),
            isTrue,
          );
        });
        test('Get user', () async {
          expect(
            await mockAppAuthenticationRepository.getUser(),
            KTestText.useremail,
          );
        });
        test('Send verification code', () async {
          expect(
            await mockAppAuthenticationRepository.sendVerificationCode(
              email: KTestText.useremail,
            ),
            isA<Right<SomeFailure, bool>>()
                .having((e) => e.value, 'value', isTrue),
          );
        });
        test('Delete user', () async {
          expect(
            await mockAppAuthenticationRepository.deleteUser(),
            isA<Right<SomeFailure, bool>>()
                .having((e) => e.value, 'value', isTrue),
          );
        });
      });
      group('${KGroupText.failureSet} ', () {
        setUp(() {
          mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
          when(mockAppAuthenticationRepository.signUpWithGoogle()).thenAnswer(
            (_) async => const Left(SomeFailure.serverError()),
          );
          when(
            mockAppAuthenticationRepository.logInWithEmailAndPassword(
              email: KTestText.useremailIncorrect,
              password: KTestText.passwordIncorrect,
            ),
          ).thenAnswer(
            (_) async => const Left(SomeFailure.serverError()),
          );
          when(
            mockAppAuthenticationRepository.signUp(
              email: KTestText.useremailIncorrect,
              password: KTestText.passwordIncorrect,
            ),
          ).thenAnswer(
            (_) async => const Left(SomeFailure.serverError()),
          );
          when(
            mockAppAuthenticationRepository.isLoggedIn(),
          ).thenAnswer(
            (_) async => false,
          );
          when(
            mockAppAuthenticationRepository.logOut(),
          ).thenAnswer(
            (_) async => const Left(SomeFailure.serverError()),
          );
          when(
            mockAppAuthenticationRepository.getUser(),
          ).thenAnswer(
            (_) async => KTestText.useremailIncorrect,
          );
          when(
            mockAppAuthenticationRepository.sendVerificationCode(
              email: KTestText.useremailIncorrect,
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
        test('Sign up with google', () async {
          expect(
            await mockAppAuthenticationRepository.signUpWithGoogle(),
            isA<Left<SomeFailure, bool>>().having(
              (e) => e.value,
              'value',
              const SomeFailure.serverError(),
            ),
          );
        });
        test('LogIn with email and password', () async {
          expect(
            await mockAppAuthenticationRepository.logInWithEmailAndPassword(
              email: KTestText.useremailIncorrect,
              password: KTestText.passwordIncorrect,
            ),
            isA<Left<SomeFailure, bool>>().having(
              (e) => e.value,
              'value',
              const SomeFailure.serverError(),
            ),
          );
        });
        test('Sign up', () async {
          expect(
            await mockAppAuthenticationRepository.signUp(
              email: KTestText.useremailIncorrect,
              password: KTestText.passwordIncorrect,
            ),
            isA<Left<SomeFailure, bool>>().having(
              (e) => e.value,
              'value',
              const SomeFailure.serverError(),
            ),
          );
        });
        test('Is logged in', () async {
          expect(
            await mockAppAuthenticationRepository.isLoggedIn(),
            isFalse,
          );
        });
        test('Get user', () async {
          expect(
            await mockAppAuthenticationRepository.getUser(),
            KTestText.useremailIncorrect,
          );
        });
        test('Send verification code', () async {
          expect(
            await mockAppAuthenticationRepository.sendVerificationCode(
              email: KTestText.useremailIncorrect,
            ),
            isA<Left<SomeFailure, bool>>().having(
              (e) => e.value,
              'value',
              const SomeFailure.serverError(),
            ),
          );
        });
        test('Delete user', () async {
          expect(
            await mockAppAuthenticationRepository.deleteUser(),
            isA<Left<SomeFailure, bool>>().having(
              (e) => e.value,
              'value',
              const SomeFailure.serverError(),
            ),
          );
        });
      });
    });
  });
}
