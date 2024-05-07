import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

/// COMMENT: Variables with widget theme that don't have a specific group
abstract class KWidgetTheme {
  static OutlineInputBorder outlineInputBorder(BuildContext context) =>
      OutlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
        borderRadius: KBorderRadius.kBorderRadius32,
      );
  static OutlineInputBorder outlineInputBorderError(BuildContext context) =>
      OutlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
        borderRadius: KBorderRadius.kBorderRadius32,
      );

  static BoxDecoration boxDecorationWidget(BuildContext context) =>
      BoxDecoration(
        borderRadius: KBorderRadius.kBorderRadius32,
        border: Border.all(color: Theme.of(context).colorScheme.secondary),
      );
  static BoxDecoration boxDecorationCircular(BuildContext context) =>
      BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.background,
      );

  static BoxDecoration boxDecorationGrayCircular(BuildContext context) =>
      BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.background,
      );

  static BoxDecoration boxDecorationCard(BuildContext context) => BoxDecoration(
        borderRadius: KBorderRadius.kBorderRadius32,
        color: Theme.of(context).colorScheme.secondary,
      );
  static BoxDecoration boxDecorationImageDesk(BuildContext context) =>
      BoxDecoration(
        borderRadius: KBorderRadius.kBorderRadiusLeft32,
        color: Theme.of(context).colorScheme.onPrimary,
      );
  static BoxDecoration boxDecorationImageMob(BuildContext context) =>
      BoxDecoration(
        borderRadius: KBorderRadius.kBorderRadiusTop32,
        color: Theme.of(context).colorScheme.onPrimary,
      );
  static BoxDecoration boxDecorationWhite(BuildContext context) =>
      BoxDecoration(
        borderRadius: KBorderRadius.kBorderRadiusRight32,
        color: Theme.of(context).colorScheme.background,
      );

  static BoxDecoration boxDecorChatMessage(BuildContext context) =>
      BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: KBorderRadius.kBorderRadius32
            .copyWith(bottomLeft: const Radius.circular(KSize.kRadius8)),
      );

  static InputDecoration inputDecoration(BuildContext context) =>
      InputDecoration(
        hintStyle: AppTextStyle.hint24,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: KPadding.kPaddingSize20,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        border: KWidgetTheme.outlineInputBorder(context),
        enabledBorder: KWidgetTheme.outlineInputBorder(context),
        disabledBorder: KWidgetTheme.outlineInputBorder(context),
        focusedBorder: KWidgetTheme.outlineInputBorder(context),
        focusedErrorBorder: KWidgetTheme.outlineInputBorderError(context),
        filled: true,
        fillColor: Theme.of(context).colorScheme.background,
      );
}
