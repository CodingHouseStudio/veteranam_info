import 'package:file_picker/file_picker.dart'
    show FilePicker, FilePickerResult, FileType;
import 'package:flutter/foundation.dart' show Uint8List, visibleForTesting;
import 'package:image_picker/image_picker.dart'
    show ImagePicker, ImageSource, XFile;
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

@Singleton(
  // env: [Config.business, Config.development],
  as: IDataPickerRepository,
)
class DataPickerRepository implements IDataPickerRepository {
  DataPickerRepository(
    this._imagePciker,
    this._filePicker,
  );
  final ImagePicker _imagePciker;
  final FilePicker _filePicker;
  @visibleForTesting
  static const imageSource = ImageSource.gallery;
  @visibleForTesting
  static const fileType = FileType.custom;
  @visibleForTesting
  static const fileAllowedExtensions = ['pdf', 'word'];
  @override
  Future<FilePickerItem?> get getImage async {
    try {
      final imageFile = await _imagePciker.pickImage(source: imageSource);
      return FilePickerItem.getFromImage(imageFile);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<FilePickerItem?> get getFile async {
    try {
      final file = await _filePicker.pickFiles(
        type: fileType,
        allowedExtensions: fileAllowedExtensions,
      );
      return FilePickerItem.getFromFile(file);
    } catch (e) {
      return null;
    }
  }
}
