import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

abstract class KBorder {
  static OutlineInputBorder outlineInputLightGray = OutlineInputBorder(
    borderSide: const BorderSide(color: AppColors.lightGray),
    borderRadius: KBorderRadius.kBorderRadiusM,
  );
  static OutlineInputBorder outlineInputTransparent = OutlineInputBorder(
    borderRadius: KBorderRadius.kBorderRadiusM,
    borderSide: const BorderSide(color: AppColors.transparent),
  );
  static OutlineInputBorder outlineInputError = OutlineInputBorder(
    borderSide: const BorderSide(color: AppColors.error),
    borderRadius: KBorderRadius.kBorderRadiusM,
  );
  static OutlineInputBorder buttonStyleOutlineInputBorder = OutlineInputBorder(
    borderSide: const BorderSide(
      color: AppColors.widgetBackground,
    ),
    borderRadius: BorderRadius.circular(KPadding.kPaddingSizeS),
  );
}
