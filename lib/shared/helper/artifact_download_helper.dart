import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:veteranam/shared/shared.dart';

class ArtifactDownloadHelper<T> extends StatefulWidget {
  const ArtifactDownloadHelper({
    required this.items,
    required this.getImageModel,
    super.key,
  });
  final List<T> items;
  final ImageModel? Function(T model) getImageModel;

  @override
  State<ArtifactDownloadHelper<T>> createState() =>
      _ArtifactDownloadHelperState<T>();

  ImageModel? _getImage(int index) => getImageModel(items.elementAt(index));
}

/// Using collectiblesData fetch the data for each artifact
/// and download the image.
/// Resize all images to have multiple sizes (small, medium, large)
/// Save images using format ID.jpg and ID.json
/// OR modify CollectibleData_helper.html to include all data
/// in the collectiblesData list so no JSON is required.
class _ArtifactDownloadHelperState<T> extends State<ArtifactDownloadHelper<T>> {
  late CacheClient cache;
  final http = Client();
  final List<String> missingImage = [];

  @override
  void initState() {
    super.initState();
    createDirectory();
  }

  void createDirectory() {
    cache = CacheClient();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          TextButton(
            onPressed: downloadArtifacts,
            child: const Text('Download Artifacts'),
          ),
          if (cache.read(key: widget._getImage(0)!.name!) != null)
            Row(
              children: [
                Expanded(
                  child: Image.memory(
                    cache.read<Uint8List>(key: widget._getImage(0)!.name!)!,
                  ),
                ),
                Expanded(
                  child: NetworkImageWidget(
                    imageUrl: widget._getImage(0)!.downloadURL,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Future<void> downloadArtifacts() async {
    missingImage.clear();

    /// Download collectibles
    try {
      for (var i = 0; i < widget.items.length; i++) {
        final image = widget._getImage(i);
        if (image != null) {
          final imageName = image.name ??
              image.downloadURL
                  .substring(0, image.downloadURL.lastIndexOf('.') - 1);
          if (await downloadImage(
                imageName,
                image.downloadURL,
              ) ==
              false) {
            missingImage.add(imageName);
          }
        }
      }
    } catch (e) {
      final value = e;
      debugPrint(value.toString());
    }

    // debugPrint('Download complete :) Missing IDs: $missingIds');
  }

  // Future<bool> downloadImageAndJson(String id) async {
  //   File jsonFile = File('$imagesDir/$id.json');
  //   late Map json;
  //   if (jsonFile.existsSync()) {
  //     json = jsonDecode(jsonFile.readAsStringSync()) as Map;
  //   } else {
  //     debugPrint('Downloading $id');
  //     // Fetch JSON for id
  //     Uri uri = Uri.parse(
  //         'https://collectionapi.metmuseum.org/public/collection/v1/objects/$id');
  //     final response = await http.get(uri);
  //     json = jsonDecode(response.body) as Map;
  //   }

  //   // Check if primaryImage field is valid
  //   if (!json.containsKey('primaryImage') || json['primaryImage'].isEmpty) {
  //     return false;
  //   }
  //   // Download image
  //   final url = json['primaryImage'] as String;
  //   //bool isPublicDomain = json['isPublicDomain'] as bool;
  //   File imgFile = File('$imagesDir/$id.jpg');
  //   // If image does not already exist, download it
  //   if (!imgFile.existsSync()) {
  //     await downloadImage(id, url);
  //     if (!imgFile.existsSync()) return false;
  //   }
  //   // Try to resize image
  //   if (await resizeImage(id, [600, 2000]) == false) {
  //     debugPrint('Failed to resize $id');
  //     imgFile.deleteSync();
  //     return false;
  //   }
  //   // Write JSON to file
  //   if (!jsonFile.existsSync()) {
  //     jsonFile.writeAsStringSync(jsonEncode(json));
  //     debugPrint('json saved @ ${jsonFile.path}');
  //   }
  //   return true;
  // }

  Future<bool> downloadImage(String name, String url) async {
    final imgResponse = await get(Uri.parse(url));
    // If the image is less than a KB, it's probably a 404 image.
    if (imgResponse.bodyBytes.lengthInBytes < 2000) {
      return false;
    }
    setState(() {
      cache.write(key: name, value: imgResponse.bodyBytes);
    });
    return true;
  }

  // Future<bool> resizeImage(String id, List<int> sizes) async {
  //   final srcFile = File('$imagesDir/$id.jpg');
  //   //debugPrint('Resizing $id...');
  //   try {
  //     final img = decodeJpg(srcFile.readAsBytesSync());
  //     if (img != null) {
  //       // Write various sizes to disk
  //       for (var size in sizes) {
  //         final resizedFile = File('$imagesDir/${id}_$size.jpg');
  //         if (await resizedFile.exists()) continue;
  //         final resizedImg = copyResize(img, width: size);
  //         await resizedFile.writeAsBytes(encodeJpg(resizedImg, quality: 90));
  //         debugPrint('Resized ${id}_$size');
  //       }
  //       return true;
  //     }
  //   } catch (e) {
  //     debugPrint('Failed to resize $id');
  //     debugPrint(e.toString());
  //   }
  //   return false;
  // }
}
