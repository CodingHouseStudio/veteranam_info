import 'dart:math';

import 'package:flutter/material.dart';

import 'package:veteranam/shared/shared_flutter.dart';

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
    this.angle,
    this.mobPadding,
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
  final EdgeInsets? mobPadding;
  final double? deskIconPadding;
  final Icon? icon;
  final double? angle;

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

  Widget get _body {
    final containerStyle = color == null
        ? style
        : style.copyWith(
            color: color,
          );
    final textStyleValue = textColor == null
        ? textStyle
        : textStyle.copyWith(
            color: textColor,
          );
    final iconWidget = icon ??
        (textColor == null
            ? iconStyle
            : iconStyle.copyWith(
                color: textColor,
              ));
    final background = color ??
        (darkMode ?? false ? AppColors.materialThemeKeyColorsSecondary : null);
    if (isDesk) {
      return _DoubleButtonWidgetDesk(
        text: text,
        onPressed: onPressed,
        widgetKey: widgetKey,
        padding: deskPadding,
        iconPadding: deskIconPadding,
        textWidth: deskTextWidth,
        angle: angle,
        containerStyle: containerStyle,
        textStyle: textStyleValue,
        icon: iconWidget,
        background: background,
      );
    } else {
      return _DoubleButtonWidgetMob(
        text: text,
        onPressed: onPressed,
        widgetKey: widgetKey,
        verticalTextPadding: mobVerticalTextPadding,
        horizontalTextPadding: mobHorizontalTextPadding,
        textWidth: mobTextWidth,
        iconPadding: mobIconPadding,
        containerStyle: containerStyle,
        textStyle: textStyleValue,
        icon: iconWidget,
        background: background,
        padding: mobPadding,
      );
    }
  }

  BoxDecoration get style => darkMode ?? false
      ? KWidgetTheme.boxDecorationBlack
      : KWidgetTheme.boxDecorationGreen;

  TextStyle get textStyle => darkMode ?? false
      ? AppTextStyle.materialThemeTitleMediumWhite
      : AppTextStyle.materialThemeTitleMedium;

  Icon get iconStyle =>
      darkMode ?? false ? KIcon.arrowUpRightWhite : KIcon.arrowUpRight;
}

class _DoubleButtonWidgetDesk extends StatefulWidget {
  const _DoubleButtonWidgetDesk({
    required this.text,
    required this.onPressed,
    required this.widgetKey,
    required this.icon,
    required this.containerStyle,
    required this.textStyle,
    required this.background,
    this.padding,
    this.iconPadding,
    this.textWidth,
    this.angle,
  });
  final String text;
  final void Function()? onPressed;
  final Key widgetKey;
  final EdgeInsets? padding;
  final double? iconPadding;
  final double? textWidth;
  final double? angle;
  final BoxDecoration containerStyle;
  final TextStyle textStyle;
  final Icon icon;
  final Color? background;

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

  void _hover(bool isHovered) {
    if (isHovered != isHovering) setState(() => isHovering = isHovered);
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: widget.widgetKey,
      onPressed: widget.onPressed,
      style: KButtonStyles.withoutStyle,
      onHover: _hover,
      child: RepaintBoundary(
        child: Stack(
          key: DoubleButtonKeys.desk,
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
                decoration: widget.containerStyle,
                padding: widget.padding ??
                    const EdgeInsets.symmetric(
                      horizontal: KPadding.kPaddingSize30,
                      vertical: KPadding.kPaddingSize12,
                    ),
                child: Text(
                  widget.text,
                  key: DoubleButtonKeys.text,
                  style: widget.textStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            TweenAnimationBuilder<double>(
              tween: Tween<double>(
                begin: 0,
                end: isHovering ? widget.angle ?? (pi / 4) : 0,
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
                    ? DoubleButtonKeys.rotateIcon
                    : DoubleButtonKeys.icon,
                icon: widget.icon,
                background: widget.background,
                padding: widget.iconPadding ?? KPadding.kPaddingSize12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DoubleButtonWidgetMob extends StatelessWidget {
  const _DoubleButtonWidgetMob({
    required this.text,
    required this.onPressed,
    required this.widgetKey,
    required this.textWidth,
    required this.iconPadding,
    required this.containerStyle,
    required this.textStyle,
    required this.icon,
    required this.background,
    required this.verticalTextPadding,
    required this.horizontalTextPadding,
    required this.padding,
  });
  final String text;
  final void Function()? onPressed;
  final Key widgetKey;
  final double? iconPadding;
  final double? textWidth;
  final BoxDecoration containerStyle;
  final TextStyle textStyle;
  final Icon icon;
  final Color? background;
  final double? verticalTextPadding;
  final double? horizontalTextPadding;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final iconPaddingValue = iconPadding ?? KPadding.kPaddingSize8;
    return TextButton(
      key: widgetKey,
      onPressed: onPressed,
      style: KButtonStyles.withoutStyle,
      child: Stack(
        key: DoubleButtonKeys.mob,
        alignment: Alignment.centerRight,
        children: [
          Container(
            width: textWidth,
            margin: EdgeInsets.only(
              right: KPadding.kPaddingSize24 +
                  (iconPaddingValue * 2) -
                  KSize.kPixel8,
            ),
            decoration: containerStyle,
            padding: padding ??
                EdgeInsets.symmetric(
                  horizontal: horizontalTextPadding ?? KPadding.kPaddingSize30,
                  vertical: verticalTextPadding ?? KPadding.kPaddingSize8,
                ),
            child: Text(
              text,
              key: DoubleButtonKeys.text,
              style: textStyle,
              textAlign: TextAlign.center,
            ),
          ),
          IconWidget(
            key: DoubleButtonKeys.icon,
            icon: icon,
            background: background,
            padding: iconPaddingValue,
          ),
        ],
      ),
    );
  }
}
