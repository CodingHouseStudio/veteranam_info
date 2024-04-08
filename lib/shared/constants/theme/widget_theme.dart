import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

abstract class KWidetTheme {
  static OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: AppColors.lightGray),
    borderRadius: KBorderRadius.kBorderRadius32,
  );
  static OutlineInputBorder outlineInputBorderError = OutlineInputBorder(
    borderSide: const BorderSide(color: AppColors.error),
    borderRadius: KBorderRadius.kBorderRadius32,
  );

  static BoxDecoration boxDecorationWidget = BoxDecoration(
    borderRadius: KBorderRadius.kBorderRadius32,
    border: Border.all(color: AppColors.lightGray),
  );
  static BoxDecoration boxDecorationCard = BoxDecoration(
    borderRadius: KBorderRadius.kBorderRadius32,
    color: AppColors.lightGray,
  );
  static BoxDecoration boxDecorationImageDesk = BoxDecoration(
    borderRadius: KBorderRadius.kBorderRadiusLeft32,
    color: AppColors.lightGray,
  );
  static BoxDecoration boxDecorationImageMob = BoxDecoration(
    borderRadius: KBorderRadius.kBorderRadiusTop32,
    color: AppColors.lightGray,
  );
  static BoxDecoration boxDecorationCircular = const BoxDecoration(
    shape: BoxShape.circle,
    color: AppColors.white,
  );

  static BoxDecoration boxDecorationCircularGray = const BoxDecoration(
    shape: BoxShape.circle,
    color: Colors.grey,
  );
  static BoxDecoration boxDecorPrimary = BoxDecoration(
    color: AppColors.background,
    border: Border.all(
      color: AppColors.widgetBackground,
    ),
    borderRadius: KBorderRadius.kBorderRadius32,
  );

  static InputDecoration inputDecoration = InputDecoration(
    hintStyle: AppTextStyle.hint24,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: KPadding.kPaddingSize20,
    ),
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    border: KWidetTheme.outlineInputBorder,
    enabledBorder: KWidetTheme.outlineInputBorder,
    disabledBorder: KWidetTheme.outlineInputBorder,
    focusedBorder: KWidetTheme.outlineInputBorder,
    focusedErrorBorder: KWidetTheme.outlineInputBorderError,
    filled: true,
    fillColor: AppColors.white,
  );
}
