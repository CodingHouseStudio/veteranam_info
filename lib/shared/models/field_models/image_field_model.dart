import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';

enum ImageFieldModelValidationError {
  empty,
}

class ImageFieldModel
    extends FormzInput<XFile?, ImageFieldModelValidationError> {
  const ImageFieldModel.pure() : super.pure(null);

  const ImageFieldModel.dirty([super.value]) : super.dirty();

  @override
  ImageFieldModelValidationError? validator(XFile? value) {
    if (value != null && value.path.isEmpty) {
      return ImageFieldModelValidationError.empty;
    }
    return null;
  }
}
