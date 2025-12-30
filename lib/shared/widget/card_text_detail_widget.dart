import 'package:flutter/material.dart';

import 'package:veteranam/shared/shared_flutter.dart';

class CardTextDetailWidget extends StatefulWidget {
  const CardTextDetailWidget({
    required this.text,
    required this.isDesk,
    this.maxLines,
    // this.hasMarkdown = false,
    this.icon,
    super.key,
    this.buttonText,
    this.buttonStyle,
  });

  final String text;
  final int? maxLines;
  final Widget? icon;
  final List<String>? buttonText;
  final ButtonStyle? buttonStyle;
  final bool isDesk;
  // final bool hasMarkdown;

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
    // The RepaintBoundary widget is used here to optimize the rendering
    // of each card widget. By wrapping the card widget in a
    // RepaintBoundary, we ensure that only the part of the widget tree
    // that changes (in this case, the card itself) is repainted
    // when there are updates. This can help improve performance,
    // especially when dealing with long lists or animations.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: KPadding.kPaddingSize16,
      children: [
        // if (widget.hasMarkdown)
        //   MarkdownLinkWidget(
        //     key: CardTextDetailKeys.text,
        //     text: widget.text
        //         .markdownCard(isDesk: widget.isDesk, fullText: fullText),
        //     isDesk: widget.isDesk,
        //   )
        // else
        Text(
          widget.text,
          key: CardTextDetailKeys.text,
          maxLines: fullText ? null : widget.maxLines ?? 2,
          style: AppTextStyle.materialThemeBodyLarge,
          overflow: TextOverflow.clip,
        ),
        Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing:
              widget.isDesk ? KPadding.kPaddingSize24 : KPadding.kPaddingSize16,
          children: [
            if (isSmallText)
              const Spacer()
            else
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    key: CardTextDetailKeys.button,
                    onPressed: () => setState(() {
                      fullText = !fullText;
                    }),
                    style: widget.buttonStyle ??
                        KButtonStyles.borderBlackButtonStyle,
                    child: RepaintBoundary(
                      child: Text(
                        fullText
                            ? widget.buttonText?.elementAt(1) ??
                                context.l10n.hide
                            : widget.buttonText?.elementAt(0) ??
                                context.l10n.more,
                        key: CardTextDetailKeys.buttonText,
                        style: widget.isDesk
                            ? AppTextStyle.materialThemeTitleMedium
                            : AppTextStyle.materialThemeTitleSmall,
                      ),
                    ),
                  ),
                ),
              ),
            if (widget.icon != null) widget.icon!,
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
