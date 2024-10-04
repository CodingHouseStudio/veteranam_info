import 'package:formz/formz.dart';

enum SurnameFieldModelValidationError { empty, wrong }

class SurnameFieldModel
    extends FormzInput<String, SurnameFieldModelValidationError> {
  const SurnameFieldModel.pure() : super.pure('');

  const SurnameFieldModel.dirty([super.value = '']) : super.dirty();

  static final _surnameRegExp = RegExp(r"^[a-zA-Zа-яА-ЯіІїЇєЄґҐ\s'-]+$");

  @override
  SurnameFieldModelValidationError? validator(String? value) {
    if (value == null || value.isEmpty) {
      return SurnameFieldModelValidationError.empty;
    }
    if (!_surnameRegExp.hasMatch(value)) {
      return SurnameFieldModelValidationError.wrong;
    }
    return null;
  }
}
