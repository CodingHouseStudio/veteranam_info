import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.discount} UserEmail From ${KGroupText.bloc}', () {
    late UserEmailFormBloc userEmailFormBloc;
    late IDiscountRepository mockdiscountRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    late FirebaseAnalyticsService mockFirebaseAnalyticsService;

    setUp(() {
      ExtendedDateTime.id = KTestVariables.id;
      ExtendedDateTime.current = KTestVariables.dateTime;
      mockdiscountRepository = MockIDiscountRepository();
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
      mockFirebaseAnalyticsService = MockFirebaseAnalyticsService();

      when(mockdiscountRepository.sendEmail(KTestVariables.emailModel))
          .thenAnswer(
        (_) async => const Right(true),
      );
      when(mockdiscountRepository.userCanSendUserEmail(KTestVariables.user.id))
          .thenAnswer(
        (_) async => const Right(0),
      );
      when(
        mockdiscountRepository.sendEmail(
          KTestVariables.emailModelWrong,
        ),
      ).thenAnswer(
        (_) async => Left(SomeFailure.serverError(error: null)),
      );
      when(
        mockdiscountRepository.sendEmail(
          KTestVariables.emailModelWrong,
        ),
      ).thenAnswer(
        (_) async => Left(SomeFailure.serverError(error: null)),
      );
      when(mockAppAuthenticationRepository.currentUser).thenAnswer(
        (invocation) => KTestVariables.user,
      );

      userEmailFormBloc = UserEmailFormBloc(
        discountRepository: mockdiscountRepository,
        appAuthenticationRepository: mockAppAuthenticationRepository,
        firebaseAnalyticsService: mockFirebaseAnalyticsService,
      );
    });

    group(
      'User email enum',
      () {
        blocTest<UserEmailFormBloc, UserEmailFormState>(
          'emits [UserEmailFormState()] when '
          'check need to show first time',
          build: () => userEmailFormBloc,
          act: (bloc) async {
            when(
              mockdiscountRepository
                  .userCanSendUserEmail(KTestVariables.user.id),
            ).thenAnswer(
              (_) async => const Right(0),
            );
            bloc.add(const UserEmailFormEvent.started());
          },
          expect: () async => [
            const UserEmailFormState(
              email: EmailFieldModel.pure(),
              formState: EmailEnum.initial,
              emailEnum: UserEmailEnum.discountEmailAbandon,
            ),
          ],
        );

        blocTest<UserEmailFormBloc, UserEmailFormState>(
          'emits [UserEmailFormState()] when '
          'check need to show first time',
          build: () => userEmailFormBloc,
          act: (bloc) async {
            when(
              mockdiscountRepository
                  .userCanSendUserEmail(KTestVariables.user.id),
            ).thenAnswer(
              (_) async => const Right(1),
            );
            bloc.add(const UserEmailFormEvent.started());
          },
          expect: () async => [
            const UserEmailFormState(
              email: EmailFieldModel.pure(),
              formState: EmailEnum.initial,
              emailEnum: UserEmailEnum.discountEmailAbandonSecondary,
            ),
          ],
        );
        blocTest<UserEmailFormBloc, UserEmailFormState>(
          'emits [UserEmailFormState()] when '
          'check need to show first time',
          build: () => userEmailFormBloc,
          act: (bloc) async {
            when(
              mockdiscountRepository
                  .userCanSendUserEmail(KTestVariables.user.id),
            ).thenAnswer(
              (_) async => const Right(2),
            );
            bloc.add(const UserEmailFormEvent.started());
          },
          expect: () async => [
            const UserEmailFormState(
              email: EmailFieldModel.pure(),
              formState: EmailEnum.initial,
              emailEnum: UserEmailEnum.discountEmailAbandonRepeat,
            ),
          ],
        );
        blocTest<UserEmailFormBloc, UserEmailFormState>(
          'emits [UserEmailFormState()] when '
          'check need to show first time',
          build: () => userEmailFormBloc,
          act: (bloc) async {
            when(
              mockdiscountRepository
                  .userCanSendUserEmail(KTestVariables.user.id),
            ).thenAnswer(
              (_) async => const Right(5),
            );
            bloc.add(const UserEmailFormEvent.started());
          },
          expect: () async => [
            const UserEmailFormState(
              email: EmailFieldModel.pure(),
              formState: EmailEnum.initial,
              emailEnum: UserEmailEnum.discountEmailAbandonRepeat,
            ),
          ],
        );
        blocTest<UserEmailFormBloc, UserEmailFormState>(
          'emits [UserEmailFormState()] when '
          'check need to show first time',
          build: () => userEmailFormBloc,
          act: (bloc) async {
            when(
              mockdiscountRepository
                  .userCanSendUserEmail(KTestVariables.user.id),
            ).thenAnswer(
              (_) async => const Right(-1),
            );
            bloc.add(const UserEmailFormEvent.started());
          },
          expect: () async => [
            const UserEmailFormState(
              email: EmailFieldModel.pure(),
              formState: EmailEnum.initial,
              emailEnum: UserEmailEnum.discountEmailNotShow,
            ),
          ],
        );
        blocTest<UserEmailFormBloc, UserEmailFormState>(
          'emits [UserEmailFormState()] when '
          'check need to show first time',
          build: () => userEmailFormBloc,
          act: (bloc) async {
            when(
              mockdiscountRepository
                  .userCanSendUserEmail(KTestVariables.user.id),
            ).thenAnswer(
              (_) async => Left(SomeFailure.serverError(error: null)),
            );
            bloc.add(const UserEmailFormEvent.started());
          },
          expect: () async => [
            const UserEmailFormState(
              email: EmailFieldModel.pure(),
              formState: EmailEnum.initial,
              emailEnum: UserEmailEnum.discountEmailNotShow,
            ),
          ],
        );
      },
    );

    group('Field', () {
      setUp(() {
        when(
          mockdiscountRepository.userCanSendUserEmail(KTestVariables.user.id),
        ).thenAnswer(
          (_) async => const Right(0),
        );
        userEmailFormBloc.add(const UserEmailFormEvent.started());
      });
      blocTest<UserEmailFormBloc, UserEmailFormState>(
        'emits [discountWatcherState()]'
        ' when load discountModel list',
        build: () => userEmailFormBloc,
        act: (bloc) async => bloc
          ..add(
            UserEmailFormEvent.updatedEmail(
              KTestVariables.emailModel.email,
            ),
          )
          ..add(const UserEmailFormEvent.sendEmail()),
        expect: () async => [
          UserEmailFormState(
            email: EmailFieldModel.dirty(KTestVariables.emailModel.email),
            formState: EmailEnum.inProgress,
            emailEnum: UserEmailEnum.discountEmailAbandon,
          ),
          const UserEmailFormState(
            email: EmailFieldModel.pure(),
            formState: EmailEnum.success,
            emailEnum: UserEmailEnum.discountEmailAbandon,
          ),
        ],
      );

      blocTest<UserEmailFormBloc, UserEmailFormState>(
        'emits [discountWatcherState()]'
        ' when load discountModel list',
        build: () => userEmailFormBloc,
        act: (bloc) async => bloc
          ..add(
            UserEmailFormEvent.updatedEmail(
              KTestVariables.emailModel.email,
            ),
          )
          ..add(
            const UserEmailFormEvent.sendEmailAfterClose(
                // userEmailEnum: UserEmailEnum.discountEmailAbandonRepeat,
                // count: 5,
                ),
          ),
        expect: () async => [
          UserEmailFormState(
            email: EmailFieldModel.dirty(KTestVariables.emailModel.email),
            formState: EmailEnum.inProgress,
            emailEnum: UserEmailEnum.discountEmailAbandon,
          ),
          const UserEmailFormState(
            email: EmailFieldModel.pure(),
            formState: EmailEnum.initial,
            emailEnum: UserEmailEnum.discountEmailAbandon,
          ),
        ],
      );

      blocTest<UserEmailFormBloc, UserEmailFormState>(
        'emits [discountWatcherState()]'
        ' when load discountModel email',
        build: () => userEmailFormBloc,
        act: (bloc) async => bloc
          ..add(
            UserEmailFormEvent.updatedEmail(
              KTestVariables.emailModelWrong.email,
            ),
          )
          ..add(const UserEmailFormEvent.sendEmail())
          ..add(
            UserEmailFormEvent.updatedEmail(
              KTestVariables.emailModel.email,
            ),
          )
          ..add(const UserEmailFormEvent.sendEmail()),
        expect: () async => [
          UserEmailFormState(
            email: EmailFieldModel.dirty(KTestVariables.emailModelWrong.email),
            formState: EmailEnum.inProgress,
            emailEnum: UserEmailEnum.discountEmailAbandon,
          ),
          UserEmailFormState(
            email: EmailFieldModel.dirty(KTestVariables.emailModelWrong.email),
            formState: EmailEnum.invalidData,
            emailEnum: UserEmailEnum.discountEmailAbandon,
          ),
          UserEmailFormState(
            email: EmailFieldModel.dirty(KTestVariables.emailModel.email),
            formState: EmailEnum.inProgress,
            emailEnum: UserEmailEnum.discountEmailAbandon,
          ),
          const UserEmailFormState(
            email: EmailFieldModel.pure(),
            formState: EmailEnum.success,
            emailEnum: UserEmailEnum.discountEmailAbandon,
          ),
        ],
      );
    });
  });
}
