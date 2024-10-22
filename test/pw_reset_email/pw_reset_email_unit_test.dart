import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.pwResetEmail} ${KGroupText.bloc}', () {
    late PwResetEmailBloc pwResetEmailBloc;
    late AuthenticationRepository mockAuthenticationRepository;
    setUp(() {
      mockAuthenticationRepository = MockAuthenticationRepository();
      pwResetEmailBloc = PwResetEmailBloc(
        authenticationRepository: mockAuthenticationRepository,
      );
    });

    blocTest<PwResetEmailBloc, PwResetEmailState>(
      'emits [PwResetEmailState] when started with correct email '
      'and email are changed, submited and valid',
      build: () => pwResetEmailBloc,
      act: (bloc) {
        when(
          mockAuthenticationRepository.sendVerificationCodeToEmail(
            email: KTestText.userEmail,
          ),
        ).thenAnswer(
          (realInvocation) async => const Right(true),
        );
        bloc
          ..add(const PwResetEmailEvent.started(KTestText.userEmail))
          ..add(const PwResetEmailEvent.emailUpdated(KTestText.userEmail))
          ..add(const PwResetEmailEvent.sendResetCode())
          ..add(const PwResetEmailEvent.sendResetCode());
      },
      expect: () => [
        const PwResetEmailState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          failure: null,
          formState: PwResetEmailEnum.inProgress,
        ),
        const PwResetEmailState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          failure: null,
          formState: PwResetEmailEnum.sending,
        ),
        const PwResetEmailState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          failure: null,
          formState: PwResetEmailEnum.success,
        ),
        const PwResetEmailState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          failure: null,
          formState: PwResetEmailEnum.resending,
        ),
        const PwResetEmailState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          failure: null,
          formState: PwResetEmailEnum.success,
        ),
      ],
    );
    blocTest<PwResetEmailBloc, PwResetEmailState>(
      'emits [PwResetEmailState] when started with correct email '
      'and prassed back button',
      build: () => pwResetEmailBloc,
      act: (bloc) {
        when(
          mockAuthenticationRepository.sendVerificationCodeToEmail(
            email: KTestText.userEmail,
          ),
        ).thenAnswer(
          (realInvocation) async => const Right(true),
        );
        bloc
          ..add(const PwResetEmailEvent.started(KTestText.userEmail))
          ..add(const PwResetEmailEvent.emailUpdated(KTestText.userEmail))
          ..add(const PwResetEmailEvent.sendResetCode())
          ..add(const PwResetEmailEvent.resetStatus());
      },
      expect: () => [
        const PwResetEmailState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          failure: null,
          formState: PwResetEmailEnum.inProgress,
        ),
        const PwResetEmailState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          failure: null,
          formState: PwResetEmailEnum.sending,
        ),
        const PwResetEmailState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          failure: null,
          formState: PwResetEmailEnum.success,
        ),
        const PwResetEmailState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          failure: null,
          formState: PwResetEmailEnum.inProgress,
        ),
      ],
    );
    blocTest<PwResetEmailBloc, PwResetEmailState>(
      'emits [PwResetEmailState] when started with email null '
      'and email are changed invalid, submited',
      build: () => pwResetEmailBloc,
      act: (bloc) {
        when(
          mockAuthenticationRepository.sendVerificationCodeToEmail(
            email: KTestText.userEmail,
          ),
        ).thenAnswer(
          (realInvocation) async => const Right(true),
        );
        bloc
          ..add(const PwResetEmailEvent.started(null))
          ..add(
            const PwResetEmailEvent.emailUpdated(
              KTestText.userEmailIncorrect,
            ),
          )
          ..add(const PwResetEmailEvent.sendResetCode())
          ..add(const PwResetEmailEvent.sendResetCode());
      },
      expect: () => [
        const PwResetEmailState(
          email: EmailFieldModel.dirty(KTestText.userEmailIncorrect),
          failure: null,
          formState: PwResetEmailEnum.inProgress,
        ),
        const PwResetEmailState(
          email: EmailFieldModel.dirty(KTestText.userEmailIncorrect),
          failure: null,
          formState: PwResetEmailEnum.invalidData,
        ),
      ],
    );
    blocTest<PwResetEmailBloc, PwResetEmailState>(
      'emits [PwResetEmailState] when email are changed, submited failure',
      build: () => pwResetEmailBloc,
      act: (bloc) {
        when(
          mockAuthenticationRepository.sendVerificationCodeToEmail(
            email: KTestText.userEmail,
          ),
        ).thenAnswer(
          (realInvocation) async =>
              Left(SomeFailure.serverError(error: KGroupText.failureSend)),
        );
        bloc
          ..add(const PwResetEmailEvent.emailUpdated(KTestText.userEmail))
          ..add(const PwResetEmailEvent.sendResetCode());
      },
      expect: () => [
        const PwResetEmailState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          failure: null,
          formState: PwResetEmailEnum.inProgress,
        ),
        const PwResetEmailState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          failure: null,
          formState: PwResetEmailEnum.sending,
        ),
        const PwResetEmailState(
          email: EmailFieldModel.dirty(KTestText.userEmail),
          failure: PwResetEmailFailure.error,
          formState: PwResetEmailEnum.inProgress,
        ),
      ],
    );
  });
}
