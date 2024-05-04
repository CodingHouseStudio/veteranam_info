import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  group('${KScreenBlocName.authentication} ', () {
    group('${KGroupText.fiedlModel} ', () {
      group('Password ${KGroupText.validationError}', () {
        test('${KGroupText.shouldBe} ${KGroupText.empty}', () {
          const result = PasswordFieldModel.pure();
          expect(result.error, PasswordFieldModelValidationError.empty);
        });
        test('${KGroupText.shouldBe} ${KGroupText.empty}', () {
          const result = PasswordFieldModel.dirty();
          expect(result.error, PasswordFieldModelValidationError.empty);
        });
        test('${KGroupText.shouldBe} invalidLength', () {
          const result = PasswordFieldModel.dirty(KTestText.shortPassword);
          expect(
            result.error,
            PasswordFieldModelValidationError.invalidLength,
          );
        });
        test('${KGroupText.shouldBe} capitalLetter', () {
          const result = PasswordFieldModel.dirty(KTestText.passwordIncorrect);
          expect(
            result.error,
            PasswordFieldModelValidationError.capitalLetter,
          );
        });
        test('${KGroupText.shouldBe} capitalLetter', () {
          const result =
              PasswordFieldModel.dirty(KTestText.passwordIncorrectNumber);
          expect(
            result.error,
            PasswordFieldModelValidationError.oneNumber,
          );
        });
        test('${KGroupText.shouldBe} correct', () {
          const result = PasswordFieldModel.dirty(KTestText.passwordCorrect);
          expect(
            result.error,
            null,
          );
        });
      });
      group('Email ${KGroupText.validationError}', () {
        test('${KGroupText.shouldBe} ${KGroupText.empty}', () {
          const result = EmailFieldModel.pure();
          expect(result.error, EmailFieldModelValidationError.empty);
        });
        test('${KGroupText.shouldBe} ${KGroupText.empty}', () {
          const result = EmailFieldModel.dirty();
          expect(result.error, EmailFieldModelValidationError.empty);
        });
        test('${KGroupText.shouldNotBe} ${KGroupText.empty}', () {
          const result = EmailFieldModel.dirty(KTestText.field);
          expect(result.error, isNot(EmailFieldModelValidationError.empty));
        });
        test('${KGroupText.shouldBe} invalidLength', () {
          const result = EmailFieldModel.dirty(KTestText.shortUserEmail);
          expect(result.error, EmailFieldModelValidationError.invalidLength);
        });
        test('${KGroupText.shouldNotBe} invalidLength', () {
          const result = EmailFieldModel.dirty(KTestText.userEmailIncorrect);
          expect(
            result.error,
            isNot(EmailFieldModelValidationError.invalidLength),
          );
        });
        test('${KGroupText.shouldBe} wrong', () {
          const result = EmailFieldModel.dirty(KTestText.userEmailIncorrect);
          expect(result.error, EmailFieldModelValidationError.wrong);
        });
        test('${KGroupText.shouldNotBe} invalidLength', () {
          const result = EmailFieldModel.dirty(KTestText.userEmail);
          expect(
            result.error,
            null,
          );
        });
      });
      group('Message ${KGroupText.validationError}', () {
        test('${KGroupText.shouldBe} ${KGroupText.empty}', () {
          const result = MessageFieldModel.pure();
          expect(result.error, MessageFieldModelValidationError.empty);
        });
        test('${KGroupText.shouldBe} ${KGroupText.empty}', () {
          const result = MessageFieldModel.dirty();
          expect(result.error, MessageFieldModelValidationError.empty);
        });
        test('${KGroupText.shouldNotBe} ${KGroupText.empty}', () {
          const result = MessageFieldModel.dirty(KTestText.field);
          expect(result.error, isNot(MessageFieldModelValidationError.empty));
        });
      });
    });
    group('${KGroupText.repository} ', () {
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

    group('${KScreenBlocName.authenticationBloc} ', () {
      late AuthenticationRepository mockAuthenticationRepository;
      late AuthenticationBloc authenticationBloc;
      setUp(() {
        mockAuthenticationRepository = MockAuthenticationRepository();
        when(mockAuthenticationRepository.currentUser).thenAnswer(
          (realInvocation) => KTestText.user,
        );
        when(mockAuthenticationRepository.getUserSetting()).thenAnswer(
          (realInvocation) async => KTestText.userSetting,
        );
        when(
          mockAuthenticationRepository.updateUserSetting(
            userSetting: UserSetting.empty.copyWith(locale: Language.english),
          ),
        ).thenAnswer(
          (realInvocation) async => const Right(true),
        );
        authenticationBloc = AuthenticationBloc(
          authenticationRepository: mockAuthenticationRepository,
        )..add(AuthenticationInitialized());
      });
      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [AuthenticationState.unauthenticated] when'
        ' AuthenticationStatusChanged',
        build: () => authenticationBloc,
        act: (bloc) async {
          bloc.add(
            const AuthenticationStatusChanged(
              AuthenticationStatus.unauthenticated,
            ),
          );
        },
        expect: () async => [
          const AuthenticationState.unauthenticated(),
        ],
      );
      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [AuthenticationState.authenticated] when'
        ' AuthenticationStatusChanged',
        build: () => authenticationBloc,
        act: (bloc) async {
          bloc.add(
            const AuthenticationStatusChanged(
              AuthenticationStatus.authenticated,
            ),
          );
        },
        expect: () async => [
          const AuthenticationState.authenticated(
            currentUser: KTestText.user,
            currentUserSetting: KTestText.userSetting,
          ),
        ],
      );
      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [AuthenticationState] when'
        ' AuthenticationStatusChanged',
        build: () => authenticationBloc,
        act: (bloc) async {
          bloc.add(
            const AuthenticationStatusChanged(
              AuthenticationStatus.unknown,
            ),
          );
        },
        expect: () async => [
          const AuthenticationState.unknown(),
        ],
      );
      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [AuthenticationState] when'
        ' AppLanguageChanged',
        build: () => authenticationBloc,
        act: (bloc) async {
          bloc.add(
            const AppLanguageChanged(
              Language.english,
            ),
          );
        },
        expect: () async => [
          AuthenticationState.authenticated(
            currentUser: KTestText.user,
            currentUserSetting:
                KTestText.userSetting.copyWith(locale: Language.english),
          ),
        ],
      );
    });
  });
}
