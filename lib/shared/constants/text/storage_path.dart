import 'package:veteranam/shared/shared.dart';

abstract class StoragePath {
  static const image = 'image';
  static const standartImageFileExtension = '.png';
  static const standartFileExtension = '.pdf';
  static const resume = 'resume';
  static String getFilePath({
    required String collection,
    required String modelId,
    required String file,
    required String? fileExtension,
    required String standartFileExtension,
    // required String? imageName,
  }) =>
      '$collection/$modelId/$file/${'${ExtendedDateTime.id}'
          '${fileExtension ?? fileExtension}'}';
}
