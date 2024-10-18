import 'package:formz/formz.dart';

enum NicknameFieldModelValidationError { wrong }

class NicknameFieldModel
    extends FormzInput<String, NicknameFieldModelValidationError> {
  const NicknameFieldModel.pure() : super.pure('');

  const NicknameFieldModel.dirty([super.value = '']) : super.dirty();

  @override
  NicknameFieldModelValidationError? validator(String? value) {
    final text = value?.trim();
    if (text != null &&
        text.isNotEmpty &&
        !RegExp(r'^[a-zA-Z0-9._а-яА-ЯіІїЇєЄґҐ]+$').hasMatch(text)) {
      return NicknameFieldModelValidationError.wrong;
    }
    return null;
  }
}
