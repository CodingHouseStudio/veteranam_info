import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.discount} UserEmail From ${KGroupText.bloc}', () {
    late DiscountUserEmailFormBloc discountUserEmailFormBloc;
    late IDiscountRepository mockdiscountRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    late FirebaseAnalyticsService mockFirebaseAnalyticsService;

    setUp(() {
      ExtendedDateTime.id = KTestText.id;
      ExtendedDateTime.current = KTestText.dateTime;
      mockdiscountRepository = MockIDiscountRepository();
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
      mockFirebaseAnalyticsService = MockFirebaseAnalyticsService();

      when(mockdiscountRepository.sendEmail(KTestText.emailModel)).thenAnswer(
        (_) async => const Right(true),
      );
      when(
        mockdiscountRepository.sendEmail(
          KTestText.emailModelWrong,
        ),
      ).thenAnswer(
        (_) async => Left(SomeFailure.serverError(error: null)),
      );
      when(
        mockdiscountRepository.sendEmail(
          KTestText.emailModelWrong,
        ),
      ).thenAnswer(
        (_) async => Left(SomeFailure.serverError(error: null)),
      );
      when(mockAppAuthenticationRepository.currentUser).thenAnswer(
        (invocation) => KTestText.user,
      );
      discountUserEmailFormBloc = DiscountUserEmailFormBloc(
        discountRepository: mockdiscountRepository,
        appAuthenticationRepository: mockAppAuthenticationRepository,
        firebaseAnalyticsService: mockFirebaseAnalyticsService,
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
        const DiscountUserEmailFormState(
          email: EmailFieldModel.pure(),
          formState: EmailEnum.success,
        ),
        const DiscountUserEmailFormState(
          email: EmailFieldModel.pure(),
          formState: EmailEnum.initial,
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
        ..add(
          const DiscountUserEmailFormEvent.sendEmailAfterClose(
            userEmailEnum: UserEmailEnum.discountEmailAbandonRepeat,
            count: 5,
          ),
        ),
      expect: () async => [
        DiscountUserEmailFormState(
          email: EmailFieldModel.dirty(KTestText.emailModel.email),
          formState: EmailEnum.inProgress,
        ),
        const DiscountUserEmailFormState(
          email: EmailFieldModel.pure(),
          formState: EmailEnum.initial,
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
        ..add(const DiscountUserEmailFormEvent.sendEmail())
        ..add(
          DiscountUserEmailFormEvent.updatedEmail(
            KTestText.emailModel.email,
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
          formState: EmailEnum.invalidData,
        ),
        DiscountUserEmailFormState(
          email: EmailFieldModel.dirty(KTestText.emailModel.email),
          formState: EmailEnum.inProgress,
        ),
        const DiscountUserEmailFormState(
          email: EmailFieldModel.pure(),
          formState: EmailEnum.success,
        ),
        const DiscountUserEmailFormState(
          email: EmailFieldModel.pure(),
          formState: EmailEnum.initial,
        ),
      ],
    );
  });
}
