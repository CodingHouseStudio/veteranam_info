import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

extension WidgetThemeExtenntion on BuildContext {
  KWidgetTheme get widgetTheme => KWidgetTheme.of(this);
}

/// COMMENT: Variables with widget theme that don't have a specific group
class KWidgetTheme {
  KWidgetTheme.of(this.context);
  final BuildContext context;
  OutlineInputBorder get outlineInputBorder => OutlineInputBorder(
        borderSide: BorderSide(color: context.color.secondary),
        borderRadius: KBorderRadius.kBorderRadius32,
      );
  OutlineInputBorder get outlineInputBorderError => OutlineInputBorder(
        borderSide: BorderSide(color: context.color.error),
        borderRadius: KBorderRadius.kBorderRadius32,
      );

  BoxDecoration get boxDecorationWidget => BoxDecoration(
        borderRadius: KBorderRadius.kBorderRadius32,
        border: Border.all(color: context.color.secondary),
      );
  BoxDecoration get boxDecorationCircular => BoxDecoration(
        shape: BoxShape.circle,
        color: context.color.background,
      );

  BoxDecoration get boxDecorationGrayCircular => BoxDecoration(
        shape: BoxShape.circle,
        color: context.color.background,
      );

  BoxDecoration get boxDecorationCard => BoxDecoration(
        borderRadius: KBorderRadius.kBorderRadius32,
        color: context.color.secondary,
      );
  BoxDecoration get boxDecorationNawbar => BoxDecoration(
        borderRadius: KBorderRadius.kBorderRadius32,
        // color: context.color.neutural,
      );
  BoxDecoration get boxDecorationImageDesk => BoxDecoration(
        borderRadius: KBorderRadius.kBorderRadiusLeft32,
        color: context.color.onPrimary,
      );
  BoxDecoration get boxDecorationImageMob => BoxDecoration(
        borderRadius: KBorderRadius.kBorderRadiusTop32,
        color: context.color.onPrimary,
      );
  BoxDecoration get boxDecorationImage => BoxDecoration(
        borderRadius: KBorderRadius.kBorderRadius32,
        color: context.color.onPrimary,
      );
  BoxDecoration get boxDecorationWhite => BoxDecoration(
        borderRadius: KBorderRadius.kBorderRadiusRight32,
        color: context.color.background,
      );

  BoxDecoration get boxDecorChatMessage => BoxDecoration(
        color: context.color.onPrimary,
        borderRadius: KBorderRadius.kBorderRadius32
            .copyWith(bottomLeft: const Radius.circular(KSize.kRadius8)),
      );
  BoxDecoration get boxCheckPoint => BoxDecoration(
        color: context.color.onSecondary,
        border: Border.all(
          color: context.color.secondary,
          width: KSize.kPixel3,
        ),
        borderRadius: KBorderRadius.kBorderRadius8,
      );

  InputDecoration get inputDecoration => InputDecoration(
        hintStyle: context.textStyle.hint24,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: KPadding.kPaddingSize20,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        border: context.widgetTheme.outlineInputBorder,
        enabledBorder: context.widgetTheme.outlineInputBorder,
        disabledBorder: context.widgetTheme.outlineInputBorder,
        focusedBorder: context.widgetTheme.outlineInputBorder,
        focusedErrorBorder: context.widgetTheme.outlineInputBorderError,
        filled: true,
        fillColor: context.color.background,
      );
}
