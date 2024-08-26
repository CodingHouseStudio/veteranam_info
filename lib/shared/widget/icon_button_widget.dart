import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({
    required this.icon,
    required this.onPressed,
    this.background,
    this.color,
    super.key,
    this.padding,
  });

  final Color? background;
  final Color? color;
  final Widget icon;
  final double? padding;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      style: KButtonStyles.iconButtonStyle.copyWith(
        backgroundColor: WidgetStatePropertyAll(background),
      ),
      padding: EdgeInsets.all(padding ?? KPadding.kPaddingSize12),
      icon: icon,
      color: color,
    );
  }
}
