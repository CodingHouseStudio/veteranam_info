import 'package:flutter/material.dart'
    show
        Border,
        BorderRadius,
        BorderSide,
        BoxDecoration,
        BoxShadow,
        BoxShape,
        Colors,
        EdgeInsets,
        FloatingLabelBehavior,
        InputDecoration,
        MenuStyle,
        Offset,
        OutlineInputBorder,
        RoundedRectangleBorder,
        VisualDensity,
        WidgetStatePropertyAll;
import 'package:veteranam/shared/constants/constants_flutter.dart';

/// COMMENT: Variables with widget theme that don't have a specific group
abstract class KWidgetTheme {
  static const outlineInputBorder = OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.materialThemeKeyColorsNeutral),
    borderRadius: KBorderRadius.kBorderRadius32,
  );
  static const outlineInputBorderEnabled = OutlineInputBorder(
    borderSide:
        BorderSide(color: AppColors.materialThemeKeyColorsNeutralVariant),
    borderRadius: KBorderRadius.kBorderRadius32,
  );
  static const outlineInputBorderHovered = OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.materialThemeRefNeutralNeutral40),
    borderRadius: KBorderRadius.kBorderRadius32,
  );
  static const outlineInputBorderFocused = OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.materialThemeRefNeutralNeutral70),
    borderRadius: KBorderRadius.kBorderRadius32,
  );
  static const outlineInputBorderDisabled = OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.materialThemeRefNeutralNeutral90),
    borderRadius: KBorderRadius.kBorderRadius32,
  );
  static const outlineInputBorderError = OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.materialThemeRefErrorError50),
    borderRadius: KBorderRadius.kBorderRadius32,
  );
  static const outlineInputBorderErrorFocused = OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.materialThemeRefErrorError30),
    borderRadius: KBorderRadius.kBorderRadius32,
  );
  static const outlineBorder = RoundedRectangleBorder(
    borderRadius: KBorderRadius.kBorderRadius32,
  );
  static const outlineBorderSide = RoundedRectangleBorder(
    borderRadius: KBorderRadius.kBorderRadius32,
    side: BorderSide(),
  );
  static const outlineBorder40 = RoundedRectangleBorder(
    borderRadius: KBorderRadius.kBorderRadius40,
  );
  static const outlineBorder48 = RoundedRectangleBorder(
    borderRadius: KBorderRadius.kBorderRadius48,
  );
  static const outlineBorder16 = RoundedRectangleBorder(
    borderRadius: KBorderRadius.kBorderRadius16,
  );
  static const outlineBorderZero = RoundedRectangleBorder(
    // ignore: avoid_redundant_argument_values
    borderRadius: BorderRadius.zero,
  );

  static const boxDecorationWidget = BoxDecoration(
    borderRadius: KBorderRadius.kBorderRadius32,
    color: AppColors.materialThemeKeyColorsNeutral,
    // border: Border.fromBorderSide(
    //   BorderSide(color: AppColors.materialThemeKeyColorsNeutral,),
    // ),
  );
  static const boxDecorationCircular = BoxDecoration(
    shape: BoxShape.circle,
    color: AppColors.materialThemeSourceSeed,
  );

  static const boxDecorationGrayCircular = BoxDecoration(
    shape: BoxShape.circle,
    color: AppColors.materialThemeKeyColorsNeutral,
  );
  static const boxDecorationWhiteCircular = BoxDecoration(
    shape: BoxShape.circle,
    color: AppColors.materialThemeWhite,
  );

  static const boxDecorationCard = BoxDecoration(
    borderRadius: KBorderRadius.kBorderRadius32,
    color: AppColors.materialThemeKeyColorsNeutral,
  );
  static const boxDecorationCardGrayBorder = BoxDecoration(
    borderRadius: KBorderRadius.kBorderRadius32,
    color: AppColors.materialThemeWhite,
    border: Border.fromBorderSide(
      BorderSide(
        color: AppColors.materialThemeKeyColorsNeutralVariant,
      ),
    ),
  );
  static const boxDecorationFooter = BoxDecoration(
    borderRadius: KBorderRadius.kBorderRadius32,
    color: AppColors.materialThemeKeyColorsNeutralVariant,
  );
  static const boxDecorationNawbar = BoxDecoration(
    borderRadius: KBorderRadius.kBorderRadius32,
    color: AppColors.materialThemeKeyColorsNeutral,
  );
  static const boxDecorationImageDesk = BoxDecoration(
    borderRadius: KBorderRadius.kBorderRadiusLeft32,
    color: AppColors.materialThemeKeyColorsNeutralVariant,
  );
  static const boxDecorationImageMob = BoxDecoration(
    borderRadius: KBorderRadius.kBorderRadiusTop32,
    color: AppColors.materialThemeKeyColorsNeutralVariant,
  );
  static const boxDecorationImage = BoxDecoration(
    borderRadius: KBorderRadius.kBorderRadius32,
    color: AppColors.materialThemeKeyColorsNeutralVariant,
  );
  static const boxDecorationWhite = BoxDecoration(
    borderRadius: KBorderRadius.kBorderRadiusRight32,
    color: AppColors.materialThemeWhite,
  );
  static const boxDecorationBlackCircular = BoxDecoration(
    shape: BoxShape.circle,
    color: AppColors.materialThemeBlack,
  );
  static const boxDecorationWhiteMain = BoxDecoration(
    borderRadius: KBorderRadius.kBorderRadius32,
    color: AppColors.materialThemeWhite,
  );
  static const boxDecorChatMessage = BoxDecoration(
    color: AppColors.materialThemeKeyColorsNeutralVariant,
    borderRadius: KBorderRadius.kBorderRadiusChat,
  );
  static const boxDecorNeutralVariant = BoxDecoration(
    color: AppColors.materialThemeKeyColorsNeutralVariant,
    borderRadius: KBorderRadius.kBorderRadius32,
  );
  static const boxDecorCheckPointFalse = BoxDecoration(
    color: AppColors.materialThemeKeyColorsNeutral,
    border: Border.fromBorderSide(
      BorderSide(
        color: AppColors.materialThemeRefNeutralNeutral80,
        width: KSize.kPixel3,
      ),
    ),
    borderRadius: KBorderRadius.kBorderRadius8,
  );
  static const boxDecorCheckPointTrue = BoxDecoration(
    color: AppColors.materialThemeSourceSeed,
    border: Border.fromBorderSide(
      BorderSide(
        color: AppColors.materialThemeSourceSeed,
        width: KSize.kPixel3,
      ),
    ),
    borderRadius: KBorderRadius.kBorderRadius8,
  );
  static const boxDecorationGreen = BoxDecoration(
    color: AppColors.materialThemeSourceSeed,
    borderRadius: KBorderRadius.kBorderRadius32,
  );
  static const boxDecorationBlack = BoxDecoration(
    color: AppColors.materialThemeKeyColorsSecondary,
    borderRadius: KBorderRadius.kBorderRadius32,
  );
  static const boxDecorationTooltip = BoxDecoration(
    color: AppColors.materialThemeBlackOpacity88,
    borderRadius: KBorderRadius.kBorderRadius32,
  );

  static const inputDecoration = InputDecoration(
    hintStyle: AppTextStyle.materialThemeTitleMediumNeutralVariant35,
    contentPadding: EdgeInsets.symmetric(
      horizontal: KPadding.kPaddingSize20,
    ),
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    border: outlineInputBorder,
    enabledBorder: outlineInputBorderEnabled,
    disabledBorder: outlineInputBorderDisabled,
    focusedBorder: outlineInputBorderFocused,
    focusedErrorBorder: outlineInputBorderErrorFocused,
    filled: true,
    fillColor: AppColors.materialThemeWhite,
    labelStyle: AppTextStyle.materialThemeTitleMedium,
    alignLabelWithHint: true,
    errorStyle: AppTextStyle.error14,
    hoverColor: AppColors.materialThemeWhite,
    errorBorder: outlineInputBorderError,
  );

  static const textFieldDecoration = BoxDecoration(
    color: AppColors.materialThemeWhite,
    border: Border.fromBorderSide(
      BorderSide(
        color: AppColors.materialThemeRefNeutralNeutral80,
      ),
    ),
    borderRadius: KBorderRadius.kBorderRadius32,
  );

  static const boxDecorationDiscountContainer = BoxDecoration(
    borderRadius: KBorderRadius.kBorderRadius32,
    color: AppColors.materialThemeWhite,
    border: Border.fromBorderSide(
      BorderSide(
        color: AppColors.materialThemeKeyColorsNeutral,
      ),
    ),
  );
  static const boxDecorationDiscountCategory = BoxDecoration(
    borderRadius: KBorderRadius.kBorderRadius32,
    color: AppColors.materialThemeWhite,
    border: Border.fromBorderSide(
      BorderSide(
        color: AppColors.materialThemeRefTertiaryTertiary80,
      ),
    ),
  );
  static const boxDecorationHome = BoxDecoration(
    borderRadius: KBorderRadius.kBorderRadius32,
    color: AppColors.materialThemeKeyColorsTertiary,
  );
  static const boxDecorationDiscount = BoxDecoration(
    borderRadius: KBorderRadius.kBorderRadius32,
    color: AppColors.materialThemeKeyColorsPrimary,
  );
  static const boxShadow = [
    BoxShadow(color: AppColors.materialThemeBlackOpacity20, blurRadius: 12),
  ];

  static const dropMenuboxShadow = [
    BoxShadow(
      color: Colors.transparent,
      blurRadius: 49,
      offset: Offset(0, 149),
    ),
    BoxShadow(
      color: AppColors.materialThemeBlackOpacity1,
      blurRadius: 38,
      offset: Offset(0, 95),
    ),
    BoxShadow(
      color: AppColors.materialThemeBlackOpacity2,
      blurRadius: 32,
      offset: Offset(0, 54),
    ),
    BoxShadow(
      color: AppColors.materialThemeBlackOpacity4,
      blurRadius: 24,
      offset: Offset(0, 24),
    ),
    BoxShadow(
      color: AppColors.materialThemeBlackOpacity4,
      blurRadius: 13,
      offset: Offset(0, 6),
    ),
  ];
  static const dropTextMenuStyle = MenuStyle(
    backgroundColor:
        WidgetStatePropertyAll(AppColors.materialThemeKeyColorsNeutral),
    shape: WidgetStatePropertyAll(KWidgetTheme.outlineBorder),
    padding: WidgetStatePropertyAll(
      EdgeInsets.symmetric(vertical: KPadding.kPaddingSize16),
    ),
    visualDensity: VisualDensity.comfortable,
  );
  static const boxDecorationWidgetDeskWithImage = BoxDecoration(
    borderRadius: KBorderRadius.kBorderRadiusOnlyRight,
    color: AppColors.materialThemeKeyColorsNeutral,
  );
  static const boxDecorationDiscountBorder = BoxDecoration(
    borderRadius: KBorderRadius.kBorderRadius32,
    color: AppColors.materialThemeKeyColorsNeutral,
    border: Border.fromBorderSide(
      BorderSide(
        color: AppColors.materialThemeKeyColorsPrimary,
        width: 3,
      ),
    ),
  );

  static const boxDecorationPopupMenuBorder = BoxDecoration(
    borderRadius: KBorderRadius.kBorderRadius32,
    border: Border.fromBorderSide(
      BorderSide(
        width: KDimensions.borderWidth3,
        color: AppColors.materialThemeWhite,
      ),
    ),
  );
  static const boxDecorationWidgetMobWithImage = BoxDecoration(
    borderRadius: KBorderRadius.kBorderRadiusOnlyBottom,
    color: AppColors.materialThemeKeyColorsNeutral,
  );
}
