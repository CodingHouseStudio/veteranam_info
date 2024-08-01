import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:veteranam/shared/shared.dart';

enum PhoneNumberFieldModelValidationError { empty, invalid }

extension PhoneNumberFieldModelValidationErrorEmpl
    on PhoneNumberFieldModelValidationError? {
  String? value(BuildContext context) {
    switch (this) {
      case PhoneNumberFieldModelValidationError.empty:
        return context.l10n.fieldCannotBeEmpty;
      case PhoneNumberFieldModelValidationError.invalid:
        return context.l10n.isWrong;
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
  PhoneNumberFieldModelValidationError? validator(String? value) {
    if (value == null || value.isEmpty) {
      return PhoneNumberFieldModelValidationError.empty;
    }
    final phoneRegExp = RegExp(r'^\+?[0-9]{7,15}$');
    if (!phoneRegExp.hasMatch(value)) {
      return PhoneNumberFieldModelValidationError.invalid;
    }
    return null;
  }
}
