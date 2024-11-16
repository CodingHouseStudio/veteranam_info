import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/password_reset/bloc/check_code/check_verification_code_cubit.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.passwordReset} ${KGroupText.bloc}', () {
    late CheckVerificationCodeCubit checkVerificationCodeCubit;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    setUp(() {
      mockAppAuthenticationRepository = MockAppAuthenticationRepository();
      checkVerificationCodeCubit = CheckVerificationCodeCubit(
        appAuthenticationRepository: mockAppAuthenticationRepository,
      );
    });

    blocTest<CheckVerificationCodeCubit, bool?>(
      'emits [true] when verification code is valid',
      build: () => checkVerificationCodeCubit,
      act: (bloc) async {
        when(
          mockAppAuthenticationRepository.checkVerificationCode(
            KTestText.code,
          ),
        ).thenAnswer(
          (realInvocation) async => const Right(true),
        );
        await bloc.started(KTestText.code);
      },
      expect: () => [true],
    );

    blocTest<CheckVerificationCodeCubit, bool?>(
      'emits [false] when verification code is not valid',
      build: () => checkVerificationCodeCubit,
      act: (bloc) async {
        when(
          mockAppAuthenticationRepository.checkVerificationCode(
            KTestText.code,
          ),
        ).thenAnswer(
          (realInvocation) async =>
              Left(SomeFailure.serverError(error: KGroupText.failure)),
        );
        await bloc.started(KTestText.code);
      },
      expect: () => [false],
    );
  });
}
