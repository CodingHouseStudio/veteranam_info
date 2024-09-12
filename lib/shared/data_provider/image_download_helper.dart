import 'dart:async';
import 'dart:io' as io; // Use io for platform-agnostic file operations
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart'; // For mobile file handling
import 'package:veteranam/shared/shared.dart';

@Singleton(order: -1)
class ArtifactDownloadHelper {
  ArtifactDownloadHelper(this.dio);
  final Dio dio;

  final String imagesDir = 'assets/images'; // Use assets directory for mobile

  static final Map<String, Uint8List> _imageMemmoryDir = {};
  final _options = Options(responseType: ResponseType.bytes);

  static Uint8List? getBytestExist(String key) =>
      _imageMemmoryDir.containsKey(key) ? _imageMemmoryDir[key] : null;

  Future<void> downloadArtifacts(ImageModel imageModel) async {
    try {
      final byte = await _downloadImage(imageModel);
      if (byte != null) {
        _imageMemmoryDir.addAll(
          {imageModel.name ?? imageModel.downloadURL: byte},
        );
      }
    } catch (error) {
      // Handle download errors
    }
  }

  Future<Uint8List?> _downloadImage(ImageModel image) async {
    if (image.downloadURL.isEmpty) {
      return null; // No URL, no download
    }

    // Check memory cache first
    final cachedBytes = getBytestExist(image.downloadURL);
    if (cachedBytes != null) {
      return cachedBytes;
    }

    // Handle differently for web vs mobile
    if (kIsWeb) {
      // On web, just download and keep in memory

      final response = await dio.get<Uint8List>(
        image.downloadURL.getImageUrl,
        options: _options,
      );
      if (response.data == null ||
          response.data!.lengthInBytes < KMinMaxSize.imageMinBytes) {
        // Likely a 404 image, handle error or provide a placeholder
        return null;
      }

      _imageMemmoryDir[image.downloadURL] = response.data!;
      return response.data;
    } else {
      // On mobile, use the local filesystem
      final filePath = await _getLocalImagePath(image);

      if (io.File(filePath).existsSync()) {
        // Image already exists locally, use cached bytes
        final bytes = await io.File(filePath).readAsBytes();
        return bytes;
      }

      // Download the image
      final response = await dio.get<Uint8List>(
        image.downloadURL.getImageUrl,
        options: _options,
      );
      if (response.data == null ||
          response.data!.lengthInBytes < KMinMaxSize.imageMinBytes) {
        // Likely a 404 image, handle error or provide a placeholder
        return null;
      }

      // Save to local file system
      await _saveDownloadedImage(filePath, response.data);
      return io.File(filePath).readAsBytes();
    }
  }

  Future<String> _getLocalImagePath(ImageModel image) async {
    final directory = await getApplicationDocumentsDirectory();
    // Use app directory for mobile
    return '${directory.path}/$imagesDir/${image.name ?? image.downloadURL}.txt';
  }

  Future<void> _saveDownloadedImage(String filePath, Uint8List? bytes) async {
    if (bytes == null) return;
    await io.Directory(filePath.substring(0, filePath.lastIndexOf('/')))
        .create(recursive: true);
    await io.File(filePath).writeAsBytes(bytes);
  }
}
