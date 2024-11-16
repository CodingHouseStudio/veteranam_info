import 'package:image_picker/image_picker.dart' show ImagePicker;
import 'package:injectable/injectable.dart';

@module
abstract class DataPickerModule {
  @singleton
  ImagePicker get imagePicker => ImagePicker();
}
