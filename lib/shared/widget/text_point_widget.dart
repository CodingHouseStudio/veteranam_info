import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class TextPointWidget extends StatelessWidget {
  const TextPointWidget(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
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
        Expanded(
          child: Text(
            text,
            style: AppTextStyle.materialThemeTitleSmall,
          ),
        ),
      ],
    );
  }
}
