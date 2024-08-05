import 'package:formz/formz.dart';

enum PhoneNumberFieldModelValidationError { empty, invalid }

class PhoneNumberFieldModel
    extends FormzInput<String, PhoneNumberFieldModelValidationError> {
  const PhoneNumberFieldModel.pure() : super.pure('');

  const PhoneNumberFieldModel.dirty([super.value = '']) : super.dirty();

  @override
  PhoneNumberFieldModelValidationError? validator(String? value) {
    if (value == null || value.isEmpty) {
      return PhoneNumberFieldModelValidationError.empty;
    }
    final phoneRegExp = RegExp(r'^\+?[0-9]{7,15}$');
    if (!phoneRegExp.hasMatch(value)) {
      return PhoneNumberFieldModelValidationError.invalid;
    }
    return null;
  }
}
