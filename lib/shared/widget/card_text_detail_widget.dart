import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class CardTextDetailWidget extends StatefulWidget {
  const CardTextDetailWidget({
    required this.text,
    required this.maxLines,
    this.icon,
    super.key,
    this.buttonText,
    this.buttonStyle,
  });
  final String text;
  final int maxLines;
  final Widget? icon;
  final List<String>? buttonText;
  final ButtonStyle? buttonStyle;

  @override
  State<CardTextDetailWidget> createState() => _CardTextDetailWidgetState();
}

class _CardTextDetailWidgetState extends State<CardTextDetailWidget> {
  late int? maxLines;

  @override
  void initState() {
    super.initState();
    maxLines = widget.maxLines;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: KWidgetkeys.widgetKeys.cardTextDetailKeys.widget,
      children: [
        Text(
          widget.text,
          key: KWidgetkeys.widgetKeys.cardTextDetailKeys.text,
          maxLines: maxLines,
          style: AppTextStyle.lableS,
          overflow: TextOverflow.clip,
        ),
        KSizedBox.kHeightSizedBoxSM,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: TextButton(
                key: KWidgetkeys.widgetKeys.cardTextDetailKeys.button,
                onPressed: () {
                  setState(() {
                    maxLines == null
                        ? maxLines = widget.maxLines
                        : maxLines = null;
                  });
                },
                style:
                    widget.buttonStyle ?? KButtonStyles.whiteButtonStyleBorder,
                child: Text(
                  maxLines == null
                      ? widget.buttonText?.elementAt(1) ??
                          KAppText.storyCardButtonNotDetail
                      : widget.buttonText?.elementAt(0) ??
                          KAppText.storyCardButtonDetail,
                  style: AppTextStyle.lableSSM,
                ),
              ),
            ),
            if (widget.icon != null) widget.icon!,
          ],
        ),
      ],
    );
  }
}
