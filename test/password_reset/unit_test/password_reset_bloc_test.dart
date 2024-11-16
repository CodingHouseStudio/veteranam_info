import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/password_reset/bloc/form/password_reset_bloc.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.passwordReset} ${KGroupText.bloc}', () {
    late PasswordResetBloc passwordResetBloc;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    setUp(() {
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
      when(
        mockAppAuthenticationRepository.resetPasswordUseCode(
          code: KTestText.code,
          newPassword: KTestText.passwordCorrect,
        ),
      ).thenAnswer(
        (realInvocation) async => const Right(true),
      );
      passwordResetBloc = PasswordResetBloc(
        appAuthenticationRepository: mockAppAuthenticationRepository,
      );
    });

    blocTest<PasswordResetBloc, PasswordResetState>(
      'emits [PasswordResetState] when password and confirm password changed'
      ' valid and reset Password',
      build: () => passwordResetBloc,
      act: (bloc) async => bloc
        ..add(
          const PasswordResetEvent.passwordUpdated(
            KTestText.passwordCorrect,
          ),
        )
        ..add(
          const PasswordResetEvent.confirmPasswordUpdated(
            KTestText.passwordCorrect,
          ),
        )
        ..add(const PasswordResetEvent.passwordReset(KTestText.code)),
      expect: () => [
        const PasswordResetState(
          password: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          confirmPassword: PasswordFieldModel.pure(),
          failure: null,
          formState: PasswordResetEnum.inProgress,
        ),
        const PasswordResetState(
          password: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          confirmPassword: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          failure: null,
          formState: PasswordResetEnum.inProgress,
        ),
        const PasswordResetState(
          password: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          confirmPassword: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          failure: null,
          formState: PasswordResetEnum.sending,
        ),
        const PasswordResetState(
          password: PasswordFieldModel.pure(),
          confirmPassword: PasswordFieldModel.pure(),
          failure: null,
          formState: PasswordResetEnum.success,
        ),
      ],
    );

    blocTest<PasswordResetBloc, PasswordResetState>(
      'emits [PasswordResetState] when password and confirm password changed'
      ' invalid and reset Password',
      build: () => passwordResetBloc,
      act: (bloc) async => bloc
        ..add(
          const PasswordResetEvent.passwordUpdated(
            KTestText.passwordIncorrect,
          ),
        )
        ..add(
          const PasswordResetEvent.confirmPasswordUpdated(
            KTestText.passwordIncorrectNumber,
          ),
        )
        ..add(const PasswordResetEvent.passwordReset(KTestText.code))
        ..add(
          const PasswordResetEvent.confirmPasswordUpdated(
            KTestText.passwordIncorrect,
          ),
        )
        ..add(const PasswordResetEvent.passwordReset(KTestText.code)),
      expect: () => [
        const PasswordResetState(
          password: PasswordFieldModel.dirty(KTestText.passwordIncorrect),
          confirmPassword: PasswordFieldModel.pure(),
          failure: null,
          formState: PasswordResetEnum.inProgress,
        ),
        const PasswordResetState(
          password: PasswordFieldModel.dirty(KTestText.passwordIncorrect),
          confirmPassword:
              PasswordFieldModel.dirty(KTestText.passwordIncorrectNumber),
          failure: null,
          formState: PasswordResetEnum.inProgress,
        ),
        const PasswordResetState(
          password: PasswordFieldModel.dirty(KTestText.passwordIncorrect),
          confirmPassword:
              PasswordFieldModel.dirty(KTestText.passwordIncorrectNumber),
          failure: null,
          formState: PasswordResetEnum.passwordMismatch,
        ),
        const PasswordResetState(
          password: PasswordFieldModel.dirty(KTestText.passwordIncorrect),
          confirmPassword:
              PasswordFieldModel.dirty(KTestText.passwordIncorrect),
          failure: null,
          formState: PasswordResetEnum.inProgress,
        ),
        const PasswordResetState(
          password: PasswordFieldModel.dirty(KTestText.passwordIncorrect),
          confirmPassword:
              PasswordFieldModel.dirty(KTestText.passwordIncorrect),
          failure: null,
          formState: PasswordResetEnum.invalidData,
        ),
      ],
    );

    blocTest<PasswordResetBloc, PasswordResetState>(
      'emits [PasswordResetState] when password and confirm password changed'
      ' valid and reset Password failure',
      build: () => passwordResetBloc,
      act: (bloc) async {
        when(
          mockAppAuthenticationRepository.resetPasswordUseCode(
            code: KTestText.code,
            newPassword: KTestText.passwordCorrect,
          ),
        ).thenAnswer(
          (realInvocation) async =>
              Left(SomeFailure.serverError(error: KGroupText.failureSend)),
        );
        bloc
          ..add(
            const PasswordResetEvent.passwordUpdated(
              KTestText.passwordCorrect,
            ),
          )
          ..add(
            const PasswordResetEvent.confirmPasswordUpdated(
              KTestText.passwordCorrect,
            ),
          )
          ..add(const PasswordResetEvent.passwordReset(KTestText.code));
      },
      expect: () => [
        const PasswordResetState(
          password: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          confirmPassword: PasswordFieldModel.pure(),
          failure: null,
          formState: PasswordResetEnum.inProgress,
        ),
        const PasswordResetState(
          password: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          confirmPassword: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          failure: null,
          formState: PasswordResetEnum.inProgress,
        ),
        const PasswordResetState(
          password: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          confirmPassword: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          failure: null,
          formState: PasswordResetEnum.sending,
        ),
        const PasswordResetState(
          password: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          confirmPassword: PasswordFieldModel.dirty(KTestText.passwordCorrect),
          failure: PasswordResetFailure.error,
          formState: PasswordResetEnum.inProgress,
        ),
      ],
    );
  });
}
