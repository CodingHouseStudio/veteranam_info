import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    required this.text,
    required this.onPressed,
    super.key,
    this.icon,
    this.padding,
    this.textStyle,
  });
  final EdgeInsets? padding;
  final Widget? icon;
  final TextStyle? textStyle;
  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: KButtonStyles.lightGrayButtonStyle,
      child: Padding(
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: KPadding.kPaddingSize80,
              vertical: KPadding.kPaddingSize32,
            ),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            if (icon != null) icon!,
            Text(
              text,
              style: AppTextStyle.text32,
            ),
          ],
        ),
      ),
    );
  }
}
