import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../test_dependency.dart';

/// FOLDER FILES COMMENT: Tests blocks that are used on several pages

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  setupFirebaseAuthMocks();

  tearDownAll(GetIt.I.reset);

  group('${KScreenBlocName.authenticationServices} ${KGroupText.cubit}', () {
    late AuthenticationRepository mockAuthenticationRepository;
    late AuthenticationServicesCubit authenticationServicesCubit;
    setUp(() {
      mockAuthenticationRepository = MockAuthenticationRepository();
      authenticationServicesCubit = AuthenticationServicesCubit(
        authenticationRepository: mockAuthenticationRepository,
      );
    });
    blocTest<AuthenticationServicesCubit, AuthenticationServicesState>(
      'emits [AuthenticationServicesState] when google sign up',
      build: () => authenticationServicesCubit,
      act: (cubit) async {
        when(
          mockAuthenticationRepository.signUpWithGoogle(),
        ).thenAnswer(
          (_) async => const Right(true),
        );
        await cubit.authenticationUseGoogle();
      },
      expect: () async => [
        const AuthenticationServicesState(
          status: AuthenticationServicesStatus.procesing,
        ),
        const AuthenticationServicesState(
          status: AuthenticationServicesStatus.authentication,
        ),
      ],
    );
    blocTest<AuthenticationServicesCubit, AuthenticationServicesState>(
      'emits [AuthenticationServicesState] when facebook sign up',
      build: () => authenticationServicesCubit,
      act: (cubit) async {
        when(
          mockAuthenticationRepository.signUpWithFacebook(),
        ).thenAnswer(
          (_) async => const Right(true),
        );
        await cubit.authenticationUseFacebook();
      },
      expect: () async => [
        const AuthenticationServicesState(
          status: AuthenticationServicesStatus.procesing,
        ),
        const AuthenticationServicesState(
          status: AuthenticationServicesStatus.authentication,
        ),
      ],
    );
    blocTest<AuthenticationServicesCubit, AuthenticationServicesState>(
      'emits [AuthenticationServicesState] when google sign up'
      ' failure serverError',
      build: () => authenticationServicesCubit,
      act: (cubit) async {
        when(
          mockAuthenticationRepository.signUpWithGoogle(),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        );
        await cubit.authenticationUseGoogle();
      },
      expect: () async => [
        const AuthenticationServicesState(
          status: AuthenticationServicesStatus.procesing,
        ),
        const AuthenticationServicesState(
          status: AuthenticationServicesStatus.error,
          failure: SomeFailure.serverError,
        ),
      ],
    );
    blocTest<AuthenticationServicesCubit, AuthenticationServicesState>(
      'emits [AuthenticationServicesState] when google sign up'
      ' failure serverError',
      build: () => authenticationServicesCubit,
      act: (cubit) async {
        when(
          mockAuthenticationRepository.signUpWithFacebook(),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        );
        await cubit.authenticationUseFacebook();
      },
      expect: () async => [
        const AuthenticationServicesState(
          status: AuthenticationServicesStatus.procesing,
        ),
        const AuthenticationServicesState(
          status: AuthenticationServicesStatus.error,
          failure: SomeFailure.serverError,
        ),
      ],
    );
  });
}
