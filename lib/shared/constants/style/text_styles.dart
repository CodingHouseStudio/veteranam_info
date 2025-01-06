import 'package:flutter/material.dart'
    show FontStyle, FontWeight, TextDecoration, TextOverflow, TextStyle;
import 'package:veteranam/shared/constants/constants_flutter.dart';

/// Text Styles

abstract class AppTextStyle {
  static const text128 = TextStyle(
    fontSize: KSize.kFont128,
    fontWeight: FontWeight.w400,
    fontFamily: 'Gilroy',
    fontStyle: FontStyle.normal,
  );

  static const text96 = TextStyle(
    fontSize: KSize.kFont96,
    fontWeight: FontWeight.w400,
    fontFamily: 'Gilroy',
    fontStyle: FontStyle.normal,
  );

  static const text64 = TextStyle(
    fontSize: KSize.kFont64,
    fontWeight: FontWeight.w400,
    fontFamily: 'Gilroy',
    fontStyle: FontStyle.normal,
  );

  static const text48 = TextStyle(
    fontSize: KSize.kFont48,
    fontWeight: FontWeight.w400,
    fontFamily: 'Gilroy',
    fontStyle: FontStyle.normal,
  );

  static const text40 = TextStyle(
    fontSize: KSize.kFont40,
    fontWeight: FontWeight.w400,
    fontFamily: 'Gilroy',
    fontStyle: FontStyle.normal,
  );

  static const text36 = TextStyle(
    fontSize: KSize.kFont36,
    fontWeight: FontWeight.w400,
    fontFamily: 'Gilroy',
    fontStyle: FontStyle.normal,
  );

  static const text32 = TextStyle(
    fontSize: KSize.kFont32,
    fontWeight: FontWeight.w400,
    fontFamily: 'Gilroy',
    fontStyle: FontStyle.normal,
  );

  static const text24 = TextStyle(
    fontSize: KSize.kFont24,
    fontWeight: FontWeight.w400,
    fontFamily: 'Gilroy',
    fontStyle: FontStyle.normal,
  );

  static const text20 = TextStyle(
    fontSize: KSize.kFont20,
    fontWeight: FontWeight.w400,
    fontFamily: 'Gilroy',
    fontStyle: FontStyle.normal,
  );

  static const text18 = TextStyle(
    fontSize: KSize.kFont18,
    fontWeight: FontWeight.w400,
    fontFamily: 'Gilroy',
    fontStyle: FontStyle.normal,
  );

  static const text16 = TextStyle(
    fontSize: KSize.kFont16,
    fontFamily: 'Gilroy',
    fontStyle: FontStyle.normal,
  );

  static const text14 = TextStyle(
    fontSize: KSize.kFont14,
    fontFamily: 'Gilroy',
    fontStyle: FontStyle.normal,
  );

  static const hint16 = TextStyle(
    color: AppColors.materialThemeKeyColorsNeutralVariant,
    fontSize: KSize.kFont16,
    fontWeight: FontWeight.w400,
  );

  static const hint20 = TextStyle(
    color: AppColors.materialThemeKeyColorsNeutralVariant,
    fontSize: KSize.kFont20,
    fontWeight: FontWeight.w400,
  );

  static const hint24 = TextStyle(
    color: AppColors.materialThemeKeyColorsNeutralVariant,
    fontSize: KSize.kFont24,
    fontWeight: FontWeight.w400,
  );

  static const hint14 = TextStyle(
    color: AppColors.materialThemeKeyColorsNeutralVariant,
    fontSize: KSize.kFont14,
    fontWeight: FontWeight.w400,
  );

  static const error14 = TextStyle(
    color: AppColors.materialThemeRefErrorError50,
    fontSize: KSize.kFont14,
    fontWeight: FontWeight.w400,
  );

  /// materialThemeDisplayLarge figma properties
  /// fontFamily: Gilroy
  /// fontSize: 57px
  /// height: 64px
  /// fontWeight: 400
  /// letterSpacing: -0.25px
  /// fontStyle: none
  /// decoration: none
  static const TextStyle materialThemeDisplayLarge = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 57,
    height: 1.12,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
  );

  /// materialThemeDisplayMedium figma properties
  /// fontFamily: Gilroy
  /// fontSize: 45px
  /// height: 52px
  /// fontWeight: 400
  /// letterSpacing: none
  /// fontStyle: none
  /// decoration: none
  static const TextStyle materialThemeDisplayMedium = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 45,
    height: 1.16,
    fontWeight: FontWeight.w400,
  );

  /// materialThemeDisplaySmall figma properties
  /// fontFamily: Gilroy
  /// fontSize: 36px
  /// height: 44px
  /// fontWeight: 400
  /// letterSpacing: none
  /// fontStyle: none
  /// decoration: none
  static const TextStyle materialThemeDisplaySmall = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 36,
    height: 1.22,
    fontWeight: FontWeight.w400,
  );

  /// materialThemeHeadlineLarge figma properties
  /// fontFamily: Gilroy
  /// fontSize: 32px
  /// height: 40px
  /// fontWeight: 500
  /// letterSpacing: none
  /// fontStyle: none
  /// decoration: none
  static const TextStyle materialThemeHeadlineLarge = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 32,
    height: 1.25,
    fontWeight: FontWeight.w500,
  );

  /// materialThemeHeadlineMedium figma properties
  /// fontFamily: Gilroy
  /// fontSize: 28px
  /// height: 36px
  /// fontWeight: 500
  /// letterSpacing: none
  /// fontStyle: none
  /// decoration: none
  static const TextStyle materialThemeHeadlineMedium = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 28,
    height: 1.29,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle materialThemeHeadlineMediumBold = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 28,
    height: 1.29,
    fontWeight: FontWeight.bold,
  );

  /// materialThemeHeadlineSmall figma properties
  /// fontFamily: Gilroy
  /// fontSize: 24px
  /// height: 32px
  /// fontWeight: 500
  /// letterSpacing: none
  /// fontStyle: none
  /// decoration: none
  static const TextStyle materialThemeHeadlineSmall = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 24,
    height: 1.33,
    fontWeight: FontWeight.w500,
    color: AppColors.materialThemeKeyColorsSecondary,
  );
  static const TextStyle materialThemeHeadlineSmallVariant = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 24,
    height: 1.33,
    fontWeight: FontWeight.w500,
    color: AppColors.materialThemeKeyColorsNeutralVariant,
  );

  /// materialThemeBodyLarge figma properties
  /// fontFamily: Gilroy
  /// fontSize: 16px
  /// height: 24px
  /// fontWeight: 400
  /// letterSpacing: 0.5px
  /// fontStyle: none
  /// decoration: none
  static const TextStyle materialThemeBodyLarge = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );
  static const TextStyle materialThemeBodyLargeNeutralVariant35 = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    color: AppColors.materialThemeRefNeutralVariantNeutralVariant35,
  );
  static const TextStyle materialThemeBodyLargeNeutralVariant50 = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    color: AppColors.materialThemeRefNeutralVariantNeutralVariant50,
  );
  static const TextStyle materialThemeBodyLargeNeutralVariant60 = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    color: AppColors.materialThemeRefNeutralVariantNeutralVariant60,
  );
  static const TextStyle materialThemeBodyLargeNeutral = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    color: AppColors.materialThemeKeyColorsNeutral,
  );
  static const TextStyle materialThemeBodyLargeBold = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.5,
  );
  static const TextStyle materialThemeBodyLargeBolcUnderLine = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.underline,
    letterSpacing: 0.5,
  );

  /// materialThemeBodyMedium figma properties
  /// fontFamily: Gilroy
  /// fontSize: 14px
  /// height: 20px
  /// fontWeight: 400
  /// letterSpacing: 0.25px
  /// fontStyle: none
  /// decoration: none
  static const TextStyle materialThemeBodyMedium = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 14,
    height: 1.43,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );
  static const TextStyle materialThemeBodyMediumBold = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 14,
    height: 1.43,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.25,
  );
  static const TextStyle materialThemeBodyMediumBoldUnderLine = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 14,
    height: 1.43,
    decoration: TextDecoration.underline,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.25,
  );
  static const TextStyle materialThemeBodyMediumNeutralVariant35 = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 14,
    height: 1.43,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: AppColors.materialThemeRefNeutralVariantNeutralVariant35,
  );
  static const TextStyle materialThemeBodyMediumNeutralVariant50 = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 14,
    height: 1.43,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: AppColors.materialThemeRefNeutralVariantNeutralVariant50,
  );
  static const TextStyle materialThemeBodyMediumNeutralVariant50UnderLine =
      TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 14,
    height: 1.43,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: AppColors.materialThemeRefNeutralVariantNeutralVariant50,
    decoration: TextDecoration.underline,
  );
  static const TextStyle materialThemeBodyMediumNeutralVariant60 = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 14,
    height: 1.43,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: AppColors.materialThemeRefNeutralVariantNeutralVariant60,
  );
  static const TextStyle materialThemeBodyMediumNeutral = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 14,
    height: 1.43,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: AppColors.materialThemeKeyColorsNeutral,
  );
  static const TextStyle materialThemeBodyMediumError = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 14,
    height: 1.43,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: AppColors.materialThemeRefErrorError50,
  );

  /// materialThemeBodySmall figma properties
  /// fontFamily: Gilroy
  /// fontSize: 12px
  /// height: 16px
  /// fontWeight: 400
  /// letterSpacing: 0.4px
  /// fontStyle: none
  /// decoration: none
  static const TextStyle materialThemeBodySmall = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 12,
    height: 1.33,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  );
  static const TextStyle materialThemeBodySmallNeutralVariant50 = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 12,
    height: 1.33,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    color: AppColors.materialThemeRefNeutralVariantNeutralVariant50,
  );
  static const TextStyle materialThemeBodySmallError = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 12,
    height: 1.33,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    color: AppColors.materialThemeRefErrorError50,
  );

  /// materialThemeLabelLarge figma properties
  /// fontFamily: Gilroy
  /// fontSize: 14px
  /// height: 20px
  /// fontWeight: 500
  /// letterSpacing: 0.1px
  /// fontStyle: none
  /// decoration: none
  static const TextStyle materialThemeLabelLarge = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 14,
    height: 1.43,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    color: AppColors.materialThemeKeyColorsSecondary,
  );
  static const TextStyle materialThemeLabelLargeError = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 14,
    height: 1.43,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    color: AppColors.materialThemeSysLightError,
  );
  static const TextStyle materialThemeLabelLargeRef = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 14,
    height: 1.43,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    decoration: TextDecoration.underline,
    color: AppColors.materialThemeRefTertiaryTertiary40,
  );
  static const TextStyle materialThemeLabelLargeUnderLine = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 14,
    height: 1.43,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    decoration: TextDecoration.underline,
  );

  /// materialThemeLabelMedium figma properties
  /// fontFamily: Gilroy
  /// fontSize: 12px
  /// height: 16px
  /// fontWeight: 500
  /// letterSpacing: 0.5px
  /// fontStyle: none
  /// decoration: none
  static const TextStyle materialThemeLabelMedium = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 12,
    height: 1.33,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );
  static const TextStyle materialThemeLabelMediumVariant50 = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 12,
    height: 1.33,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    color: AppColors.materialThemeRefNeutralVariantNeutralVariant50,
  );

  /// materialThemeLabelSmall figma properties
  /// fontFamily: Gilroy
  /// fontSize: 11px
  /// height: 16px
  /// fontWeight: 500
  /// letterSpacing: 0.5px
  /// fontStyle: none
  /// decoration: none
  static const TextStyle materialThemeLabelSmall = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 11,
    height: 1.45,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );
  static const TextStyle materialThemeLabelSmallBlack = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 11,
    height: 1.45,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    color: AppColors.materialThemeBlack,
  );
  static const TextStyle materialThemeLabelSmallNeutralVariant35 = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 11,
    height: 1.45,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    color: AppColors.materialThemeRefNeutralVariantNeutralVariant35,
  );
  static const TextStyle materialThemeLabelSmallNeutralVariant70 = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 11,
    height: 1.45,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    color: AppColors.materialThemeRefNeutralVariantNeutralVariant70,
  );

  /// materialThemeTitleLarge figma properties
  /// fontFamily: Gilroy
  /// fontSize: 22px
  /// height: 28px
  /// fontWeight: 400
  /// letterSpacing: none
  /// fontStyle: none
  /// decoration: none
  static const TextStyle materialThemeTitleLarge = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 22,
    height: 1.27,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle materialThemeTitleLargeBold = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 22,
    height: 1.27,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle materialThemeTitleLargeNeutral80 = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 22,
    height: 1.27,
    fontWeight: FontWeight.w400,
    color: AppColors.materialThemeRefNeutralNeutral80,
  );

  /// materialThemeTitleMedium figma properties
  /// fontFamily: Gilroy
  /// fontSize: 16px
  /// height: 24px
  /// fontWeight: 500
  /// letterSpacing: 0.15px
  /// fontStyle: none
  /// decoration: none
  static const TextStyle materialThemeTitleMedium = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    color: AppColors.materialThemeKeyColorsSecondary,
  );
  static const TextStyle materialThemeTitleMediumUnderline = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    color: AppColors.materialThemeKeyColorsSecondary,
  );
  static const TextStyle materialThemeTitleMediumNeutral70 = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    color: AppColors.materialThemeRefNeutralNeutral70,
  );
  static const TextStyle materialThemeTitleMediumBlack = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 16,
    color: AppColors.materialThemeBlack,
    height: 1.5,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  );
  static const TextStyle materialThemeTitleMediumNeutralVariant35 = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    color: AppColors.materialThemeRefNeutralVariantNeutralVariant35,
  );
  static const TextStyle materialThemeTitleMediumNeutralVariant50 = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    color: AppColors.materialThemeRefNeutralVariantNeutralVariant50,
  );
  static const TextStyle materialThemeTitleMediumNeutralVariant70 = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    color: AppColors.materialThemeRefNeutralVariantNeutralVariant70,
  );
  static const TextStyle materialThemeTitleMediumNeutral = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    color: AppColors.materialThemeKeyColorsNeutral,
  );
  static const TextStyle materialThemeTitleMediumWhite = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    color: AppColors.materialThemeWhite,
  );

  /// materialThemeTitleSmall figma properties
  /// fontFamily: Gilroy
  /// fontSize: 14px
  /// height: 20px
  /// fontWeight: 500
  /// letterSpacing: 0.1px
  /// fontStyle: none
  /// decoration: none
  static const TextStyle materialThemeTitleSmall = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 14,
    height: 1.43,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    color: AppColors.materialThemeKeyColorsSecondary,
  );

  static const TextStyle materialThemeTitleSmallNeutral = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 14,
    height: 1.43,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    color: AppColors.materialThemeKeyColorsNeutral,
  );

  static const TextStyle materialThemeTitleSmallNeutral80 = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 14,
    height: 1.43,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    color: AppColors.materialThemeRefNeutralNeutral80,
  );

  /// h1 figma properties
  /// fontFamily: Gilroy
  /// fontSize: 64px
  /// height: 64px
  /// fontWeight: 500
  /// letterSpacing: -0.25px
  /// fontStyle: none
  /// decoration: none
  static const TextStyle h1 = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 64,
    height: 1,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.25,
    color: AppColors.materialThemeKeyColorsSecondary,
  );

  /// h1Mob figma properties
  /// fontFamily: Gilroy
  /// fontSize: 36px
  /// height: 44px
  /// fontWeight: 500
  /// letterSpacing: none
  /// fontStyle: none
  /// decoration: none
  static const TextStyle h1Mob = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 36,
    height: 1.22,
    fontWeight: FontWeight.w500,
    color: AppColors.materialThemeKeyColorsSecondary,
  );

  /// h1Tablet figma properties
  /// fontFamily: Gilroy
  /// fontSize: 48px
  /// height: 56px
  /// fontWeight: 500
  /// letterSpacing: -0.25px
  /// fontStyle: none
  /// decoration: none
  static const TextStyle h1Tablet = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 48,
    height: 1.17,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.25,
    color: AppColors.materialThemeKeyColorsSecondary,
  );
}
