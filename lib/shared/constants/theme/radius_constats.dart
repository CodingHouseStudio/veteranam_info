import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

abstract class KBorderRadius {
  static BorderRadius kBorderRadius32 = BorderRadius.circular(KSize.kRadius32);
  static BorderRadius kBorderRadius8 = BorderRadius.circular(KSize.kPixel8);
  static BorderRadius kBorderRadiusL = BorderRadius.circular(KSize.kPixel48);
  static BorderRadius kBorderRadiusLeft32 =
      const BorderRadius.horizontal(left: Radius.circular(KSize.kRadius32));
}
