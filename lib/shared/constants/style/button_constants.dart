import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

abstract class KButtonStyles {
  static ButtonStyle whiteButtonStyle(BuildContext context) =>
      TextButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.background,
        minimumSize:
            const Size(KMinMaxSize.minWidth100, KMinMaxSize.minHeight50),
        padding: const EdgeInsets.all(KPadding.kPaddingSize8),
        // side: const BorderSide(
        //   color: KColorTheme.white,
        // ),
        shape: RoundedRectangleBorder(
          borderRadius: KBorderRadius.kBorderRadius32,
        ),
      );
  static ButtonStyle whiteButtonStyleWInf(BuildContext context) =>
      TextButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.background,
        minimumSize: const Size(double.infinity, KMinMaxSize.minHeight50),
        padding: const EdgeInsets.all(KPadding.kPaddingSize8),
        shape: RoundedRectangleBorder(
          borderRadius: KBorderRadius.kBorderRadius32,
        ),
      );
  static ButtonStyle whiteButtonStyleBorder(BuildContext context) =>
      TextButton.styleFrom(
        minimumSize:
            const Size(KMinMaxSize.minWidth100, KMinMaxSize.minHeight50),
        padding: const EdgeInsets.all(KPadding.kPaddingSize8),
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: KBorderRadius.kBorderRadius32,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      );

  static final ButtonStyle transparentButtonStyle = TextButton.styleFrom(
    minimumSize: const Size(KMinMaxSize.minWidth100, KMinMaxSize.minHeight50),
    padding: const EdgeInsets.all(KPadding.kPaddingSize8),
    alignment: Alignment.centerLeft,
    shape: RoundedRectangleBorder(
      borderRadius: KBorderRadius.kBorderRadius32,
    ),
  );
  static ButtonStyle lightGrayButtonStyle(BuildContext context) =>
      TextButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        minimumSize:
            const Size(KMinMaxSize.minWidth100, KMinMaxSize.minHeight50),
        padding: const EdgeInsets.all(KPadding.kPaddingSize8),
        shape: RoundedRectangleBorder(
          borderRadius: KBorderRadius.kBorderRadius32,
        ),
      );
  static ButtonStyle lightGrayButtonStyleWInf(BuildContext context) =>
      TextButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        minimumSize: const Size(double.infinity, KMinMaxSize.minHeight50),
        padding: const EdgeInsets.all(KPadding.kPaddingSize8),
        shape: RoundedRectangleBorder(
          borderRadius: KBorderRadius.kBorderRadius32,
        ),
      );
  static ButtonStyle transparentButtonStyleBottomBorder(BuildContext context) =>
      TextButton.styleFrom(
        minimumSize:
            const Size(KMinMaxSize.minWidth100, KMinMaxSize.minHeight50),
        padding: const EdgeInsets.symmetric(horizontal: KPadding.kPaddingSize8),
        shape: LinearBorder.bottom(side: const BorderSide()),
        backgroundColor: Theme.of(context).colorScheme.background,
      );

  static final ButtonStyle secondaryButtonStyle = TextButton.styleFrom(
    minimumSize: const Size(328, 60),
    // backgroundColor: AppColors.widgetBackground,
    padding: const EdgeInsets.all(KPadding.kPaddingSize4),
    shape: RoundedRectangleBorder(
      borderRadius: KBorderRadius.kBorderRadius8,
    ),
  );
  static final ButtonStyle widgetBackgroundButtonStyleWInf =
      TextButton.styleFrom(
    // backgroundColor: AppColors.widgetBackground,
    minimumSize: const Size(double.infinity, KMinMaxSize.minHeight50),
    padding: const EdgeInsets.all(KPadding.kPaddingSize24),
  );

  static final ButtonStyle widgetBackgroundSquareButtonStyleWInf =
      TextButton.styleFrom(
    // backgroundColor: AppColors.widgetBackground,
    minimumSize: const Size(200, 50),
    padding: const EdgeInsets.all(KPadding.kPaddingSize24),
    shape: RoundedRectangleBorder(
      borderRadius: KBorderRadius.kBorderRadius40,
    ),
  );

  static final ButtonStyle widgetLightGreyButtonStyleWInf =
      TextButton.styleFrom(
    // backgroundColor: AppColors.background,
    minimumSize: const Size(double.infinity, KMinMaxSize.minHeight50),
    padding: const EdgeInsets.all(KPadding.kPaddingSize24),
  );

  static ButtonStyle dropListButtonStyle(BuildContext context) =>
      TextButton.styleFrom(
        minimumSize:
            const Size(KMinMaxSize.minWidth100, KMinMaxSize.minHeight50),
        padding:
            const EdgeInsets.symmetric(horizontal: KPadding.kPaddingSize20),
        shape: RoundedRectangleBorder(
          borderRadius: KBorderRadius.kBorderRadius0,
        ),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
      );
}
