import 'package:flutter/widgets.dart' show BuildContext;
import 'package:veteranam/components/company/field_models/company_code_field_model.dart';
import 'package:veteranam/components/company/field_models/company_name_field_model.dart';
import 'package:veteranam/components/company/field_models/piblic_name_field_model.dart';
import 'package:veteranam/components/discounts/field_model/discount_link_field_model.dart';
import 'package:veteranam/components/discounts_add/field_models/field_models.dart';
import 'package:veteranam/shared/shared_flutter.dart';

extension EmailFieldModelValidationErrorEmpl
    on EmailFieldModelValidationError? {
  String? value(BuildContext context) {
    switch (this) {
      case EmailFieldModelValidationError.empty:
        return context.l10n.fieldCannotBeEmpty;
      case EmailFieldModelValidationError.invalidLength:
        return '${context.l10n.email} ${context.l10n.tooShortEmailPassword(6)}';
      case EmailFieldModelValidationError.wrong:
        return '${context.l10n.email} ${context.l10n.isWrongEmail}';
      case null:
        return null;
    }
  }
}

extension DiscountLinkFieldModelValidationErrorEmpl
    on DiscountLinkFieldModelValidationError? {
  String? value(BuildContext context) {
    switch (this) {
      case DiscountLinkFieldModelValidationError.empty:
        return context.l10n.fieldCannotBeEmpty;
      case DiscountLinkFieldModelValidationError.invalidLink:
        return context.l10n.invalidLink;
      case DiscountLinkFieldModelValidationError.invalidLength:
        return '${context.l10n.link} ${context.l10n.tooshort(12)}';
      case null:
        return null;
    }
  }
}

extension LinkFieldModelValidationErrorEmpl on LinkFieldModelValidationError? {
  String? value(BuildContext context) {
    switch (this) {
      case LinkFieldModelValidationError.invalidLink:
        return context.l10n.invalidLink;
      case LinkFieldModelValidationError.invalidLength:
        return '${context.l10n.link} ${context.l10n.tooshort(12)}';
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
      case NameFieldModelValidationError.wrong:
        return '${context.l10n.name} ${context.l10n.isWrong}';
      case NameFieldModelValidationError.invalidLength:
        return '${context.l10n.name} ${context.l10n.tooshort(2)}';
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
        return '${context.l10n.password} '
            '${context.l10n.tooShortEmailPassword(8)}';
      case null:
        return null;
      case PasswordFieldModelValidationError.capitalLetter:
        return '${context.l10n.password} '
            '${context.l10n.capitalLetter}';
      case PasswordFieldModelValidationError.oneNumber:
        return '${context.l10n.password} '
            '${context.l10n.oneNumber}';
      case PasswordFieldModelValidationError.onlyEnglishLetter:
        return '${context.l10n.password} '
            '${context.l10n.onlyEnglishLetter}';
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
        return '${context.l10n.message} ${context.l10n.tooshort(16)}.'
            ' ${context.l10n.contain15Charcters}';
      case null:
        return null;
    }
  }
}

extension MultiFieldModelValidationErrorEmpl on ListFieldModelValidationError? {
  String? value(BuildContext context) {
    switch (this) {
      case ListFieldModelValidationError.empty:
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
      case DiscountsFieldModelValidationError.wrongRange:
        return context.l10n.discountWrongRange;
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

extension SurnameFieldModelValidationErrorEmpl
    on SurnameFieldModelValidationError? {
  String? value(BuildContext context) {
    switch (this) {
      case SurnameFieldModelValidationError.empty:
        return context.l10n.fieldCannotBeEmpty;
      case SurnameFieldModelValidationError.wrong:
        return '${context.l10n.lastName} ${context.l10n.isWrong}';
      case null:
        return null;
    }
  }
}

extension NicknameFieldModelValidationErrorEmpl
    on NicknameFieldModelValidationError? {
  String? value(BuildContext context) {
    switch (this) {
      case NicknameFieldModelValidationError.wrong:
        return '${KAppText.nickname} ${context.l10n.isWrong}';
      case null:
        return null;
    }
  }
}

extension CompanyNameFieldModelValidationErrorEmpl
    on CompanyNameFieldModelValidationError? {
  String? value(BuildContext context) {
    switch (this) {
      case CompanyNameFieldModelValidationError.empty:
        return context.l10n.fieldCannotBeEmpty;
      case CompanyNameFieldModelValidationError.invalidLength:
        return '${context.l10n.companyName} ${context.l10n.tooshort(2)}';
      case null:
        return null;
    }
  }
}

extension PublicNameFieldModelValidationErrorEmpl
    on PublicNameFieldModelValidationError? {
  String? value(BuildContext context) {
    switch (this) {
      case PublicNameFieldModelValidationError.empty:
        return context.l10n.fieldCannotBeEmpty;
      case null:
        return null;
    }
  }
}

extension CompanyCodeFieldModelValidationErrorEmpl
    on CompanyCodeFieldModelValidationError? {
  String? value(BuildContext context) {
    switch (this) {
      case CompanyCodeFieldModelValidationError.empty:
        return context.l10n.fieldCannotBeEmpty;
      case CompanyCodeFieldModelValidationError.wrong:
        return '${context.l10n.companyCode} ${context.l10n.isWrongEmail}';
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
      case CitiesFieldModelValidationError.limit:
        return '${context.l10n.discountLimitMessage}'
            ' ${context.l10n.citiesLimit}';
      case null:
        return null;
    }
  }
}

extension CategoriesFieldModelValidationErrorEmpl
    on CategoriesFieldModelValidationError? {
  String? value(BuildContext context) {
    switch (this) {
      case CategoriesFieldModelValidationError.empty:
        return context.l10n.fieldCannotBeEmpty;
      case CategoriesFieldModelValidationError.limit:
        return '${context.l10n.discountLimitMessage}'
            ' ${context.l10n.categoriesLimit}';
      case null:
        return null;
    }
  }
}

extension EligibilityFieldModelValidationErrorEmpl
    on EligibilityFieldModelValidationError? {
  String? value(BuildContext context) {
    switch (this) {
      case EligibilityFieldModelValidationError.empty:
        return context.l10n.fieldCannotBeEmpty;
      case null:
        return null;
    }
  }
}
