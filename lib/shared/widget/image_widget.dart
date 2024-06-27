// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

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
    return Image.network(
      imageUrl,
      // placeholder: (context, url) =>
      //     const CircularProgressIndicator.adaptive(), //Image.asset(''),
      // errorWidget: (context, url, error) {
      //   debugPrint('image error: $error');
      //   return KIcon.error;
      // },
      fit: fit,
      width: size,
      height: size,
      cacheWidth: KMinMaxSize.kImageMaxSize,
      cacheHeight: KMinMaxSize.kImageMaxSize,
    );
    // return CachedNetworkImage(
    //   imageUrl: imageUrl,
    //   placeholder: (context, url) =>
    //       const CircularProgressIndicator.adaptive(), //Image.asset(''),
    //   errorWidget: (context, url, error) {
    //     debugPrint('image error: $error');
    //     return KIcon.error;
    //   },
    //   fit: fit,
    //   width: size,
    //   height: size,
    //   isAntiAlias:
    // );
  }
}
