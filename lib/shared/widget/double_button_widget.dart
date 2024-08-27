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
  final double? mobIconPadding;
  final Alignment? align;

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
        );
}

class _DoubleButtonWidgetDesk extends StatefulWidget {
  const _DoubleButtonWidgetDesk({
    required this.text,
    required this.onPressed,
    required this.widgetKey,
    this.textColor,
    this.color,
  });
  final String text;
  final Color? color;
  final Color? textColor;
  final void Function()? onPressed;
  final Key widgetKey;

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
              margin: const EdgeInsets.only(right: KPadding.kPaddingSize40),
              decoration:
                  KWidgetTheme.boxDecorationGreen.copyWith(color: widget.color),
              padding: const EdgeInsets.symmetric(
                horizontal: KPadding.kPaddingSize30,
                vertical: KPadding.kPaddingSize12,
              ),
              child: Text(
                widget.text,
                key: KWidgetkeys.widget.doubleButton.text,
                style: AppTextStyle.materialThemeTitleMedium.copyWith(
                  color: widget.textColor ??
                      AppColors.materialThemeKeyColorsSecondary,
                ),
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
              icon: KIcon.arrowUpRight.copyWith(
                color: widget.textColor ??
                    AppColors.materialThemeKeyColorsSecondary,
              ),
              background: widget.color,
              padding: KPadding.kPaddingSize12,
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
            decoration: KWidgetTheme.boxDecorationGreen.copyWith(color: color),
            padding: EdgeInsets.symmetric(
              horizontal: horizontalTextPadding ?? KPadding.kPaddingSize30,
              vertical: verticalTextPadding ?? KPadding.kPaddingSize8,
            ),
            child: Text(
              text,
              key: KWidgetkeys.widget.doubleButton.text,
              style: AppTextStyle.materialThemeTitleMedium.copyWith(
                color: textColor ?? AppColors.materialThemeKeyColorsSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          IconWidget(
            key: KWidgetkeys.widget.doubleButton.icon,
            icon: KIcon.arrowUpRight.copyWith(
              color: textColor ?? AppColors.materialThemeKeyColorsSecondary,
            ),
            background: color,
            padding: iconPaddingValue,
          ),
        ],
      ),
    );
  }
}
