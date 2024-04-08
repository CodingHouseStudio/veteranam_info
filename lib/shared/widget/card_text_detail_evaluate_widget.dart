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
    this.titleTopMob = false,
    this.titleDate,
  });
  final String text;
  final List<String>? buttonText;
  final ButtonStyle? buttonStyle;
  final Widget titleWidget;
  final bool titleTopMob;
  final String? image;
  final Widget? bottom;
  final Widget? titleDate;

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
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final isDesk =
            KPlatformConstants.changeToDescWidget(constraints.maxWidth);
        return CardAddImageWidget(
          titleWidget:
              !isDesk && widget.titleTopMob ? widget.titleWidget : null,
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
                  Padding(
                    padding: EdgeInsets.only(
                      top: isDesk
                          ? KPadding.kPaddingSize8
                          : KPadding.kPaddingSize16,
                      bottom: isDesk
                          ? KPadding.kPaddingSize32
                          : KPadding.kPaddingSize16,
                    ),
                    child: buildTitle(isDesk: isDesk),
                  ),
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
                            onTap: () => setState(() {
                              like == null || like == false
                                  ? like = true
                                  : like = null;
                            }),
                            child: like == null || !like!
                                ? KIcon.like.setIconKey(
                                    KWidgetkeys
                                        .widget.cardTextDetailEvaluate.iconLike,
                                  )
                                : KIcon.activeLike.setIconKey(
                                    KWidgetkeys.widget.cardTextDetailEvaluate
                                        .iconActiveLike,
                                  ),
                          ),
                          KSizedBox.kWidthSizedBox8,
                          KIcon.smile.setIconKey(
                            KWidgetkeys.widget.cardTextDetailEvaluate.iconSmile,
                          ),
                          KSizedBox.kWidthSizedBox8,
                          InkWell(
                            onTap: () => setState(() {
                              like == null || like! == true
                                  ? like = false
                                  : like = null;
                            }),
                            child: like == null || like!
                                ? KIcon.dislike.setIconKey(
                                    KWidgetkeys.widget.cardTextDetailEvaluate
                                        .iconDislike,
                                  )
                                : KIcon.activeDislike.setIconKey(
                                    KWidgetkeys.widget.cardTextDetailEvaluate
                                        .iconActiveDislike,
                                  ),
                          ),
                        ],
                      ),
                      KIcon.share.setIconKey(
                        KWidgetkeys.widget.cardTextDetailEvaluate.iconShare,
                      ),
                    ],
                  ),
                  if (widget.bottom != null) widget.bottom!,
                ],
              ),
            ),
          ),
          isDesk: isDesk,
        );
      },
    );
  }

  Widget buildTitle({required bool isDesk}) {
    if (widget.titleDate != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (isDesk || !widget.titleTopMob) widget.titleWidget,
          widget.titleDate!,
        ],
      );
    } else {
      return widget.titleWidget;
    }
  }
}
