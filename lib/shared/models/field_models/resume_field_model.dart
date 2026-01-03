import 'package:formz/formz.dart';
import 'package:veteranam/shared/constants/models.dart';

enum ResumeFieldModelValidationError {
  empty,
}

class ResumeFieldModel
    extends FormzInput<FilePickerItem?, ResumeFieldModelValidationError> {
  const ResumeFieldModel.pure() : super.pure(null);

  const ResumeFieldModel.dirty(super.value) : super.dirty();

  @override
  ResumeFieldModelValidationError? validator(FilePickerItem? value) {
    if (value == null || value.bytes.isEmpty) {
      return ResumeFieldModelValidationError.empty;
    }
    return null;
  }
}
