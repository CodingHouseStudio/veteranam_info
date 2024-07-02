import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

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
