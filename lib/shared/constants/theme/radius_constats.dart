import 'package:flutter/material.dart' show BorderRadius, Radius;
import 'package:veteranam/shared/constants/constants_flutter.dart';

abstract class KBorderRadius {
  static const kBorderRadius10 =
      BorderRadius.all(Radius.circular(KSize.kRadius10));
  static const kBorderRadius16 =
      BorderRadius.all(Radius.circular(KSize.kRadius16));
  static const kBorderRadius32 =
      BorderRadius.all(Radius.circular(KSize.kRadius32));
  static const kBorderRadius40 =
      BorderRadius.all(Radius.circular(KSize.kRadius40));
  static const kBorderRadius8 =
      BorderRadius.all(Radius.circular(KSize.kPixel8));
  static const kBorderRadius48 =
      BorderRadius.all(Radius.circular(KSize.kPixel48));
  static const kBorderRadiusLeft32 =
      BorderRadius.horizontal(left: Radius.circular(KSize.kRadius32));
  static const kBorderRadiusRight32 =
      BorderRadius.horizontal(right: Radius.circular(KSize.kRadius32));
  static const kBorderRadiusTop32 =
      BorderRadius.vertical(top: Radius.circular(KSize.kRadius32));
  static const kBorderRadiusChat = BorderRadius.only(
    bottomLeft: Radius.circular(KSize.kRadius8),
    bottomRight: Radius.circular(KSize.kRadius32),
    topLeft: Radius.circular(KSize.kRadius32),
    topRight: Radius.circular(KSize.kRadius32),
  );
}
