import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';
import 'package:kozak/shared/shared.dart';

enum EmailFieldModelValidationError {
  empty,
  invalidLength,
  wrong,
}

extension EmailFieldModelValidationErrorEmpl
    on EmailFieldModelValidationError? {
  String? value(BuildContext context) {
    switch (this) {
      case EmailFieldModelValidationError.empty:
        return context.l10n.fieldCannotBeEmpty;
      case EmailFieldModelValidationError.invalidLength:
        return '${context.l10n.email} ${context.l10n.tooShortEmail}';
      case EmailFieldModelValidationError.wrong:
        return '${context.l10n.email} ${context.l10n.isWrongEmail}';
      case null:
        return null;
    }
  }
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
    if (!RegExp(r'^[A-Za-z0-9@.]+$').hasMatch(value)) {
      return EmailFieldModelValidationError.wrong;
    }

    if (!(value.contains('@') &&
        value.contains('.') &&
        value.lastIndexOf('.') > value.indexOf('@'))) {
      return EmailFieldModelValidationError.wrong;
    }

    return null;
  }
}

/// FOLDER FILES COMMENT: Classes set validator for fields
