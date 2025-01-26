import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

late AuthenticationRepository mockAppAuthenticationRepository;
void loginTestWidgetRegister() {
  ExtendedDateTime.current = KTestVariables.feedbackModel.timestamp;
  mockAppAuthenticationRepository = MockAuthenticationRepository();
  when(
    mockAppAuthenticationRepository.logIn(
      email: KTestVariables.userEmail,
      password: KTestVariables.passwordCorrect,
    ),
  ).thenAnswer(
    (invocation) async => const Right(true),
  );
  when(
    mockAppAuthenticationRepository.signUpWithGoogle(),
  ).thenAnswer(
    (invocation) async => const Right(true),
  );

  when(
    mockAppAuthenticationRepository.signUpWithFacebook(),
  ).thenAnswer(
    (invocation) async => const Right(true),
  );

  _registerRepository();
}

void _registerRepository() {
  registerSingleton(mockAppAuthenticationRepository);
}
