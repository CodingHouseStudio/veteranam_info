import 'dart:async';

import 'dart:io' as io; // Use io for platform-agnostic file operations
// import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http_library;
import 'package:injectable/injectable.dart';

import 'package:path_provider/path_provider.dart'; // For mobile file handling
import 'package:veteranam/shared/shared.dart';

@Singleton(order: -1)
class ArtifactDownloadHelper {
  ArtifactDownloadHelper({required this.http});
  final http_library.Client http;

  final String imagesDir = 'assets/images'; // Use assets directory for web

  Future<ImageModel> downloadArtifacts(ImageModel imageModel) async {
    try {
      final image = await _downloadImage(imageModel);
      return image;
    } catch (error) {
      // Handle download errors gracefully (e.g., logging, UI feedback)
      return imageModel; // Return original image or provide a placeholder
    }
  }

  Future<ImageModel> _downloadImage(ImageModel image) async {
    if (image.downloadURL.isEmpty) {
      return image; // No URL, no download
    }

    // Handle differently for web vs mobile
    // if (kIsWeb) {
    //   // On web, just download and keep in memory
    //   final imgResponse = await http.get(Uri.parse(image.downloadURL));
    //   if (imgResponse.bodyBytes.lengthInBytes < 2000) {
    //     // Likely a 404 image, handle error or provide a placeholder
    //     return image;
    //   }

    //   return image.copyWith(bytes: imgResponse.bodyBytes);
    // } else {
    // On mobile, use the local filesystem
    debugPrint('START LOADE IMAGE: ${DateTime.now()}');
    final filePath = await _getLocalImagePath(image);
    debugPrint('_getLocalImagePath LOADE IMAGE: ${DateTime.now()}');

    if (io.File(filePath).existsSync()) {
      // Image already exists locally, use cached bytes
      final bytes = await io.File(filePath).readAsBytes();
      debugPrint('FINISH LOADE IMAGE: ${DateTime.now()}');
      return image.copyWith(bytes: bytes);
    }

    // Download the image
    final imgResponse = await http.get(Uri.parse(image.downloadURL));
    if (imgResponse.bodyBytes.lengthInBytes < 2000) {
      // Likely a 404 image, handle error or provide a placeholder
      return image;
    }

    // Save to local file system
    await _saveDownloadedImage(filePath, imgResponse.bodyBytes);
    return image.copyWith(bytes: await io.File(filePath).readAsBytes());
    // }
  }

  Future<String> _getLocalImagePath(ImageModel image) async {
    final directory = await getApplicationDocumentsDirectory();
    // Use app directory for mobile
    return '${directory.path}/$imagesDir/${image.name ?? image.downloadURL}.jpg';
  }

  Future<void> _saveDownloadedImage(String filePath, List<int> bytes) async {
    await io.Directory(filePath.substring(0, filePath.lastIndexOf('/')))
        .create(recursive: true);
    await io.File(filePath).writeAsBytes(bytes);
  }
}
