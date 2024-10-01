import 'package:formz/formz.dart';

enum MessageFieldModelValidationError { empty }

class MessageFieldModel
    extends FormzInput<String, MessageFieldModelValidationError> {
  const MessageFieldModel.pure() : super.pure('');

  const MessageFieldModel.dirty([super.value = '']) : super.dirty();

  @override
  MessageFieldModelValidationError? validator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return MessageFieldModelValidationError.empty;
    }
    return null;
  }
}
