import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/password_reset/bloc/check_code/check_verification_code_cubit.dart';
import 'package:veteranam/components/password_reset/bloc/form/password_reset_bloc.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

late IAppAuthenticationRepository mockAppAuthenticationRepository;
void passwordResetWidgetTestRegister() {
  mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
  when(
    mockAppAuthenticationRepository.resetPasswordUseCode(
      code: KTestVariables.code,
      newPassword: KTestVariables.passwordCorrect,
    ),
  ).thenAnswer(
    (invocation) async => const Right(true),
  );

  _resgiterBloc();
}

void _resgiterBloc() {
  // PasswordResetBloc
  registerFactory<PasswordResetBloc>(
    () => PasswordResetBloc(
      appAuthenticationRepository: mockAppAuthenticationRepository,
    ),
  );
  // CheckVerificationCodeCubit
  registerFactoryParam<CheckVerificationCodeCubit, String?, void>(
    (code, voidValue) => CheckVerificationCodeCubit(
      appAuthenticationRepository: mockAppAuthenticationRepository,
      code: code,
    ),
  );
}
