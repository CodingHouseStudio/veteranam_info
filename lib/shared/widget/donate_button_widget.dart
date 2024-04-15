import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class DonateButtonWidget extends StatelessWidget {
  const DonateButtonWidget({
    required this.text,
    required this.onPressed,
    super.key,
    this.icon,
    this.textStyle,
    this.backgroundColor,
  });
  final Icon? icon;
  final TextStyle? textStyle;
  final String text;
  final void Function() onPressed;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: KButtonStyles.whiteButtonStyleWInf.copyWith(
        backgroundColor: MaterialStatePropertyAll(
          backgroundColor ?? AppColors.white,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: KPadding.kPaddingSize32,
          bottom: KPadding.kPaddingSize16,
          right: KPadding.kPaddingSize16,
          top: KPadding.kPaddingSize16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: textStyle ?? AppTextStyle.text32,
            ),
            IconWidget(
              icon: icon ?? KIcon.arrowUpRight,
              background: AppColors.lightGray,
            ),
          ],
        ),
      ),
    );
  }
}
