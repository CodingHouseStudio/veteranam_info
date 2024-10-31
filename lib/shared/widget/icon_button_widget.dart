import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({
    required this.icon,
    required this.onPressed,
    this.background,
    this.color,
    super.key,
    this.padding,
    this.buttonStyle,
  });

  final Color? background;
  final Color? color;
  final Widget icon;
  final double? padding;
  final void Function()? onPressed;
  final ButtonStyle? buttonStyle;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      style: buttonStyle ??
          KButtonStyles.iconButtonStyle.copyWith(
            backgroundColor: WidgetStatePropertyAll(background),
          ),
      padding: EdgeInsets.all(padding ?? KPadding.kPaddingSize12),
      icon: icon,
      color: color,
    );
  }
}
