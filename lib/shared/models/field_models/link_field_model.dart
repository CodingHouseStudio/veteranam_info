import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:veteranam/shared/shared.dart';

enum LinkFieldModelValidationError {
  empty,
  invalidLink,
  invalidLength,
}

extension LinkFieldModelValidationErrorEmpl on LinkFieldModelValidationError? {
  String? value(BuildContext context) {
    switch (this) {
      case LinkFieldModelValidationError.empty:
        return context.l10n.fieldCannotBeEmpty;
      case LinkFieldModelValidationError.invalidLink:
        return context.l10n.invalidLink;
      case LinkFieldModelValidationError.invalidLength:
        return '${context.l10n.link} ${context.l10n.tooShort}';
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
    if (value == null || value.isEmpty) {
      return LinkFieldModelValidationError.empty;
    }
    if (value.length <= 12) {
      return LinkFieldModelValidationError.invalidLength;
    }
    if (!value.isUrlValid) {
      return LinkFieldModelValidationError.invalidLink;
    }
    return null;
  }
}
