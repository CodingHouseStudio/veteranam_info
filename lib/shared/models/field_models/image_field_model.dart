import 'package:formz/formz.dart';
import 'package:veteranam/shared/shared.dart';

enum ImageFieldModelValidationError {
  empty,
}

class ImageFieldModel
    extends FormzInput<ImagePickerItem?, ImageFieldModelValidationError> {
  const ImageFieldModel.pure() : super.pure(null);

  const ImageFieldModel.dirty([super.value]) : super.dirty();

  @override
  ImageFieldModelValidationError? validator(ImagePickerItem? value) {
    if (value == null || value.bytes.isEmpty) {
      return ImageFieldModelValidationError.empty;
    }
    return null;
  }
}
