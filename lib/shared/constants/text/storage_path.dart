import 'package:kozak/shared/shared.dart';

abstract class StoragePath {
  static const _image = 'image';
  static const _standartFileExtension = 'png';
  static String getPath({
    required String collenction,
    required String modelId,
    String? imageName,
  }) =>
      '$collenction/$modelId/$_image/${imageName ?? '${ExtendedDateTime.id}.$_standartFileExtension'}';
}
