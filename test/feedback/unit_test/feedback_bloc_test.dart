import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/feedback/bloc/feedback_bloc.dart';
import 'package:veteranam/shared/shared_dart.dart';
import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.feedback} ${KGroupText.bloc} ', () {
    late FeedbackBloc feedbackBloc;
    late IFeedbackRepository mockFeedbackRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    setUp(() {
      ExtendedDateTime.current = KTestVariables.dateTime;
      ExtendedDateTime.id = KTestVariables.feedbackModel.id;
      mockFeedbackRepository = MockIFeedbackRepository();
      mockAppAuthenticationRepository = MockAppAuthenticationRepository();
      when(mockFeedbackRepository.sendFeedback(KTestVariables.feedbackModel))
          .thenAnswer(
        (realInvocation) async => const Right(true),
      );
      when(
        mockFeedbackRepository
            .checkUserNeedShowFeedback(KTestVariables.user.id),
      ).thenAnswer(
        (realInvocation) async => const Right(true),
      );
      when(mockAppAuthenticationRepository.currentUser).thenAnswer(
        (realInvocation) => KTestVariables.user,
      );
      when(mockAppAuthenticationRepository.currentUserSetting).thenAnswer(
        (realInvocation) => KTestVariables.userSetting,
      );
      feedbackBloc = FeedbackBloc(
        feedbackRepository: mockFeedbackRepository,
        appAuthenticationRepository: mockAppAuthenticationRepository,
      );
    });

    blocTest<FeedbackBloc, FeedbackState>(
      'emits [FeedbackState] when started, name, email and message'
      ' are changed and valid',
      build: () => feedbackBloc,
      act: (bloc) => bloc
        ..add(const FeedbackEvent.started())
        ..add(const FeedbackEvent.nameUpdated(KTestVariables.nameCorrect))
        ..add(const FeedbackEvent.emailUpdated(KTestVariables.userEmail))
        ..add(const FeedbackEvent.messageUpdated(KTestVariables.field)),
      expect: () => [
        const FeedbackState(
          formState: FeedbackEnum.initial,
          name: NameFieldModel.pure(),
          email: EmailFieldModel.pure(),
          message: MessageFieldModel.pure(),
          failure: null,
        ),
        const FeedbackState(
          formState: FeedbackEnum.inProgress,
          name: NameFieldModel.dirty(KTestVariables.nameCorrect),
          email: EmailFieldModel.pure(),
          message: MessageFieldModel.pure(),
          failure: null,
        ),
        const FeedbackState(
          formState: FeedbackEnum.inProgress,
          name: NameFieldModel.dirty(KTestVariables.nameCorrect),
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          message: MessageFieldModel.pure(),
          failure: null,
        ),
        const FeedbackState(
          formState: FeedbackEnum.inProgress,
          name: NameFieldModel.dirty(KTestVariables.nameCorrect),
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          message: MessageFieldModel.dirty(KTestVariables.field),
          failure: null,
        ),
      ],
    );
    blocTest<FeedbackBloc, FeedbackState>(
      'emits [FeedbackState] when started show notShowFeedback, name, email and'
      ' message are changed and not valid',
      build: () => feedbackBloc,
      act: (bloc) {
        when(
          mockFeedbackRepository
              .checkUserNeedShowFeedback(KTestVariables.user.id),
        ).thenAnswer(
          (realInvocation) async => const Right(false),
        );
        bloc
          ..add(const FeedbackEvent.started())
          ..add(const FeedbackEvent.nameUpdated(KTestVariables.fieldEmpty))
          ..add(
            const FeedbackEvent.emailUpdated(KTestVariables.userEmailIncorrect),
          )
          ..add(const FeedbackEvent.messageUpdated(KTestVariables.fieldEmpty));
      },
      expect: () => [
        const FeedbackState(
          formState: FeedbackEnum.notShow,
          name: NameFieldModel.pure(),
          email: EmailFieldModel.pure(),
          message: MessageFieldModel.pure(),
          failure: null,
        ),
        const FeedbackState(
          formState: FeedbackEnum.inProgress,
          name: NameFieldModel.dirty(),
          email: EmailFieldModel.pure(),
          message: MessageFieldModel.pure(),
          failure: null,
        ),
        const FeedbackState(
          formState: FeedbackEnum.inProgress,
          name: NameFieldModel.dirty(),
          email: EmailFieldModel.dirty(KTestVariables.userEmailIncorrect),
          message: MessageFieldModel.pure(),
          failure: null,
        ),
        const FeedbackState(
          formState: FeedbackEnum.inProgress,
          name: NameFieldModel.dirty(),
          email: EmailFieldModel.dirty(KTestVariables.userEmailIncorrect),
          message: MessageFieldModel.dirty(),
          failure: null,
        ),
      ],
    );
    blocTest<FeedbackBloc, FeedbackState>(
      'emits [ReportState] when valid data is submitted'
      ' with correct credentials',
      build: () => feedbackBloc,
      act: (bloc) async {
        when(
          mockFeedbackRepository
              .checkUserNeedShowFeedback(KTestVariables.user.id),
        ).thenAnswer(
          (realInvocation) async => const Left(
            SomeFailure.serverError,
          ),
        );
        bloc
          ..add(const FeedbackEvent.started())
          ..add(const FeedbackEvent.nameUpdated(KTestVariables.nameCorrect))
          ..add(const FeedbackEvent.emailUpdated(KTestVariables.userEmail))
          ..add(const FeedbackEvent.messageUpdated(KTestVariables.field))
          ..add(const FeedbackEvent.save());
      },
      expect: () => [
        const FeedbackState(
          formState: FeedbackEnum.initial,
          name: NameFieldModel.pure(),
          email: EmailFieldModel.pure(),
          message: MessageFieldModel.pure(),
          failure: SomeFailure.serverError,
        ),
        const FeedbackState(
          formState: FeedbackEnum.inProgress,
          name: NameFieldModel.dirty(KTestVariables.nameCorrect),
          email: EmailFieldModel.pure(),
          message: MessageFieldModel.pure(),
          failure: null,
        ),
        const FeedbackState(
          formState: FeedbackEnum.inProgress,
          name: NameFieldModel.dirty(KTestVariables.nameCorrect),
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          message: MessageFieldModel.pure(),
          failure: null,
        ),
        const FeedbackState(
          formState: FeedbackEnum.inProgress,
          name: NameFieldModel.dirty(KTestVariables.nameCorrect),
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          message: MessageFieldModel.dirty(KTestVariables.field),
          failure: null,
        ),
        const FeedbackState(
          formState: FeedbackEnum.sendingMessage,
          name: NameFieldModel.dirty(KTestVariables.nameCorrect),
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          message: MessageFieldModel.dirty(KTestVariables.field),
          failure: null,
        ),
        const FeedbackState(
          email: EmailFieldModel.pure(),
          message: MessageFieldModel.pure(),
          name: NameFieldModel.pure(),
          formState: FeedbackEnum.success,
          failure: null,
        ),
      ],
    );
    blocTest<FeedbackBloc, FeedbackState>(
      'emits [ReportState] when valid data is submitted'
      ' with correct credentials and sendignMessageAgain',
      build: () => feedbackBloc,
      act: (bloc) async => bloc
        ..add(const FeedbackEvent.nameUpdated(KTestVariables.nameCorrect))
        ..add(const FeedbackEvent.emailUpdated(KTestVariables.userEmail))
        ..add(const FeedbackEvent.messageUpdated(KTestVariables.field))
        ..add(const FeedbackEvent.save())
        ..add(const FeedbackEvent.sendignMessageAgain()),
      expect: () => [
        const FeedbackState(
          formState: FeedbackEnum.inProgress,
          name: NameFieldModel.dirty(KTestVariables.nameCorrect),
          email: EmailFieldModel.pure(),
          message: MessageFieldModel.pure(),
          failure: null,
        ),
        const FeedbackState(
          formState: FeedbackEnum.inProgress,
          name: NameFieldModel.dirty(KTestVariables.nameCorrect),
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          message: MessageFieldModel.pure(),
          failure: null,
        ),
        const FeedbackState(
          formState: FeedbackEnum.inProgress,
          name: NameFieldModel.dirty(KTestVariables.nameCorrect),
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          message: MessageFieldModel.dirty(KTestVariables.field),
          failure: null,
        ),
        const FeedbackState(
          formState: FeedbackEnum.sendingMessage,
          name: NameFieldModel.dirty(KTestVariables.nameCorrect),
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          message: MessageFieldModel.dirty(KTestVariables.field),
          failure: null,
        ),
        const FeedbackState(
          email: EmailFieldModel.pure(),
          message: MessageFieldModel.pure(),
          name: NameFieldModel.pure(),
          formState: FeedbackEnum.success,
          failure: null,
        ),
        const FeedbackState(
          email: EmailFieldModel.pure(),
          message: MessageFieldModel.pure(),
          name: NameFieldModel.pure(),
          formState: FeedbackEnum.sendignMessageAgain,
          failure: null,
        ),
        const FeedbackState(
          formState: FeedbackEnum.initial,
          name: NameFieldModel.pure(),
          email: EmailFieldModel.pure(),
          message: MessageFieldModel.pure(),
          failure: null,
        ),
      ],
    );
    blocTest<FeedbackBloc, FeedbackState>(
      'emits [FeedbackState] when valid data is submitted '
      'with incorrect credentials',
      build: () => feedbackBloc,
      act: (bloc) => bloc
        ..add(const FeedbackEvent.nameUpdated(KTestVariables.fieldEmpty))
        ..add(
          const FeedbackEvent.emailUpdated(KTestVariables.userEmailIncorrect),
        )
        ..add(const FeedbackEvent.messageUpdated(KTestVariables.fieldEmpty))
        ..add(const FeedbackEvent.save()),
      expect: () => [
        const FeedbackState(
          formState: FeedbackEnum.inProgress,
          name: NameFieldModel.dirty(),
          email: EmailFieldModel.pure(),
          message: MessageFieldModel.pure(),
          failure: null,
        ),
        const FeedbackState(
          formState: FeedbackEnum.inProgress,
          name: NameFieldModel.dirty(),
          email: EmailFieldModel.dirty(KTestVariables.userEmailIncorrect),
          message: MessageFieldModel.pure(),
          failure: null,
        ),
        const FeedbackState(
          formState: FeedbackEnum.inProgress,
          name: NameFieldModel.dirty(),
          email: EmailFieldModel.dirty(KTestVariables.userEmailIncorrect),
          message: MessageFieldModel.dirty(),
          failure: null,
        ),
        const FeedbackState(
          formState: FeedbackEnum.invalidData,
          name: NameFieldModel.dirty(),
          email: EmailFieldModel.dirty(KTestVariables.userEmailIncorrect),
          message: MessageFieldModel.dirty(),
          failure: null,
        ),
      ],
    );
    blocTest<FeedbackBloc, FeedbackState>(
      'emits [FeedbackState] when valid data is submitted '
      'with failure',
      build: () => feedbackBloc,
      act: (bloc) {
        when(
          mockFeedbackRepository.sendFeedback(KTestVariables.feedbackModel),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        );
        bloc
          ..add(const FeedbackEvent.nameUpdated(KTestVariables.nameCorrect))
          ..add(const FeedbackEvent.emailUpdated(KTestVariables.userEmail))
          ..add(const FeedbackEvent.messageUpdated(KTestVariables.field))
          ..add(const FeedbackEvent.save());
      },
      expect: () => [
        const FeedbackState(
          formState: FeedbackEnum.inProgress,
          name: NameFieldModel.dirty(KTestVariables.nameCorrect),
          email: EmailFieldModel.pure(),
          message: MessageFieldModel.pure(),
          failure: null,
        ),
        const FeedbackState(
          formState: FeedbackEnum.inProgress,
          name: NameFieldModel.dirty(KTestVariables.nameCorrect),
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          message: MessageFieldModel.pure(),
          failure: null,
        ),
        const FeedbackState(
          formState: FeedbackEnum.inProgress,
          name: NameFieldModel.dirty(KTestVariables.nameCorrect),
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          message: MessageFieldModel.dirty(KTestVariables.field),
          failure: null,
        ),
        const FeedbackState(
          formState: FeedbackEnum.sendingMessage,
          name: NameFieldModel.dirty(KTestVariables.nameCorrect),
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          message: MessageFieldModel.dirty(KTestVariables.field),
          failure: null,
        ),
        const FeedbackState(
          formState: FeedbackEnum.initial,
          name: NameFieldModel.dirty(KTestVariables.nameCorrect),
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          message: MessageFieldModel.dirty(KTestVariables.field),
          failure: SomeFailure.serverError,
        ),
      ],
    );
    // blocTest<FeedbackBloc, FeedbackState>(
    //   'emits [FeedbackState] when valid data is clear '
    //   'and submited',
    //   build: () => feedbackBloc,
    //   act: (bloc) {
    //     when(
    //       mockFeedbackRepository.sendFeedback(KTestText.feedbackModel),
    //     ).thenAnswer(
    //       (_) async => const Left(SomeFailure.serverError),
    //     );
    //     bloc
    //       ..add(const FeedbackEvent.nameUpdated(KTestText.field))
    //       ..add(const FeedbackEvent.emailUpdated(KTestText.userEmail))
    //       ..add(const FeedbackEvent.messageUpdated(KTestText.field))
    //       ..add(const FeedbackEvent.clear())
    //       ..add(const FeedbackEvent.save());
    //   },
    //   expect: () => [
    //     const FeedbackState(
    //       formState: FeedbackEnum.inProgress,
    //       name: NameFieldModel.dirty(KTestText.nameCorrect),
    //       email: EmailFieldModel.pure(),
    //       message: MessageFieldModel.pure(),
    //       failure: null,
    //     ),
    //     const FeedbackState(
    //       formState: FeedbackEnum.inProgress,
    //       name: NameFieldModel.dirty(KTestText.nameCorrect),
    //       email: EmailFieldModel.dirty(KTestText.userEmail),
    //       message: MessageFieldModel.pure(),
    //       failure: null,
    //     ),
    //     const FeedbackState(
    //       formState: FeedbackEnum.inProgress,
    //       name: NameFieldModel.dirty(KTestText.nameCorrect),
    //       email: EmailFieldModel.dirty(KTestText.userEmail),
    //       message: MessageFieldModel.dirty(KTestText.field),
    //       failure: null,
    //     ),
    //     const FeedbackState(
    //       formState: FeedbackEnum.clear,
    //       name: NameFieldModel.pure(),
    //       email: EmailFieldModel.pure(),
    //       message: MessageFieldModel.pure(),
    //       failure: null,
    //     ),
    //     const FeedbackState(
    //       formState: FeedbackEnum.invalidData,
    //       name: NameFieldModel.pure(),
    //       email: EmailFieldModel.pure(),
    //       message: MessageFieldModel.pure(),
    //       failure: null,
    //     ),
    //   ],
    // );
  });
}
