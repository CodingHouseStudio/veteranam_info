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

extension ReportFieldModelValidationErrorEmpl
    on ReportFieldModelValidationError? {
  String? value(BuildContext context) {
    switch (this) {
      case ReportFieldModelValidationError.empty:
        return context.l10n.fieldCannotBeEmpty;
      // case ReportFieldModelValidationError.invalid:
      //   return context.l10n.isWrongReport;
      case ReportFieldModelValidationError.invalidLength:
        return '${context.l10n.message} ${context.l10n.tooshort}.'
            ' ${context.l10n.contain15Charcters}';
      case null:
        return null;
    }
  }
}

extension CitiesFieldModelValidationErrorEmpl
    on CitiesFieldModelValidationError? {
  String? value(BuildContext context) {
    switch (this) {
      case CitiesFieldModelValidationError.empty:
        return context.l10n.fieldCannotBeEmpty;
      case null:
        return null;
    }
  }
}

extension DiscountsFieldModelValidationErrorEmpl
    on DiscountsFieldModelValidationError? {
  String? value(BuildContext context) {
    switch (this) {
      case DiscountsFieldModelValidationError.empty:
        return context.l10n.fieldCannotBeEmpty;
      case DiscountsFieldModelValidationError.wrongFormat:
        return context.l10n.discountsWrongFormat;
      case null:
        return null;
    }
  }
}

extension DateFieldModelValidationErrorEmpl on DateFieldModelValidationError? {
  String? value(BuildContext context) {
    switch (this) {
      case DateFieldModelValidationError.empty:
        return context.l10n.fieldCannotBeEmpty;
      case null:
        return null;
    }
  }
}