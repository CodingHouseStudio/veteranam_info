import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
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
    if (value.isEmpty) {
      return EmailFieldModelValidationError.empty;
    }
    // Check for minimum and maximum length
    if (value.length < 6) {
      return EmailFieldModelValidationError.invalidLength;
    }

    // Additional checks for invalid characters
    if (!EmailValidator.validate(value)) {
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
    if (invalidCharacters.any((char) => value.contains(char))) {
      return EmailFieldModelValidationError.wrong;
    }

    return null;
  }
}

class EmailInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // delete all spaces
    final newText = newValue.text.replaceAll(RegExp(r'\s+'), '');
    return TextEditingValue(
      text: newText,
      selection: newValue.selection,
    );
  }
}

/// FOLDER FILES COMMENT: Classes set validator for fields
