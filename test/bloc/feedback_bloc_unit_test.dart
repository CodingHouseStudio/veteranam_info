import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../text_dependency.dart';

/// FOLDER FILES COMMENT: Tests blocks that are used on several pages
void main() {
  group('${KScreenBlocName.feedback} ', () {
    group('${KGroupText.model} ', () {
      test('${KGroupText.shouldBe} ${KGroupText.modelJson}', () {
        final json = {
          'id': KTestText.feedbackModel.id,
          'guestId': KTestText.feedbackModel.guestId,
          'guestName': KTestText.feedbackModel.guestName,
          'email': KTestText.feedbackModel.email,
          'timestamp': KTestText.feedbackModel.timestamp.toIso8601String(),
          'message': KTestText.feedbackModel.message,
          'status': _$FeedbackStatusEnumMap[KTestText.feedbackModel.status],
        };

        final feedbackModel = FeedbackModel.fromJson(json);

        expect(feedbackModel.id, KTestText.feedbackModel.id);
        expect(feedbackModel.email, KTestText.feedbackModel.email);
        expect(feedbackModel.guestId, KTestText.feedbackModel.guestId);
        expect(feedbackModel.guestName, KTestText.feedbackModel.guestName);
        expect(feedbackModel.message, KTestText.feedbackModel.message);
        expect(
          feedbackModel.status,
          KTestText.feedbackModel.status,
        );
        expect(
          feedbackModel.timestamp,
          KTestText.feedbackModel.timestamp,
        );
      });

      test('${KGroupText.shouldNotBe} ${KGroupText.modelJson}', () {
        final json = {
          'id': KTestText.feedbackModel.id,
          'guestId': KTestText.feedbackModel.guestId,
          'guestName': KTestText.feedbackModel.guestName,
          'email': KTestText.feedbackModel.email,
          'timestamp': KTestText.feedbackModel.timestamp.toIso8601String(),
          'message': KTestText.feedbackModel.message,
        };

        expect(
          () => QuestionModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.fiedlModel} ', () {
      group('Name ${KGroupText.validationError}', () {
        test('${KGroupText.shouldBe} ${KGroupText.empty}', () {
          const result = NameFieldModel.pure();
          expect(result.error, NameFieldModelValidationError.empty);
        });
        test('${KGroupText.shouldBe} ${KGroupText.empty}', () {
          const result = NameFieldModel.dirty();
          expect(result.error, NameFieldModelValidationError.empty);
        });
        test('${KGroupText.shouldNotBe} ${KGroupText.empty}', () {
          const result = NameFieldModel.dirty(KTestText.field);
          expect(result.error, null);
        });
      });
      group('Email ${KGroupText.validationError}', () {
        test('${KGroupText.shouldBe} ${KGroupText.empty}', () {
          const result = EmailFieldModel.pure();
          expect(result.error, EmailFieldModelValidationError.empty);
        });
        test('${KGroupText.shouldBe} ${KGroupText.empty}', () {
          const result = EmailFieldModel.dirty();
          expect(result.error, EmailFieldModelValidationError.empty);
        });
        test('${KGroupText.shouldNotBe} ${KGroupText.empty}', () {
          const result = EmailFieldModel.dirty(KTestText.field);
          expect(result.error, isNot(EmailFieldModelValidationError.empty));
        });
        test('${KGroupText.shouldBe} invalidLength', () {
          const result = EmailFieldModel.dirty(KTestText.shortUserEmail);
          expect(result.error, EmailFieldModelValidationError.invalidLength);
        });
        test('${KGroupText.shouldNotBe} invalidLength', () {
          const result = EmailFieldModel.dirty(KTestText.useremailIncorrect);
          expect(
            result.error,
            isNot(EmailFieldModelValidationError.invalidLength),
          );
        });
        test('${KGroupText.shouldBe} wrong', () {
          const result = EmailFieldModel.dirty(KTestText.useremailIncorrect);
          expect(result.error, EmailFieldModelValidationError.wrong);
        });
        test('${KGroupText.shouldNotBe} invalidLength', () {
          const result = EmailFieldModel.dirty(KTestText.useremail);
          expect(
            result.error,
            null,
          );
        });
      });
      group('Message ${KGroupText.validationError}', () {
        test('${KGroupText.shouldBe} ${KGroupText.empty}', () {
          const result = MessageFieldModel.pure();
          expect(result.error, MessageFieldModelValidationError.empty);
        });
        test('${KGroupText.shouldBe} ${KGroupText.empty}', () {
          const result = MessageFieldModel.dirty();
          expect(result.error, MessageFieldModelValidationError.empty);
        });
        test('${KGroupText.shouldNotBe} ${KGroupText.empty}', () {
          const result = MessageFieldModel.dirty(KTestText.field);
          expect(result.error, isNot(MessageFieldModelValidationError.empty));
        });
      });
    });
    group('${KGroupText.repository} ', () {
      late IFeedbackRepository mockFeedbackRepository;
      setUp(() {
        mockFeedbackRepository = MockIFeedbackRepository();
        when(mockFeedbackRepository.sendFeedback(KTestText.feedbackModel))
            .thenAnswer(
          (_) async => const Right(true),
        );
        when(
          mockFeedbackRepository.sendFeedback(KTestText.feedbackModelIncorect),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError()),
        );
      });
      test('${KGroupText.successfulSet} feedback', () async {
        expect(
          await mockFeedbackRepository.sendFeedback(KTestText.feedbackModel),
          isA<Right<SomeFailure, bool>>()
              .having((e) => e.value, 'value', isTrue),
        );
      });
      test('${KGroupText.failureSet} feedback', () async {
        expect(
          await mockFeedbackRepository
              .sendFeedback(KTestText.feedbackModelIncorect),
          isA<Left<SomeFailure, bool>>().having(
            (e) => e.value,
            'value',
            const SomeFailure.serverError(),
          ),
        );
      });
    });
    group('${KScreenBlocName.feedbackBloc} ', () {
      late FeedbackBloc feedbackBloc;
      late IFeedbackRepository mockFeedbackRepository;
      setUp(() {
        ExtendedDateTime.customTime = KTestText.feedbackModel.timestamp;
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
          ..add(const FeedbackEvent.emailUpdated(KTestText.useremail))
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
            email: EmailFieldModel.dirty(KTestText.useremail),
            message: MessageFieldModel.pure(),
            failure: FeedbackFailure.initial,
          ),
          const FeedbackState(
            formState: FeedbackEnum.initial,
            name: NameFieldModel.dirty(KTestText.field),
            email: EmailFieldModel.dirty(KTestText.useremail),
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
            const FeedbackEvent.emailUpdated(KTestText.useremailIncorrect),
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
            email: EmailFieldModel.dirty(KTestText.useremailIncorrect),
            message: MessageFieldModel.pure(),
            failure: FeedbackFailure.initial,
          ),
          const FeedbackState(
            formState: FeedbackEnum.initial,
            name: NameFieldModel.dirty(),
            email: EmailFieldModel.dirty(KTestText.useremailIncorrect),
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
          ..add(const FeedbackEvent.emailUpdated(KTestText.useremail))
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
            email: EmailFieldModel.dirty(KTestText.useremail),
            message: MessageFieldModel.pure(),
            failure: FeedbackFailure.initial,
          ),
          const FeedbackState(
            formState: FeedbackEnum.initial,
            name: NameFieldModel.dirty(KTestText.field),
            email: EmailFieldModel.dirty(KTestText.useremail),
            message: MessageFieldModel.dirty(KTestText.field),
            failure: FeedbackFailure.initial,
          ),
          const FeedbackState(
            formState: FeedbackEnum.sendingMessage,
            name: NameFieldModel.dirty(KTestText.field),
            email: EmailFieldModel.dirty(KTestText.useremail),
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
          ..add(const FeedbackEvent.emailUpdated(KTestText.useremail))
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
            email: EmailFieldModel.dirty(KTestText.useremail),
            message: MessageFieldModel.pure(),
            failure: FeedbackFailure.initial,
          ),
          const FeedbackState(
            formState: FeedbackEnum.initial,
            name: NameFieldModel.dirty(KTestText.field),
            email: EmailFieldModel.dirty(KTestText.useremail),
            message: MessageFieldModel.dirty(KTestText.field),
            failure: FeedbackFailure.initial,
          ),
          const FeedbackState(
            formState: FeedbackEnum.sendingMessage,
            name: NameFieldModel.dirty(KTestText.field),
            email: EmailFieldModel.dirty(KTestText.useremail),
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
          ..add(const FeedbackEvent.emailUpdated(KTestText.useremailIncorrect))
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
            email: EmailFieldModel.dirty(KTestText.useremailIncorrect),
            message: MessageFieldModel.pure(),
            failure: FeedbackFailure.initial,
          ),
          const FeedbackState(
            formState: FeedbackEnum.initial,
            name: NameFieldModel.dirty(),
            email: EmailFieldModel.dirty(KTestText.useremailIncorrect),
            message: MessageFieldModel.dirty(),
            failure: FeedbackFailure.initial,
          ),
          const FeedbackState(
            formState: FeedbackEnum.invalidData,
            name: NameFieldModel.dirty(),
            email: EmailFieldModel.dirty(KTestText.useremailIncorrect),
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
            ..add(const FeedbackEvent.emailUpdated(KTestText.useremail))
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
            email: EmailFieldModel.dirty(KTestText.useremail),
            message: MessageFieldModel.pure(),
            failure: FeedbackFailure.initial,
          ),
          const FeedbackState(
            formState: FeedbackEnum.initial,
            name: NameFieldModel.dirty(KTestText.field),
            email: EmailFieldModel.dirty(KTestText.useremail),
            message: MessageFieldModel.dirty(KTestText.field),
            failure: FeedbackFailure.initial,
          ),
          const FeedbackState(
            formState: FeedbackEnum.sendingMessage,
            name: NameFieldModel.dirty(KTestText.field),
            email: EmailFieldModel.dirty(KTestText.useremail),
            message: MessageFieldModel.dirty(KTestText.field),
            failure: FeedbackFailure.initial,
          ),
          const FeedbackState(
            formState: FeedbackEnum.invalidData,
            name: NameFieldModel.dirty(KTestText.field),
            email: EmailFieldModel.dirty(KTestText.useremail),
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
            ..add(const FeedbackEvent.emailUpdated(KTestText.useremail))
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
            email: EmailFieldModel.dirty(KTestText.useremail),
            message: MessageFieldModel.pure(),
            failure: FeedbackFailure.initial,
          ),
          const FeedbackState(
            formState: FeedbackEnum.initial,
            name: NameFieldModel.dirty(KTestText.field),
            email: EmailFieldModel.dirty(KTestText.useremail),
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
  });
}

const _$FeedbackStatusEnumMap = {
  FeedbackStatus.isNew: 'isNew',
  FeedbackStatus.responseRequired: 'responseRequired',
  FeedbackStatus.resolved: 'resolved',
  FeedbackStatus.ideas: 'ideas',
};
