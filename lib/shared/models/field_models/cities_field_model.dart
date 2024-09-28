import 'package:formz/formz.dart';
import 'package:veteranam/shared/shared.dart';

enum CitiesFieldModelValidationError { empty }

class CitiesFieldModel
    extends FormzInput<List<String>?, CitiesFieldModelValidationError> {
  const CitiesFieldModel.pure() : super.pure(null);

  const CitiesFieldModel.dirty([super.value]) : super.dirty();

  CitiesFieldModel add(String city) {
    return CitiesFieldModel.dirty(value.addFieldModel(city));
  }

  CitiesFieldModel remove(String city) {
    return CitiesFieldModel.dirty(value.removeFieldModel(city));
  }

  @override
  CitiesFieldModelValidationError? validator(List<String>? value) {
    if (value == null ||
        value.isEmpty ||
        value.every(
          (element) => element.trim().isEmpty,
        )) {
      return CitiesFieldModelValidationError.empty;
    }
    return null;
  }
}
