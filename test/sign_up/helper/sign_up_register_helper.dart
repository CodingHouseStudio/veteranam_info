import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

late AuthenticationRepository mockAuthenticationRepository;
void signUpWidgetTestRegister() {
  ExtendedDateTime.current = KTestVariables.feedbackModel.timestamp;
  mockAuthenticationRepository = MockAuthenticationRepository();
  when(
    mockAuthenticationRepository.signUp(
      email: KTestVariables.userEmail,
      password: KTestVariables.passwordCorrect,
    ),
  ).thenAnswer(
    (invocation) async => const Right(true),
  );
  when(
    mockAuthenticationRepository.signUpWithGoogle(),
  ).thenAnswer(
    (invocation) async => const Right(true),
  );

  when(
    mockAuthenticationRepository.signUpWithFacebook(),
  ).thenAnswer(
    (invocation) async => const Right(true),
  );

  _registerRepository();
}

void _registerRepository() {
  registerSingleton(mockAuthenticationRepository);
}
