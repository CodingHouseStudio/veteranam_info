import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class DoubleButtonWidget extends StatelessWidget {
  const DoubleButtonWidget({
    required this.text,
    required this.onPressed,
    this.textColor,
    super.key,
    this.color,
  });
  final String text;
  final Color? color;
  final Color? textColor;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: TextButton(
        onPressed: onPressed,
        style: KButtonStyles.zeroPaddingButtonStyle,
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Container(
              margin: const EdgeInsets.only(right: KPadding.kPaddingSize40),
              decoration:
                  KWidgetTheme.boxDecorationBlack.copyWith(color: color),
              padding: const EdgeInsets.symmetric(
                horizontal: KPadding.kPaddingSize30,
                vertical: KPadding.kPaddingSize12,
              ),
              child: Text(
                text,
                style: AppTextStyle.materialThemeTitleMedium.copyWith(
                  color: textColor ?? AppColors.materialThemeBlack,
                ),
              ),
            ),
            IconWidget(
              icon: KIcon.arrowUpRight
                  .copyWith(color: textColor ?? AppColors.materialThemeBlack),
              background: color ?? AppColors.materialThemeSourceSeed,
            ),
          ],
        ),
      ),
    );
  }
}
