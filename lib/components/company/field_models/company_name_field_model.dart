import 'package:formz/formz.dart';

enum CompanyNameFieldModelValidationError {
  empty,
  invalidLength,
}

class CompanyNameFieldModel
    extends FormzInput<String, CompanyNameFieldModelValidationError> {
  const CompanyNameFieldModel.pure() : super.pure('');

  const CompanyNameFieldModel.dirty([super.value = '']) : super.dirty();

  @override
  CompanyNameFieldModelValidationError? validator(String value) {
    final text = value.trim();
    if (text.isEmpty) {
      return CompanyNameFieldModelValidationError.empty;
    }
    // Check for minimum and maximum length
    if (text.length <= 2) {
      return CompanyNameFieldModelValidationError.invalidLength;
    }

    return null;
  }
}

/// FOLDER FILES COMMENT: Classes set validator for fields
