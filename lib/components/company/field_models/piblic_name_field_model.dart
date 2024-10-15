import 'package:formz/formz.dart';

enum PublicNameFieldModelValidationError {
  empty,
}

class PublicNameFieldModel
    extends FormzInput<String, PublicNameFieldModelValidationError> {
  const PublicNameFieldModel.pure() : super.pure('');

  const PublicNameFieldModel.dirty([super.value = '']) : super.dirty();

  @override
  PublicNameFieldModelValidationError? validator(String value) {
    final text = value.trim();
    if (text.isEmpty) {
      return PublicNameFieldModelValidationError.empty;
    }

    return null;
  }
}
