import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../text_dependency.dart';

void main() {
  group('${KScreenBlocName.loginBloc} ', () {
    late LoginBloc loginBloc;
    late AuthenticationRepository mockAuthenticationRepository;
    setUp(() {
      ExtendedDateTime.customTime = KTestText.feedbackModel.timestamp;
      mockAuthenticationRepository = MockAuthenticationRepository();
      when(
        mockAuthenticationRepository.logIn(
          email: KTestText.useremail,
          password: KTestText.passwordCorrect,
        ),
      ).thenAnswer(
        (realInvocation) async => const Right(true),
      );
      loginBloc =
          LoginBloc(authenticationRepository: mockAuthenticationRepository);
    });

    blocTest<LoginBloc, LoginState>(
      'emits [LoginState] when email are changed, submited and password'
      ' are changed and valid',
      build: () => loginBloc,
      act: (bloc) => bloc
        ..add(const LoginEvent.emailUpdated(KTestText.useremail))
        ..add(const LoginEvent.loginSubmitted())
        ..add(const LoginEvent.passwordUpdated(KTestText.passwordCorrect)),
      expect: () => [
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.useremail),
          password: PasswordFieldModel.pure(),
          failure: LoginError.initial,
          fieldsState: FieldEnum.inProgress,
          showPassword: false,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.useremail),
          password: PasswordFieldModel.pure(),
          failure: LoginError.initial,
          fieldsState: FieldEnum.initial,
          showPassword: true,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.useremail),
          password: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          failure: LoginError.initial,
          fieldsState: FieldEnum.inProgress,
          showPassword: true,
        ),
      ],
    );
    blocTest<LoginBloc, LoginState>(
      'emits [LoginState] when password invalid are changed, submited',
      build: () => loginBloc,
      act: (bloc) => bloc
        ..add(const LoginEvent.emailUpdated(KTestText.useremailIncorrect))
        ..add(const LoginEvent.loginSubmitted()),
      expect: () => [
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.useremailIncorrect),
          password: PasswordFieldModel.pure(),
          failure: LoginError.initial,
          fieldsState: FieldEnum.inProgress,
          showPassword: false,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.useremailIncorrect),
          password: PasswordFieldModel.pure(),
          failure: LoginError.initial,
          fieldsState: FieldEnum.invalidData,
          showPassword: false,
        ),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LoginState] when email are changed, submited and password'
      ' are changed valid and submited',
      build: () => loginBloc,
      act: (bloc) => bloc
        ..add(const LoginEvent.emailUpdated(KTestText.useremail))
        ..add(const LoginEvent.loginSubmitted())
        ..add(const LoginEvent.passwordUpdated(KTestText.passwordCorrect))
        ..add(const LoginEvent.loginSubmitted()),
      expect: () => [
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.useremail),
          password: PasswordFieldModel.pure(),
          failure: LoginError.initial,
          fieldsState: FieldEnum.inProgress,
          showPassword: false,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.useremail),
          password: PasswordFieldModel.pure(),
          failure: LoginError.initial,
          fieldsState: FieldEnum.initial,
          showPassword: true,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.useremail),
          password: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          failure: LoginError.initial,
          fieldsState: FieldEnum.inProgress,
          showPassword: true,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.useremail),
          password: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          failure: LoginError.initial,
          fieldsState: FieldEnum.success,
          showPassword: true,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.useremail),
          password: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          failure: LoginError.none,
          fieldsState: FieldEnum.success,
          showPassword: true,
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
            email: KTestText.useremail,
            password: KTestText.passwordCorrect,
          ),
        ).thenAnswer(
          (realInvocation) async => const Left(SomeFailure.serverError()),
        );
        return bloc
          ..add(const LoginEvent.emailUpdated(KTestText.useremail))
          ..add(const LoginEvent.loginSubmitted())
          ..add(const LoginEvent.passwordUpdated(KTestText.passwordCorrect))
          ..add(const LoginEvent.loginSubmitted());
      },
      expect: () => [
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.useremail),
          password: PasswordFieldModel.pure(),
          failure: LoginError.initial,
          fieldsState: FieldEnum.inProgress,
          showPassword: false,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.useremail),
          password: PasswordFieldModel.pure(),
          failure: LoginError.initial,
          fieldsState: FieldEnum.initial,
          showPassword: true,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.useremail),
          password: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          failure: LoginError.initial,
          fieldsState: FieldEnum.inProgress,
          showPassword: true,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.useremail),
          password: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          failure: LoginError.initial,
          fieldsState: FieldEnum.success,
          showPassword: true,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.useremail),
          password: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          failure: LoginError.error,
          fieldsState: FieldEnum.invalidData,
          showPassword: false,
        ),
      ],
    );
    blocTest<LoginBloc, LoginState>(
      'emits [LoginState] when email are changed, submited and hide password',
      build: () => loginBloc,
      act: (bloc) {
        return bloc
          ..add(const LoginEvent.emailUpdated(KTestText.useremail))
          ..add(const LoginEvent.loginSubmitted())
          ..add(const LoginEvent.passwordHide());
      },
      expect: () => [
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.useremail),
          password: PasswordFieldModel.pure(),
          failure: LoginError.initial,
          fieldsState: FieldEnum.inProgress,
          showPassword: false,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.useremail),
          password: PasswordFieldModel.pure(),
          failure: LoginError.initial,
          fieldsState: FieldEnum.initial,
          showPassword: true,
        ),
        const LoginState(
          email: EmailFieldModel.dirty(KTestText.useremail),
          password: PasswordFieldModel.pure(),
          failure: LoginError.initial,
          fieldsState: FieldEnum.inProgress,
          showPassword: false,
        ),
      ],
    );
  });
}
