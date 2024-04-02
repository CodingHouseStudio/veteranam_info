import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

abstract class KBoxDecoration {
  static BoxDecoration boxDecorPrimary = BoxDecoration(
    color: AppColors.background,
    border: Border.all(
      color: AppColors.widgetBackground,
    ),
    borderRadius: KBorderRadius.kBorderRadiusM,
  );
}
