import 'package:formz/formz.dart';
import 'package:veteranam/shared/shared.dart';

enum LinkNullableFieldModelValidationError {
  // empty,
  invalidLink,
  invalidLength,
}

class LinkNullableFieldModel
    extends FormzInput<String?, LinkNullableFieldModelValidationError> {
  const LinkNullableFieldModel.pure() : super.pure(null);

  const LinkNullableFieldModel.dirty([super.value]) : super.dirty();

  @override
  LinkNullableFieldModelValidationError? validator(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    if (value.length <= 12) {
      return LinkNullableFieldModelValidationError.invalidLength;
    }
    if (!value.isUrlValid) {
      return LinkNullableFieldModelValidationError.invalidLink;
    }
    return null;
  }
}
