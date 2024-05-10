import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../../text_dependency.dart';

void main() {
  group('${KScreenBlocName.feedback} ${KGroupText.bloc} ', () {
    late FeedbackBloc feedbackBloc;
    late IFeedbackRepository mockFeedbackRepository;
    setUp(() {
      ExtendedDateTime.customTime = KTestText.dateTime;
      ExtendedDateTime.id = KTestText.feedbackModel.id;
      mockFeedbackRepository = MockIFeedbackRepository();
      when(mockFeedbackRepository.sendFeedback(KTestText.feedbackModel))
          .thenAnswer(
        (realInvocation) async => const Right(true),
      );
      feedbackBloc = FeedbackBloc(feedbackRepository: mockFeedbackRepository);
    });

    blocTest<FeedbackBloc, FeedbackState>(
      'emits [FeedbackState] when name, email and message'
      ' are changed and valid',
      build: () => feedbackBloc,
      act: (bloc) => bloc
        ..add(const FeedbackEvent.nameUpdated(KTestText.field))
        ..add(const FeedbackEvent.emailUpdated(KTestText.userEmail))
        ..add(const FeedbackEvent.messageUpdated(KTestText.field)),
      expect: () => [
        const FeedbackState(
          formState: FeedbackEnum.initial,
          name: NameFieldModel.dirty(KTestText.field),
          email: EmailFieldModel.pure(),
          message: MessageFieldModel.pure(),
          failure: FeedbackFailure.initial,
        ),
        const FeedbackState(
          formState: FeedbackEnum.initial,
          name: NameFieldModel.dirty(KTestText.field),
          email: EmailFieldModel.dirty(KTestText.userEmail),
          message: MessageFieldModel.pure(),
          failure: FeedbackFailure.initial,
        ),
        const FeedbackState(
          formState: FeedbackEnum.initial,
          name: NameFieldModel.dirty(KTestText.field),
          email: EmailFieldModel.dirty(KTestText.userEmail),
          message: MessageFieldModel.dirty(KTestText.field),
          failure: FeedbackFailure.initial,
        ),
      ],
    );
    blocTest<FeedbackBloc, FeedbackState>(
      'emits [FeedbackState] when name, email and'
      ' message are changed and not valid',
      build: () => feedbackBloc,
      act: (bloc) => bloc
        ..add(const FeedbackEvent.nameUpdated(KTestText.fieldEmpty))
        ..add(
          const FeedbackEvent.emailUpdated(KTestText.userEmailIncorrect),
        )
        ..add(const FeedbackEvent.messageUpdated(KTestText.fieldEmpty)),
      expect: () => [
        const FeedbackState(
          formState: FeedbackEnum.initial,
          name: NameFieldModel.dirty(),
          email: EmailFieldModel.pure(),
          message: MessageFieldModel.pure(),
          failure: FeedbackFailure.initial,
        ),
        const FeedbackState(
          formState: FeedbackEnum.initial,
          name: NameFieldModel.dirty(),
          email: EmailFieldModel.dirty(KTestText.userEmailIncorrect),
          message: MessageFieldModel.pure(),
          failure: FeedbackFailure.initial,
        ),
        const FeedbackState(
          formState: FeedbackEnum.initial,
          name: NameFieldModel.dirty(),
          email: EmailFieldModel.dirty(KTestText.userEmailIncorrect),
          message: MessageFieldModel.dirty(),
          failure: FeedbackFailure.initial,
        ),
      ],
    );
    blocTest<FeedbackBloc, FeedbackState>(
      'emits [FeedbackBloc] when valid data is submitted'
      ' with correct credentials',
      build: () => feedbackBloc,
      act: (bloc) async => bloc
        ..add(const FeedbackEvent.nameUpdated(KTestText.field))
        ..add(const FeedbackEvent.emailUpdated(KTestText.userEmail))
        ..add(const FeedbackEvent.messageUpdated(KTestText.field))
        ..add(const FeedbackEvent.save()),
      expect: () => [
        const FeedbackState(
          formState: FeedbackEnum.initial,
          name: NameFieldModel.dirty(KTestText.field),
          email: EmailFieldModel.pure(),
          message: MessageFieldModel.pure(),
          failure: FeedbackFailure.initial,
        ),
        const FeedbackState(
          formState: FeedbackEnum.initial,
          name: NameFieldModel.dirty(KTestText.field),
          email: EmailFieldModel.dirty(KTestText.userEmail),
          message: MessageFieldModel.pure(),
          failure: FeedbackFailure.initial,
        ),
        const FeedbackState(
          formState: FeedbackEnum.initial,
          name: NameFieldModel.dirty(KTestText.field),
          email: EmailFieldModel.dirty(KTestText.userEmail),
          message: MessageFieldModel.dirty(KTestText.field),
          failure: FeedbackFailure.initial,
        ),
        const FeedbackState(
          formState: FeedbackEnum.sendingMessage,
          name: NameFieldModel.dirty(KTestText.field),
          email: EmailFieldModel.dirty(KTestText.userEmail),
          message: MessageFieldModel.dirty(KTestText.field),
          failure: FeedbackFailure.initial,
        ),
        const FeedbackState(
          email: EmailFieldModel.pure(),
          message: MessageFieldModel.pure(),
          name: NameFieldModel.pure(),
          formState: FeedbackEnum.success,
          failure: FeedbackFailure.none,
        ),
      ],
    );
    blocTest<FeedbackBloc, FeedbackState>(
      'emits [FeedbackBloc] when valid data is submitted'
      ' with correct credentials and sendignMessageAgain',
      build: () => feedbackBloc,
      act: (bloc) async => bloc
        ..add(const FeedbackEvent.nameUpdated(KTestText.field))
        ..add(const FeedbackEvent.emailUpdated(KTestText.userEmail))
        ..add(const FeedbackEvent.messageUpdated(KTestText.field))
        ..add(const FeedbackEvent.save())
        ..add(const FeedbackEvent.sendignMessageAgain()),
      expect: () => [
        const FeedbackState(
          formState: FeedbackEnum.initial,
          name: NameFieldModel.dirty(KTestText.field),
          email: EmailFieldModel.pure(),
          message: MessageFieldModel.pure(),
          failure: FeedbackFailure.initial,
        ),
        const FeedbackState(
          formState: FeedbackEnum.initial,
          name: NameFieldModel.dirty(KTestText.field),
          email: EmailFieldModel.dirty(KTestText.userEmail),
          message: MessageFieldModel.pure(),
          failure: FeedbackFailure.initial,
        ),
        const FeedbackState(
          formState: FeedbackEnum.initial,
          name: NameFieldModel.dirty(KTestText.field),
          email: EmailFieldModel.dirty(KTestText.userEmail),
          message: MessageFieldModel.dirty(KTestText.field),
          failure: FeedbackFailure.initial,
        ),
        const FeedbackState(
          formState: FeedbackEnum.sendingMessage,
          name: NameFieldModel.dirty(KTestText.field),
          email: EmailFieldModel.dirty(KTestText.userEmail),
          message: MessageFieldModel.dirty(KTestText.field),
          failure: FeedbackFailure.initial,
        ),
        const FeedbackState(
          email: EmailFieldModel.pure(),
          message: MessageFieldModel.pure(),
          name: NameFieldModel.pure(),
          formState: FeedbackEnum.success,
          failure: FeedbackFailure.none,
        ),
        const FeedbackState(
          email: EmailFieldModel.pure(),
          message: MessageFieldModel.pure(),
          name: NameFieldModel.pure(),
          formState: FeedbackEnum.sendignMessageAgain,
          failure: FeedbackFailure.none,
        ),
      ],
    );
    blocTest<FeedbackBloc, FeedbackState>(
      'emits [FeedbackState] when valid data is submitted '
      'with incorrect credentials',
      build: () => feedbackBloc,
      act: (bloc) => bloc
        ..add(const FeedbackEvent.nameUpdated(KTestText.fieldEmpty))
        ..add(const FeedbackEvent.emailUpdated(KTestText.userEmailIncorrect))
        ..add(const FeedbackEvent.messageUpdated(KTestText.fieldEmpty))
        ..add(const FeedbackEvent.save()),
      expect: () => [
        const FeedbackState(
          formState: FeedbackEnum.initial,
          name: NameFieldModel.dirty(),
          email: EmailFieldModel.pure(),
          message: MessageFieldModel.pure(),
          failure: FeedbackFailure.initial,
        ),
        const FeedbackState(
          formState: FeedbackEnum.initial,
          name: NameFieldModel.dirty(),
          email: EmailFieldModel.dirty(KTestText.userEmailIncorrect),
          message: MessageFieldModel.pure(),
          failure: FeedbackFailure.initial,
        ),
        const FeedbackState(
          formState: FeedbackEnum.initial,
          name: NameFieldModel.dirty(),
          email: EmailFieldModel.dirty(KTestText.userEmailIncorrect),
          message: MessageFieldModel.dirty(),
          failure: FeedbackFailure.initial,
        ),
        const FeedbackState(
          formState: FeedbackEnum.invalidData,
          name: NameFieldModel.dirty(),
          email: EmailFieldModel.dirty(KTestText.userEmailIncorrect),
          message: MessageFieldModel.dirty(),
          failure: FeedbackFailure.initial,
        ),
      ],
    );
    blocTest<FeedbackBloc, FeedbackState>(
      'emits [FeedbackState] when valid data is submitted '
      'with incorrect credentials',
      build: () => feedbackBloc,
      act: (bloc) {
        when(
          mockFeedbackRepository.sendFeedback(KTestText.feedbackModel),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError()),
        );
        bloc
          ..add(const FeedbackEvent.nameUpdated(KTestText.field))
          ..add(const FeedbackEvent.emailUpdated(KTestText.userEmail))
          ..add(const FeedbackEvent.messageUpdated(KTestText.field))
          ..add(const FeedbackEvent.save());
      },
      expect: () => [
        const FeedbackState(
          formState: FeedbackEnum.initial,
          name: NameFieldModel.dirty(KTestText.field),
          email: EmailFieldModel.pure(),
          message: MessageFieldModel.pure(),
          failure: FeedbackFailure.initial,
        ),
        const FeedbackState(
          formState: FeedbackEnum.initial,
          name: NameFieldModel.dirty(KTestText.field),
          email: EmailFieldModel.dirty(KTestText.userEmail),
          message: MessageFieldModel.pure(),
          failure: FeedbackFailure.initial,
        ),
        const FeedbackState(
          formState: FeedbackEnum.initial,
          name: NameFieldModel.dirty(KTestText.field),
          email: EmailFieldModel.dirty(KTestText.userEmail),
          message: MessageFieldModel.dirty(KTestText.field),
          failure: FeedbackFailure.initial,
        ),
        const FeedbackState(
          formState: FeedbackEnum.sendingMessage,
          name: NameFieldModel.dirty(KTestText.field),
          email: EmailFieldModel.dirty(KTestText.userEmail),
          message: MessageFieldModel.dirty(KTestText.field),
          failure: FeedbackFailure.initial,
        ),
        const FeedbackState(
          formState: FeedbackEnum.invalidData,
          name: NameFieldModel.dirty(KTestText.field),
          email: EmailFieldModel.dirty(KTestText.userEmail),
          message: MessageFieldModel.dirty(KTestText.field),
          failure: FeedbackFailure.error,
        ),
      ],
    );
    blocTest<FeedbackBloc, FeedbackState>(
      'emits [FeedbackState] when valid data is clear '
      'and submited',
      build: () => feedbackBloc,
      act: (bloc) {
        when(
          mockFeedbackRepository.sendFeedback(KTestText.feedbackModel),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError()),
        );
        bloc
          ..add(const FeedbackEvent.nameUpdated(KTestText.field))
          ..add(const FeedbackEvent.emailUpdated(KTestText.userEmail))
          ..add(const FeedbackEvent.messageUpdated(KTestText.field))
          ..add(const FeedbackEvent.clear())
          ..add(const FeedbackEvent.save());
      },
      expect: () => [
        const FeedbackState(
          formState: FeedbackEnum.initial,
          name: NameFieldModel.dirty(KTestText.field),
          email: EmailFieldModel.pure(),
          message: MessageFieldModel.pure(),
          failure: FeedbackFailure.initial,
        ),
        const FeedbackState(
          formState: FeedbackEnum.initial,
          name: NameFieldModel.dirty(KTestText.field),
          email: EmailFieldModel.dirty(KTestText.userEmail),
          message: MessageFieldModel.pure(),
          failure: FeedbackFailure.initial,
        ),
        const FeedbackState(
          formState: FeedbackEnum.initial,
          name: NameFieldModel.dirty(KTestText.field),
          email: EmailFieldModel.dirty(KTestText.userEmail),
          message: MessageFieldModel.dirty(KTestText.field),
          failure: FeedbackFailure.initial,
        ),
        const FeedbackState(
          formState: FeedbackEnum.clear,
          name: NameFieldModel.pure(),
          email: EmailFieldModel.pure(),
          message: MessageFieldModel.pure(),
          failure: FeedbackFailure.initial,
        ),
        const FeedbackState(
          formState: FeedbackEnum.invalidData,
          name: NameFieldModel.pure(),
          email: EmailFieldModel.pure(),
          message: MessageFieldModel.pure(),
          failure: FeedbackFailure.initial,
        ),
      ],
    );
  });
}
