import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class TextPointWidget extends StatelessWidget {
  const TextPointWidget(
    this.text, {
    super.key,
    this.textAlign,
    this.pointColor,
    this.textStyle,
    this.mainAxisAlignment,
    this.textColor,
    this.mainAxisSize,
    // this.hasExpanded = true,
  });
  final String text;
  final TextAlign? textAlign;
  final Color? pointColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final MainAxisAlignment? mainAxisAlignment;
  final MainAxisSize? mainAxisSize;
  // final bool hasExpanded;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
      mainAxisSize: mainAxisSize ?? MainAxisSize.max,
      children: [
        CircleAvatar(
          radius: KSize.kPixel4,
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
          style: textStyle ??
              (textColor == null
                  ? AppTextStyle.materialThemeTitleSmall
                  : AppTextStyle.materialThemeTitleSmall
                      .copyWith(color: textColor)),
          textAlign: textAlign,
        ),
      ],
    );
  }
}
