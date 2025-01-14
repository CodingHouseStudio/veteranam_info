import 'package:flutter/material.dart' show BoxFit, Key;
// import 'package:flutter_svg/svg.dart';
import 'package:veteranam/shared/shared_flutter.dart';

// extension SvgPictureExtension on SvgPicture {
//   SvgPicture copyWith({
//     Key? key,
//     BytesLoader? bytesLoader,
//     double? width,
//     double? height,
//     BoxFit? fit,
//     AlignmentGeometry? alignment,
//     WidgetBuilder? placeholderBuilder,
//     bool? matchTextDirection,
//     bool? allowDrawingOutsideViewBox,
//     String? semanticsLabel,
//     bool? excludeFromSemantics,
//     Clip? clipBehavior,
//     ColorFilter? colorFilter,
//   }) {
//     return SvgPicture(
//       bytesLoader ?? this.bytesLoader,
//       key: key ?? this.key,
//       width: width ?? this.width,
//       height: height ?? this.height,
//       fit: fit ?? this.fit,
//       alignment: alignment ?? this.alignment,
//       placeholderBuilder: placeholderBuilder ?? this.placeholderBuilder,
//       matchTextDirection: matchTextDirection ?? this.matchTextDirection,
//       allowDrawingOutsideViewBox:
//           allowDrawingOutsideViewBox ?? this.allowDrawingOutsideViewBox,
//       semanticsLabel: semanticsLabel ?? this.semanticsLabel,
//       excludeFromSemantics: excludeFromSemantics ??
// this.excludeFromSemantics,
//       clipBehavior: clipBehavior ?? this.clipBehavior,
//       colorFilter: colorFilter ?? this.colorFilter,
//     );
//   }
// }

// extension ImageExension on Image {
//   Image setKey(Key key) => Image(
//         image: image,
//         key: key,
//       );
// }

class KImage {
  // AssetImageWidget(
  //       'assets/images/logo.png',
  //       key: key,
  //       fit: BoxFit.contain,
  //       cacheSize: null,
  //       // cacheSize: KMinMaxSize.kHomeImageMaxSize,
  //       // height: KMinMaxSize.minHeight50,
  //     );
  // static AssetImageWidget logoHome({Key? key}) => AssetImageWidget(
  //       'assets/images/logo_home.svg',
  //       widgetKey: key,
  //     );
  // static AssetImageWidget homeImage({Key? key}) => AssetImageWidget(
  //       'assets/images/home_image.png',
  //       fit: BoxFit.fill,
  //       widgetKey: key,
  //     );
  // static AssetImageWidget homeImageMob({Key? key}) => AssetImageWidget(
  //       'assets/images/home_image_mob.png',
  //       widgetKey: key,
  //     );
  static AssetImageWidget discountImage({Key? key}) => AssetImageWidget(
        'assets/images/discount_image.png',
        fit: BoxFit.fill,
        cacheSize: KMinMaxSize.kHomeImageMaxSize,
        widgetKey: key,
      );
  static AssetImageWidget inforamationImage({Key? key}) => AssetImageWidget(
        'assets/images/information_image.png',
        fit: BoxFit.fill,
        cacheSize: KMinMaxSize.kHomeImageMaxSize,
        widgetKey: key,
      );
  // static AssetImageWidget wavingHand({Key? key}) => AssetImageWidget(
  //       'assets/icons/waving_hand.png',
  //       width: KSize.kPixel16,
  //       height: KSize.kPixel16,
  //       widgetKey: key,
  //     );
  // static AssetImageWidget coffee({Key? key}) => AssetImageWidget(
  //       'assets/icons/hot_beverage.png',
  //       widgetKey: key,
  //     );
  static AssetImageWidget veteran1({Key? key}) => AssetImageWidget(
        'assets/images/veteran1.png',
        widgetKey: key,
      );
  static AssetImageWidget veteran2({Key? key}) => AssetImageWidget(
        'assets/images/veteran2.png',
        widgetKey: key,
      );
  static AssetImageWidget veteran3({Key? key}) => AssetImageWidget(
        'assets/images/veteran3.png',
        widgetKey: key,
      );
  static AssetImageWidget veteran4({Key? key}) => AssetImageWidget(
        'assets/images/veteran4.png',
        widgetKey: key,
      );
  static AssetImageWidget veteran5({Key? key}) => AssetImageWidget(
        'assets/images/veteran5.png',
        widgetKey: key,
      );

  // static const SvgPicture emptyList({Key? key}) =>SvgPicture(
  //   SvgAssetLoader('assets/images/empty_list.svg'),
  // );

  // static const Image workImage({Key? key}) =>AssetImageWidget(
  //    'assets/images/work_image.png'),
  //   fit: BoxFit.fill,
  // );
  // precacheImage(
  //   AssetImage(
  //     name,
  //   ),
  //   context,
  // );
}
