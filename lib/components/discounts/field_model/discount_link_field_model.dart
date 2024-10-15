import 'package:formz/formz.dart';
import 'package:veteranam/shared/shared.dart';

enum DiscountLinkFieldModelValidationError {
  empty,
  invalidLink,
  invalidLength,
}

class DiscountLinkFieldModel
    extends FormzInput<String, DiscountLinkFieldModelValidationError> {
  const DiscountLinkFieldModel.pure() : super.pure('');

  const DiscountLinkFieldModel.dirty([super.value = '']) : super.dirty();

  @override
  DiscountLinkFieldModelValidationError? validator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return DiscountLinkFieldModelValidationError.empty;
    }
    if (value.length <= 12) {
      return DiscountLinkFieldModelValidationError.invalidLength;
    }
    if (!value.isUrlValid) {
      return DiscountLinkFieldModelValidationError.invalidLink;
    }
    return null;
  }
}
