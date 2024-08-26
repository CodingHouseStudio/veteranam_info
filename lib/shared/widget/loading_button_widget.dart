import 'dart:math';

import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class LoadingButtonWidget extends StatelessWidget {
  const LoadingButtonWidget({
    required this.isDesk,
    required this.onPressed,
    required this.text,
    required this.widgetKey,
    super.key,
  });
  final bool isDesk;
  final void Function()? onPressed;
  final String text;
  final Key widgetKey;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isDesk
          ? _LoadingButtonWidgetDesk(
              text: text,
              onPressed: onPressed,
              widgetKey: widgetKey,
            )
          : _LoadingButtonWidgetMob(
              text: text,
              onPressed: onPressed,
              widgetKey: widgetKey,
            ),
    );
  }
}

class _LoadingButtonWidgetDesk extends StatefulWidget {
  const _LoadingButtonWidgetDesk({
    required this.text,
    required this.onPressed,
    required this.widgetKey,
  });
  final String text;
  final void Function()? onPressed;
  final Key widgetKey;

  @override
  State<_LoadingButtonWidgetDesk> createState() =>
      _LoadingButtonWidgetDeskState();
}

class _LoadingButtonWidgetDeskState extends State<_LoadingButtonWidgetDesk>
    with SingleTickerProviderStateMixin {
  late bool isHovering;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    isHovering = false;
    _controller = AnimationController(
      vsync: this,
      duration:
          const Duration(seconds: 1), // Set a duration for a smooth rotation
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear, // Use linear curve for continuous rotation
    );
  }

  void _handleHover(bool isHovered) {
    setState(() {
      isHovering = isHovered;
      if (isHovered) {
        _controller.repeat(); // Start infinite rotation on hover
      } else {
        _controller.stop(); // Stop rotation when not hovered
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: widget.widgetKey,
      onPressed: widget.onPressed,
      style: KButtonStyles.withoutStyle,
      onHover: _handleHover,
      child: Stack(
        key: KWidgetkeys.widget.loadingButton.desk,
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
              decoration: KWidgetTheme.boxDecorationBlack,
              padding: const EdgeInsets.symmetric(
                horizontal: KPadding.kPaddingSize30,
                vertical: KPadding.kPaddingSize12,
              ),
              child: Text(
                widget.text,
                key: KWidgetkeys.widget.loadingButton.text,
                style: AppTextStyle.materialThemeTitleMedium.copyWith(
                  color: AppColors.materialThemeWhite,
                ),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _animation,
            builder: (BuildContext context, Widget? child) {
              // ignore: omit_local_variable_types
              final double angle = _controller.value * 2 * pi;
              return Transform.rotate(
                angle: angle,
                child: child,
              );
            },
            child: IconWidget(
              key: isHovering
                  ? KWidgetkeys.widget.loadingButton.loadingIcon
                  : KWidgetkeys.widget.loadingButton.icon,
              icon: KIcon.refresh.copyWith(
                color: AppColors.materialThemeWhite,
              ),
              padding: KPadding.kPaddingSize12,
              background: AppColors.materialThemeKeyColorsSecondary,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _LoadingButtonWidgetMob extends StatelessWidget {
  const _LoadingButtonWidgetMob({
    required this.text,
    required this.onPressed,
    required this.widgetKey,
  });
  final String text;
  final void Function()? onPressed;
  final Key widgetKey;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: widgetKey,
      onPressed: onPressed,
      style: KButtonStyles.withoutStyle,
      child: Stack(
        key: KWidgetkeys.widget.loadingButton.mob,
        alignment: Alignment.centerRight,
        children: [
          Container(
            margin: const EdgeInsets.only(right: KPadding.kPaddingSize40),
            decoration: KWidgetTheme.boxDecorationBlack,
            padding: const EdgeInsets.symmetric(
              horizontal: KPadding.kPaddingSize30,
              vertical: KPadding.kPaddingSize12,
            ),
            child: Text(
              text,
              key: KWidgetkeys.widget.loadingButton.text,
              style: AppTextStyle.materialThemeTitleMedium.copyWith(
                color: AppColors.materialThemeWhite,
              ),
            ),
          ),
          IconWidget(
            key: KWidgetkeys.widget.loadingButton.icon,
            icon: KIcon.refresh.copyWith(
              color: AppColors.materialThemeWhite,
            ),
            padding: KPadding.kPaddingSize12,
            background: AppColors.materialThemeKeyColorsSecondary,
          ),
        ],
      ),
    );
  }
}
