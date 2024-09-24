import 'package:formz/formz.dart';

enum NameFieldModelValidationError { empty, wrong }

class NameFieldModel extends FormzInput<String, NameFieldModelValidationError> {
  const NameFieldModel.pure() : super.pure('');

  const NameFieldModel.dirty([super.value = '']) : super.dirty();

  static final _nameRegExp = RegExp(r"^[a-zA-Zа-яА-ЯіІїЇєЄґҐ\s'-]+$");

  @override
  NameFieldModelValidationError? validator(String? value) {
    if (value == null || value.isEmpty) {
      return NameFieldModelValidationError.empty;
    }
    if (!_nameRegExp.hasMatch(value)) {
      return NameFieldModelValidationError.wrong;
    }
    return null;
  }
}
