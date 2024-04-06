import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

abstract class KButtonStyles {
  static final ButtonStyle whiteButtonStyle = TextButton.styleFrom(
    backgroundColor: AppColors.white,
    minimumSize: const Size(KMinMaxSize.minWidth100, KMinMaxSize.minHeight50),
    padding: const EdgeInsets.all(KPadding.kPaddingSize8),
    // side: const BorderSide(
    //   color: KColorTheme.white,
    // ),
    shape: RoundedRectangleBorder(
      borderRadius: KBorderRadius.kBorderRadius32,
    ),
  );
  static final ButtonStyle whiteButtonStyleBorder = TextButton.styleFrom(
    minimumSize: const Size(KMinMaxSize.minWidth100, KMinMaxSize.minHeight50),
    padding: const EdgeInsets.all(KPadding.kPaddingSize8),
    side: const BorderSide(
      color: AppColors.lightGray,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: KBorderRadius.kBorderRadius32,
    ),
  );

  static final ButtonStyle transparentButtonStyle = TextButton.styleFrom(
    minimumSize: const Size(KMinMaxSize.minWidth100, KMinMaxSize.minHeight50),
    padding: const EdgeInsets.all(KPadding.kPaddingSize8),
    alignment: Alignment.centerLeft,
    shape: RoundedRectangleBorder(
      borderRadius: KBorderRadius.kBorderRadius32,
    ),
  );
  static final ButtonStyle lightGrayButtonStyle = TextButton.styleFrom(
    backgroundColor: AppColors.lightGray,
    minimumSize: const Size(KMinMaxSize.minWidth100, KMinMaxSize.minHeight50),
    padding: const EdgeInsets.all(KPadding.kPaddingSize8),
    shape: RoundedRectangleBorder(
      borderRadius: KBorderRadius.kBorderRadius32,
    ),
  );
  static final ButtonStyle transparentButtonStyleBottomBorder =
      TextButton.styleFrom(
    minimumSize: const Size(KMinMaxSize.minWidth100, KMinMaxSize.minHeight50),
    padding: const EdgeInsets.symmetric(horizontal: KPadding.kPaddingSize8),
    shape: LinearBorder.bottom(side: const BorderSide()),
  );

  static final ButtonStyle secondaryButtonStyle = TextButton.styleFrom(
    minimumSize: const Size(328, 60),
    backgroundColor: AppColors.widgetBackground,
    padding: const EdgeInsets.all(KPadding.kPaddingSize4),
    shape: RoundedRectangleBorder(
      borderRadius: KBorderRadius.kBorderRadius8,
    ),
  );
}
