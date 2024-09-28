import 'package:formz/formz.dart';

enum ReportFieldModelValidationError {
  empty,
  invalidLength,
  // invalid,
}

class ReportFieldModel
    extends FormzInput<String, ReportFieldModelValidationError> {
  const ReportFieldModel.pure() : super.pure('');

  const ReportFieldModel.dirty([super.value = '']) : super.dirty();

  @override
  ReportFieldModelValidationError? validator(String? value) {
    final text = value?.trim();
    if (text == null) {
      return ReportFieldModelValidationError.empty;
    }
    if (text.isEmpty) {
      return ReportFieldModelValidationError.empty;
    }
    if (text.length <= 15) {
      return ReportFieldModelValidationError.invalidLength;
    }
    // if (value.contains(RegExp(r'[^a-zA-Z0-9\s]')) ||
    //     value.contains(RegExp(r'[^\w\s]'))) {
    //   return ReportFieldModelValidationError.invalid;
    // }
    return null;
  }
}
