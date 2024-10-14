import 'package:formz/formz.dart';

enum CitiesFieldModelValidationError { empty, limit }

class CitiesFieldModel
    extends FormzInput<List<String>, CitiesFieldModelValidationError> {
  const CitiesFieldModel.pure() : super.pure(const []);

  const CitiesFieldModel.dirty([super.value = const []]) : super.dirty();

  @override
  CitiesFieldModelValidationError? validator(List<String>? value) {
    if (value == null ||
        value.isEmpty ||
        value.every(
          (element) => element.trim().isEmpty,
        )) {
      return CitiesFieldModelValidationError.empty;
    }
    if (value.length > 30) {
      return CitiesFieldModelValidationError.limit;
    }
    return null;
  }
}
