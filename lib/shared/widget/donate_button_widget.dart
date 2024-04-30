import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class DonateButtonWidget extends StatelessWidget {
  const DonateButtonWidget({
    required this.text,
    required this.onPressed,
    required this.isDesk,
    super.key,
    this.icon,
    this.backgroundColor,
  });
  final Icon? icon;
  final String text;
  final void Function() onPressed;
  final Color? backgroundColor;
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: KButtonStyles.whiteButtonStyleWInf.copyWith(
        backgroundColor: MaterialStatePropertyAll(backgroundColor),
      ),
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
                text,
                style: isDesk ? AppTextStyle.text32 : AppTextStyle.text24,
                maxLines: KMinMaxSize.donateCardButtonTextMaxLine,
              ),
            ),
            IconWidget(
              icon: icon ?? KIcon.arrowUpRight,
              // background: AppColors.lightGray,
            ),
          ],
        ),
      ),
    );
  }
}
