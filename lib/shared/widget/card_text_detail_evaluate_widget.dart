import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class CardTextDetailEvaluateWidget extends StatefulWidget {
  const CardTextDetailEvaluateWidget({
    required this.text,
    required this.titleWidget,
    super.key,
    this.buttonText,
    this.image,
    this.buttonStyle,
    this.bottom,
  });
  final String text;
  final List<String>? buttonText;
  final ButtonStyle? buttonStyle;
  final Widget titleWidget;
  final String? image;
  final Widget? bottom;

  @override
  State<CardTextDetailEvaluateWidget> createState() =>
      _CardTextDetailEvaluateWidgetState();
}

class _CardTextDetailEvaluateWidgetState
    extends State<CardTextDetailEvaluateWidget> {
  late bool? like;
  late int? maxLines;

  @override
  void initState() {
    super.initState();
    like = null;
    maxLines = 10;
  }

  @override
  Widget build(BuildContext context) {
    return CardAddImageWidget(
      image: widget.image,
      childWidget: Center(
        key: KWidgetkeys.widget.cardTextDetailEvaluate.widget,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: KMinMaxSize.maxWidth640,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              widget.titleWidget,
              KSizedBox.kHeightSizedBox24,
              CardTextDetailWidget(
                text: widget.text,
                maxLines: KDimensions.storyCardMaxLines,
                buttonText: widget.buttonText,
                buttonStyle: widget.buttonStyle,
              ),
              KSizedBox.kHeightSizedBox24,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        key: KWidgetkeys.widget.cardTextDetailEvaluate.iconLike,
                        onTap: () => setState(() {
                          like == null || like == false
                              ? like = true
                              : like = null;
                        }),
                        child: like == null || !like!
                            ? KIcon.like
                            : KIcon.activeLike,
                      ),
                      KSizedBox.kWidthSizedBox8,
                      Container(
                        key:
                            KWidgetkeys.widget.cardTextDetailEvaluate.iconSmile,
                        child: KIcon.smile,
                      ),
                      KSizedBox.kWidthSizedBox8,
                      InkWell(
                        key: KWidgetkeys
                            .widget.cardTextDetailEvaluate.iconDislike,
                        onTap: () => setState(() {
                          like == null || like! == true
                              ? like = false
                              : like = null;
                        }),
                        child: like == null || like!
                            ? KIcon.dislike
                            : KIcon.activeDislike,
                      ),
                    ],
                  ),
                  Container(
                    key: KWidgetkeys.widget.cardTextDetailEvaluate.iconShare,
                    child: KIcon.share,
                  ),
                ],
              ),
              if (widget.bottom != null) widget.bottom!,
            ],
          ),
        ),
      ),
    );
  }
}
