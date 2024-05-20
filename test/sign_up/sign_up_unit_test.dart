import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../text_dependency.dart';

void main() {
  group('${KScreenBlocName.signUp} ${KGroupText.bloc}', () {
    late SignUpBloc signUpBloc;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    setUp(() {
      ExtendedDateTime.current = KTestText.feedbackModel.timestamp;
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
      when(
        mockAppAuthenticationRepository.signUp(
          email: KTestText.userEmail,
          password: KTestText.passwordCorrect,
        ),
      ).thenAnswer(
        (realInvocation) async => const Right(true),
      );
      signUpBloc = SignUpBloc(
        iAppAuthenticationRepository: mockAppAuthenticationRepository,
      );
    });

    blocTest<SignUpBloc, SignUpState>(
      'emits [SignUpState] when email are changed, submited and password'
      ' are changed and valid',
      build: () => signUpBloc,
      act: (bloc) => bloc
        ..add(const SignUpEvent.emailUpdated(KTestText.userEmail))
        ..add(const SignUpEvent.signUpSubmitted())
        ..add(const SignUpEvent.passwordUpdated(KTestText.passwordCorrect)),
      expect: () => [
        const SignUpState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.pure(),
          failure: SignUpError.initial,
          fieldsIsCorrect: null,
          showPasswordField: false,
        ),
        const SignUpState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.pure(),
          failure: SignUpError.initial,
          fieldsIsCorrect: null,
          showPasswordField: true,
        ),
        const SignUpState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          failure: SignUpError.initial,
          fieldsIsCorrect: null,
          showPasswordField: true,
        ),
      ],
    );
    blocTest<SignUpBloc, SignUpState>(
      'emits [SignUpState] when password invalid are changed, submited',
      build: () => signUpBloc,
      act: (bloc) => bloc
        ..add(const SignUpEvent.emailUpdated(KTestText.userEmailIncorrect))
        ..add(const SignUpEvent.signUpSubmitted()),
      expect: () => [
        const SignUpState(
          email: EmailFieldModel.dirty(KTestText.userEmailIncorrect),
          password: PasswordFieldModel.pure(),
          failure: SignUpError.initial,
          fieldsIsCorrect: null,
          showPasswordField: false,
        ),
        const SignUpState(
          email: EmailFieldModel.dirty(KTestText.userEmailIncorrect),
          password: PasswordFieldModel.pure(),
          failure: SignUpError.initial,
          fieldsIsCorrect: false,
          showPasswordField: false,
        ),
      ],
    );

    blocTest<SignUpBloc, SignUpState>(
      'emits [SignUpState] when email are changed, submited and password'
      ' are changed valid and submited',
      build: () => signUpBloc,
      act: (bloc) => bloc
        ..add(const SignUpEvent.emailUpdated(KTestText.userEmail))
        ..add(const SignUpEvent.signUpSubmitted())
        ..add(const SignUpEvent.passwordUpdated(KTestText.passwordCorrect))
        ..add(const SignUpEvent.signUpSubmitted()),
      expect: () => [
        const SignUpState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.pure(),
          failure: SignUpError.initial,
          fieldsIsCorrect: null,
          showPasswordField: false,
        ),
        const SignUpState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.pure(),
          failure: SignUpError.initial,
          fieldsIsCorrect: null,
          showPasswordField: true,
        ),
        const SignUpState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          failure: SignUpError.initial,
          fieldsIsCorrect: null,
          showPasswordField: true,
        ),
        const SignUpState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          failure: SignUpError.initial,
          fieldsIsCorrect: true,
          showPasswordField: true,
        ),
        const SignUpState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          failure: SignUpError.none,
          fieldsIsCorrect: true,
          showPasswordField: false,
        ),
      ],
    );
    blocTest<SignUpBloc, SignUpState>(
      'emits [SignUpState] when email are changed, submited and password'
      ' are changed valid and submited failure',
      build: () => signUpBloc,
      act: (bloc) {
        when(
          mockAppAuthenticationRepository.signUp(
            email: KTestText.userEmail,
            password: KTestText.passwordCorrect,
          ),
        ).thenAnswer(
          (realInvocation) async => const Left(SomeFailure.serverError()),
        );
        return bloc
          ..add(const SignUpEvent.emailUpdated(KTestText.userEmail))
          ..add(const SignUpEvent.signUpSubmitted())
          ..add(const SignUpEvent.passwordUpdated(KTestText.passwordCorrect))
          ..add(const SignUpEvent.signUpSubmitted());
      },
      expect: () => [
        const SignUpState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.pure(),
          failure: SignUpError.initial,
          fieldsIsCorrect: null,
          showPasswordField: false,
        ),
        const SignUpState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.pure(),
          failure: SignUpError.initial,
          fieldsIsCorrect: null,
          showPasswordField: true,
        ),
        const SignUpState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          failure: SignUpError.initial,
          fieldsIsCorrect: null,
          showPasswordField: true,
        ),
        const SignUpState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          failure: SignUpError.initial,
          fieldsIsCorrect: true,
          showPasswordField: true,
        ),
        const SignUpState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          failure: SignUpError.error,
          fieldsIsCorrect: true,
          showPasswordField: false,
        ),
      ],
    );
    blocTest<SignUpBloc, SignUpState>(
      'emits [SignUpState] when email are changed, submited and hide password',
      build: () => signUpBloc,
      act: (bloc) {
        return bloc
          ..add(const SignUpEvent.emailUpdated(KTestText.userEmail))
          ..add(const SignUpEvent.signUpSubmitted())
          ..add(const SignUpEvent.passwordFieldHide());
      },
      expect: () => [
        const SignUpState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.pure(),
          failure: SignUpError.initial,
          fieldsIsCorrect: null,
          showPasswordField: false,
        ),
        const SignUpState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.pure(),
          failure: SignUpError.initial,
          fieldsIsCorrect: null,
          showPasswordField: true,
        ),
        const SignUpState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          password: PasswordFieldModel.pure(),
          failure: SignUpError.initial,
          fieldsIsCorrect: null,
          showPasswordField: false,
        ),
      ],
    );
  });
}
