import 'package:formz/formz.dart';

enum NameFieldModelValidationError { empty }

class NameFieldModel extends FormzInput<String, NameFieldModelValidationError> {
  const NameFieldModel.pure() : super.pure('');

  const NameFieldModel.dirty([super.value = '']) : super.dirty();

  @override
  NameFieldModelValidationError? validator(String? value) {
    if (value == null) {
      return NameFieldModelValidationError.empty;
    }
    if (value.trim().isEmpty) {
      return NameFieldModelValidationError.empty;
    }
    return null;
  }
}
