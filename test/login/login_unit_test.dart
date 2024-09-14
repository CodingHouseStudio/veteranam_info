import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.login} ${KGroupText.bloc}', () {
    late LoginBloc loginBloc;
    late AuthenticationRepository mockAuthenticationRepository;
    setUp(() {
      ExtendedDateTime.current = KTestText.feedbackModel.timestamp;
      mockAuthenticationRepository = MockAuthenticationRepository();
      when(
        mockAuthenticationRepository.logIn(
          email: KTestText.userEmail,
          password: KTestText.passwordCorrect,
        ),
      ).thenAnswer(
        (realInvocation) async => const Right(true),
      );
      loginBloc = LoginBloc(
        authenticationRepository: mockAuthenticationRepository,
      );
    });

    blocTest<LoginBloc, LoginState>(
      'emits [LoginState] when email are changed, submited and password'
      ' are changed and valid',
      build: () => loginBloc,
      act: (bloc) => bloc
        ..add(const LoginEvent.emailUpdated(KTestText.userEmail))
        ..add(const LoginEvent.loginSubmitted())
        ..add(const LoginEvent.passwordUpdated(KTestText.passwordIncorrect))
        ..add(const LoginEvent.loginSubmitted()),
      expect: () => [
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.pure(),
          failure: null,
          formState: LoginEnum.inProgress,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.pure(),
          failure: null,
          formState: LoginEnum.showPassword,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.dirty(KTestText.passwordIncorrect),
          failure: null,
          formState: LoginEnum.passwordInProgress,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.dirty(KTestText.passwordIncorrect),
          failure: null,
          formState: LoginEnum.passwordInvalidData,
        ),
      ],
    );
    blocTest<LoginBloc, LoginState>(
      'emits [LoginState] when password invalid are changed, submited',
      build: () => loginBloc,
      act: (bloc) => bloc
        ..add(const LoginEvent.emailUpdated(KTestText.userEmailIncorrect))
        ..add(const LoginEvent.loginSubmitted()),
      expect: () => [
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.userEmailIncorrect),
          password: PasswordFieldModel.pure(),
          failure: null,
          formState: LoginEnum.inProgress,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.userEmailIncorrect),
          password: PasswordFieldModel.pure(),
          failure: null,
          formState: LoginEnum.invalidData,
        ),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LoginState] when email are changed, submited and password'
      ' are changed valid and submited',
      build: () => loginBloc,
      act: (bloc) => bloc
        ..add(const LoginEvent.emailUpdated(KTestText.userEmail))
        ..add(const LoginEvent.loginSubmitted())
        ..add(const LoginEvent.passwordUpdated(KTestText.passwordCorrect))
        ..add(const LoginEvent.loginSubmitted()),
      expect: () => [
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.pure(),
          failure: null,
          formState: LoginEnum.inProgress,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.pure(),
          failure: null,
          formState: LoginEnum.showPassword,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          failure: null,
          formState: LoginEnum.passwordInProgress,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          failure: null,
          formState: LoginEnum.success,
        ),
        const LoginState(
          email: EmailFieldModel.pure(),
          password: PasswordFieldModel.pure(),
          failure: null,
          formState: LoginEnum.success,
        ),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LoginState] when email are changed, submited and password'
      ' are changed valid and submited failure',
      build: () => loginBloc,
      act: (bloc) {
        when(
          mockAuthenticationRepository.logIn(
            email: KTestText.userEmail,
            password: KTestText.passwordCorrect,
          ),
        ).thenAnswer(
          (realInvocation) async => Left(
            SomeFailure.serverError(
              error: null,
            ),
          ),
        );
        return bloc
          ..add(const LoginEvent.emailUpdated(KTestText.userEmail))
          ..add(const LoginEvent.loginSubmitted())
          ..add(const LoginEvent.passwordUpdated(KTestText.passwordCorrect))
          ..add(const LoginEvent.loginSubmitted());
      },
      expect: () => [
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.pure(),
          failure: null,
          formState: LoginEnum.inProgress,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.pure(),
          failure: null,
          formState: LoginEnum.showPassword,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          failure: null,
          formState: LoginEnum.passwordInProgress,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          failure: null,
          formState: LoginEnum.success,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          failure: LoginError.error,
          formState: LoginEnum.initial,
        ),
      ],
    );
    blocTest<LoginBloc, LoginState>(
      'emits [LoginState] when email are changed, submited and hide password',
      build: () => loginBloc,
      act: (bloc) {
        return bloc
          ..add(const LoginEvent.emailUpdated(KTestText.userEmail))
          ..add(const LoginEvent.loginSubmitted())
          ..add(const LoginEvent.passwordFieldHide());
      },
      expect: () => [
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.pure(),
          failure: null,
          formState: LoginEnum.inProgress,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.pure(),
          failure: null,
          formState: LoginEnum.showPassword,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.pure(),
          failure: null,
          formState: LoginEnum.inProgress,
        ),
      ],
    );
  });
}
