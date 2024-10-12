import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

@Singleton(env: [Config.business, Config.development])
class DataPickerRepository {
  DataPickerRepository(
    this._imagePciker,
  );
  final ImagePicker _imagePciker;

  Future<Uint8List?> get getImage async {
    try {
      final imageFile =
          await _imagePciker.pickImage(source: ImageSource.gallery);
      return imageFile?.readAsBytes();
    } catch (e) {
      return null;
    }
  }
}
