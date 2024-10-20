import 'package:formz/formz.dart';

enum PasswordFieldModelValidationError {
  empty,
  invalidLength,
  onlyEnglishLetter,
  capitalLetter,
  oneNumber
}

class PasswordFieldModel
    extends FormzInput<String, PasswordFieldModelValidationError> {
  const PasswordFieldModel.pure() : super.pure('');

  const PasswordFieldModel.dirty([super.value = '']) : super.dirty();

  @override
  PasswordFieldModelValidationError? validator(String value) {
    final text = value.trim();
    if (text.isEmpty) {
      return PasswordFieldModelValidationError.empty;
    }

    // Check for minimum and maximum length
    if (text.length < 8) {
      return PasswordFieldModelValidationError.invalidLength;
    }

    if (!RegExp(r'^[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{};:"\\|,.<>\/?`~ ]+$')
        .hasMatch(text)) {
      return PasswordFieldModelValidationError.onlyEnglishLetter;
    }

    if (!RegExp('[A-Z]').hasMatch(text)) {
      return PasswordFieldModelValidationError.capitalLetter;
    }
    if (!RegExp(r'\d').hasMatch(text)) {
      return PasswordFieldModelValidationError.oneNumber;
    }

    return null;
  }
}
