import 'package:formz/formz.dart';

enum NameFieldModelValidationError { empty, wrong, invalidLength }

class NameFieldModel extends FormzInput<String, NameFieldModelValidationError> {
  const NameFieldModel.pure() : super.pure('');

  const NameFieldModel.dirty([super.value = '']) : super.dirty();

  @override
  NameFieldModelValidationError? validator(String? value) {
    final text = value?.trim();

    if (text == null || text.isEmpty) {
      return NameFieldModelValidationError.empty;
    }
    if (text.length < 2) {
      return NameFieldModelValidationError.invalidLength;
    }
    if (!RegExp(r"^[a-zA-Zа-яА-ЯіІїЇєЄґҐ\s'-]+$").hasMatch(text)) {
      return NameFieldModelValidationError.wrong;
    }
    return null;
  }
}
