import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    required this.imageUrl,
    this.fit,
    super.key,
    this.size,
  });

  final String imageUrl;
  final BoxFit? fit;
  final double? size;

  @override
  Widget build(BuildContext context) {
    // ignore: flutter_style_todos
    /// TODO: FIX
    // Precache the image with error handling
    // precacheImage(
    //   NetworkImage(
    //     imageUrl,
    //     headers: {
    //       'Cache-Control': 'max-age=7200',
    //     },
    //   ),
    //   context,
    // )

    return Image.network(
      imageUrl,
      fit: fit,
      width: size,
      height: size,
      // headers: const {
      //   'Cache-Control': 'max-age=7200',
      // },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        debugPrint('Image load error: $error');
        return const Icon(Icons.error);
      },
    );

    // Alternative: Using CachedNetworkImage
    // return CachedNetworkImage(
    //   imageUrl: imageUrl,
    //   placeholder: (context, url) =>
    //       const CircularProgressIndicator.adaptive(),
    //   errorWidget: (context, url, error) {
    //     debugPrint('Image load error: $error');
    //     return const Icon(Icons.error);
    //   },
    //   fit: fit,
    //   width: size,
    //   height: size,
    // );
  }
}
