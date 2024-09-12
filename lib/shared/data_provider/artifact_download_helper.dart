import 'dart:async';
import 'dart:io' as io;
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb, kReleaseMode;
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart'; // For mobile file handling
import 'package:veteranam/shared/shared.dart';

@Singleton(order: -1)
class ArtifactDownloadHelper {
  ArtifactDownloadHelper(this.dio);
  final Dio dio;

  final String imagesDir = 'assets/images'; // Use assets directory for web

  static final Map<String, Uint8List> _imageMemmoryDir = {};

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
      // return image;
    } catch (error) {
      // Handle download errors gracefully (e.g., logging, UI feedback)
      // return imageModel; // Return original image or provide a placeholder
    }
  }

  Future<Uint8List?> _downloadImage(ImageModel image) async {
    if (image.downloadURL.isEmpty) {
      return null; // No URL, no download
    }

    // Handle differently for web vs mobile
    if (kIsWeb) {
      // On web, just download and keep in memory
      final imgResponse = await dio.get<Uint8List>(
        _url(image.downloadURL),
        options: Options(responseType: ResponseType.bytes),
      );
      if (imgResponse.data == null || imgResponse.data!.lengthInBytes < 2000) {
        // Likely a 404 image, handle error or provide a placeholder
        return null;
      }

      return imgResponse.data;
    } else {
      // On mobile, use the local filesystem
      final filePath = await _getLocalImagePath(image);

      if (io.File(filePath).existsSync()) {
        // Image already exists locally, use cached bytes
        final bytes = await io.File(filePath).readAsBytes();
        return bytes;
      }

      // Download the image
      final imgResponse = await dio.get<Uint8List>(
        _url(image.downloadURL),
        options: Options(responseType: ResponseType.bytes),
      );
      if (imgResponse.data == null || imgResponse.data!.lengthInBytes < 2000) {
        // Likely a 404 image, handle error or provide a placeholder
        return null;
      }

      // Save to local file system
      await _saveDownloadedImage(filePath, imgResponse.data);
      return io.File(filePath).readAsBytes();
    }
  }

  String _url(String imageUrl) {
    if ((Config.isProduction && kReleaseMode) || !kIsWeb) {
      final url = kIsWeb ? Uri.base.origin : 'https://veteranam.info';
      return '$url$_urlPrefix$imageUrl';
    } else {
      return imageUrl;
    }
  }

  String get _urlPrefix {
    // widget.size == null
    // ?
    const quality = '85';
    const format = 'auto'; // KPlatformConstants.isWebSaffari ? 'jpeg' : 'auto';
    return '/cdn-cgi/image/quality=$quality,format=$format/';
  }

  Future<String> _getLocalImagePath(ImageModel image) async {
    final directory = await getApplicationDocumentsDirectory();
    // Use app directory for mobile
    return '${directory.path}/$imagesDir/${image.name ?? image.downloadURL}.jpg';
  }

  Future<void> _saveDownloadedImage(String filePath, Uint8List? bytes) async {
    if (bytes == null) return;
    await io.Directory(filePath.substring(0, filePath.lastIndexOf('/')))
        .create(recursive: true);
    await io.File(filePath).writeAsBytes(bytes);
  }
}
