import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

abstract class KBorder {
  static OutlineInputBorder outlineInputLightGray = OutlineInputBorder(
    borderSide: const BorderSide(color: AppColors.lightGray),
    borderRadius: KBorderRadius.kBorderRadius32,
  );
  static OutlineInputBorder outlineInputTransparent = OutlineInputBorder(
    borderRadius: KBorderRadius.kBorderRadius32,
    borderSide: const BorderSide(color: AppColors.transparent),
  );
  static OutlineInputBorder outlineInputError = OutlineInputBorder(
    borderSide: const BorderSide(color: AppColors.error),
    borderRadius: KBorderRadius.kBorderRadius32,
  );
  static OutlineInputBorder buttonStyleOutlineInputBorder = OutlineInputBorder(
    borderSide: const BorderSide(
      color: AppColors.widgetBackground,
    ),
    borderRadius: BorderRadius.circular(KPadding.kPaddingSize10),
  );
}
