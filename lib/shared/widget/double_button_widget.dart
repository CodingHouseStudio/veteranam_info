import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class DoubleButtonWidget extends StatefulWidget {
  const DoubleButtonWidget({
    required this.text,
    required this.onPressed,
    this.textColor,
    super.key,
    this.color,
  });
  final String text;
  final Color? color;
  final Color? textColor;
  final void Function()? onPressed;

  @override
  State<DoubleButtonWidget> createState() => _DoubleButtonWidgetState();
}

class _DoubleButtonWidgetState extends State<DoubleButtonWidget> {
  late bool isHovering;
  @override
  void initState() {
    isHovering = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: widget.onPressed,
        style: KButtonStyles.doubleButtonStyle,
        onHover: (value) => setState(() {
          isHovering = value;
        }),
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            AnimatedPadding(
              duration: const Duration(milliseconds: 200),
              padding: isHovering
                  ? const EdgeInsets.only(right: KPadding.kPaddingSize12)
                  : EdgeInsets.zero,
              child: Container(
                margin: const EdgeInsets.only(right: KPadding.kPaddingSize40),
                decoration: KWidgetTheme.boxDecorationBlack
                    .copyWith(color: widget.color),
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
              duration: const Duration(milliseconds: 200),
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
                background: widget.color ?? AppColors.materialThemeSourceSeed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
