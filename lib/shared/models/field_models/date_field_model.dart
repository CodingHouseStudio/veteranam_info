import 'package:formz/formz.dart';

import 'package:veteranam/shared/extension/extension_constants.dart';

enum DateFieldModelValidationError { empty }

class DateFieldModel
    extends FormzInput<DateTime?, DateFieldModelValidationError> {
  // Constructor for pure (initial) state with optional initial DateTime value
  // Since DateTime cannot be null in this setup, you need to provide a default
  // value for the pure constructor.
  const DateFieldModel.pure() : super.pure(null);

  // Constructor for dirty state with required DateTime value
  const DateFieldModel.dirty(super.value) : super.dirty();

  @override
  DateFieldModelValidationError? validator(DateTime? value) {
    // Here, value cannot be null, so you might want to check for a specific
    // date range or other criteria instead
    // Example: Check if the date is in the future
    if (value == null || value.isBefore(ExtendedDateTime.current)) {
      return DateFieldModelValidationError.empty;
    }
    return null;
  }
}
