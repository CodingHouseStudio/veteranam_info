import 'package:veteranam/shared/shared.dart';

abstract class StoragePath {
  static const _image = 'image';
  static const standartImageFileExtension = '.png';
  static const standartFileExtension = '.pdf';
  static const _resume = 'resume';
  static String getImagePath({
    required String collection,
    required String modelId,
    required String? imageExtension,
    // required String? imageName,
  }) =>
      '$collection/$modelId/$_image/${'${ExtendedDateTime.id}'
          '${imageExtension ?? standartImageFileExtension}'}';

  static String getResumePath({
    required String collection,
    required String modelId,
    required String? fileExtension,
    // String? resumeName,
  }) =>
      '$collection/$modelId/$_resume/${'${ExtendedDateTime.id}'
          '${fileExtension ?? standartFileExtension}'}';
}
