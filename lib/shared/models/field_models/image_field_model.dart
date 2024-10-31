import 'package:formz/formz.dart';

import 'package:veteranam/shared/constants/models.dart';

enum ImageFieldModelValidationError {
  empty,
}

class ImageFieldModel
    extends FormzInput<FilePickerItem?, ImageFieldModelValidationError> {
  const ImageFieldModel.pure() : super.pure(null);

  const ImageFieldModel.dirty([super.value]) : super.dirty();

  @override
  ImageFieldModelValidationError? validator(FilePickerItem? value) {
    if (value == null || value.bytes.isEmpty) {
      return ImageFieldModelValidationError.empty;
    }
    return null;
  }
}
