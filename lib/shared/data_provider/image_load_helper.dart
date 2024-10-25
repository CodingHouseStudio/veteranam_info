import 'dart:io' as io; // Use io for platform-agnostic file operations
import 'dart:typed_data' show Uint8List;

// import 'package:dio/browser.dart';
import 'package:dio/dio.dart' show Dio, Options, ResponseType;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory; // For mobile file handling
import 'package:veteranam/shared/shared.dart';

@Singleton(order: -1)
class ArtifactDownloadHelper {
  ArtifactDownloadHelper(this._dio);
  final Dio _dio;

  final String _imagesDir = 'assets/images'; // Use assets directory for mobile

  static final Map<String, Uint8List> _imageMemmoryDir = {};
  final _options = Options(
    responseType: ResponseType.bytes,
    // headers: {
    // Headers.contentTypeHeader: 'image/*',
    // 'Cache-Control': 'max-age=3600',
    // 'Accept': 'image/webp,image/apng,image/*,*/*;q=1.0',
    // 'Connection': 'close',
    // },
    receiveTimeout: const Duration(seconds: 5),
    followRedirects: true,
  );

  static Uint8List? getBytestExist(String key) =>
      _imageMemmoryDir.containsKey(key) ? _imageMemmoryDir[key] : null;

  Future<void> downloadArtifacts(ImageModel imageModel) async {
    try {
      if (!_imageMemmoryDir
              .containsKey(imageModel.name ?? imageModel.downloadURL) &&
          imageModel.downloadURL.isNotEmpty) {
        final byte = await _downloadImage(imageModel);
        if (byte != null) {
          _imageMemmoryDir.addAll(
            {imageModel.name ?? imageModel.downloadURL: byte},
          );
        }
      }
    } catch (error) {
      // Handle download errors\
    }
  }

  Future<Uint8List?> _downloadImage(ImageModel image) async {
    // Handle differently for web vs mobile
    if (kIsWeb) {
      // _dio.httpClientAdapter = BrowserHttpClientAdapter
      // (withCredentials: true);

      final response = await _dio.get<Uint8List>(
        image.downloadURL.getImageUrl,
        options: _options,
      );
      if (response.data == null ||
          response.data!.lengthInBytes < KMinMaxSize.imageMinBytes) {
        // Likely a 404 image, handle error or provide a placeholder
        return null;
      }

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
      final response = await _dio.get<Uint8List>(
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
    return '${directory.path}/$_imagesDir/${image.name ?? image.downloadURL}.txt';
  }

  Future<void> _saveDownloadedImage(String filePath, Uint8List? bytes) async {
    if (bytes == null) return;
    await io.Directory(filePath.substring(0, filePath.lastIndexOf('/')))
        .create(recursive: true);
    await io.File(filePath).writeAsBytes(bytes);
  }
}
