// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class CardTextDetailWidget extends StatefulWidget {
  const CardTextDetailWidget({
    required this.text,
    required this.isDesk,
    this.maxLines,
    this.hasMarkdown = false,
    this.icon,
    super.key,
    this.buttonText,
    this.buttonStyle,
  });

  final String text;
  final int? maxLines;
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
  late bool isSmallText;

  @override
  void initState() {
    super.initState();
    isSmallText = widget.text.length <=
        (widget.isDesk
            ? KDimensions.descriptionDeskHideLength
            : KDimensions.descriptionMobHideLength);
    fullText = isSmallText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.hasMarkdown)
          MarkdownLinkWidget(
            key: KWidgetkeys.widget.cardTextDetail.text,
            text: widget.text
                .markdownCard(isDesk: widget.isDesk, fullText: fullText),
          )
        else
          Text(
            widget.text,
            key: KWidgetkeys.widget.cardTextDetail.text,
            maxLines: fullText ? null : widget.maxLines ?? 2,
            style: AppTextStyle.materialThemeBodyLarge,
            overflow: TextOverflow.clip,
          ),
        KSizedBox.kHeightSizedBox16,
        Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isSmallText)
              const Spacer()
            else
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
                              context.l10n.more,
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

  // String get subtext {
  //   final index = widget.text.indexOf('\n\n');
  //   final i = index != -1
  //       ? index
  //       : widget.text.length > KMinMaxSize.titleDeskMaxLength
  //           ? KMinMaxSize.titleDeskMaxLength
  //           : widget.text.length;
  //   return '${widget.text.substring(0, i)}...';
  // }
}
