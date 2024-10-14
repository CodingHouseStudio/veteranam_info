import 'package:veteranam/shared/shared.dart';

abstract class IDataPickerRepository {
  Future<ImagePickerItem?> get getImage;
  Future<ImagePickerItem?> get getFile;
}
