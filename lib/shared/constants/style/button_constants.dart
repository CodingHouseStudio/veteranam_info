import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

extension TextThemeExtention on BuildContext {
  ButtonStylesContext get buttonStyle => ButtonStylesContext.of(this);
}

class ButtonStylesContext {
  ButtonStylesContext.of(this.context);
  final BuildContext context;
  ButtonStyle get whiteButtonStyle => TextButton.styleFrom(
        backgroundColor: context.color.background,
        minimumSize:
            const Size(KMinMaxSize.minWidth100, KMinMaxSize.minHeight50),
        padding: const EdgeInsets.all(KPadding.kPaddingSize8),
        // side: const BorderSide(
        //   color: KColorTheme.white,
        // ),
        shape: const RoundedRectangleBorder(
          borderRadius: KBorderRadius.kBorderRadius32,
        ),
      );
  ButtonStyle get borderButtonStyle => TextButton.styleFrom(
        minimumSize:
            const Size(KMinMaxSize.minWidth100, KMinMaxSize.minHeight50),
        shape: RoundedRectangleBorder(
          borderRadius: KBorderRadius.kBorderRadius32,
          side: BorderSide(color: context.color.secondary),
        ),
      );
  ButtonStyle get whiteButtonStyleWInf => TextButton.styleFrom(
        backgroundColor: context.color.background,
        minimumSize: const Size(double.infinity, KMinMaxSize.minHeight50),
        padding: const EdgeInsets.all(KPadding.kPaddingSize8),
        shape: const RoundedRectangleBorder(
          borderRadius: KBorderRadius.kBorderRadius32,
        ),
      );
  ButtonStyle get whiteButtonStyleBorder => TextButton.styleFrom(
        minimumSize:
            const Size(KMinMaxSize.minWidth100, KMinMaxSize.minHeight50),
        padding: const EdgeInsets.all(KPadding.kPaddingSize8),
        side: BorderSide(
          color: context.color.primary,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: KBorderRadius.kBorderRadius32,
        ),
        backgroundColor: context.color.background,
      );
  ButtonStyle get lightGrayButtonStyle => TextButton.styleFrom(
        backgroundColor: context.color.onPrimary,
        minimumSize:
            const Size(KMinMaxSize.minWidth100, KMinMaxSize.minHeight50),
        padding: const EdgeInsets.all(KPadding.kPaddingSize8),
        shape: const RoundedRectangleBorder(
          borderRadius: KBorderRadius.kBorderRadius32,
        ),
      );
  ButtonStyle get lightGrayButtonStyleWInf => TextButton.styleFrom(
        backgroundColor: context.color.onPrimary,
        minimumSize: const Size(double.infinity, KMinMaxSize.minHeight50),
        padding: const EdgeInsets.all(KPadding.kPaddingSize8),
        shape: const RoundedRectangleBorder(
          borderRadius: KBorderRadius.kBorderRadius32,
        ),
      );
  ButtonStyle get transparentButtonStyleBottomBorder => TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: KPadding.kPaddingSize8),
        shape: LinearBorder.bottom(side: const BorderSide()),
        backgroundColor: context.color.background,
      );

  ButtonStyle get secondaryButtonStyle => TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: KPadding.kPaddingSize24,
          vertical: KPadding.kPaddingSize8,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: KBorderRadius.kBorderRadius32,
          side: BorderSide(color: context.color.secondary),
        ),
      );

  ButtonStyle get dropListButtonStyle => TextButton.styleFrom(
        minimumSize:
            const Size(KMinMaxSize.minWidth100, KMinMaxSize.minHeight50),
        padding:
            const EdgeInsets.symmetric(horizontal: KPadding.kPaddingSize32),
        alignment: Alignment.centerLeft,
        shape: const RoundedRectangleBorder(
          // ignore: avoid_redundant_argument_values
          borderRadius: BorderRadius.zero,
        ),
        backgroundColor: context.color.onPrimary,
      );

  ButtonStyle get imageButton => IconButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: KPadding.kPaddingSize90,
        ),
        iconSize: KSize.kPixel70,
        backgroundColor: context.color.onPrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: KBorderRadius.kBorderRadius32,
        ),
      );
}

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
}
