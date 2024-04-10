import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:kozak/shared/shared.dart';

enum NameFieldModelValidationError { empty }

extension NameFieldModelValidationErrorEmpl on NameFieldModelValidationError? {
  String? value(BuildContext context) {
    switch (this) {
      case NameFieldModelValidationError.empty:
        return context.l10n.fieldCannotBeEmpty;
      case null:
        return null;
    }
  }
}

class NameFieldModel
    extends FormzInput<String?, NameFieldModelValidationError> {
  const NameFieldModel.pure() : super.pure(null);

  const NameFieldModel.dirty([super.value = '']) : super.dirty();

  @override
  NameFieldModelValidationError? validator(String? value) {
    if (value == null) {
      return NameFieldModelValidationError.empty;
    }
    if (value.isEmpty) {
      return NameFieldModelValidationError.empty;
    }
    return null;
  }
}
