import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/sign_up/bloc/sign_up_bloc.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.signUp} ${KGroupText.bloc}', () {
    late SignUpBloc signUpBloc;
    late AuthenticationRepository mockAuthenticationRepository;
    setUp(() {
      ExtendedDateTime.current = KTestVariables.feedbackModel.timestamp;
      mockAuthenticationRepository = MockAuthenticationRepository();
      when(
        mockAuthenticationRepository.signUp(
          email: KTestVariables.userEmail,
          password: KTestVariables.passwordCorrect,
        ),
      ).thenAnswer(
        (realInvocation) async => const Right(true),
      );
      signUpBloc = SignUpBloc(
        authenticationRepository: mockAuthenticationRepository,
      );
    });

    blocTest<SignUpBloc, SignUpState>(
      'emits [SignUpState] when email are changed, submited and password'
      ' are changed and valid',
      build: () => signUpBloc,
      act: (bloc) => bloc
        ..add(const SignUpEvent.emailUpdated(KTestVariables.userEmail))
        ..add(const SignUpEvent.signUpSubmitted())
        ..add(
          const SignUpEvent.passwordUpdated(KTestVariables.passwordIncorrect),
        )
        ..add(const SignUpEvent.signUpSubmitted()),
      expect: () => [
        const SignUpState(
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          password: PasswordFieldModel.pure(),
          failure: null,
          formState: SignUpEnum.inProgress,
        ),
        const SignUpState(
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          password: PasswordFieldModel.pure(),
          failure: null,
          formState: SignUpEnum.showPassword,
        ),
        const SignUpState(
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          password: PasswordFieldModel.dirty(KTestVariables.passwordIncorrect),
          failure: null,
          formState: SignUpEnum.passwordInProgress,
        ),
        const SignUpState(
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          password: PasswordFieldModel.dirty(KTestVariables.passwordIncorrect),
          failure: null,
          formState: SignUpEnum.passwordInvalidData,
        ),
      ],
    );
    blocTest<SignUpBloc, SignUpState>(
      'emits [SignUpState] when password invalid are changed, submited',
      build: () => signUpBloc,
      act: (bloc) => bloc
        ..add(const SignUpEvent.emailUpdated(KTestVariables.userEmailIncorrect))
        ..add(const SignUpEvent.signUpSubmitted()),
      expect: () => [
        const SignUpState(
          email: EmailFieldModel.dirty(KTestVariables.userEmailIncorrect),
          password: PasswordFieldModel.pure(),
          failure: null,
          formState: SignUpEnum.inProgress,
        ),
        const SignUpState(
          email: EmailFieldModel.dirty(KTestVariables.userEmailIncorrect),
          password: PasswordFieldModel.pure(),
          failure: null,
          formState: SignUpEnum.invalidData,
        ),
      ],
    );

    blocTest<SignUpBloc, SignUpState>(
      'emits [SignUpState] when email are changed, submited and password'
      ' are changed valid and submited',
      build: () => signUpBloc,
      act: (bloc) => bloc
        ..add(const SignUpEvent.emailUpdated(KTestVariables.userEmail))
        ..add(const SignUpEvent.signUpSubmitted())
        ..add(const SignUpEvent.passwordUpdated(KTestVariables.passwordCorrect))
        ..add(const SignUpEvent.signUpSubmitted()),
      expect: () => [
        const SignUpState(
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          password: PasswordFieldModel.pure(),
          failure: null,
          formState: SignUpEnum.inProgress,
        ),
        const SignUpState(
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          password: PasswordFieldModel.pure(),
          failure: null,
          formState: SignUpEnum.showPassword,
        ),
        const SignUpState(
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          password: PasswordFieldModel.dirty(KTestVariables.passwordCorrect),
          failure: null,
          formState: SignUpEnum.passwordInProgress,
        ),
        const SignUpState(
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          password: PasswordFieldModel.dirty(KTestVariables.passwordCorrect),
          failure: null,
          formState: SignUpEnum.success,
        ),
        const SignUpState(
          email: EmailFieldModel.pure(),
          password: PasswordFieldModel.pure(),
          failure: null,
          formState: SignUpEnum.success,
        ),
      ],
    );
    blocTest<SignUpBloc, SignUpState>(
      'emits [SignUpState] when email are changed, submited and password'
      ' are changed valid and submited failure',
      build: () => signUpBloc,
      act: (bloc) {
        when(
          mockAuthenticationRepository.signUp(
            email: KTestVariables.userEmail,
            password: KTestVariables.passwordCorrect,
          ),
        ).thenAnswer(
          (realInvocation) async => Left(
            SomeFailure.serverError(
              error: null,
            ),
          ),
        );
        return bloc
          ..add(const SignUpEvent.emailUpdated(KTestVariables.userEmail))
          ..add(const SignUpEvent.signUpSubmitted())
          ..add(
            const SignUpEvent.passwordUpdated(KTestVariables.passwordCorrect),
          )
          ..add(const SignUpEvent.signUpSubmitted());
      },
      expect: () => [
        const SignUpState(
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          password: PasswordFieldModel.pure(),
          failure: null,
          formState: SignUpEnum.inProgress,
        ),
        const SignUpState(
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          password: PasswordFieldModel.pure(),
          failure: null,
          formState: SignUpEnum.showPassword,
        ),
        const SignUpState(
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          password: PasswordFieldModel.dirty(KTestVariables.passwordCorrect),
          failure: null,
          formState: SignUpEnum.passwordInProgress,
        ),
        const SignUpState(
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          password: PasswordFieldModel.dirty(KTestVariables.passwordCorrect),
          failure: null,
          formState: SignUpEnum.success,
        ),
        const SignUpState(
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          password: PasswordFieldModel.dirty(KTestVariables.passwordCorrect),
          failure: SignUpError.error,
          formState: SignUpEnum.inProgress,
        ),
      ],
    );
    blocTest<SignUpBloc, SignUpState>(
      'emits [SignUpState] when email are changed, submited and hide password',
      build: () => signUpBloc,
      act: (bloc) {
        return bloc
          ..add(const SignUpEvent.emailUpdated(KTestVariables.userEmail))
          ..add(const SignUpEvent.signUpSubmitted())
          ..add(const SignUpEvent.passwordFieldHide());
      },
      expect: () => [
        const SignUpState(
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          password: PasswordFieldModel.pure(),
          failure: null,
          formState: SignUpEnum.inProgress,
        ),
        const SignUpState(
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          password: PasswordFieldModel.pure(),
          failure: null,
          formState: SignUpEnum.showPassword,
        ),
        const SignUpState(
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          password: PasswordFieldModel.pure(),
          failure: null,
          formState: SignUpEnum.inProgress,
        ),
      ],
    );
  });
}
