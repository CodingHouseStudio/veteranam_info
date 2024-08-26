import 'package:veteranam/shared/shared.dart';

abstract class StoragePath {
  static const _image = 'image';
  static const _standartImageFileExtension = 'png';
  static const _resume = 'resume';
  static String getImagePath({
    required String collection,
    required String modelId,
    String? imageName,
  }) =>
      '$collection/$modelId/$_image/${imageName ?? '${ExtendedDateTime.id}.$_standartImageFileExtension'}';

  static String getResumePath({
    required String collection,
    required String modelId,
    required String fileExtension,
    String? resumeName,
  }) =>
      '$collection/$modelId/$_resume/${resumeName ?? '${ExtendedDateTime.id}.$fileExtension'}';
}
