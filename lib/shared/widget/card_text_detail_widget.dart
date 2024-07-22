import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_markdown_selectionarea/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';
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
  late bool fullText;

  @override
  void initState() {
    super.initState();
    fullText = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.hasMarkdown)
          SelectionArea(
            child: MarkdownBody(
              data: fullText ? widget.text : subtext,
              // selectable: true,
              styleSheet: MarkdownStyleSheet(
                a: AppTextStyle.materialThemeBodyLarge,
              ),
              onTapLink: (text, href, title) async {
                if (href == null) return;
                if (!href.isUrlValid && KPlatformConstants.isWebDesktop) {
                  await Clipboard.setData(ClipboardData(text: text));
                  return;
                }
                final canLaunch = await canLaunchUrl(Uri.parse(href));
                if (canLaunch) {
                  await launchUrl(
                    Uri.parse(href),
                  );
                }
              },
            ),
          )
        else
          Text(
            fullText ? widget.text : subtext,
            key: KWidgetkeys.widget.cardTextDetail.text,
            // maxLines: maxLines,
            style: AppTextStyle.materialThemeBodyLarge,
            overflow: TextOverflow.clip,
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
                  onPressed: () => setState(() {
                    fullText = !fullText;
                  }),
                  style: widget.buttonStyle ??
                      KButtonStyles.borderBlackButtonStyle,
                  child: Text(
                    fullText
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

  String get subtext {
    final index = widget.text.indexOf('\n\n');
    final i = index != -1
        ? index
        : widget.text.length > KMinMaxSize.titleMaxLength
            ? KMinMaxSize.titleMaxLength
            : widget.text.length;
    return '${widget.text.substring(0, i)}...';
  }
}
