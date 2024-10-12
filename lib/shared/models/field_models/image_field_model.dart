import 'dart:typed_data';

import 'package:formz/formz.dart';

enum ImageFieldModelValidationError {
  empty,
}

class ImageFieldModel
    extends FormzInput<Uint8List?, ImageFieldModelValidationError> {
  const ImageFieldModel.pure() : super.pure(null);

  const ImageFieldModel.dirty([super.value]) : super.dirty();

  @override
  ImageFieldModelValidationError? validator(Uint8List? value) {
    if (value == null || value.isEmpty) {
      return ImageFieldModelValidationError.empty;
    }
    return null;
  }
}
