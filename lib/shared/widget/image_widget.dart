import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';

// coverage:ignore-file
class ImageWidget extends StatefulWidget {
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
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(
      NetworkImage(
        widget.imageUrl,
        // headers: {
        //   'Cache-Control': 'max-age=3600',
        // },
      ),
      context,
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // Precache the image with error handling

    return Image.network(
      widget.imageUrl,
      fit: widget.fit,
      width: widget.size,
      height: widget.size,
      headers: const {
        'Cache-Control': 'max-age=3600',
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        // debugPrint('Image load error: $error');
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
