import 'dart:developer' show log;
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/shared/data_provider/image_load_helper.dart';
import 'package:veteranam/shared/shared_flutter.dart';
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
    this.imageBytes,
    // this.skeletonizerLoading = true,
    // this.loadingIndicatorColor,
  });
  final String? imageUrl;
  final BoxFit? fit;
  final double? size;
  final bool? highQuality;
  final String? imageName;
  final Uint8List? imageBytes;
  // final bool skeletonizerLoading;

  @override
  State<NetworkImageWidget> createState() => _NetworkImageWidgetState();
}

class _NetworkImageWidgetState extends State<NetworkImageWidget> {
  Uint8List? bytes;

  @override
  void initState() {
    super.initState();
    if (widget.imageBytes == null) {
      bytes = ArtifactDownloadHelper.getBytestExist(
        widget.imageName ?? widget.imageUrl!,
      );
    } else {
      bytes = widget.imageBytes;
    }
  }

  @override
  void didChangeDependencies() {
    if (Config.isWeb || context.read<MobOfflineModeCubit>().state.isOffline) {
      try {
        precacheImage(
          bytes == null
              ? CachedNetworkImageProvider(
                  widget.imageUrl!.getImageUrl, // widget.imageUrl,
                  headers: const {
                    'Cache-Control': 'max-age=3600',
                  },
                )
              : MemoryImage(
                  bytes!,
                ),
          context,
          onError: (exception, stackTrace) {
            log(
              'Precache Image $exception',
              error: exception,
              stackTrace: stackTrace,
              name: 'Cached Network Image',
            );
          },
        );
      } catch (e, stack) {
        log(
          'Image cache error',
          error: e,
          stackTrace: stack,
          level: KDimensions.logLevelWarning,
          name: 'precacheImage',
        );
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // return Text('${bytes == null}');
    if (bytes == null && widget.imageUrl != null) {
      if (Config.isWeb || context.read<MobOfflineModeCubit>().state.isOffline) {
        return getCachedNetworkImage(
          widget.imageUrl!.getImageUrl,
        );
      } else {
        return getImageNetwork(widget.imageUrl!.getImageUrl);
      }
    } else {
      if (bytes != null) {
        return Image.memory(
          bytes!,
          fit: widget.fit,
          height: widget.size,
          width: widget.size,
          errorBuilder: (context, error, stack) {
            log(
              'Image memory error',
              error: error,
              stackTrace: stack,
              level: KDimensions.logLevelError,
              name: 'Image Length: ${bytes!.length}',
            );
            SomeFailure.serverError(
              error: 'URL: ${widget.imageUrl}, Error: $error',
              tag: 'Memory',
              tagKey: ErrorText.imageKey,
              errorLevel: ErrorLevelEnum.warning,
              data: 'Image Length: ${bytes!.length}',
            );
            return KIcon.error;
          },
          cacheHeight: KMinMaxSize.kImageMaxSize,
          cacheWidth: KMinMaxSize.kImageMaxSize,
          filterQuality: widget.highQuality ?? false
              ? FilterQuality.high
              : FilterQuality.medium,
        );
      }
      return const SizedBox.shrink();
    }
    // if (Config.isWeb) {
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

  Widget getImageNetwork(String? imageUrl) => Image.network(
        imageUrl!,
        fit: widget.fit,
        height: widget.size,
        width: widget.size,
        errorBuilder: (context, error, stack) {
          if (imageUrl != widget.imageUrl) {
            return getImageNetwork(widget.imageUrl);
          } else {
            log(
              'Image network error',
              error: error,
              stackTrace: stack,
              level: KDimensions.logLevelError,
              name: 'URL: ${widget.imageUrl}',
            );
            SomeFailure.serverError(
              error: 'URL: ${widget.imageUrl}, Error: $error',
              tag: 'Network',
              tagKey: ErrorText.imageKey,
              errorLevel: ErrorLevelEnum.warning,
              data: 'URL: ${widget.imageUrl}',
            );
            return KIcon.error;
          }
        },
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

  Widget getCachedNetworkImage(String? imageUrl) => CachedNetworkImage(
        imageUrl: imageUrl!, // widget.imageUrl,
        fit: widget.fit,
        height: widget.size,
        width: widget.size,
        errorWidget: (context, url, error) {
          if (imageUrl != widget.imageUrl) {
            return getCachedNetworkImage(widget.imageUrl);
          } else {
            log(
              'Cached Network Image error with url : $url',
              error: error,
              name: 'URL: $url',
              level: KDimensions.logLevelError,
            );
            SomeFailure.serverError(
              error: error,
              tag: 'CachedNetworkImage',
              tagKey: ErrorText.imageKey,
              errorLevel: ErrorLevelEnum.warning,
              data: 'URL: $url',
            );
            return KIcon.error;
          }
        },
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
  // bool get imageHasUrl => widget.imageBytes == null &&
  // widget.imageUrl != null;
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
//         return KIcon.error;
//       },
//     );

//     // Alternative: Using CachedNetworkImage
//     // return CachedNetworkImage(
//     //   imageUrl: imageUrl,
//     //   placeholder: (context, url) =>
//     //       const CircularProgressIndicator.adaptive(),
//     //   errorWidget: (context, url, error) {
//     //     return const Icon(Icons.error);
//     //   },
//     //   fit: fit,
//     //   width: size,
//     //   height: size,
//     // );
//   }
// }
