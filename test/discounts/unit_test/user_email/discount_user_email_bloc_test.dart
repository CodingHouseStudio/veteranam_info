import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group('${KScreenBlocName.discount} UserEmail From ${KGroupText.bloc}', () {
    late DiscountUserEmailFormBloc discountUserEmailFormBloc;
    late IDiscountRepository mockdiscountRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;

    setUp(() {
      ExtendedDateTime.id = KTestText.id;
      ExtendedDateTime.current = KTestText.dateTime;
      mockdiscountRepository = MockIDiscountRepository();
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
      when(mockdiscountRepository.sendEmail(KTestText.emailModel)).thenAnswer(
        (_) async => const Right(true),
      );
      when(
        mockdiscountRepository.sendEmail(
          KTestText.emailModelWrong,
        ),
      ).thenAnswer(
        (_) async => const Left(SomeFailure.serverError()),
      );
      when(
        mockdiscountRepository.sendEmail(
          KTestText.emailModelWrong,
        ),
      ).thenAnswer(
        (_) async => const Left(SomeFailure.serverError()),
      );
      when(mockAppAuthenticationRepository.currentUser).thenAnswer(
        (invocation) => KTestText.user,
      );
      discountUserEmailFormBloc = DiscountUserEmailFormBloc(
        discountRepository: mockdiscountRepository,
        appAuthenticationRepository: mockAppAuthenticationRepository,
      );
    });

    blocTest<DiscountUserEmailFormBloc, DiscountUserEmailFormState>(
      'emits [discountWatcherState()]'
      ' when load discountModel list',
      build: () => discountUserEmailFormBloc,
      act: (bloc) async => bloc
        ..add(
          DiscountUserEmailFormEvent.updatedEmail(
            KTestText.emailModel.email,
          ),
        )
        ..add(const DiscountUserEmailFormEvent.sendEmail()),
      expect: () async => [
        DiscountUserEmailFormState(
          email: EmailFieldModel.dirty(KTestText.emailModel.email),
          formState: EmailEnum.inProgress,
        ),
        DiscountUserEmailFormState(
          email: EmailFieldModel.dirty(KTestText.emailModel.email),
          formState: EmailEnum.success,
        ),
      ],
    );

    blocTest<DiscountUserEmailFormBloc, DiscountUserEmailFormState>(
      'emits [discountWatcherState()]'
      ' when load discountModel list',
      build: () => discountUserEmailFormBloc,
      act: (bloc) async => bloc
        ..add(
          DiscountUserEmailFormEvent.updatedEmail(
            KTestText.emailModel.email,
          ),
        )
        ..add(const DiscountUserEmailFormEvent.sendEmailAfterClose()),
      expect: () async => [
        DiscountUserEmailFormState(
          email: EmailFieldModel.dirty(KTestText.emailModel.email),
          formState: EmailEnum.inProgress,
        ),
        const DiscountUserEmailFormState(
          email: EmailFieldModel.pure(),
          formState: EmailEnum.close,
        ),
      ],
    );

    blocTest<DiscountUserEmailFormBloc, DiscountUserEmailFormState>(
      'emits [discountWatcherState()]'
      ' when load discountModel email',
      build: () => discountUserEmailFormBloc,
      act: (bloc) async => bloc
        ..add(
          DiscountUserEmailFormEvent.updatedEmail(
            KTestText.emailModelWrong.email,
          ),
        )
        ..add(const DiscountUserEmailFormEvent.sendEmail()),
      expect: () async => [
        DiscountUserEmailFormState(
          email: EmailFieldModel.dirty(KTestText.emailModelWrong.email),
          formState: EmailEnum.inProgress,
        ),
        DiscountUserEmailFormState(
          email: EmailFieldModel.dirty(KTestText.emailModelWrong.email),
          formState: EmailEnum.success,
        ),
      ],
    );
  });
}
