import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';
import 'package:kozak/shared/shared.dart';

enum PasswordFieldModelValidationError {
  empty,
  invalidLength,
  capitalLetter,
  oneNumber
}

extension PasswordFieldModelValidationErrorEmpl
    on PasswordFieldModelValidationError? {
  String? value(BuildContext context) {
    switch (this) {
      case PasswordFieldModelValidationError.empty:
        return context.l10n.fieldCannotBeEmpty;
      case PasswordFieldModelValidationError.invalidLength:
        return '${context.l10n.password} ${context.l10n.tooShortPassword}';
      case null:
        return null;
      case PasswordFieldModelValidationError.capitalLetter:
        return context.l10n.capitalLetter;
      case PasswordFieldModelValidationError.oneNumber:
        return context.l10n.oneNumber;
    }
  }
}

class PasswordFieldModel
    extends FormzInput<String, PasswordFieldModelValidationError> {
  const PasswordFieldModel.pure() : super.pure('');

  const PasswordFieldModel.dirty([super.value = '']) : super.dirty();

  @override
  PasswordFieldModelValidationError? validator(String value) {
    if (value.isEmpty) {
      return PasswordFieldModelValidationError.empty;
    }

    // Check for minimum and maximum length
    if (value.length < 8) {
      return PasswordFieldModelValidationError.invalidLength;
    }
    if (!RegExp('[A-Z]').hasMatch(value)) {
      return PasswordFieldModelValidationError.capitalLetter;
    }
    if (!RegExp(r'\d').hasMatch(value)) {
      return PasswordFieldModelValidationError.oneNumber;
    }

    return null;
  }
}
