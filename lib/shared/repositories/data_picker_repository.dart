import 'package:file_picker/file_picker.dart'
    show FilePicker, FilePickerResult, FileType;
import 'package:flutter/foundation.dart' show Uint8List, visibleForTesting;
import 'package:image_picker/image_picker.dart'
    show ImagePicker, ImageSource, XFile;
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

class FilePickerItem {
  FilePickerItem({
    required this.bytes,
    required this.name,
    required this.ref,
    this.extension,
  });

  final Uint8List bytes;
  final String? extension;
  final String? name;
  final String? ref;

  static Future<FilePickerItem?> getFromImage(XFile? image) async {
    if (image == null) return null;
    final hasExtension = image.name.contains('.');
    return FilePickerItem(
      bytes: await image.readAsBytes(),
      extension: hasExtension
          ? image.name.substring(
              image.name.lastIndexOf('.'),
            )
          : null,
      name: image.name,
      ref: image.path,
    );
  }

  static Future<FilePickerItem?> getFromFile(
    FilePickerResult? fileResult,
  ) async {
    if (fileResult == null) return null;
    final file = fileResult.files.first;
    if (file.bytes == null) return null;
    final hasExtension = file.name.contains('.');
    return FilePickerItem(
      bytes: file.bytes!,
      extension: hasExtension
          ? file.name.substring(
              file.name.lastIndexOf('.'),
            )
          : null,
      name: file.name,
      ref: file.path,
    );
  }

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
