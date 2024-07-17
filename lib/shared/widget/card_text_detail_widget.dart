import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:veteranam/shared/shared.dart';

class CardTextDetailWidget extends StatefulWidget {
  const CardTextDetailWidget({
    required this.text,
    required this.maxLines,
    required this.isDesk,
    this.hasMarkdown = false,
    this.icon,
    super.key,
    this.buttonText,
    this.buttonStyle,
  });

  final String text;
  final int maxLines;
  final List<Widget>? icon;
  final List<String>? buttonText;
  final ButtonStyle? buttonStyle;
  final bool isDesk;
  final bool hasMarkdown;

  @override
  State<CardTextDetailWidget> createState() => _CardTextDetailWidgetState();
}

class _CardTextDetailWidgetState extends State<CardTextDetailWidget> {
  late String text;

  @override
  void initState() {
    super.initState();
    text = widget.text.substring(0, widget.text.indexOf('\n'));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.hasMarkdown)
          MarkdownBody(
            data: text,
            selectable: true,
            styleSheet: MarkdownStyleSheet(
              a: AppTextStyle.materialThemeBodyLarge,
            ),
          )
        else
          Text(
            text,
            key: KWidgetkeys.widget.cardTextDetail.text,
            // maxLines: maxLines,
            style: AppTextStyle.materialThemeBodyLarge,
            // overflow: TextOverflow.clip,
          ),
        if (!widget.isDesk) KSizedBox.kHeightSizedBox16,
        Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  key: KWidgetkeys.widget.cardTextDetail.button,
                  onPressed: () {
                    setState(() {
                      if (text.length == widget.text.length) {
                        text =
                            widget.text.substring(0, widget.text.indexOf('\n'));
                      } else {
                        text = widget.text;
                      }
                    });
                  },
                  style: widget.buttonStyle ??
                      KButtonStyles.borderBlackButtonStyle,
                  child: Text(
                    text.length == widget.text.length
                        ? widget.buttonText?.elementAt(1) ?? context.l10n.hide
                        : widget.buttonText?.elementAt(0) ??
                            context.l10n.detail,
                    key: KWidgetkeys.widget.cardTextDetail.buttonText,
                    style: widget.isDesk
                        ? AppTextStyle.materialThemeTitleMedium
                        : AppTextStyle.materialThemeTitleSmall,
                  ),
                ),
              ),
            ),
            if (widget.isDesk)
              KSizedBox.kHeightSizedBox24
            else
              KSizedBox.kHeightSizedBox16,
            if (widget.icon != null) ...widget.icon!,
          ],
        ),
      ],
    );
  }
}
