import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../constants.dart';

void main() {
  group(KScreenBlocName.feedbackBloc, () {
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
        expect(result.error, isNot(NameFieldModelValidationError.empty));
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
          isNot(EmailFieldModelValidationError.wrong),
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

  group('correct/incorrect data', () {
    late FeedbackBloc feedbackBloc;

    setUp(() {
      feedbackBloc = FeedbackBloc();
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
          fieldsState: FeedbackEnum.inProgress,
          name: NameFieldModel.dirty(KTestText.field),
          email: EmailFieldModel.pure(),
          message: MessageFieldModel.pure(),
        ),
        const FeedbackState(
          fieldsState: FeedbackEnum.inProgress,
          name: NameFieldModel.dirty(KTestText.field),
          email: EmailFieldModel.dirty(KTestText.useremail),
          message: MessageFieldModel.pure(),
        ),
        const FeedbackState(
          fieldsState: FeedbackEnum.inProgress,
          name: NameFieldModel.dirty(KTestText.field),
          email: EmailFieldModel.dirty(KTestText.useremail),
          message: MessageFieldModel.dirty(KTestText.field),
        ),
      ],
    );
    blocTest<FeedbackBloc, FeedbackState>(
      'emits [FeedbackState] when name, email and'
      ' message are changed and not valid',
      build: () => feedbackBloc,
      act: (bloc) => bloc
        ..add(const FeedbackEvent.nameUpdated(KTestText.fieldEmpty))
        ..add(const FeedbackEvent.emailUpdated(KTestText.useremailIncorrect))
        ..add(const FeedbackEvent.messageUpdated(KTestText.fieldEmpty)),
      expect: () => [
        const FeedbackState(
          fieldsState: FeedbackEnum.inProgress,
          name: NameFieldModel.dirty(),
          email: EmailFieldModel.pure(),
          message: MessageFieldModel.pure(),
        ),
        const FeedbackState(
          fieldsState: FeedbackEnum.inProgress,
          name: NameFieldModel.dirty(),
          email: EmailFieldModel.dirty(KTestText.useremailIncorrect),
          message: MessageFieldModel.pure(),
        ),
        const FeedbackState(
          fieldsState: FeedbackEnum.inProgress,
          name: NameFieldModel.dirty(),
          email: EmailFieldModel.dirty(KTestText.useremailIncorrect),
          message: MessageFieldModel.dirty(),
        ),
      ],
    );
    blocTest<FeedbackBloc, FeedbackState>(
      'emits [FeedbackBloc] when valid data is submitted'
      ' with correct credentials',
      build: () => feedbackBloc,
      act: (bloc) => bloc
        ..add(const FeedbackEvent.nameUpdated(KTestText.field))
        ..add(const FeedbackEvent.emailUpdated(KTestText.useremail))
        ..add(const FeedbackEvent.messageUpdated(KTestText.field))
        ..add(const FeedbackEvent.save()),
      expect: () => [
        const FeedbackState(
          fieldsState: FeedbackEnum.inProgress,
          name: NameFieldModel.dirty(KTestText.field),
          email: EmailFieldModel.pure(),
          message: MessageFieldModel.pure(),
        ),
        const FeedbackState(
          fieldsState: FeedbackEnum.inProgress,
          name: NameFieldModel.dirty(KTestText.field),
          email: EmailFieldModel.dirty(KTestText.useremail),
          message: MessageFieldModel.pure(),
        ),
        const FeedbackState(
          fieldsState: FeedbackEnum.inProgress,
          name: NameFieldModel.dirty(KTestText.field),
          email: EmailFieldModel.dirty(KTestText.useremail),
          message: MessageFieldModel.dirty(KTestText.field),
        ),
        const FeedbackState(
          email: EmailFieldModel.pure(),
          message: MessageFieldModel.pure(),
          name: NameFieldModel.pure(),
          fieldsState: FeedbackEnum.success,
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
          fieldsState: FeedbackEnum.inProgress,
          name: NameFieldModel.dirty(),
          email: EmailFieldModel.pure(),
          message: MessageFieldModel.pure(),
        ),
        const FeedbackState(
          fieldsState: FeedbackEnum.inProgress,
          name: NameFieldModel.dirty(),
          email: EmailFieldModel.dirty(KTestText.useremailIncorrect),
          message: MessageFieldModel.pure(),
        ),
        const FeedbackState(
          fieldsState: FeedbackEnum.inProgress,
          name: NameFieldModel.dirty(),
          email: EmailFieldModel.dirty(KTestText.useremailIncorrect),
          message: MessageFieldModel.dirty(),
        ),
        const FeedbackState(
          fieldsState: FeedbackEnum.invalidData,
          name: NameFieldModel.dirty(),
          email: EmailFieldModel.dirty(KTestText.useremailIncorrect),
          message: MessageFieldModel.dirty(),
        ),
      ],
    );
  });
}
