import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

/// COMMENT: Variables with widget theme that don't have a specific group
abstract class KWidgetTheme {
  static OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    // borderSide: const BorderSide(color: AppColors.lightGray),
    borderRadius: KBorderRadius.kBorderRadius32,
  );
  static OutlineInputBorder outlineInputBorderError = OutlineInputBorder(
    // borderSide: const BorderSide(color: AppColors.error),
    borderRadius: KBorderRadius.kBorderRadius32,
  );

  static BoxDecoration boxDecorationWidget = BoxDecoration(
    borderRadius: KBorderRadius.kBorderRadius32,
    // border: Border.all(color: AppColors.lightGray),
  );
  static const BoxDecoration boxDecorationCircular = BoxDecoration(
    shape: BoxShape.circle,
    // color: AppColors.white,
  );
  static BoxDecoration boxDecorationCard = BoxDecoration(
    borderRadius: KBorderRadius.kBorderRadius32,
    // color: AppColors.lightGray,
  );
  static BoxDecoration boxDecorationDonateCard = BoxDecoration(
    borderRadius: KBorderRadius.kBorderRadius40,
    // color: AppColors.lightGray,
  );
  static BoxDecoration boxDecorationImageDesk = BoxDecoration(
    borderRadius: KBorderRadius.kBorderRadiusLeft32,
    // color: AppColors.lightGray,
  );
  static BoxDecoration boxDecorationImageMob = BoxDecoration(
    borderRadius: KBorderRadius.kBorderRadiusTop32,
    // color: AppColors.lightGray,
  );
  static BoxDecoration boxDecorationWhite = BoxDecoration(
    borderRadius: KBorderRadius.kBorderRadiusRight32,
    // color: AppColors.white,
  );

  static BoxDecoration boxDecorationCircularGray = const BoxDecoration(
    shape: BoxShape.circle,
    // color: Colors.grey,
  );
  static BoxDecoration boxDecorPrimary = BoxDecoration(
    // color: AppColors.background,
    border: Border.all(
        // color: AppColors.widgetBackground,
        ),
    borderRadius: KBorderRadius.kBorderRadius32,
  );
  static BoxDecoration boxDecorChatMessage = BoxDecoration(
    // color: AppColors.widgetBackground,
    borderRadius: KBorderRadius.kBorderRadius32
        .copyWith(bottomLeft: const Radius.circular(KSize.kRadius8)),
  );

  static InputDecoration inputDecoration = InputDecoration(
    hintStyle: AppTextStyle.hint24,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: KPadding.kPaddingSize20,
    ),
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    border: KWidgetTheme.outlineInputBorder,
    enabledBorder: KWidgetTheme.outlineInputBorder,
    disabledBorder: KWidgetTheme.outlineInputBorder,
    focusedBorder: KWidgetTheme.outlineInputBorder,
    focusedErrorBorder: KWidgetTheme.outlineInputBorderError,
    filled: true,
    // fillColor: AppColors.white,
  );
}
