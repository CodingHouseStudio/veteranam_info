import 'package:formz/formz.dart';

import 'package:veteranam/shared/models/discount_model.dart';

enum EligibilityFieldModelValidationError { empty }

class EligibilityFieldModel extends FormzInput<List<EligibilityEnum>,
    EligibilityFieldModelValidationError> {
  const EligibilityFieldModel.pure() : super.pure(const []);

  const EligibilityFieldModel.dirty([super.value = const []]) : super.dirty();

  @override
  EligibilityFieldModelValidationError? validator(
    List<EligibilityEnum>? value,
  ) {
    if (value == null || value.isEmpty) {
      return EligibilityFieldModelValidationError.empty;
    }
    return null;
  }
}
