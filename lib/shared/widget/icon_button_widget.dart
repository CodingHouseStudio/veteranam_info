import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({
    required this.icon,
    required this.onPressed,
    this.background,
    super.key,
    this.padding,
  });
  final Color? background;
  final Widget icon;
  final double? padding;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      style: KButtonStyles.iconButtonStyle.copyWith(
        backgroundColor: MaterialStatePropertyAll(background),
      ),
      padding: EdgeInsets.all(padding ?? KPadding.kPaddingSize12),
      icon: icon,
    );
  }
}
