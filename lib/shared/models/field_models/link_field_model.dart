import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:veteranam/shared/shared.dart';

enum LinkFieldModelValidationError { empty }

extension LinkFieldModelValidationErrorEmpl on LinkFieldModelValidationError? {
  String? value(BuildContext context) {
    switch (this) {
      case LinkFieldModelValidationError.empty:
        return context.l10n.fieldCannotBeEmpty;
      case null:
        return null;
    }
  }
}

class LinkFieldModel extends FormzInput<String, LinkFieldModelValidationError> {
  const LinkFieldModel.pure() : super.pure('');

  const LinkFieldModel.dirty([super.value = '']) : super.dirty();

  @override
  LinkFieldModelValidationError? validator(String? value) {
    if (value == null) {
      return LinkFieldModelValidationError.empty;
    }
    if (value.isEmpty) {
      return LinkFieldModelValidationError.empty;
    }
    return null;
  }
}
