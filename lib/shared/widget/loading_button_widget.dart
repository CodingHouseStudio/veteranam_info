import 'dart:math';

import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

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
    if (isHovered != isHovering) {
      setState(() {
        isHovering = isHovered;
        if (isHovered) {
          _controller.repeat(); // Start infinite rotation on hover
        } else {
          _controller.stop(); // Stop rotation when not hovered
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: widget.widgetKey,
      onPressed: widget.onPressed,
      style: KButtonStyles.withoutStyle,
      onHover: _handleHover,
      child: RepaintBoundary(
        child: Stack(
          key: LoadingButtonKeys.desk,
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
                  key: LoadingButtonKeys.text,
                  style: AppTextStyle.materialThemeTitleMediumWhite,
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _animation,
              builder: (BuildContext context, Widget? child) {
                final angle = _controller.value * 2 * pi;
                return Transform.rotate(
                  angle: angle,
                  child: child,
                );
              },
              child: IconWidget(
                key: isHovering
                    ? LoadingButtonKeys.loadingIcon
                    : LoadingButtonKeys.icon,
                icon: KIcon.refreshWhite,
                padding: KPadding.kPaddingSize12,
                background: AppColors.materialThemeKeyColorsSecondary,
              ),
            ),
          ],
        ),
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
        key: LoadingButtonKeys.mob,
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
              key: LoadingButtonKeys.text,
              style: AppTextStyle.materialThemeTitleMediumWhite,
            ),
          ),
          const IconWidget(
            key: LoadingButtonKeys.icon,
            icon: KIcon.refreshWhite,
            padding: KPadding.kPaddingSize12,
            background: AppColors.materialThemeKeyColorsSecondary,
          ),
        ],
      ),
    );
  }
}
