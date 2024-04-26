import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../text_dependency.dart';

class MockAuthenticationRepositoryUnitTest extends Mock
    implements AuthenticationRepository {
  @override
  User get currentUser {
    return User.empty;
  }

  @override
  Stream<AuthenticationStatus> get status =>
      Stream.value(AuthenticationStatus.unknown);
  @override
  Future<UserSetting> getUserSetting() async {
    return UserSetting.empty;
  }
}

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
          const result = EmailFieldModel.dirty(KTestText.useremailIncorrect);
          expect(
            result.error,
            isNot(EmailFieldModelValidationError.invalidLength),
          );
        });
        test('${KGroupText.shouldBe} wrong', () {
          const result = EmailFieldModel.dirty(KTestText.useremailIncorrect);
          expect(result.error, EmailFieldModelValidationError.wrong);
        });
        test('${KGroupText.shouldNotBe} invalidLength', () {
          const result = EmailFieldModel.dirty(KTestText.useremail);
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
      late AuthenticationRepository mockAuthenticationRepository;
      group('${KGroupText.successfulSet} ', () {
        setUp(() {
          mockAuthenticationRepository = MockAuthenticationRepository();
          when(
            mockAuthenticationRepository.logIn(
              email: KTestText.useremail,
              password: KTestText.passwordCorrect,
            ),
          ).thenAnswer(
            (_) async => const Right(true),
          );
          when(mockAuthenticationRepository.signUpWithGoogle()).thenAnswer(
            (_) async => const Right(true),
          );
          when(mockAuthenticationRepository.getUserSetting()).thenAnswer(
            (_) async => const UserSetting(id: KTestText.field),
          );
        });
        test('Log in', () async {
          expect(
            await mockAuthenticationRepository.logIn(
              email: KTestText.useremail,
              password: KTestText.passwordCorrect,
            ),
            isA<Right<SomeFailure, bool>>()
                .having((e) => e.value, 'value', isTrue),
          );
        });
        test('Sign up with google', () async {
          expect(
            await mockAuthenticationRepository.signUpWithGoogle(),
            isA<Right<SomeFailure, bool>>()
                .having((e) => e.value, 'value', isTrue),
          );
        });
        test('get user setting', () async {
          expect(
            await mockAuthenticationRepository.getUserSetting(),
            const UserSetting(id: KTestText.field),
          );
        });
      });
      group('${KGroupText.failureSet} ', () {
        setUp(() {
          mockAuthenticationRepository = MockAuthenticationRepository();
          when(
            mockAuthenticationRepository.logIn(
              email: KTestText.useremail,
              password: KTestText.passwordCorrect,
            ),
          ).thenAnswer(
            (_) async => const Left(SomeFailure.serverError()),
          );
          when(mockAuthenticationRepository.signUpWithGoogle()).thenAnswer(
            (_) async => const Left(SomeFailure.serverError()),
          );
          when(mockAuthenticationRepository.getUserSetting()).thenAnswer(
            (_) async => UserSetting.empty,
          );
        });
        test('Log in', () async {
          expect(
            await mockAuthenticationRepository.logIn(
              email: KTestText.useremail,
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
            await mockAuthenticationRepository.signUpWithGoogle(),
            isA<Left<SomeFailure, bool>>().having(
              (e) => e.value,
              'value',
              const SomeFailure.serverError(),
            ),
          );
        });
        test('get user setting', () async {
          expect(
            await mockAuthenticationRepository.getUserSetting(),
            UserSetting.empty,
          );
        });
      });
    });
    group('${KScreenBlocName.authenticationBloc} ', () {
      late AuthenticationRepository mockAuthenticationRepository;
      late AuthenticationBloc authenticationBloc;
      setUp(() {
        mockAuthenticationRepository = MockAuthenticationRepositoryUnitTest();
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
          const AuthenticationState.unknown(),
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
          const AuthenticationState.unknown(),
          const AuthenticationState.authenticated(
            currentUser: User.empty,
            currentUserSetting: UserSetting.empty,
          ),
        ],
      );
      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [AuthenticationState.unknown] when'
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
          const AuthenticationState.unknown(),
          const AuthenticationState.unknown().copyWith(
            userSetting: UserSetting.empty.copyWith(locale: Language.english),
          ),
        ],
      );
    });
  });
}
