import 'package:flutter/material.dart';
import 'package:veteranam/shared/constants/constants.dart';
import 'package:veteranam/shared/shared.dart';

abstract class KButtonStyles {
  static const ButtonStyle widgetBackgroundButtonStyleWInf = ButtonStyle(
    // backgroundColor: AppColors.widgetBackground,
    minimumSize: WidgetStatePropertyAll(
      Size(double.infinity, KMinMaxSize.minHeight50),
    ),
    padding: WidgetStatePropertyAll(
      EdgeInsets.all(KPadding.kPaddingSize24),
    ),
  );

  static const ButtonStyle widgetBackgroundSquareButtonStyleWInf = ButtonStyle(
    // backgroundColor: AppColors.widgetBackground,
    minimumSize: WidgetStatePropertyAll(Size(200, 50)),
    padding: WidgetStatePropertyAll(
      EdgeInsets.all(KPadding.kPaddingSize24),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius40,
      ),
    ),
  );

  static const ButtonStyle widgetLightGreyButtonStyleWInf = ButtonStyle(
    // backgroundColor: AppColors.background,
    minimumSize: WidgetStatePropertyAll(
      Size(double.infinity, KMinMaxSize.minHeight50),
    ),
    padding: WidgetStatePropertyAll(
      EdgeInsets.all(KPadding.kPaddingSize24),
    ),
  );

  static const ButtonStyle transparentButtonStyle = ButtonStyle(
    padding: WidgetStatePropertyAll(
      EdgeInsets.all(KPadding.kPaddingSize4),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
      ),
    ),
  );

  static const whiteButtonStyle = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(AppColors.materialThemeWhite),
    minimumSize: WidgetStatePropertyAll(
      Size(KMinMaxSize.minWidth100, KMinMaxSize.minHeight50),
    ),
    padding: WidgetStatePropertyAll(EdgeInsets.all(KPadding.kPaddingSize8)),
    // side: WidgetStatePropertyAll( BorderSide(
    //   color: KColorTheme.white,
    // ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
      ),
    ),
  );

  static const whiteSnackBarButtonStyle = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(AppColors.materialThemeWhite),
    minimumSize: WidgetStatePropertyAll(
      Size(KMinMaxSize.minWidth100, KMinMaxSize.minHeight50),
    ),
    padding: WidgetStatePropertyAll(EdgeInsets.all(KPadding.kPaddingSize16)),
    // side: WidgetStatePropertyAll( BorderSide(
    //   color: KColorTheme.white,
    // ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
      ),
    ),
  );
  static const withoutStyle = ButtonStyle(
    alignment: Alignment.centerLeft,
    padding: WidgetStatePropertyAll(EdgeInsets.zero),
    shape: WidgetStatePropertyAll(LinearBorder.none),
    overlayColor: WidgetStatePropertyAll(Colors.transparent),
  );
  static const boxButtonStyle = ButtonStyle(
    alignment: Alignment.centerLeft,
    padding:
        WidgetStatePropertyAll(EdgeInsets.only(left: KPadding.kPaddingSize8)),
    overlayColor: WidgetStatePropertyAll(Colors.transparent),
  );
  static const borderButtonStyle = ButtonStyle(
    minimumSize: WidgetStatePropertyAll(
      Size(KMinMaxSize.minWidth100, KMinMaxSize.minHeight50),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
        side: BorderSide(color: AppColors.materialThemeKeyColorsNeutral),
      ),
    ),
  );
  static const whiteButtonStyleWInf = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(AppColors.materialThemeWhite),
    minimumSize: WidgetStatePropertyAll(
      Size(double.infinity, KMinMaxSize.minHeight50),
    ),
    padding: WidgetStatePropertyAll(EdgeInsets.all(KPadding.kPaddingSize8)),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
      ),
    ),
  );
  static const whiteButtonStyleBorder = ButtonStyle(
    minimumSize: WidgetStatePropertyAll(
      Size(KMinMaxSize.minWidth100, KMinMaxSize.minHeight50),
    ),
    padding: WidgetStatePropertyAll(EdgeInsets.all(KPadding.kPaddingSize8)),
    side: WidgetStatePropertyAll(
      BorderSide(
        color: AppColors.materialThemeWhite,
      ),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
      ),
    ),
    backgroundColor: WidgetStatePropertyAll(AppColors.materialThemeWhite),
  );
  static const lightGrayButtonStyle = ButtonStyle(
    backgroundColor:
        WidgetStatePropertyAll(AppColors.materialThemeKeyColorsNeutral),
    minimumSize: WidgetStatePropertyAll(
      Size(KMinMaxSize.minWidth100, KMinMaxSize.minHeight50),
    ),
    padding: WidgetStatePropertyAll(EdgeInsets.all(KPadding.kPaddingSize8)),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
      ),
    ),
  );
  static const lightGrayButtonStyleWInf = ButtonStyle(
    backgroundColor:
        WidgetStatePropertyAll(AppColors.materialThemeKeyColorsNeutral),
    minimumSize: WidgetStatePropertyAll(
      Size(double.infinity, KMinMaxSize.minHeight50),
    ),
    padding: WidgetStatePropertyAll(EdgeInsets.all(KPadding.kPaddingSize8)),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
      ),
    ),
  );
  static const transparentButtonStyleBottomBorder = ButtonStyle(
    padding: WidgetStatePropertyAll(
      EdgeInsets.symmetric(horizontal: KPadding.kPaddingSize8),
    ),
    shape: WidgetStatePropertyAll(
      LinearBorder(bottom: LinearBorderEdge()),
    ),
    backgroundColor: WidgetStatePropertyAll(AppColors.materialThemeWhite),
  );

  static const secondaryButtonStyle = ButtonStyle(
    padding: WidgetStatePropertyAll(
      EdgeInsets.symmetric(
        horizontal: KPadding.kPaddingSize24,
        vertical: KPadding.kPaddingSize8,
      ),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
        side: BorderSide(),
      ),
    ),
  );

  static const endListButtonStyle = ButtonStyle(
    padding: WidgetStatePropertyAll(
      EdgeInsets.symmetric(
        horizontal: KPadding.kPaddingSize16,
        vertical: KPadding.kPaddingSize4,
      ),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
        side: BorderSide(),
      ),
    ),
  );

  static const dropListButtonStyle = ButtonStyle(
    minimumSize: WidgetStatePropertyAll(
      Size(KMinMaxSize.minWidth100, KMinMaxSize.minHeight50),
    ),
    padding: WidgetStatePropertyAll(
      EdgeInsets.symmetric(horizontal: KPadding.kPaddingSize32),
    ),
    alignment: Alignment.centerLeft,
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        // ignore: avoid_redundant_argument_values
        borderRadius: BorderRadius.zero,
      ),
    ),
    backgroundColor: WidgetStatePropertyAll(AppColors.materialThemeWhite),
  );

  static const imageButton = ButtonStyle(
    padding: WidgetStatePropertyAll(
      EdgeInsets.symmetric(
        vertical: KPadding.kPaddingSize90,
      ),
    ),
    iconSize: WidgetStatePropertyAll(KSize.kPixel70),
    backgroundColor: WidgetStatePropertyAll(AppColors.materialThemeWhite),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
      ),
    ),
  );
  static const iconButtonStyle = ButtonStyle(
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadiusL,
      ),
    ),
    backgroundColor: WidgetStatePropertyAll(AppColors.materialThemeWhite),
  );

  static const advancedButtonStyle = ButtonStyle(
    padding:
        WidgetStatePropertyAll(EdgeInsets.only(right: KPadding.kPaddingSize8)),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
      ),
    ),
  );
  static const advancedFilterButtonStyle = ButtonStyle(
    padding: WidgetStatePropertyAll(
      EdgeInsets.symmetric(
        horizontal: KPadding.kPaddingSize16,
        vertical: KPadding.kPaddingSize8,
      ),
    ),
    backgroundColor: WidgetStatePropertyAll(AppColors.materialThemeSourceSeed),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
      ),
    ),
  );

  static const additionalButtonStyle = ButtonStyle(
    padding: WidgetStatePropertyAll(EdgeInsets.zero),
    overlayColor: WidgetStatePropertyAll(Colors.transparent),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
      ),
    ),
    foregroundColor:
        WidgetStatePropertyAll(AppColors.materialThemeKeyColorsSecondary),
    alignment: Alignment.centerLeft,
  );

  static const filterButtonStyleBorder = ButtonStyle(
    minimumSize: WidgetStatePropertyAll(
      Size(KMinMaxSize.minWidth100, KMinMaxSize.minHeight50),
    ),
    padding: WidgetStatePropertyAll(EdgeInsets.all(KPadding.kPaddingSize8)),
    side: WidgetStatePropertyAll(
      BorderSide(),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
      ),
    ),
    backgroundColor: WidgetStatePropertyAll(AppColors.materialThemeSourceSeed),
  );

  static const filterButtonStyleBorderWhite = ButtonStyle(
    minimumSize: WidgetStatePropertyAll(
      Size(KMinMaxSize.minWidth100, KMinMaxSize.minHeight50),
    ),
    padding: WidgetStatePropertyAll(EdgeInsets.all(KPadding.kPaddingSize8)),
    side: WidgetStatePropertyAll(
      BorderSide(),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
      ),
    ),
    backgroundColor: WidgetStatePropertyAll(AppColors.materialThemeWhite),
  );

  static const borderBlackButtonStyle = ButtonStyle(
    padding: WidgetStatePropertyAll(
      EdgeInsets.symmetric(
        vertical: KPadding.kPaddingSize4,
        horizontal: KPadding.kPaddingSize16,
      ),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
        side: BorderSide(color: AppColors.materialThemeKeyColorsSecondary),
      ),
    ),
  );
  static const footerButtonTransparent = ButtonStyle(
    overlayColor: WidgetStatePropertyAll(Colors.transparent),
  );

  static const blackButtonStyle = ButtonStyle(
    minimumSize: WidgetStatePropertyAll(
      Size(KMinMaxSize.minWidth100, KMinMaxSize.minHeight50),
    ),
    padding: WidgetStatePropertyAll(EdgeInsets.all(KPadding.kPaddingSize16)),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius16,
      ),
    ),
    backgroundColor: WidgetStatePropertyAll(AppColors.materialThemeBlack),
  );
  static const discountCityButtonStyle = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(AppColors.materialThemeWhite),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
      ),
    ),
    side: WidgetStatePropertyAll(
      BorderSide(color: AppColors.materialThemeKeyColorsNeutral),
    ),
    overlayColor: WidgetStatePropertyAll(Colors.transparent),
    minimumSize: WidgetStatePropertyAll(
      Size(double.minPositive, KMinMaxSize.minHeight30),
    ),
  );
  static const closeDialogButtonStyle = ButtonStyle(
    padding: WidgetStatePropertyAll(
      EdgeInsets.only(
        top: KPadding.kPaddingSize8,
        bottom: KPadding.kPaddingSize8,
        left: KPadding.kPaddingSize24,
      ),
    ),
    backgroundColor: WidgetStatePropertyAll(
      AppColors.materialThemeKeyColorsSecondary,
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
        side: BorderSide(color: AppColors.materialThemeWhite),
      ),
    ),
  );
}
