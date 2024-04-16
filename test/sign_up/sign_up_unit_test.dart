import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../text_dependency.dart';

void main() {
  group('${KScreenBlocName.signUpBloc} ', () {
    late SignUpBloc signUpBloc;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    setUp(() {
      ExtendedDateTime.customTime = KTestText.feedbackModel.timestamp;
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
      when(
        mockAppAuthenticationRepository.signUp(
          email: KTestText.useremail,
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
        ..add(const SignUpEvent.emailUpdated(KTestText.useremail))
        ..add(const SignUpEvent.signUpSubmitted())
        ..add(const SignUpEvent.passwordUpdated(KTestText.passwordCorrect)),
      expect: () => [
        const SignUpState(
          email: EmailFieldModel.dirty(KTestText.useremail),
          password: PasswordFieldModel.pure(),
          failure: SignUpError.initial,
          fieldsState: FieldEnum.inProgress,
          showPassword: false,
        ),
        const SignUpState(
          email: EmailFieldModel.dirty(KTestText.useremail),
          password: PasswordFieldModel.pure(),
          failure: SignUpError.initial,
          fieldsState: FieldEnum.initial,
          showPassword: true,
        ),
        const SignUpState(
          email: EmailFieldModel.dirty(KTestText.useremail),
          password: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          failure: SignUpError.initial,
          fieldsState: FieldEnum.inProgress,
          showPassword: true,
        ),
      ],
    );
    blocTest<SignUpBloc, SignUpState>(
      'emits [SignUpState] when password invalid are changed, submited',
      build: () => signUpBloc,
      act: (bloc) => bloc
        ..add(const SignUpEvent.emailUpdated(KTestText.useremailIncorrect))
        ..add(const SignUpEvent.signUpSubmitted()),
      expect: () => [
        const SignUpState(
          email: EmailFieldModel.dirty(KTestText.useremailIncorrect),
          password: PasswordFieldModel.pure(),
          failure: SignUpError.initial,
          fieldsState: FieldEnum.inProgress,
          showPassword: false,
        ),
        const SignUpState(
          email: EmailFieldModel.dirty(KTestText.useremailIncorrect),
          password: PasswordFieldModel.pure(),
          failure: SignUpError.initial,
          fieldsState: FieldEnum.invalidData,
          showPassword: false,
        ),
      ],
    );

    blocTest<SignUpBloc, SignUpState>(
      'emits [SignUpState] when email are changed, submited and password'
      ' are changed valid and submited',
      build: () => signUpBloc,
      act: (bloc) => bloc
        ..add(const SignUpEvent.emailUpdated(KTestText.useremail))
        ..add(const SignUpEvent.signUpSubmitted())
        ..add(const SignUpEvent.passwordUpdated(KTestText.passwordCorrect))
        ..add(const SignUpEvent.signUpSubmitted()),
      expect: () => [
        const SignUpState(
          email: EmailFieldModel.dirty(KTestText.useremail),
          password: PasswordFieldModel.pure(),
          failure: SignUpError.initial,
          fieldsState: FieldEnum.inProgress,
          showPassword: false,
        ),
        const SignUpState(
          email: EmailFieldModel.dirty(KTestText.useremail),
          password: PasswordFieldModel.pure(),
          failure: SignUpError.initial,
          fieldsState: FieldEnum.initial,
          showPassword: true,
        ),
        const SignUpState(
          email: EmailFieldModel.dirty(KTestText.useremail),
          password: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          failure: SignUpError.initial,
          fieldsState: FieldEnum.inProgress,
          showPassword: true,
        ),
        const SignUpState(
          email: EmailFieldModel.dirty(KTestText.useremail),
          password: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          failure: SignUpError.initial,
          fieldsState: FieldEnum.success,
          showPassword: true,
        ),
        const SignUpState(
          email: EmailFieldModel.dirty(KTestText.useremail),
          password: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          failure: SignUpError.none,
          fieldsState: FieldEnum.success,
          showPassword: true,
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
            email: KTestText.useremail,
            password: KTestText.passwordCorrect,
          ),
        ).thenAnswer(
          (realInvocation) async => const Left(SomeFailure.serverError()),
        );
        return bloc
          ..add(const SignUpEvent.emailUpdated(KTestText.useremail))
          ..add(const SignUpEvent.signUpSubmitted())
          ..add(const SignUpEvent.passwordUpdated(KTestText.passwordCorrect))
          ..add(const SignUpEvent.signUpSubmitted());
      },
      expect: () => [
        const SignUpState(
          email: EmailFieldModel.dirty(KTestText.useremail),
          password: PasswordFieldModel.pure(),
          failure: SignUpError.initial,
          fieldsState: FieldEnum.inProgress,
          showPassword: false,
        ),
        const SignUpState(
          email: EmailFieldModel.dirty(KTestText.useremail),
          password: PasswordFieldModel.pure(),
          failure: SignUpError.initial,
          fieldsState: FieldEnum.initial,
          showPassword: true,
        ),
        const SignUpState(
          email: EmailFieldModel.dirty(KTestText.useremail),
          password: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          failure: SignUpError.initial,
          fieldsState: FieldEnum.inProgress,
          showPassword: true,
        ),
        const SignUpState(
          email: EmailFieldModel.dirty(KTestText.useremail),
          password: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          failure: SignUpError.initial,
          fieldsState: FieldEnum.success,
          showPassword: true,
        ),
        const SignUpState(
          email: EmailFieldModel.dirty(KTestText.useremail),
          password: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          failure: SignUpError.error,
          fieldsState: FieldEnum.invalidData,
          showPassword: false,
        ),
      ],
    );
    blocTest<SignUpBloc, SignUpState>(
      'emits [SignUpState] when email are changed, submited and hide password',
      build: () => signUpBloc,
      act: (bloc) {
        return bloc
          ..add(const SignUpEvent.emailUpdated(KTestText.useremail))
          ..add(const SignUpEvent.signUpSubmitted())
          ..add(const SignUpEvent.passwordHide());
      },
      expect: () => [
        const SignUpState(
          email: EmailFieldModel.dirty(KTestText.useremail),
          password: PasswordFieldModel.pure(),
          failure: SignUpError.initial,
          fieldsState: FieldEnum.inProgress,
          showPassword: false,
        ),
        const SignUpState(
          email: EmailFieldModel.dirty(KTestText.useremail),
          password: PasswordFieldModel.pure(),
          failure: SignUpError.initial,
          fieldsState: FieldEnum.initial,
          showPassword: true,
        ),
        const SignUpState(
          email: EmailFieldModel.dirty(KTestText.useremail),
          password: PasswordFieldModel.pure(),
          failure: SignUpError.initial,
          fieldsState: FieldEnum.inProgress,
          showPassword: false,
        ),
      ],
    );
  });
}
