import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class CardTextDetailWidget extends StatefulWidget {
  const CardTextDetailWidget({
    required this.text,
    required this.maxLines,
    required this.isDesk,
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
  final bool isDesk;

  @override
  State<CardTextDetailWidget> createState() => _CardTextDetailWidgetState();
}

class _CardTextDetailWidgetState extends State<CardTextDetailWidget> {
  late int? maxLines;
  late GlobalKey cardDetailKey;

  @override
  void initState() {
    super.initState();
    cardDetailKey = GlobalKey();
    maxLines = widget.maxLines;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: cardDetailKey,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          key: KWidgetkeys.widget.cardTextDetail.text,
          maxLines: maxLines,
          style: AppTextStyle.materialThemeBodyLarge,
          overflow: TextOverflow.clip,
        ),
        KSizedBox.kHeightSizedBox24,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: TextButton(
                key: KWidgetkeys.widget.cardTextDetail.button,
                onPressed: () {
                  setState(() {
                    if (maxLines == null) {
                      maxLines = widget.maxLines;
                      Scrollable.ensureVisible(
                        cardDetailKey.currentContext!,
                      );
                    } else {
                      maxLines = null;
                    }
                  });
                },
                style:
                    widget.buttonStyle ?? KButtonStyles.whiteButtonStyleBorder,
                child: Text(
                  maxLines == null
                      ? widget.buttonText?.elementAt(1) ?? context.l10n.hide
                      : widget.buttonText?.elementAt(0) ?? context.l10n.detail,
                  key: KWidgetkeys.widget.cardTextDetail.buttonText,
                  style: widget.isDesk
                      ? AppTextStyle.materialThemeTitleMedium
                      : AppTextStyle.materialThemeTitleSmall,
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
