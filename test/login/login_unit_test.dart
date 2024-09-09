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
        ..add(const LoginEvent.passwordUpdated(KTestText.passwordCorrect)),
      expect: () => [
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.pure(),
          failure: null,
          fieldsIsCorrect: null,
          showPasswordField: false,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.pure(),
          failure: null,
          fieldsIsCorrect: null,
          showPasswordField: true,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          failure: null,
          fieldsIsCorrect: null,
          showPasswordField: true,
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
          fieldsIsCorrect: null,
          showPasswordField: false,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.userEmailIncorrect),
          password: PasswordFieldModel.pure(),
          failure: null,
          showPasswordField: false,
          fieldsIsCorrect: false,
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
          fieldsIsCorrect: null,
          showPasswordField: false,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.pure(),
          failure: null,
          fieldsIsCorrect: null,
          showPasswordField: true,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          failure: null,
          fieldsIsCorrect: null,
          showPasswordField: true,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          failure: null,
          fieldsIsCorrect: true,
          showPasswordField: true,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          failure: null,
          fieldsIsCorrect: true,
          showPasswordField: false,
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
          fieldsIsCorrect: null,
          showPasswordField: false,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.pure(),
          failure: null,
          fieldsIsCorrect: null,
          showPasswordField: true,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          failure: null,
          fieldsIsCorrect: null,
          showPasswordField: true,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          failure: null,
          fieldsIsCorrect: true,
          showPasswordField: true,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          failure: LoginError.error,
          fieldsIsCorrect: true,
          showPasswordField: false,
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
          fieldsIsCorrect: null,
          showPasswordField: false,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.pure(),
          failure: null,
          fieldsIsCorrect: null,
          showPasswordField: true,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.pure(),
          failure: null,
          fieldsIsCorrect: null,
          showPasswordField: false,
        ),
      ],
    );
  });
}
