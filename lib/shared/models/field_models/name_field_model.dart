import 'package:formz/formz.dart';

enum NameFieldModelValidationError { empty, wrong, tooShort }

class NameFieldModel extends FormzInput<String, NameFieldModelValidationError> {
  const NameFieldModel.pure() : super.pure('');

  const NameFieldModel.dirty([super.value = '']) : super.dirty();

  static final _nameRegExp = RegExp(r"^[a-zA-Zа-яА-ЯіІїЇєЄґҐ\s'-]+$");

  static const int minLength = 2;

  @override
  NameFieldModelValidationError? validator(String? value) {
    final text = value?.trim();

    if (text == null || text.isEmpty) {
      return NameFieldModelValidationError.empty;
    }
    if (text.length < minLength) {
      return NameFieldModelValidationError.tooShort;
    }
    if (!_nameRegExp.hasMatch(text)) {
      return NameFieldModelValidationError.wrong;
    }
    return null;
  }
}
