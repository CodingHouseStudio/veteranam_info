import 'package:file_picker/file_picker.dart' deferred as file_picker
    show FilePicker, FilePickerResult, FileType;
import 'package:freezed_annotation/freezed_annotation.dart'
    show visibleForTesting;
import 'package:image_picker/image_picker.dart'
    show ImagePicker, ImageSource, XFile;
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

@Singleton(as: IDataPickerRepository)
class DataPickerRepository implements IDataPickerRepository {
  DataPickerRepository({
    required ImagePicker imagePciker,
  }) : _imagePciker = imagePciker;
  final ImagePicker _imagePciker;
  @visibleForTesting
  static const imageSource = ImageSource.gallery;
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
      // It's a big library
      await file_picker.loadLibrary();
      final fileResult = await file_picker.FilePicker.platform.pickFiles(
        type: file_picker.FileType.custom,
        allowedExtensions: fileAllowedExtensions,
      );
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
    } catch (e) {
      return null;
    }
  }
}
