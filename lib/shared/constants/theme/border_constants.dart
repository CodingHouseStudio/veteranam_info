import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

abstract class KBorder {
  static OutlineInputBorder outlineInputLightGray = OutlineInputBorder(
    borderSide: const BorderSide(color: KColorTheme.lightGray),
    borderRadius: KBorderRadius.kBorderRadiusM,
  );
  static OutlineInputBorder outlineInputTransparent = OutlineInputBorder(
    borderRadius: KBorderRadius.kBorderRadiusM,
    borderSide: const BorderSide(color: KColorTheme.transparent),
  );
  static OutlineInputBorder outlineInputError = OutlineInputBorder(
    borderSide: const BorderSide(color: KColorTheme.error),
    borderRadius: KBorderRadius.kBorderRadiusM,
  );
  OutlineInputBorder buttonStyleOutlineInputBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: KColorTheme.background),
    borderRadius: BorderRadius.circular(KPadding.kPaddingSizeS),
  );
}
