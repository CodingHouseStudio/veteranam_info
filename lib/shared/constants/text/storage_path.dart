import 'package:veteranam/shared/shared.dart';

abstract class StoragePath {
  static const _image = 'image';
  static const _standartImageFileExtension = 'png';
  static const _resume = 'resume';
  static String getImagePath({
    required String collenction,
    required String modelId,
    String? imageName,
  }) =>
      '$collenction/$modelId/$_image/${imageName ?? '${ExtendedDateTime.id}.$_standartImageFileExtension'}';

  static String getResumePath({
    required String collenction,
    required String modelId,
    required String fileExtension,
    String? resumeName,
  }) =>
      '$collenction/$modelId/$_resume/${resumeName ?? '${ExtendedDateTime.id}.$fileExtension'}';
}
