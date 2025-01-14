import 'package:formz/formz.dart';
import 'package:veteranam/shared/extension/extension_dart.dart';

enum LinkFieldModelValidationError {
  // empty,
  invalidLink,
  invalidLength,
}

class LinkFieldModel
    extends FormzInput<String?, LinkFieldModelValidationError> {
  const LinkFieldModel.pure() : super.pure(null);

  const LinkFieldModel.dirty([super.value]) : super.dirty();

  @override
  LinkFieldModelValidationError? validator(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    if (!value.isUrlValid) {
      return LinkFieldModelValidationError.invalidLink;
    }
    if (value.length < 12) {
      return LinkFieldModelValidationError.invalidLength;
    }
    return null;
  }
}
