import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class CardTextDetailWidget extends StatefulWidget {
  const CardTextDetailWidget({
    required this.text,
    required this.maxLines,
    this.icon,
    super.key,
  });
  final String text;
  final int maxLines;
  final Widget? icon;

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
      key: KWidgetkeys.cardTextDetailKeys.widget,
      children: [
        Text(
          widget.text,
          key: KWidgetkeys.cardTextDetailKeys.text,
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
                key: KWidgetkeys.cardTextDetailKeys.button,
                onPressed: () {
                  setState(() {
                    maxLines == null
                        ? maxLines = widget.maxLines
                        : maxLines = null;
                  });
                },
                style: KButtonStyles.whiteButtonStyleBorder,
                child: Text(
                  maxLines == null
                      ? KAppText.storyCardButtonNotDetail
                      : KAppText.storyCardButtonDetail,
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
