import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';

enum ResumeFieldModelValidationError {
  empty,
}

class ResumeFieldModel
    extends FormzInput<XFile?, ResumeFieldModelValidationError> {
  const ResumeFieldModel.pure() : super.pure(null);

  const ResumeFieldModel.dirty([super.value]) : super.dirty();

  @override
  ResumeFieldModelValidationError? validator(XFile? value) {
    if (value == null || value.path.isEmpty) {
      return ResumeFieldModelValidationError.empty;
    }
    return null;
  }
}
