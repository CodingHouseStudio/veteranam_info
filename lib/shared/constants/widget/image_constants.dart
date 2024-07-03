// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

extension ImageExension on Image {
  Image setKey(Key key) => Image(
        image: image,
        key: key,
      );
}

abstract class KImage {
  static final Image instagram = _get('assets/icons/instagram.svg');
  static final Image linkedIn = _get('assets/icons/linkedin.svg');
  static final Image facebook = _get('assets/icons/facebook.svg');
  static final Image apple = _get('assets/icons/social_icons.svg');
  static final Image google = _get('assets/icons/social_icons_g.svg');
  static final Image logo = _get('assets/images/logo.svg');
  static final Image logoHome = _get('assets/images/logo_home.svg');
  static final Image homeImage = _get(
    'assets/images/home_image.png',
    fit: BoxFit.fill,
  );
  static final Image homeImageMob = _get(
    'assets/images/home_image_mob.png',
  );
  static final Image discountImage = _get(
    'assets/images/discount_image.png',
    fit: BoxFit.fill,
    casheSize: KMinMaxSize.kHomeImageMaxSize,
  );
  static final Image inforamationImage = _get(
    'assets/images/information_image.png',
    fit: BoxFit.fill,
    casheSize: KMinMaxSize.kHomeImageMaxSize,
  );
  static final Image wavingHand = _get(
    'assets/icons/waving_hand.png',
    width: KSize.kPixel16,
    height: KSize.kPixel16,
  );
  static final Image veteran1 = _get(
    'assets/images/veteran1.png',
  );
  static final Image veteran2 = _get(
    'assets/images/veteran2.png',
  );
  static final Image veteran3 = _get(
    'assets/images/veteran3.png',
  );
  static final Image veteran4 = _get(
    'assets/images/veteran4.png',
  );
  static final Image veteran5 = _get(
    'assets/images/veteran5.png',
  );
  // static const SvgPicture emptyList = SvgPicture(
  //   SvgAssetLoader('assets/images/empty_list.svg'),
  // );

  // static const Image workImage = _get(
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
  }) =>
      Image.asset(
        key: Key(name),
        name,
        fit: fit,
        width: width,
        height: height,
        cacheHeight: casheSize ?? KMinMaxSize.kImageMaxSize,
        cacheWidth: casheSize ?? KMinMaxSize.kImageMaxSize,
      );
}
