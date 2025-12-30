import 'package:flutter/material.dart' show OutlineInputBorder;

import 'package:veteranam/shared/constants/constants_flutter.dart';

abstract class KBorder {
  static const outlineInputLightGray = OutlineInputBorder(
    borderRadius: KBorderRadius.kBorderRadius32,
  );
  static const outlineInputTransparent = OutlineInputBorder(
    borderRadius: KBorderRadius.kBorderRadius32,
  );
  static const outlineInputError = OutlineInputBorder(
    borderRadius: KBorderRadius.kBorderRadius32,
  );
  static const buttonStyleOutlineInputBorder = OutlineInputBorder(
    borderRadius: KBorderRadius.kBorderRadius10,
  );
}
