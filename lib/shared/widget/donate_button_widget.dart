import 'dart:math';

import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class DonateButtonWidget extends StatelessWidget {
  const DonateButtonWidget({
    required this.text,
    required this.isDesk,
    this.onPressed,
    super.key,
    this.icon,
  });
  final Icon? icon;
  final String text;
  final void Function()? onPressed;
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isDesk
          ? _DonateButtonWidgetDesk(
              isDesk: isDesk,
              text: text,
              onPressed: onPressed,
              icon: icon,
            )
          : _DonateButtonWidgetMob(
              isDesk: isDesk,
              text: text,
              onPressed: onPressed,
              icon: icon,
            ),
    );
  }
}

class _DonateButtonWidgetDesk extends StatefulWidget {
  const _DonateButtonWidgetDesk({
    required this.text,
    required this.isDesk,
    this.onPressed,
    this.icon,
  });
  final Icon? icon;
  final String text;
  final void Function()? onPressed;
  final bool isDesk;

  @override
  State<_DonateButtonWidgetDesk> createState() => _DonateButtonWidgetState();
}

class _DonateButtonWidgetState extends State<_DonateButtonWidgetDesk> {
  late bool isHovering;
  @override
  void initState() {
    isHovering = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      style: KButtonStyles.whiteButtonStyleWInf,
      onHover: (value) => setState(() {
        isHovering = value;
      }),
      child: Padding(
        padding: const EdgeInsets.only(
          left: KPadding.kPaddingSize32,
          bottom: KPadding.kPaddingSize16,
          right: KPadding.kPaddingSize16,
          top: KPadding.kPaddingSize16,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.text,
                style: widget.isDesk
                    ? AppTextStyle.materialThemeTitleLarge
                    : AppTextStyle.materialThemeTitleMedium,
                maxLines: KMinMaxSize.textMaxLineOne,
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
                icon: widget.icon ??
                    KIcon.arrowUpRight.copyWith(
                      color: AppColors.materialThemeWhite,
                    ),
                background: AppColors.materialThemeKeyColorsSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DonateButtonWidgetMob extends StatelessWidget {
  const _DonateButtonWidgetMob({
    required this.text,
    required this.isDesk,
    this.onPressed,
    this.icon,
  });
  final Icon? icon;
  final String text;
  final void Function()? onPressed;
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: KButtonStyles.whiteButtonStyleWInf,
      child: Padding(
        padding: const EdgeInsets.only(
          left: KPadding.kPaddingSize32,
          bottom: KPadding.kPaddingSize8,
          right: KPadding.kPaddingSize8,
          top: KPadding.kPaddingSize8,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: AppTextStyle.materialThemeTitleLarge,
                maxLines: KMinMaxSize.textMaxLineOne,
              ),
            ),
            IconWidget(
              padding: KPadding.kPaddingSize16,
              icon: icon ??
                  KIcon.arrowUpRight.copyWith(
                    color: AppColors.materialThemeKeyColorsNeutral,
                  ),
              background: AppColors.materialThemeKeyColorsSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
