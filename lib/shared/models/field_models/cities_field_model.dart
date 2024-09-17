import 'package:formz/formz.dart';

enum CitiesFieldModelValidationError { empty }

class CitiesFieldModel
    extends FormzInput<List<String>?, CitiesFieldModelValidationError> {
  const CitiesFieldModel.pure() : super.pure(null);

  const CitiesFieldModel.dirty([super.value]) : super.dirty();

  @override
  CitiesFieldModelValidationError? validator(List<String>? value) {
    if (value == null ||
        value.isEmpty ||
        value.every(
          (element) => element.isEmpty,
        )) {
      return CitiesFieldModelValidationError.empty;
    }
    return null;
  }
}
