import 'package:formz/formz.dart';

enum CompanyCodeFieldModelValidationError {
  empty,
  wrong,
}

class CompanyCodeFieldModel
    extends FormzInput<String, CompanyCodeFieldModelValidationError> {
  const CompanyCodeFieldModel.pure() : super.pure('');

  const CompanyCodeFieldModel.dirty([super.value = '']) : super.dirty();

  @override
  CompanyCodeFieldModelValidationError? validator(String value) {
    final text = value.trim();
    if (text.isEmpty) {
      return CompanyCodeFieldModelValidationError.empty;
    }
    final regexEdrpou = RegExp(r'^\d{8}$');
    final regexIpn = RegExp(r'^\d{10}$');
    // Check for minimum and maximum length
    if (!(regexEdrpou.hasMatch(text) || regexIpn.hasMatch(text))) {
      return CompanyCodeFieldModelValidationError.wrong;
    }

    return null;
  }
}

/// FOLDER FILES COMMENT: Classes set validator for fields
