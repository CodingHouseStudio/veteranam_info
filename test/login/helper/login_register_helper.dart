import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/login/bloc/login_bloc.dart';
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

  _registerBloc();
}

void _registerBloc() {
  // LoginBloc
  registerFactory<LoginBloc>(
    () => LoginBloc(
      authenticationRepository: mockAppAuthenticationRepository,
    ),
  );

  // AuthenticationServicesCubit
  registerFactory<AuthenticationServicesCubit>(
    () => AuthenticationServicesCubit(
      authenticationRepository: mockAppAuthenticationRepository,
    ),
  );
}
