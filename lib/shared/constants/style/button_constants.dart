import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

abstract class KButtonStyles {
  static final ButtonStyle whiteButtonStyle = TextButton.styleFrom(
    backgroundColor: AppColors.white,
    minimumSize: const Size(KMinMaxSize.minWidth100, KMinMaxSize.minHeight50),
    padding: const EdgeInsets.all(KPadding.kPaddingSizeXSS),
    side: const BorderSide(
      color: AppColors.white,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: KBorderRadius.kBorderRadiusM,
    ),
  );
  static final ButtonStyle backgroundButtonStyleUI = TextButton.styleFrom(
    backgroundColor: KColorTheme.background,
    shape: RoundedRectangleBorder(
      borderRadius: KBorderRadius.kBorderRadiusS,
      side: const BorderSide(color: KColorTheme.widgetBackground),
    ),
    minimumSize: const Size(704, 92),
  static final ButtonStyle transparentButtonStyle = TextButton.styleFrom(
    minimumSize: const Size(KMinMaxSize.minWidth100, KMinMaxSize.minHeight50),
    padding: const EdgeInsets.all(KPadding.kPaddingSizeXSS),
    alignment: Alignment.centerLeft,
    shape: RoundedRectangleBorder(
      borderRadius: KBorderRadius.kBorderRadiusM,
    ),
  );
}
