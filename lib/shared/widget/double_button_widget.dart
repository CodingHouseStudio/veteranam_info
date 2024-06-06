import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class DoubleButtonWidget extends StatelessWidget {
  const DoubleButtonWidget({
    required this.text,
    required this.isDesk,
    required this.onPressed,
    required this.widgetKey,
    super.key,
    this.color,
    this.textColor,
  });
  final String text;
  final Color? color;
  final Color? textColor;
  final void Function()? onPressed;
  final bool isDesk;
  final Key widgetKey;

  @override
  Widget build(BuildContext context) {
    if (isDesk) {
      return Align(
        alignment: Alignment.centerLeft,
        child: _DoubleButtonWidgetDesk(
          text: text,
          onPressed: onPressed,
          color: color,
          textColor: textColor,
          widgetKey: widgetKey,
        ),
      );
    } else {
      return Align(
        alignment: Alignment.centerLeft,
        child: _DoubleButtonWidgetMob(
          text: text,
          onPressed: onPressed,
          color: color,
          textColor: textColor,
          widgetKey: widgetKey,
        ),
      );
    }
  }
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
      style: KButtonStyles.doubleButtonStyle,
      onHover: (value) => setState(() {
        isHovering = value;
      }),
      child: Stack(
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
                  KWidgetTheme.boxDecorationBlack.copyWith(color: widget.color),
              padding: const EdgeInsets.symmetric(
                horizontal: KPadding.kPaddingSize30,
                vertical: KPadding.kPaddingSize12,
              ),
              child: Text(
                widget.text,
                style: AppTextStyle.materialThemeTitleMedium.copyWith(
                  color: widget.textColor ?? AppColors.materialThemeBlack,
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
              icon: KIcon.arrowUpRight.copyWith(
                color: widget.textColor ?? AppColors.materialThemeBlack,
              ),
              background: widget.color,
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
    this.textColor,
    this.color,
  });
  final String text;
  final Color? color;
  final Color? textColor;
  final void Function()? onPressed;
  final Key widgetKey;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: widgetKey,
      onPressed: onPressed,
      style: KButtonStyles.doubleButtonStyle,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Container(
            margin: const EdgeInsets.only(right: KPadding.kPaddingSize40),
            decoration: KWidgetTheme.boxDecorationBlack.copyWith(color: color),
            padding: const EdgeInsets.symmetric(
              horizontal: KPadding.kPaddingSize30,
              vertical: KPadding.kPaddingSize12,
            ),
            child: Text(
              text,
              style: AppTextStyle.materialThemeTitleMedium.copyWith(
                color: textColor ?? AppColors.materialThemeBlack,
              ),
            ),
          ),
          IconWidget(
            icon: KIcon.arrowUpRight.copyWith(
              color: textColor ?? AppColors.materialThemeBlack,
            ),
            background: color,
          ),
        ],
      ),
    );
  }
}
