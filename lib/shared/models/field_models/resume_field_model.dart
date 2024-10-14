import 'package:formz/formz.dart';
import 'package:veteranam/shared/shared.dart';

enum ResumeFieldModelValidationError {
  empty,
}

class ResumeFieldModel
    extends FormzInput<ImagePickerItem?, ResumeFieldModelValidationError> {
  const ResumeFieldModel.pure() : super.pure(null);

  const ResumeFieldModel.dirty(super.value) : super.dirty();

  @override
  ResumeFieldModelValidationError? validator(ImagePickerItem? value) {
    if (value == null || value.bytes.isEmpty) {
      return ResumeFieldModelValidationError.empty;
    }
    return null;
  }
}
