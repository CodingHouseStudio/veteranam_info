import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import 'package:veteranam/components/login/bloc/login_bloc.dart';
import 'package:veteranam/shared/shared_dart.dart';
import '../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.login} ${KGroupText.bloc}', () {
    late LoginBloc loginBloc;
    late AuthenticationRepository mockAuthenticationRepository;
    setUp(() {
      ExtendedDateTime.current = KTestVariables.feedbackModel.timestamp;
      mockAuthenticationRepository = MockAuthenticationRepository();
      when(
        mockAuthenticationRepository.logIn(
          email: KTestVariables.userEmail,
          password: KTestVariables.passwordCorrect,
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
        ..add(const LoginEvent.emailUpdated(KTestVariables.userEmail))
        ..add(const LoginEvent.loginSubmitted())
        ..add(
          const LoginEvent.passwordUpdated(KTestVariables.passwordIncorrect),
        )
        ..add(const LoginEvent.loginSubmitted()),
      expect: () => [
        const LoginState(
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          password: PasswordFieldModel.pure(),
          failure: null,
          formState: LoginEnum.inProgress,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          password: PasswordFieldModel.pure(),
          failure: null,
          formState: LoginEnum.showPassword,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          password: PasswordFieldModel.dirty(KTestVariables.passwordIncorrect),
          failure: null,
          formState: LoginEnum.passwordInProgress,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          password: PasswordFieldModel.dirty(KTestVariables.passwordIncorrect),
          failure: null,
          formState: LoginEnum.passwordInvalidData,
        ),
      ],
    );
    blocTest<LoginBloc, LoginState>(
      'emits [LoginState] when password invalid are changed, submited',
      build: () => loginBloc,
      act: (bloc) => bloc
        ..add(const LoginEvent.emailUpdated(KTestVariables.userEmailIncorrect))
        ..add(const LoginEvent.loginSubmitted()),
      expect: () => [
        const LoginState(
          email: EmailFieldModel.dirty(KTestVariables.userEmailIncorrect),
          password: PasswordFieldModel.pure(),
          failure: null,
          formState: LoginEnum.inProgress,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestVariables.userEmailIncorrect),
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
        ..add(const LoginEvent.emailUpdated(KTestVariables.userEmail))
        ..add(const LoginEvent.loginSubmitted())
        ..add(const LoginEvent.passwordUpdated(KTestVariables.passwordCorrect))
        ..add(const LoginEvent.loginSubmitted()),
      expect: () => [
        const LoginState(
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          password: PasswordFieldModel.pure(),
          failure: null,
          formState: LoginEnum.inProgress,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          password: PasswordFieldModel.pure(),
          failure: null,
          formState: LoginEnum.showPassword,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          password: PasswordFieldModel.dirty(KTestVariables.passwordCorrect),
          failure: null,
          formState: LoginEnum.passwordInProgress,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          password: PasswordFieldModel.dirty(KTestVariables.passwordCorrect),
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
            email: KTestVariables.userEmail,
            password: KTestVariables.passwordCorrect,
          ),
        ).thenAnswer(
          (realInvocation) async => const Left(SomeFailure.serverError),
        );
        return bloc
          ..add(const LoginEvent.emailUpdated(KTestVariables.userEmail))
          ..add(const LoginEvent.loginSubmitted())
          ..add(
            const LoginEvent.passwordUpdated(KTestVariables.passwordCorrect),
          )
          ..add(const LoginEvent.loginSubmitted());
      },
      expect: () => [
        const LoginState(
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          password: PasswordFieldModel.pure(),
          failure: null,
          formState: LoginEnum.inProgress,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          password: PasswordFieldModel.pure(),
          failure: null,
          formState: LoginEnum.showPassword,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          password: PasswordFieldModel.dirty(KTestVariables.passwordCorrect),
          failure: null,
          formState: LoginEnum.passwordInProgress,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          password: PasswordFieldModel.dirty(KTestVariables.passwordCorrect),
          failure: null,
          formState: LoginEnum.success,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          password: PasswordFieldModel.dirty(KTestVariables.passwordCorrect),
          failure: SomeFailure.serverError,
          formState: LoginEnum.inProgress,
        ),
      ],
    );
    blocTest<LoginBloc, LoginState>(
      'emits [LoginState] when email are changed, submited and hide password',
      build: () => loginBloc,
      act: (bloc) {
        return bloc
          ..add(const LoginEvent.emailUpdated(KTestVariables.userEmail))
          ..add(const LoginEvent.loginSubmitted())
          ..add(const LoginEvent.passwordFieldHide());
      },
      expect: () => [
        const LoginState(
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          password: PasswordFieldModel.pure(),
          failure: null,
          formState: LoginEnum.inProgress,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          password: PasswordFieldModel.pure(),
          failure: null,
          formState: LoginEnum.showPassword,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          password: PasswordFieldModel.pure(),
          failure: null,
          formState: LoginEnum.inProgress,
        ),
      ],
    );
  });
}
