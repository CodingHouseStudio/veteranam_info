import 'package:veteranam/shared/shared_dart.dart';

abstract class IDataPickerRepository {
  Future<FilePickerItem?> get getImage;
  Future<FilePickerItem?> get getFile;
}
