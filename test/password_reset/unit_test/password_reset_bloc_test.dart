import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/password_reset/bloc/form/password_reset_bloc.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.passwordReset} ${KGroupText.bloc}', () {
    late PasswordResetBloc passwordResetBloc;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    setUp(() {
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
      when(
        mockAppAuthenticationRepository.resetPasswordUseCode(
          code: KTestVariables.code,
          newPassword: KTestVariables.passwordCorrect,
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
            KTestVariables.passwordCorrect,
          ),
        )
        ..add(
          const PasswordResetEvent.confirmPasswordUpdated(
            KTestVariables.passwordCorrect,
          ),
        )
        ..add(const PasswordResetEvent.passwordReset(KTestVariables.code)),
      expect: () => [
        const PasswordResetState(
          password: PasswordFieldModel.dirty(KTestVariables.passwordCorrect),
          confirmPassword: PasswordFieldModel.pure(),
          failure: null,
          formState: PasswordResetEnum.inProgress,
        ),
        const PasswordResetState(
          password: PasswordFieldModel.dirty(KTestVariables.passwordCorrect),
          confirmPassword:
              PasswordFieldModel.dirty(KTestVariables.passwordCorrect),
          failure: null,
          formState: PasswordResetEnum.inProgress,
        ),
        const PasswordResetState(
          password: PasswordFieldModel.dirty(KTestVariables.passwordCorrect),
          confirmPassword:
              PasswordFieldModel.dirty(KTestVariables.passwordCorrect),
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
            KTestVariables.passwordIncorrect,
          ),
        )
        ..add(
          const PasswordResetEvent.confirmPasswordUpdated(
            KTestVariables.passwordIncorrectNumber,
          ),
        )
        ..add(const PasswordResetEvent.passwordReset(KTestVariables.code))
        ..add(
          const PasswordResetEvent.confirmPasswordUpdated(
            KTestVariables.passwordIncorrect,
          ),
        )
        ..add(const PasswordResetEvent.passwordReset(KTestVariables.code)),
      expect: () => [
        const PasswordResetState(
          password: PasswordFieldModel.dirty(KTestVariables.passwordIncorrect),
          confirmPassword: PasswordFieldModel.pure(),
          failure: null,
          formState: PasswordResetEnum.inProgress,
        ),
        const PasswordResetState(
          password: PasswordFieldModel.dirty(KTestVariables.passwordIncorrect),
          confirmPassword:
              PasswordFieldModel.dirty(KTestVariables.passwordIncorrectNumber),
          failure: null,
          formState: PasswordResetEnum.inProgress,
        ),
        const PasswordResetState(
          password: PasswordFieldModel.dirty(KTestVariables.passwordIncorrect),
          confirmPassword:
              PasswordFieldModel.dirty(KTestVariables.passwordIncorrectNumber),
          failure: null,
          formState: PasswordResetEnum.passwordMismatch,
        ),
        const PasswordResetState(
          password: PasswordFieldModel.dirty(KTestVariables.passwordIncorrect),
          confirmPassword:
              PasswordFieldModel.dirty(KTestVariables.passwordIncorrect),
          failure: null,
          formState: PasswordResetEnum.inProgress,
        ),
        const PasswordResetState(
          password: PasswordFieldModel.dirty(KTestVariables.passwordIncorrect),
          confirmPassword:
              PasswordFieldModel.dirty(KTestVariables.passwordIncorrect),
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
            code: KTestVariables.code,
            newPassword: KTestVariables.passwordCorrect,
          ),
        ).thenAnswer(
          (realInvocation) async => const Left(SomeFailure.serverError),
        );
        bloc
          ..add(
            const PasswordResetEvent.passwordUpdated(
              KTestVariables.passwordCorrect,
            ),
          )
          ..add(
            const PasswordResetEvent.confirmPasswordUpdated(
              KTestVariables.passwordCorrect,
            ),
          )
          ..add(const PasswordResetEvent.passwordReset(KTestVariables.code));
      },
      expect: () => [
        const PasswordResetState(
          password: PasswordFieldModel.dirty(KTestVariables.passwordCorrect),
          confirmPassword: PasswordFieldModel.pure(),
          failure: null,
          formState: PasswordResetEnum.inProgress,
        ),
        const PasswordResetState(
          password: PasswordFieldModel.dirty(KTestVariables.passwordCorrect),
          confirmPassword:
              PasswordFieldModel.dirty(KTestVariables.passwordCorrect),
          failure: null,
          formState: PasswordResetEnum.inProgress,
        ),
        const PasswordResetState(
          password: PasswordFieldModel.dirty(KTestVariables.passwordCorrect),
          confirmPassword:
              PasswordFieldModel.dirty(KTestVariables.passwordCorrect),
          failure: null,
          formState: PasswordResetEnum.sending,
        ),
        const PasswordResetState(
          password: PasswordFieldModel.dirty(KTestVariables.passwordCorrect),
          confirmPassword:
              PasswordFieldModel.dirty(KTestVariables.passwordCorrect),
          failure: SomeFailure.serverError,
          formState: PasswordResetEnum.inProgress,
        ),
      ],
    );
  });
}
