// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

extension SvgPictureExtension on SvgPicture {
  SvgPicture copyWith({
    Key? key,
    BytesLoader? bytesLoader,
    double? width,
    double? height,
    BoxFit? fit,
    AlignmentGeometry? alignment,
    WidgetBuilder? placeholderBuilder,
    bool? matchTextDirection,
    bool? allowDrawingOutsideViewBox,
    String? semanticsLabel,
    bool? excludeFromSemantics,
    Clip? clipBehavior,
    ColorFilter? colorFilter,
  }) {
    return SvgPicture(
      bytesLoader ?? this.bytesLoader,
      key: key ?? this.key,
      width: width ?? this.width,
      height: height ?? this.height,
      fit: fit ?? this.fit,
      alignment: alignment ?? this.alignment,
      placeholderBuilder: placeholderBuilder ?? this.placeholderBuilder,
      matchTextDirection: matchTextDirection ?? this.matchTextDirection,
      allowDrawingOutsideViewBox:
          allowDrawingOutsideViewBox ?? this.allowDrawingOutsideViewBox,
      semanticsLabel: semanticsLabel ?? this.semanticsLabel,
      excludeFromSemantics: excludeFromSemantics ?? this.excludeFromSemantics,
      clipBehavior: clipBehavior ?? this.clipBehavior,
      colorFilter: colorFilter ?? this.colorFilter,
    );
  }
}

extension ImageExension on Image {
  Image setKey(Key key) => Image(
        image: image,
        key: key,
      );
}

abstract class KImage {
  static const SvgPicture instagram =
      SvgPicture(SvgAssetLoader('assets/icons/instagram.svg'));
  static const SvgPicture linkedIn =
      SvgPicture(SvgAssetLoader('assets/icons/linkedin.svg'));
  static const SvgPicture facebook =
      SvgPicture(SvgAssetLoader('assets/icons/social_icons_f.svg'));
  static const SvgPicture apple =
      SvgPicture(SvgAssetLoader('assets/icons/social_icons.svg'));
  static const SvgPicture google =
      SvgPicture(SvgAssetLoader('assets/icons/social_icons_g.svg'));
  static const SvgPicture logo = SvgPicture(
    SvgAssetLoader('assets/images/logo.svg'),
  );
  static const SvgPicture logoHome = SvgPicture(
    SvgAssetLoader('assets/images/logo_home.svg'),
  );
  static const Image homeImage = Image(
    image: AssetImage('assets/images/home_image.png'),
    fit: BoxFit.fill,
  );
  static const Image homeImageMob = Image(
    image: AssetImage('assets/images/home_image_mob.png'),
  );
  static const Image discountImage = Image(
    image: AssetImage('assets/images/discount_image.png'),
    fit: BoxFit.fill,
  );
  static const Image inforamationImage = Image(
    image: AssetImage('assets/images/information_image.png'),
    fit: BoxFit.fill,
  );
  static const Image wavingHand = Image(
    image: AssetImage('assets/icons/waving_hand.png'),
  );
  static const Image veteran1 = Image(
    image: AssetImage('assets/images/veteran1.png'),
  );
  static const Image veteran2 = Image(
    image: AssetImage('assets/images/veteran2.png'),
  );
  static const Image veteran3 = Image(
    image: AssetImage('assets/images/veteran3.png'),
  );
  static const Image veteran4 = Image(
    image: AssetImage('assets/images/veteran4.png'),
  );
  static const Image veteran5 = Image(
    image: AssetImage('assets/images/veteran5.png'),
  );
  // static const Image workImage = Image(
  //   image: AssetImage('assets/images/work_image.png'),
  //   fit: BoxFit.fill,
  // );
}
