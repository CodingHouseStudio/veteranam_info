// ignore_for_file: unused_import

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../test_dependency.dart';

/// FOLDER FILES COMMENT: Tests blocks that are used on several pages
void main() {
  setupFirebaseAuthMocks();

  group('${KScreenBlocName.authenticationServices} ${KGroupText.cubit}', () {
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    late AuthenticationServicesCubit authenticationServicesCubit;
    setUp(() {
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
      authenticationServicesCubit = AuthenticationServicesCubit(
        appAuthenticationRepository: mockAppAuthenticationRepository,
      );
    });
    blocTest<AuthenticationServicesCubit, AuthenticationServicesFailure>(
      'emits [AuthenticationServicesFailure] when failure none',
      build: () => authenticationServicesCubit,
      act: (cubit) async {
        when(
          mockAppAuthenticationRepository.signUpWithGoogle(),
        ).thenAnswer(
          (_) async => const Right(true),
        );
        await cubit.authenticationUseGoogle();
      },
      expect: () async => [
        AuthenticationServicesFailure.none,
      ],
    );
    blocTest<AuthenticationServicesCubit, AuthenticationServicesFailure>(
      'emits [AuthenticationServicesFailure] when failure serverError',
      build: () => authenticationServicesCubit,
      act: (cubit) async {
        when(
          mockAppAuthenticationRepository.signUpWithGoogle(),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError()),
        );
        await cubit.authenticationUseGoogle();
      },
      expect: () async => [
        AuthenticationServicesFailure.error,
      ],
    );
  });
}
