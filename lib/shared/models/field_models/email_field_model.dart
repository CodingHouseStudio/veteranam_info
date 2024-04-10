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
        return '${context.l10n.email} ${context.l10n.tooshortEmail}';
      case EmailFieldModelValidationError.wrong:
        return '${context.l10n.email} ${context.l10n.isWrongEmail}';
      case null:
        return null;
    }
  }
}

class EmailFieldModel
    extends FormzInput<String?, EmailFieldModelValidationError> {
  const EmailFieldModel.pure() : super.pure(null);

  const EmailFieldModel.dirty([super.value = '']) : super.dirty();

  @override
  EmailFieldModelValidationError? validator(String? value) {
    if (value == null || value.isEmpty) {
      return EmailFieldModelValidationError.empty;
    }

    // Check for minimum and maximum length
    if (value.length < 6 || value.length > 254) {
      return EmailFieldModelValidationError.invalidLength;
    }

    // Additional checks for invalid characters
    if (value.contains(' ') || value.contains(',') || value.contains(';')) {
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
