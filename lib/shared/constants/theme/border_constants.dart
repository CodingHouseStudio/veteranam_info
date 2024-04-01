import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

abstract class KBorder {
  static OutlineInputBorder outlineInput = OutlineInputBorder(
    borderSide: const BorderSide(color: KColorTheme.white),
    borderRadius: KBorderRadius.kBorderRadiusM,
  );
  OutlineInputBorder buttonStyleOutlineInputBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: KColorTheme.background),
    borderRadius: BorderRadius.circular(KPadding.kPaddingSizeS),
  );
}
