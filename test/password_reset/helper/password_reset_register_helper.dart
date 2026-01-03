import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
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

  _resgiterRepository();
}

void _resgiterRepository() {
  registerSingleton(mockAppAuthenticationRepository);
}
