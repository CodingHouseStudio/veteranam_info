import 'package:veteranam/shared/shared.dart';

abstract class IDataPickerRepository {
  Future<FilePickerItem?> get getImage;
  Future<FilePickerItem?> get getFile;
}
