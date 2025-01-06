import 'package:flutter/material.dart'
    show
        Alignment,
        BorderSide,
        ButtonStyle,
        Colors,
        EdgeInsets,
        LinearBorder,
        LinearBorderEdge,
        RoundedRectangleBorder,
        Size,
        WidgetState,
        WidgetStateProperty,
        WidgetStatePropertyAll;
import 'package:veteranam/shared/constants/constants_flutter.dart';

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
      KWidgetTheme.outlineBorder40,
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
      KWidgetTheme.outlineBorder,
    ),
  );

  static const ButtonStyle transparentSharedIconButtonStyle = ButtonStyle(
    padding: WidgetStatePropertyAll(
      EdgeInsets.only(
        right: KPadding.kPaddingSize8,
      ),
    ),
    shape: WidgetStatePropertyAll(
      KWidgetTheme.outlineBorder,
    ),
    alignment: Alignment.centerLeft,
  );

  static final ButtonStyle transparentPopupMenuButtonStyle = ButtonStyle(
    padding: const WidgetStatePropertyAll(
      EdgeInsets.only(
        right: KPadding.kPaddingSize60,
        left: KPadding.kPaddingSize16,
        top: KPadding.kPaddingSize8,
        bottom: KPadding.kPaddingSize8,
      ),
    ),
    shape: const WidgetStatePropertyAll(
      KWidgetTheme.outlineBorder16,
    ),
    alignment: Alignment.centerLeft,
    foregroundColor: WidgetStateProperty.resolveWith(
      (states) {
        if (states.contains(WidgetState.disabled)) {
          return AppColors.materialThemeBlackOpacity88;
        }
        return AppColors.materialThemeBlack;
      },
    ),
    backgroundColor: WidgetStateProperty.resolveWith(
      (states) {
        if (states.contains(WidgetState.disabled)) {
          return AppColors.materialThemeRefNeutralNeutral90;
        }
        return Colors.transparent;
      },
    ),
  );

  static const ButtonStyle neutralButtonStyle = ButtonStyle(
    padding: WidgetStatePropertyAll(
      EdgeInsets.all(KPadding.kPaddingSize12),
    ),
    backgroundColor: WidgetStatePropertyAll(
      AppColors.materialThemeKeyColorsNeutral,
    ),
    shape: WidgetStatePropertyAll(
      KWidgetTheme.outlineBorder,
    ),
    maximumSize: WidgetStatePropertyAll(Size.fromWidth(210)),
  );

  static const ButtonStyle transparentPhoneNumberButtonStyle = ButtonStyle(
    padding: WidgetStatePropertyAll(
      EdgeInsets.symmetric(horizontal: KPadding.kPaddingSize8),
    ),
    shape: WidgetStatePropertyAll(
      KWidgetTheme.outlineBorder,
    ),
  );

  static const whiteButtonStyle = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(AppColors.materialThemeWhite),
    // minimumSize: WidgetStatePropertyAll(
    //   Size(KMinMaxSize.minWidth100, KMinMaxSize.minHeight50),
    // ),
    padding: WidgetStatePropertyAll(EdgeInsets.all(KPadding.kPaddingSize8)),
    // side: WidgetStatePropertyAll( BorderSide(
    //   color: KColorTheme.white,
    // ),
    shape: WidgetStatePropertyAll(
      KWidgetTheme.outlineBorder,
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
      KWidgetTheme.outlineBorder,
    ),
  );
  static const withoutStyle = ButtonStyle(
    maximumSize: WidgetStatePropertyAll(
      Size(
        KMinMaxSize.maxWidth328,
        double.infinity,
      ),
    ),
    alignment: Alignment.centerLeft,
    padding: WidgetStatePropertyAll(EdgeInsets.zero),
    shape: WidgetStatePropertyAll(LinearBorder.none),
    overlayColor: WidgetStatePropertyAll(Colors.transparent),
  );
  static const withoutStyleNavBar = ButtonStyle(
    maximumSize: WidgetStatePropertyAll(
      Size(
        KMinMaxSize.maxWidth328,
        double.infinity,
      ),
    ),
    alignment: Alignment.centerLeft,
    padding: WidgetStatePropertyAll(
      EdgeInsets.symmetric(
        vertical: KPadding.kPaddingSize12,
        horizontal: KPadding.kPaddingSize16,
      ),
    ),
    shape: WidgetStatePropertyAll(LinearBorder.none),
    overlayColor: WidgetStatePropertyAll(Colors.transparent),
  );
  static const withoutStyleAligmentBottomLeft = ButtonStyle(
    maximumSize: WidgetStatePropertyAll(
      Size(
        KMinMaxSize.maxWidth328,
        double.infinity,
      ),
    ),
    alignment: Alignment.bottomLeft,
    padding: WidgetStatePropertyAll(EdgeInsets.zero),
    shape: WidgetStatePropertyAll(LinearBorder.none),
    overlayColor: WidgetStatePropertyAll(Colors.transparent),
  );
  static const withoutStylePadding8 = ButtonStyle(
    maximumSize: WidgetStatePropertyAll(
      Size(
        KMinMaxSize.maxWidth328,
        double.infinity,
      ),
    ),
    alignment: Alignment.bottomLeft,
    padding: WidgetStatePropertyAll(
      EdgeInsets.all(KPadding.kPaddingSize8),
    ),
    shape: WidgetStatePropertyAll(LinearBorder.none),
    overlayColor: WidgetStatePropertyAll(Colors.transparent),
  );
  static const boxMobButtonStyle = ButtonStyle(
    alignment: Alignment.centerLeft,
    padding: WidgetStatePropertyAll(
      EdgeInsets.zero,
    ),
    backgroundColor:
        WidgetStatePropertyAll(AppColors.materialThemeKeyColorsNeutral),
  );
  static const borderButtonStyle = ButtonStyle(
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
      KWidgetTheme.outlineBorder,
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
      KWidgetTheme.outlineBorder,
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
      KWidgetTheme.outlineBorder,
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
      KWidgetTheme.outlineBorder,
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
      KWidgetTheme.outlineBorderSide,
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
      KWidgetTheme.outlineBorderSide,
    ),
  );

  static const dropListButtonStyle = ButtonStyle(
    padding: WidgetStatePropertyAll(
      EdgeInsets.symmetric(horizontal: KPadding.kPaddingSize32),
    ),
    alignment: Alignment.centerLeft,
    shape: WidgetStatePropertyAll(
      KWidgetTheme.outlineBorderZero,
    ),
    // backgroundColor:
    //     WidgetStatePropertyAll(AppColors.materialThemeKeyColorsNeutral),
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
      KWidgetTheme.outlineBorder,
    ),
  );
  static const iconButtonStyle = ButtonStyle(
    shape: WidgetStatePropertyAll(
      KWidgetTheme.outlineBorder48,
    ),
    backgroundColor: WidgetStatePropertyAll(AppColors.materialThemeWhite),
  );

  static const advancedButtonStyle = ButtonStyle(
    padding: WidgetStatePropertyAll(EdgeInsets.all(KPadding.kPaddingSize12)),
    shape: WidgetStatePropertyAll(
      KWidgetTheme.outlineBorder,
    ),
    backgroundColor: WidgetStatePropertyAll(
      AppColors.materialThemeKeyColorsNeutral,
    ),
  );
  static const advancedFilterButtonStyle = ButtonStyle(
    padding: WidgetStatePropertyAll(
      EdgeInsets.symmetric(
        horizontal: KPadding.kPaddingSize16,
        vertical: KPadding.kPaddingSize8,
      ),
    ),
    alignment: Alignment.center,
    backgroundColor: WidgetStatePropertyAll(AppColors.materialThemeSourceSeed),
    shape: WidgetStatePropertyAll(
      KWidgetTheme.outlineBorder,
    ),
  );

  static const additionalButtonStyle = ButtonStyle(
    padding: WidgetStatePropertyAll(EdgeInsets.zero),
    overlayColor: WidgetStatePropertyAll(Colors.transparent),
    shape: WidgetStatePropertyAll(
      KWidgetTheme.outlineBorder,
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
      KWidgetTheme.outlineBorder,
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
      KWidgetTheme.outlineBorder,
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

  static const borderBlackUserRoleButtonStyle = ButtonStyle(
    padding: WidgetStatePropertyAll(
      EdgeInsets.only(
        left: KPadding.kPaddingSize8,
        right: KPadding.kPaddingSize16,
        top: KPadding.kPaddingSize4,
        bottom: KPadding.kPaddingSize4,
      ),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
        side: BorderSide(color: AppColors.materialThemeKeyColorsSecondary),
      ),
    ),
  );

  static const borderBlackButtonPwResetStyle = ButtonStyle(
    padding: WidgetStatePropertyAll(
      EdgeInsets.symmetric(
        vertical: KPadding.kPaddingSize4,
        horizontal: KPadding.kPaddingSize10,
      ),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
        side: BorderSide(color: AppColors.materialThemeKeyColorsSecondary),
      ),
    ),
  );
  static const borderBlackMyDiscountsButtonStyle = ButtonStyle(
    padding: WidgetStatePropertyAll(
      EdgeInsets.only(
        top: KPadding.kPaddingSize20,
        bottom: KPadding.kPaddingSize20,
        right: KPadding.kPaddingSize16,
        left: KPadding.kPaddingSize8,
      ),
    ),
    alignment: Alignment.centerLeft,
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
        side: BorderSide(color: AppColors.materialThemeKeyColorsSecondary),
      ),
    ),
  );
  static const borderBlackMyDiscountsDeactivateButtonStyle = ButtonStyle(
    padding: WidgetStatePropertyAll(
      EdgeInsets.only(
        top: KPadding.kPaddingSize12,
        bottom: KPadding.kPaddingSize12,
        right: KPadding.kPaddingSize16,
        left: KPadding.kPaddingSize8,
      ),
    ),
    alignment: Alignment.centerLeft,
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
        side: BorderSide(color: AppColors.materialThemeKeyColorsSecondary),
      ),
    ),
  );
  static const borderBlackMyDiscountsTrashButtonStyle = ButtonStyle(
    padding: WidgetStatePropertyAll(
      EdgeInsets.all(
        KPadding.kPaddingSize12,
      ),
    ),
    alignment: Alignment.centerLeft,
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
        side: BorderSide(color: AppColors.materialThemeKeyColorsSecondary),
      ),
    ),
  );

  static const borderBlackDiscountAddButtonStyle = ButtonStyle(
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

  static const borderBlackButtonAdvancedFilterStyle = ButtonStyle(
    padding: WidgetStatePropertyAll(
      EdgeInsets.symmetric(
        vertical: KPadding.kPaddingSize8,
        horizontal: KPadding.kPaddingSize24,
      ),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
        side: BorderSide(color: AppColors.materialThemeKeyColorsSecondary),
      ),
    ),
  );

  static const borderBlackDiscountLinkButtonStyle = ButtonStyle(
    padding: WidgetStatePropertyAll(
      EdgeInsets.symmetric(
        vertical: KPadding.kPaddingSize4,
        horizontal: KPadding.kPaddingSize10,
      ),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
        side: BorderSide(color: AppColors.materialThemeKeyColorsSecondary),
      ),
    ),
  );

  static const circularBorderBlackButtonStyle = ButtonStyle(
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius48,
        side: BorderSide(color: AppColors.materialThemeKeyColorsSecondary),
      ),
    ),
  );

  static const circularButtonStyle = ButtonStyle(
    padding: WidgetStatePropertyAll(EdgeInsets.all(KPadding.kPaddingSize12)),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius48,
      ),
    ),
  );

  static const borderGrayButtonStyle = ButtonStyle(
    padding: WidgetStatePropertyAll(
      EdgeInsets.symmetric(
        vertical: KPadding.kPaddingSize4,
        horizontal: KPadding.kPaddingSize16,
      ),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
        side: BorderSide(color: AppColors.materialThemeKeyColorsNeutralVariant),
      ),
    ),
  );
  static const footerButtonTransparent = ButtonStyle(
    overlayColor: WidgetStatePropertyAll(Colors.transparent),
  );
  static const discountAddButtonTransparent = ButtonStyle(
    overlayColor: WidgetStatePropertyAll(Colors.transparent),
    padding: WidgetStatePropertyAll(
      EdgeInsets.zero,
    ),
  );

  static const blackButtonStyle = ButtonStyle(
    minimumSize: WidgetStatePropertyAll(
      Size(KMinMaxSize.minWidth100, KMinMaxSize.minHeight50),
    ),
    padding: WidgetStatePropertyAll(EdgeInsets.all(KPadding.kPaddingSize16)),
    shape: WidgetStatePropertyAll(
      KWidgetTheme.outlineBorder16,
    ),
    backgroundColor: WidgetStatePropertyAll(AppColors.materialThemeBlack),
  );
  static const discountCityButtonStyle = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(AppColors.materialThemeWhite),
    shape: WidgetStatePropertyAll(
      KWidgetTheme.outlineBorder,
    ),
    side: WidgetStatePropertyAll(
      BorderSide(color: AppColors.materialThemeKeyColorsNeutral),
    ),
    overlayColor: WidgetStatePropertyAll(Colors.transparent),
    minimumSize: WidgetStatePropertyAll(
      Size(double.minPositive, KMinMaxSize.minHeight30),
    ),
  );
  static const boxButtonStyle = ButtonStyle(
    backgroundColor:
        WidgetStatePropertyAll(AppColors.materialThemeKeyColorsNeutral),
    shape: WidgetStatePropertyAll(
      KWidgetTheme.outlineBorder,
    ),
    padding: WidgetStatePropertyAll(
      EdgeInsets.only(
        top: KPadding.kPaddingSize24,
        right: KPadding.kPaddingSize24,
        bottom: KPadding.kPaddingSize24,
        left: KPadding.kPaddingSize24,
      ),
    ),
  );
  static const discountBoxButtonStyle = ButtonStyle(
    backgroundColor:
        WidgetStatePropertyAll(AppColors.materialThemeKeyColorsPrimary),
    shape: WidgetStatePropertyAll(
      KWidgetTheme.outlineBorder,
    ),
    padding: WidgetStatePropertyAll(
      EdgeInsets.only(
        top: KPadding.kPaddingSize8,
        // ignore: avoid_redundant_argument_values
        right: 0,
        // ignore: avoid_redundant_argument_values
        bottom: 0,
        // bottom: KPadding.kPaddingSize24,
        left: KPadding.kPaddingSize24,
      ),
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
  static const dropFieldButtonStyle = ButtonStyle(
    textStyle: WidgetStatePropertyAll(AppTextStyle.materialThemeBodyLarge),
    padding: WidgetStatePropertyAll(
      EdgeInsets.symmetric(horizontal: KPadding.kPaddingSize16),
    ),
  );

  static const borderNeutralButtonStyle = ButtonStyle(
    padding: WidgetStatePropertyAll(
      EdgeInsets.symmetric(
        vertical: KPadding.kPaddingSize4,
        horizontal: KPadding.kPaddingSize16,
      ),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
        side: BorderSide(color: AppColors.materialThemeRefNeutralNeutral80),
      ),
    ),
  );

  static const borderSecondaryButtonStyle = ButtonStyle(
    padding: WidgetStatePropertyAll(
      EdgeInsets.symmetric(
        vertical: KPadding.kPaddingSize4,
        horizontal: KPadding.kPaddingSize16,
      ),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
        side: BorderSide(color: AppColors.materialThemeRefSecondarySecondary70),
      ),
    ),
  );

  static const borderSecondaryExpandButtonStyle = ButtonStyle(
    padding: WidgetStatePropertyAll(
      EdgeInsets.symmetric(
        vertical: KPadding.kPaddingSize4,
        horizontal: KPadding.kPaddingSize16,
      ),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
        side: BorderSide(color: AppColors.materialThemeRefSecondarySecondary70),
      ),
    ),
    minimumSize: WidgetStatePropertyAll(
      Size(
        KMinMaxSize.maxWidth328,
        0,
      ),
    ),
  );

  static const blackDetailsButtonStyle = ButtonStyle(
    padding: WidgetStatePropertyAll(
      EdgeInsets.symmetric(
        vertical: KPadding.kPaddingSize4,
        horizontal: KPadding.kPaddingSize16,
      ),
    ),
    backgroundColor: WidgetStatePropertyAll(
      AppColors.materialThemeKeyColorsSecondary,
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
      ),
    ),
  );

  static const borderWhiteButtonStyle = ButtonStyle(
    // padding: WidgetStatePropertyAll(
    //   EdgeInsets.symmetric(
    //     vertical: KPadding.kPaddingSize4,
    //     horizontal: KPadding.kPaddingSize16,
    //   ),
    // ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
        side: BorderSide(color: AppColors.materialThemeWhite, width: 3),
      ),
    ),
  );

  static const noBackgroundOnHoverButtonStyle = ButtonStyle(
    overlayColor: WidgetStatePropertyAll(
      Colors.transparent,
    ),
  );

  static const circularBorderNeutralButtonStyle = ButtonStyle(
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius48,
        side: BorderSide(color: AppColors.materialThemeKeyColorsNeutral),
      ),
    ),
    backgroundColor: WidgetStatePropertyAll(Colors.transparent),
  );

  static const circularBorderTransparentButtonStyle = ButtonStyle(
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius48,
        side: BorderSide(color: AppColors.materialThemeKeyColorsNeutral),
      ),
    ),
    backgroundColor:
        WidgetStatePropertyAll(AppColors.materialThemeKeyColorsNeutral),
  );
}
