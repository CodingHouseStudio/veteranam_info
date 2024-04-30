import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

abstract class KBorder {
  static OutlineInputBorder outlineInputLightGray = OutlineInputBorder(
    borderRadius: KBorderRadius.kBorderRadius32,
  );
  static OutlineInputBorder outlineInputTransparent = OutlineInputBorder(
    borderRadius: KBorderRadius.kBorderRadius32,
  );
  static OutlineInputBorder outlineInputError = OutlineInputBorder(
    borderRadius: KBorderRadius.kBorderRadius32,
  );
  static OutlineInputBorder buttonStyleOutlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(KPadding.kPaddingSize10),
  );
}
