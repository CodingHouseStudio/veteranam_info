import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

class ImagePickerItem {
  ImagePickerItem({
    required this.bytes,
    required this.name,
    required this.ref,
    this.extension,
  });

  final Uint8List bytes;
  final String? extension;
  final String? name;
  final String? ref;

  static Future<ImagePickerItem> get(XFile file) async => ImagePickerItem(
        bytes: await file.readAsBytes(),
        extension: file.name.substring(
          file.name.lastIndexOf('.'),
        ),
        name: file.name,
        ref: file.path,
      );

  ImageModel image(String downloadURL) => ImageModel(
        downloadURL: downloadURL,
        name: name,
        ref: ref,
        type: extension,
      );

  ResumeModel resume(String downloadURL) => ResumeModel(
        downloadURL: downloadURL,
        name: name,
        ref: ref,
        type: extension,
      );
}

@Singleton(
  env: [Config.business, Config.development],
  as: IDataPickerRepository,
)
class DataPickerRepository implements IDataPickerRepository {
  DataPickerRepository(
    this._imagePciker,
  );
  final ImagePicker _imagePciker;

  @override
  Future<ImagePickerItem?> get getImage async {
    try {
      final imageFile =
          await _imagePciker.pickImage(source: ImageSource.gallery);
      return imageFile == null ? null : ImagePickerItem.get(imageFile);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<ImagePickerItem?> get getFile async {
    try {
      final imageFile = await _imagePciker.pickMedia();
      return imageFile == null ? null : ImagePickerItem.get(imageFile);
    } catch (e) {
      return null;
    }
  }
}
