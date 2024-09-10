import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class TextPointWidget extends StatelessWidget {
  const TextPointWidget(
    this.text, {
    super.key,
    this.textAlign,
    this.pointColor,
    this.textStyle,
    this.mainAxisAlignment,
    // this.hasExpanded = true,
  });
  final String text;
  final TextAlign? textAlign;
  final Color? pointColor;
  final TextStyle? textStyle;
  final MainAxisAlignment? mainAxisAlignment;
  // final bool hasExpanded;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: KPadding.kPaddingSize4,
          backgroundColor: pointColor,
        ),
        KSizedBox.kWidthSizedBox8,
        // if (hasExpanded)
        //   Expanded(
        //     child: Text(
        //       text,
        //       style: AppTextStyle.materialThemeTitleSmall,
        //       textAlign: textAlign,
        //     ),
        //   )
        // else
        Text(
          text,
          style: textStyle ?? AppTextStyle.materialThemeTitleSmall,
          textAlign: textAlign,
        ),
      ],
    );
  }
}
