import 'package:formz/formz.dart';

enum CategoriesFieldModelValidationError { empty, limit }

class CategoriesFieldModel
    extends FormzInput<List<String>, CategoriesFieldModelValidationError> {
  const CategoriesFieldModel.pure() : super.pure(const []);

  const CategoriesFieldModel.dirty([super.value = const []]) : super.dirty();

  @override
  CategoriesFieldModelValidationError? validator(List<String>? value) {
    if (value == null ||
        value.isEmpty ||
        value.every(
          (element) => element.trim().isEmpty,
        )) {
      return CategoriesFieldModelValidationError.empty;
    }
    if (value.length > 2) {
      return CategoriesFieldModelValidationError.limit;
    }
    return null;
  }
}
