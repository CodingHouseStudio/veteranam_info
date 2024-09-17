import 'package:formz/formz.dart';

enum DiscountsFieldModelValidationError { empty }

class DiscountsFieldModel
    extends FormzInput<List<int>?, DiscountsFieldModelValidationError> {
  const DiscountsFieldModel.pure() : super.pure(null);

  const DiscountsFieldModel.dirty([super.value]) : super.dirty();

  @override
  DiscountsFieldModelValidationError? validator(List<int>? value) {
    if (value == null || value.isEmpty) {
      return DiscountsFieldModelValidationError.empty;
    }
    return null;
  }
}
