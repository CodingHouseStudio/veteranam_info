import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';
import 'package:kozak/shared/shared.dart';

enum PhoneNumberFieldModelValidationError {
  empty,
  invalidLength,
  invalidFormat,
}

extension PhoneNumberFieldModelValidationErrorEmpl
    on PhoneNumberFieldModelValidationError? {
  String? value(BuildContext context) {
    switch (this) {
      case PhoneNumberFieldModelValidationError.empty:
        return context.l10n.fieldCannotBeEmpty;
      case PhoneNumberFieldModelValidationError.invalidLength:
        return '${context.l10n.phoneNumber} ${context.l10n.tooshort}';
      case PhoneNumberFieldModelValidationError.invalidFormat:
        return '${context.l10n.phoneNumber} ${context.l10n.isWrong}';
      case null:
        return null;
    }
  }
}

class PhoneNumberFieldModel
    extends FormzInput<String, PhoneNumberFieldModelValidationError> {
  const PhoneNumberFieldModel.pure() : super.pure('');

  const PhoneNumberFieldModel.dirty([super.value = '']) : super.dirty();

  @override
  PhoneNumberFieldModelValidationError? validator(String value) {
    if (value.isEmpty) {
      return PhoneNumberFieldModelValidationError.empty;
    }

    // Check for valid length (assuming a standard length for the phone number)
    if (value.length != 17) {
      // Length for phone number in format +38 XXX XXX XX XX
      return PhoneNumberFieldModelValidationError.invalidLength;
    }

    // Validate phone number format using regular expression
    final phoneRegExp = RegExp(r'^\+\d{2} \d{3} \d{3} \d{2} \d{2}$');
    if (!phoneRegExp.hasMatch(value)) {
      return PhoneNumberFieldModelValidationError.invalidFormat;
    }

    return null;
  }
}
