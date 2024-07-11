// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:veteranam/shared/shared.dart';

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
  static SvgImageWidget instagram({Key? key}) => SvgImageWidget(
        path: 'assets/icons/instagram.svg',
        key: key,
      );
  static SvgImageWidget linkedIn({Key? key}) => SvgImageWidget(
        path: 'assets/icons/linkedin.svg',
        key: key,
      );
  static SvgImageWidget facebook({Key? key}) => SvgImageWidget(
        path: 'assets/icons/facebook.svg',
        key: key,
      );
  static SvgImageWidget apple({Key? key}) => SvgImageWidget(
        path: 'assets/icons/social_icons.svg',
        key: key,
      );
  static SvgImageWidget google({Key? key}) => SvgImageWidget(
        path: 'assets/icons/social_icons_g.svg',
        key: key,
      );
  static SvgImageWidget logo({Key? key}) => SvgImageWidget(
        path: 'assets/images/logo.svg',
        key: key,
      );
  static Image logoHome({Key? key}) => _get(
        'assets/images/logo_home.svg',
        key: key,
      );
  static Image homeImage({Key? key}) => _get(
        'assets/images/home_image.png',
        fit: BoxFit.fill,
        key: key,
      );
  static Image homeImageMob({Key? key}) => _get(
        'assets/images/home_image_mob.png',
        key: key,
      );
  static Image discountImage({Key? key}) => _get(
        'assets/images/discount_image.png',
        fit: BoxFit.fill,
        casheSize: KMinMaxSize.kHomeImageMaxSize,
        key: key,
      );
  static Image inforamationImage({Key? key}) => _get(
        'assets/images/information_image.png',
        fit: BoxFit.fill,
        casheSize: KMinMaxSize.kHomeImageMaxSize,
        key: key,
      );
  static Image wavingHand({Key? key}) => _get(
        'assets/icons/waving_hand.png',
        width: KSize.kPixel16,
        height: KSize.kPixel16,
        key: key,
      );
  static Image coffee({Key? key}) => _get(
        'assets/icons/hot_beverage.png',
        width: KSize.kPixel24,
        height: KSize.kPixel24,
        key: key,
      );
  static Image veteran1({Key? key}) => _get(
        'assets/images/veteran1.png',
        key: key,
      );
  static Image veteran2({Key? key}) => _get(
        'assets/images/veteran2.png',
        key: key,
      );
  static Image veteran3({Key? key}) => _get(
        'assets/images/veteran3.png',
        key: key,
      );
  static Image veteran4({Key? key}) => _get(
        'assets/images/veteran4.png',
        key: key,
      );
  static Image veteran5({Key? key}) => _get(
        'assets/images/veteran5.png',
        key: key,
      );
  // static const SvgPicture emptyList({Key? key}) =>SvgPicture(
  //   SvgAssetLoader('assets/images/empty_list.svg'),
  // );

  // static const Image workImage({Key? key}) =>_get(
  //    'assets/images/work_image.png'),
  //   fit: BoxFit.fill,
  // );
  // precacheImage(
  //   AssetImage(
  //     name,
  //   ),
  //   context,
  // );
  static Image _get(
    String name, {
    BoxFit? fit,
    double? width,
    double? height,
    int? casheSize,
    Key? key,
  }) =>
      Image.asset(
        key: key ?? Key(name),
        name,
        fit: fit,
        width: width,
        height: height,
        cacheHeight: casheSize ?? KMinMaxSize.kImageMaxSize,
        cacheWidth: casheSize ?? KMinMaxSize.kImageMaxSize,
      );
}
