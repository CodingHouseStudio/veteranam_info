import 'dart:math';

import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class DoubleButtonWidget extends StatelessWidget {
  const DoubleButtonWidget({
    required this.text,
    required this.isDesk,
    required this.onPressed,
    required this.widgetKey,
    this.mobVerticalTextPadding,
    super.key,
    this.color,
    this.textColor,
    this.hasAlign = true,
    this.mobTextWidth,
    this.mobIconPadding,
    this.align,
    this.mobHorizontalTextPadding,
    this.darkMode,
    this.deskPadding,
    this.deskIconPadding,
    this.deskTextWidth,
    this.icon,
  });
  final String text;
  final Color? color;
  final Color? textColor;
  final void Function()? onPressed;
  final bool isDesk;
  final Key widgetKey;
  final bool hasAlign;
  final double? mobVerticalTextPadding;
  final double? mobHorizontalTextPadding;
  final double? mobTextWidth;
  final double? deskTextWidth;
  final double? mobIconPadding;
  final Alignment? align;
  final bool? darkMode;
  final EdgeInsets? deskPadding;
  final double? deskIconPadding;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    if (hasAlign) {
      return Align(
        alignment: align ?? Alignment.centerLeft,
        child: _body,
      );
    } else {
      return _body;
    }
  }

  Widget get _body => isDesk
      ? _DoubleButtonWidgetDesk(
          text: text,
          onPressed: onPressed,
          color: color,
          textColor: textColor,
          widgetKey: widgetKey,
          useBlackStyle: darkMode,
          padding: deskPadding,
          iconPadding: deskIconPadding,
          textWidth: deskTextWidth,
          icon: icon,
        )
      : _DoubleButtonWidgetMob(
          text: text,
          onPressed: onPressed,
          color: color,
          textColor: textColor,
          widgetKey: widgetKey,
          verticalTextPadding: mobVerticalTextPadding,
          horizontalTextPadding: mobHorizontalTextPadding,
          textWidth: mobTextWidth,
          iconPadding: mobIconPadding,
          useBlackStyle: darkMode,
          icon: icon,
        );
}

class _DoubleButtonWidgetDesk extends StatefulWidget {
  const _DoubleButtonWidgetDesk({
    required this.text,
    required this.onPressed,
    required this.widgetKey,
    this.textColor,
    this.color,
    this.useBlackStyle,
    this.padding,
    this.iconPadding,
    this.textWidth,
    this.icon,
  });
  final String text;
  final Color? color;
  final Color? textColor;
  final void Function()? onPressed;
  final Key widgetKey;
  final bool? useBlackStyle;
  final EdgeInsets? padding;
  final double? iconPadding;
  final double? textWidth;
  final Icon? icon;

  @override
  State<_DoubleButtonWidgetDesk> createState() =>
      _DoubleButtonWidgetDeskState();
}

class _DoubleButtonWidgetDeskState extends State<_DoubleButtonWidgetDesk> {
  late bool isHovering;
  @override
  void initState() {
    isHovering = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: widget.widgetKey,
      onPressed: widget.onPressed,
      style: KButtonStyles.withoutStyle,
      onHover: (value) => setState(() => isHovering = value),
      child: Stack(
        key: KWidgetkeys.widget.doubleButton.desk,
        alignment: Alignment.centerRight,
        children: [
          AnimatedPadding(
            duration: const Duration(
              milliseconds: KDimensions.doubleButtonAnimationDuration,
            ),
            padding: isHovering
                ? const EdgeInsets.only(right: KPadding.kPaddingSize12)
                : EdgeInsets.zero,
            child: Container(
              width: widget.textWidth,
              margin: const EdgeInsets.only(right: KPadding.kPaddingSize40),
              decoration: KWidgetTheme.boxDecorationGreen.copyWith(
                color: widget.color ??
                    (widget.useBlackStyle ?? false
                        ? AppColors.materialThemeKeyColorsSecondary
                        : null),
              ),
              padding: widget.padding ??
                  const EdgeInsets.symmetric(
                    horizontal: KPadding.kPaddingSize30,
                    vertical: KPadding.kPaddingSize12,
                  ),
              child: Text(
                widget.text,
                key: KWidgetkeys.widget.doubleButton.text,
                style: AppTextStyle.materialThemeTitleMedium.copyWith(
                  color: widget.textColor ??
                      (widget.useBlackStyle ?? false
                          ? AppColors.materialThemeWhite
                          : AppColors.materialThemeKeyColorsSecondary),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          TweenAnimationBuilder<double>(
            tween: Tween<double>(
              begin: 0,
              end: isHovering ? pi / 4 : 0,
            ),
            duration: const Duration(
              milliseconds: KDimensions.doubleButtonAnimationDuration,
            ),
            builder: (BuildContext context, double angle, Widget? child) {
              return Transform.rotate(
                angle: angle,
                child: child,
              );
            },
            child: IconWidget(
              key: isHovering
                  ? KWidgetkeys.widget.doubleButton.rotateIcon
                  : KWidgetkeys.widget.doubleButton.icon,
              icon: widget.icon ??
                  KIcon.arrowUpRight.copyWith(
                    color: widget.textColor ??
                        (widget.useBlackStyle ?? false
                            ? AppColors.materialThemeWhite
                            : AppColors.materialThemeKeyColorsSecondary),
                  ),
              background: widget.color ??
                  (widget.useBlackStyle ?? false
                      ? AppColors.materialThemeKeyColorsSecondary
                      : null),
              padding: widget.iconPadding ?? KPadding.kPaddingSize12,
            ),
          ),
        ],
      ),
    );
  }
}

class _DoubleButtonWidgetMob extends StatelessWidget {
  const _DoubleButtonWidgetMob({
    required this.text,
    required this.onPressed,
    required this.widgetKey,
    this.verticalTextPadding,
    this.textColor,
    this.color,
    this.textWidth,
    this.iconPadding,
    this.horizontalTextPadding,
    this.useBlackStyle,
    this.icon,
  });
  final String text;
  final Color? color;
  final Color? textColor;
  final void Function()? onPressed;
  final Key widgetKey;
  final double? verticalTextPadding;
  final double? horizontalTextPadding;
  final double? textWidth;
  final double? iconPadding;
  final bool? useBlackStyle;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    final iconPaddingValue = iconPadding ?? KPadding.kPaddingSize8;
    return TextButton(
      key: widgetKey,
      onPressed: onPressed,
      style: KButtonStyles.withoutStyle,
      child: Stack(
        key: KWidgetkeys.widget.doubleButton.mob,
        alignment: Alignment.centerRight,
        children: [
          Container(
            width: textWidth,
            margin: EdgeInsets.only(
              right: KPadding.kPaddingSize24 +
                  (iconPaddingValue * 2) -
                  KSize.kPixel8,
            ),
            decoration: KWidgetTheme.boxDecorationGreen.copyWith(
              color: color ??
                  (useBlackStyle ?? false
                      ? AppColors.materialThemeKeyColorsSecondary
                      : null),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: horizontalTextPadding ?? KPadding.kPaddingSize30,
              vertical: verticalTextPadding ?? KPadding.kPaddingSize8,
            ),
            child: Text(
              text,
              key: KWidgetkeys.widget.doubleButton.text,
              style: AppTextStyle.materialThemeTitleMedium.copyWith(
                color: textColor ??
                    (useBlackStyle ?? false
                        ? AppColors.materialThemeWhite
                        : AppColors.materialThemeKeyColorsSecondary),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          IconWidget(
            key: KWidgetkeys.widget.doubleButton.icon,
            icon: icon ??
                KIcon.arrowUpRight.copyWith(
                  color: textColor ??
                      (useBlackStyle ?? false
                          ? AppColors.materialThemeWhite
                          : AppColors.materialThemeKeyColorsSecondary),
                ),
            background: color ??
                (useBlackStyle ?? false
                    ? AppColors.materialThemeKeyColorsSecondary
                    : null),
            padding: iconPaddingValue,
          ),
        ],
      ),
    );
  }
}
