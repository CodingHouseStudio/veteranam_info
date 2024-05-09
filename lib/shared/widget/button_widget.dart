import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    required this.text,
    required this.isDesk,
    required this.onPressed,
    this.iconRightMerge,
    super.key,
    this.icon,
    this.textStyle,
    this.backgroundColor,
    this.padding,
  });
  final Widget? icon;
  final TextStyle? textStyle;
  final String text;
  final void Function()? onPressed;
  final bool isDesk;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final Widget? iconRightMerge;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: isDesk
          ? KButtonStyles.lightGrayButtonStyle(context)
          : KButtonStyles.lightGrayButtonStyleWInf(context),
      child: Padding(
        padding: padding ??
            (isDesk
                ? const EdgeInsets.symmetric(
                    horizontal: KPadding.kPaddingSize80,
                    vertical: KPadding.kPaddingSize32,
                  )
                : const EdgeInsets.symmetric(
                    vertical: KPadding.kPaddingSize16,
                  )),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            if (icon != null) icon!,
            if (iconRightMerge != null) iconRightMerge!,
            Text(
              text,
              style: textStyle ??
                  (isDesk ? AppTextStyle.text32 : AppTextStyle.text24),
            ),
          ],
        ),
      ),
    );
  }
}
