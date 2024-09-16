import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart' show kIsWeb, kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/shared/shared.dart';
// import 'package:cached_network_image/cached_network_image.dart';

class NetworkImageWidget extends StatefulWidget {
  const NetworkImageWidget({
    required this.imageUrl,
    // this.useCloudflare,
    super.key,
    this.fit,
    this.size,
    this.highQuality,
    this.imageName,
    // this.skeletonizerLoading = true,
    // this.loadingIndicatorColor,
  });
  final String imageUrl;
  final BoxFit? fit;
  final double? size;
  final bool? highQuality;
  final String? imageName;
  // final bool skeletonizerLoading;

  @override
  State<NetworkImageWidget> createState() => _NetworkImageWidgetState();
}

class _NetworkImageWidgetState extends State<NetworkImageWidget> {
  late Uint8List? bytes;

  @override
  void initState() {
    super.initState();
    bytes = ArtifactDownloadHelper.getBytestExist(
      widget.imageName ?? widget.imageUrl,
    );
  }

  @override
  void didChangeDependencies() {
    if (kIsWeb || context.read<MobOfflineModeCubit>().state.isOffline) {
      precacheImage(
        bytes == null
            ? CachedNetworkImageProvider(
                widget.imageUrl.getImageUrl, // widget.imageUrl,
                headers: const {
                  'Cache-Control': 'max-age=3600',
                },
              )
            : MemoryImage(
                bytes!,
              ),
        context,
      );
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // return Text('${bytes == null}');
    if (bytes == null) {
      if (kIsWeb || context.read<MobOfflineModeCubit>().state.isOffline) {
        return CachedNetworkImage(
          imageUrl: widget.imageUrl.getImageUrl, // widget.imageUrl,
          fit: widget.fit,
          height: widget.size,
          width: widget.size,
          errorWidget: (context, url, error) => KIcon.error,
          httpHeaders: const {
            'Cache-Control': 'max-age=3600',
          },
          filterQuality: widget.highQuality ?? false
              ? FilterQuality.high
              : FilterQuality.low,
          placeholder: (context, url) =>
              // skeletonizerLoading
              //     ? const SkeletonizerWidget(
              //         isLoading: true,
              //         child: CircularProgressIndicator.adaptive(),
              //       )
              //     :
              const CircularProgressIndicator.adaptive(
            valueColor:
                AlwaysStoppedAnimation(AppColors.materialThemeKeyColorsPrimary),
            strokeWidth: 5,
          ),
        );
      } else {
        return Image.network(
          widget.imageUrl,
          fit: widget.fit,
          height: widget.size,
          width: widget.size,
          errorBuilder: (context, url, error) => KIcon.error,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return const CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation(
                AppColors.materialThemeKeyColorsPrimary,
              ),
              strokeWidth: 5,
            );
          },
        );
      }
    } else {
      return Image.memory(
        bytes!,
        fit: widget.fit,
        height: widget.size,
        width: widget.size,
        errorBuilder: (context, url, error) => KIcon.error,
        cacheHeight: widget.size?.toInt() ?? KMinMaxSize.kImageMaxSize,
        cacheWidth: widget.size?.toInt() ?? KMinMaxSize.kImageMaxSize,
        filterQuality: FilterQuality.high,
      );
    }
    // if (KTest.testIsWeb) {
    //   return _NetworkWebImageWidget(
    //     imageUrl: imageUrl,
    //     fit: fit,
    //     size: size,
    //     // skeletonizerLoading: skeletonizerLoading,
    //     // loadingIndicatorColor: loadingIndicatorColor,
    //   );
    // }
    // return _NetworkMobileImageWidget(
    //   imageUrl: imageUrl,
    //   fit: fit,
    //   size: size,
    //   // skeletonizerLoading: skeletonizerLoading,
    //   // loadingIndicatorColor: loadingIndicatorColor,
    // );
  }
}

// class _NetworkMobileImageWidget extends StatelessWidget {
//   const _NetworkMobileImageWidget({
//     required this.imageUrl,
//     // required this.skeletonizerLoading,
//     // required this.loadingIndicatorColor,
//     this.fit,
//     this.size,
//   });
//   final String imageUrl;
//   final BoxFit? fit;
//   final double? size;
//   // final Color? loadingIndicatorColor;
//   // final bool skeletonizerLoading;

//   @override
//   Widget build(BuildContext context) {
//     return CachedNetworkImage(
//       imageUrl: imageUrl,
//       fit: fit,
//       height: size,
//       width: size,
//       errorWidget: (context, url, error) => KIcon.error,
//       placeholder: (context, url) =>
//           // skeletonizerLoading
//           //     ? const SkeletonizerWidget(
//           //         isLoading: true,
//           //         child: CircularProgressIndicator.adaptive(),
//           //       )
//           //     :
//           const CircularProgressIndicator.adaptive(
//         valueColor:
//             AlwaysStoppedAnimation(AppColors.materialThemeKeyColorsPrimary),
//         strokeWidth: 5,
//       ),
//     );
//   }
// }

// class _NetworkWebImageWidget extends StatefulWidget {
//   const _NetworkWebImageWidget({
//     required this.imageUrl,
//     // required this.skeletonizerLoading,
//     // required this.loadingIndicatorColor,
//     this.fit,
//     this.size,
//   });

//   final String imageUrl;
//   final BoxFit? fit;
//   final double? size;
//   // final bool skeletonizerLoading;
//   // final Color? loadingIndicatorColor;

//   @override
//   State<_NetworkWebImageWidget> createState() => _NetworkWebImageWidgetState
// ();
// }

// class _NetworkWebImageWidgetState extends State<_NetworkWebImageWidget> {
//   late Image image;
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void didChangeDependencies() {
// precacheImage(
//   NetworkImage(
//     widget.imageUrl,
//   ),
//   context,
// );
//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Precache the image with error handling

//     return Image.network(
//        widget.imageUrl,
//       fit: widget.fit,
//       width: widget.size,
//       height: widget.size,
//       headers: const {
//         'Cache-Control': 'max-age=3600',
//       },
//       loadingBuilder: (context, child, loadingProgress) {
//         if (loadingProgress == null) {
//           return child;
//         }
//         // if (widget.skeletonizerLoading) {
//         //   return const SkeletonizerWidget(
//         //     isLoading: true,
//         //     child: SizedBox.shrink(),
//         //   );
//         // } else {
//         return const CircularProgressIndicator.adaptive(
//           valueColor:
//               AlwaysStoppedAnimation(AppColors.materialThemeKeyColorsPrimary)
//       ,
//           strokeWidth: 5,
//         );
//         // }
//       },
//       errorBuilder: (context, error, stackTrace) {
//         // debugPrint('Image load error: $error');
//         return KIcon.error;
//       },
//     );

//     // Alternative: Using CachedNetworkImage
//     // return CachedNetworkImage(
//     //   imageUrl: imageUrl,
//     //   placeholder: (context, url) =>
//     //       const CircularProgressIndicator.adaptive(),
//     //   errorWidget: (context, url, error) {
//     //     debugPrint('Image load error: $error');
//     //     return const Icon(Icons.error);
//     //   },
//     //   fit: fit,
//     //   width: size,
//     //   height: size,
//     // );
//   }
// }
