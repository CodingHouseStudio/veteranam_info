import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import 'package:veteranam/components/password_reset/bloc/check_code/check_verification_code_cubit.dart';
import 'package:veteranam/shared/shared_dart.dart';
import '../../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.passwordReset} ${KGroupText.bloc}', () {
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    setUp(() {
      mockAppAuthenticationRepository = MockAppAuthenticationRepository();
    });
    group('emits [true] when verification code is valid', () {
      setUp(
        () => when(
          mockAppAuthenticationRepository.checkVerificationCode(
            KTestVariables.code,
          ),
        ).thenAnswer(
          (realInvocation) async => const Right(true),
        ),
      );
      blocTest<CheckVerificationCodeCubit, bool?>(
        'Bloc Test',
        build: () => CheckVerificationCodeCubit(
          appAuthenticationRepository: mockAppAuthenticationRepository,
          code: KTestVariables.code,
        ),
        // act: (bloc) async {
        //   // await bloc.started(KTestVariables.code);
        // },
        expect: () => [true],
      );
    });

    group('emits [false] when verification code is not valid', () {
      setUp(
        () => when(
          mockAppAuthenticationRepository.checkVerificationCode(
            KTestVariables.code,
          ),
        ).thenAnswer(
          (realInvocation) async => const Left(SomeFailure.serverError),
        ),
      );
      blocTest<CheckVerificationCodeCubit, bool?>(
        'emits [false] when verification code is not valid',
        build: () => CheckVerificationCodeCubit(
          appAuthenticationRepository: mockAppAuthenticationRepository,
          code: KTestVariables.code,
        ),
        // act: (bloc) async {
        //   // await bloc.started(KTestVariables.code);
        // },
        expect: () => [false],
      );
    });
  });
}
