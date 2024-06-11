import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class TextPointWidget extends StatelessWidget {
  const TextPointWidget(
    this.text, {
    super.key,
    this.textAlign,
    this.hasExpanded = true,
  });
  final String text;
  final TextAlign? textAlign;
  final bool hasExpanded;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.materialThemeBlack,
          ),
          height: KSize.kPixel8,
          width: KSize.kPixel8,
        ),
        KSizedBox.kWidthSizedBox8,
        if (hasExpanded)
          Expanded(
            child: Text(
              text,
              style: AppTextStyle.materialThemeTitleSmall,
              textAlign: textAlign,
            ),
          )
        else
          Text(
            text,
            style: AppTextStyle.materialThemeTitleSmall,
            textAlign: textAlign,
          ),
      ],
    );
  }
}
