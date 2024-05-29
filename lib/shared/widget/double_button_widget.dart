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
    return TextButton.icon(
      onPressed: onPressed,
      style:
          const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.zero)),
      icon: Container(
        decoration: KWidgetTheme.boxDecorationBlack.copyWith(color: color),
        padding: const EdgeInsets.symmetric(
          horizontal: KPadding.kPaddingSize30,
          vertical: KPadding.kPaddingSize12,
        ),
        child: Expanded(
          child: Text(
            text,
            style: AppTextStyle.materialThemeTitleMedium.copyWith(
              color: textColor ?? AppColors.materialThemeBlack,
            ),
          ),
        ),
      ),
      label: IconWidget(
        icon: KIcon.arrowUpRight
            .copyWith(color: textColor ?? AppColors.materialThemeBlack),
        background: color ?? AppColors.materialThemeSourceSeed,
      ),
    );
  }
}
