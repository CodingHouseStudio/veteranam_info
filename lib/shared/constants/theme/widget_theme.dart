import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

abstract class KWidetTheme {
  static OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: AppColors.lightGray),
    borderRadius: KBorderRadius.kBorderRadiusM,
  );
  static OutlineInputBorder outlineInputBorderError = OutlineInputBorder(
    borderSide: const BorderSide(color: AppColors.error),
    borderRadius: KBorderRadius.kBorderRadiusM,
  );

  static BoxDecoration boxDecorationWidget = BoxDecoration(
    borderRadius: KBorderRadius.kBorderRadiusM,
    border: Border.all(color: AppColors.lightGray),
  );
  static BoxDecoration boxDecorationCard = BoxDecoration(
    borderRadius: KBorderRadius.kBorderRadiusM,
    color: AppColors.lightGray,
  );
  static BoxDecoration boxDecorationImage = BoxDecoration(
    borderRadius: KBorderRadius.kBorderRadiusLeftM,
    color: AppColors.lightGray,
  );
  static BoxDecoration boxDecorationCircular = const BoxDecoration(
    shape: BoxShape.circle,
    color: AppColors.white,
  );

  static InputDecoration inputDecoration = InputDecoration(
    hintStyle: AppTextStyle.hintM,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: KPadding.kPaddingSizeM,
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
