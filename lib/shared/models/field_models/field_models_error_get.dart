import 'package:flutter/widgets.dart';
import 'package:veteranam/shared/shared.dart';

extension EmailFieldModelValidationErrorEmpl
    on EmailFieldModelValidationError? {
  String? value(BuildContext context) {
    switch (this) {
      case EmailFieldModelValidationError.empty:
        return context.l10n.fieldCannotBeEmpty;
      case EmailFieldModelValidationError.invalidLength:
        return '${context.l10n.email} ${context.l10n.tooShortEmailPassword}';
      case EmailFieldModelValidationError.wrong:
        return '${context.l10n.email} ${context.l10n.isWrongEmail}';
      case null:
        return null;
    }
  }
}

extension LinkFieldModelValidationErrorEmpl on LinkFieldModelValidationError? {
  String? value(BuildContext context) {
    switch (this) {
      case LinkFieldModelValidationError.empty:
        return context.l10n.fieldCannotBeEmpty;
      case LinkFieldModelValidationError.invalidLink:
        return context.l10n.invalidLink;
      case LinkFieldModelValidationError.invalidLength:
        return '${context.l10n.link} ${context.l10n.tooshort}';
      case null:
        return null;
    }
  }
}

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

extension PasswordFieldModelValidationErrorEmpl
    on PasswordFieldModelValidationError? {
  String? value(BuildContext context) {
    switch (this) {
      case PasswordFieldModelValidationError.empty:
        return context.l10n.fieldCannotBeEmpty;
      case PasswordFieldModelValidationError.invalidLength:
        return '${context.l10n.password} ${context.l10n.tooShortEmailPassword}';
      case null:
        return null;
      case PasswordFieldModelValidationError.capitalLetter:
        return context.l10n.capitalLetter;
      case PasswordFieldModelValidationError.oneNumber:
        return context.l10n.oneNumber;
    }
  }
}

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