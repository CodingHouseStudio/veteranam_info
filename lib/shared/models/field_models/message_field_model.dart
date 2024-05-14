import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:kozak/shared/shared.dart';

enum MessageFieldModelValidationError { empty }

extension MessageFieldModelValidationErrorEmpl
    on MessageFieldModelValidationError? {
  String? value(BuildContext context) {
    switch (this) {
      case MessageFieldModelValidationError.empty:
        return context.l10n.fieldCannotBeEmpty;
      case null:
        return null;
    }
  }
}

class MessageFieldModel
    extends FormzInput<String, MessageFieldModelValidationError> {
  const MessageFieldModel.pure() : super.pure('');

  const MessageFieldModel.dirty([super.value = '']) : super.dirty();

  @override
  MessageFieldModelValidationError? validator(String? value) {
    if (value == null) {
      return MessageFieldModelValidationError.empty;
    }
    if (value.isEmpty) {
      return MessageFieldModelValidationError.empty;
    }
    return null;
  }
}
