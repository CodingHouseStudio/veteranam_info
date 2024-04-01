import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

abstract class KBoxDecoration {
  static BoxDecoration boxDecorPrimary = BoxDecoration(
    color: KColorTheme.background,
    border: Border.all(
      color: KColorTheme.widgetBackground,
    ),
    borderRadius: KBorderRadius.kBorderRadiusS,
  );
}
