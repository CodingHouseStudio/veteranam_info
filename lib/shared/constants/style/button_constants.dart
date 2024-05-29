import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

abstract class KButtonStyles {
  static const ButtonStyle widgetBackgroundButtonStyleWInf = ButtonStyle(
    // backgroundColor: AppColors.widgetBackground,
    minimumSize: MaterialStatePropertyAll(
      Size(double.infinity, KMinMaxSize.minHeight50),
    ),
    padding: MaterialStatePropertyAll(
      EdgeInsets.all(KPadding.kPaddingSize24),
    ),
  );

  static const ButtonStyle widgetBackgroundSquareButtonStyleWInf = ButtonStyle(
    // backgroundColor: AppColors.widgetBackground,
    minimumSize: MaterialStatePropertyAll(Size(200, 50)),
    padding: MaterialStatePropertyAll(
      EdgeInsets.all(KPadding.kPaddingSize24),
    ),
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius40,
      ),
    ),
  );

  static const ButtonStyle widgetLightGreyButtonStyleWInf = ButtonStyle(
    // backgroundColor: AppColors.background,
    minimumSize: MaterialStatePropertyAll(
      Size(double.infinity, KMinMaxSize.minHeight50),
    ),
    padding: MaterialStatePropertyAll(
      EdgeInsets.all(KPadding.kPaddingSize24),
    ),
  );

  static const ButtonStyle transparentButtonStyle = ButtonStyle(
    minimumSize: MaterialStatePropertyAll(
      Size(KMinMaxSize.minWidth100, KMinMaxSize.minHeight50),
    ),
    padding: MaterialStatePropertyAll(
      EdgeInsets.all(KPadding.kPaddingSize8),
    ),
    alignment: Alignment.centerLeft,
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
      ),
    ),
  );

  static const whiteButtonStyle = ButtonStyle(
    backgroundColor: MaterialStatePropertyAll(AppColors.materialThemeWhite),
    minimumSize: MaterialStatePropertyAll(
      Size(KMinMaxSize.minWidth100, KMinMaxSize.minHeight50),
    ),
    padding: MaterialStatePropertyAll(EdgeInsets.all(KPadding.kPaddingSize8)),
    // side: MaterialStatePropertyAll( BorderSide(
    //   color: KColorTheme.white,
    // ),
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
      ),
    ),
  );
  static const borderButtonStyle = ButtonStyle(
    minimumSize: MaterialStatePropertyAll(
      Size(KMinMaxSize.minWidth100, KMinMaxSize.minHeight50),
    ),
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
        side: BorderSide(color: AppColors.materialThemeKeyColorsNeutral),
      ),
    ),
  );
  static const whiteButtonStyleWInf = ButtonStyle(
    backgroundColor: MaterialStatePropertyAll(AppColors.materialThemeWhite),
    minimumSize: MaterialStatePropertyAll(
      Size(double.infinity, KMinMaxSize.minHeight50),
    ),
    padding: MaterialStatePropertyAll(EdgeInsets.all(KPadding.kPaddingSize8)),
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
      ),
    ),
  );
  static const whiteButtonStyleBorder = ButtonStyle(
    minimumSize: MaterialStatePropertyAll(
      Size(KMinMaxSize.minWidth100, KMinMaxSize.minHeight50),
    ),
    padding: MaterialStatePropertyAll(EdgeInsets.all(KPadding.kPaddingSize8)),
    side: MaterialStatePropertyAll(
      BorderSide(
        color: AppColors.materialThemeWhite,
      ),
    ),
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
      ),
    ),
    backgroundColor: MaterialStatePropertyAll(AppColors.materialThemeWhite),
  );
  static const lightGrayButtonStyle = ButtonStyle(
    backgroundColor:
        MaterialStatePropertyAll(AppColors.materialThemeKeyColorsNeutral),
    minimumSize: MaterialStatePropertyAll(
      Size(KMinMaxSize.minWidth100, KMinMaxSize.minHeight50),
    ),
    padding: MaterialStatePropertyAll(EdgeInsets.all(KPadding.kPaddingSize8)),
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
      ),
    ),
  );
  static const lightGrayButtonStyleWInf = ButtonStyle(
    backgroundColor:
        MaterialStatePropertyAll(AppColors.materialThemeKeyColorsNeutral),
    minimumSize: MaterialStatePropertyAll(
      Size(double.infinity, KMinMaxSize.minHeight50),
    ),
    padding: MaterialStatePropertyAll(EdgeInsets.all(KPadding.kPaddingSize8)),
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
      ),
    ),
  );
  static const transparentButtonStyleBottomBorder = ButtonStyle(
    padding: MaterialStatePropertyAll(
      EdgeInsets.symmetric(horizontal: KPadding.kPaddingSize8),
    ),
    shape: MaterialStatePropertyAll(
      LinearBorder(bottom: LinearBorderEdge()),
    ),
    backgroundColor: MaterialStatePropertyAll(AppColors.materialThemeWhite),
  );

  static const secondaryButtonStyle = ButtonStyle(
    padding: MaterialStatePropertyAll(
      EdgeInsets.symmetric(
        horizontal: KPadding.kPaddingSize24,
        vertical: KPadding.kPaddingSize8,
      ),
    ),
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
        side: BorderSide(color: AppColors.materialThemeKeyColorsNeutralVariant),
      ),
    ),
  );

  static const dropListButtonStyle = ButtonStyle(
    minimumSize: MaterialStatePropertyAll(
      Size(KMinMaxSize.minWidth100, KMinMaxSize.minHeight50),
    ),
    padding: MaterialStatePropertyAll(
      EdgeInsets.symmetric(horizontal: KPadding.kPaddingSize20),
    ),
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        // ignore: avoid_redundant_argument_values
        borderRadius: BorderRadius.zero,
      ),
    ),
    backgroundColor: MaterialStatePropertyAll(AppColors.materialThemeWhite),
  );

  static const imageButton = ButtonStyle(
    padding: MaterialStatePropertyAll(
      EdgeInsets.symmetric(
        vertical: KPadding.kPaddingSize90,
      ),
    ),
    iconSize: MaterialStatePropertyAll(KSize.kPixel70),
    backgroundColor: MaterialStatePropertyAll(AppColors.materialThemeWhite),
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
      ),
    ),
  );
}
