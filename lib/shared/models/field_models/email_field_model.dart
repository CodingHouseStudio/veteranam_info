import 'package:email_validator/email_validator.dart';
import 'package:formz/formz.dart';

enum EmailFieldModelValidationError {
  empty,
  invalidLength,
  wrong,
}

class EmailFieldModel
    extends FormzInput<String, EmailFieldModelValidationError> {
  const EmailFieldModel.pure() : super.pure('');

  const EmailFieldModel.dirty([super.value = '']) : super.dirty();

  @override
  EmailFieldModelValidationError? validator(String value) {
    final text = value.trim();
    if (text.isEmpty) {
      return EmailFieldModelValidationError.empty;
    }
    // Check for minimum and maximum length
    if (text.length < 6) {
      return EmailFieldModelValidationError.invalidLength;
    }

    // Additional checks for invalid characters
    if (!EmailValidator.validate(text)) {
      return EmailFieldModelValidationError.wrong;
    }
    final invalidCharacters = [
      '&',
      '=',
      '_',
      "'",
      '-',
      '+',
      '<',
      '>',
      '}',
      '{',
      '/',
      '*',
    ];
    if (invalidCharacters.any(text.contains)) {
      return EmailFieldModelValidationError.wrong;
    }

    return null;
  }
}

/// FOLDER FILES COMMENT: Classes set validator for fields
