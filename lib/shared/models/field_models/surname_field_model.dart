import 'package:formz/formz.dart';

enum SurnameFieldModelValidationError { empty, wrong }

class SurnameFieldModel
    extends FormzInput<String, SurnameFieldModelValidationError> {
  const SurnameFieldModel.pure() : super.pure('');

  const SurnameFieldModel.dirty([super.value = '']) : super.dirty();

  @override
  SurnameFieldModelValidationError? validator(String? value) {
    if (value == null || value.isEmpty) {
      return SurnameFieldModelValidationError.empty;
    }
    if (!RegExp(r"^[a-zA-Zа-яА-ЯіІїЇєЄґҐ\s'-]+$").hasMatch(value)) {
      return SurnameFieldModelValidationError.wrong;
    }
    return null;
  }
}
