import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class CardTextDetailEvaluateWidget extends StatefulWidget {
  const CardTextDetailEvaluateWidget({
    required this.text,
    required this.titleWidget,
    required this.isDesk,
    this.titleIcon,
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
  final bool isDesk;
  final Widget? titleIcon;

  @override
  State<CardTextDetailEvaluateWidget> createState() =>
      _CardTextDetailEvaluateWidgetState();
}

class _CardTextDetailEvaluateWidgetState
    extends State<CardTextDetailEvaluateWidget> {
  late EvaluationEnum evaluation;
  late int? maxLines;

  @override
  void initState() {
    super.initState();
    evaluation = EvaluationEnum.none;
    maxLines = 10;
  }

  @override
  Widget build(BuildContext context) {
    return CardAddImageWidget(
      titleWidget: !widget.isDesk && widget.titleTopMob
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.titleWidget,
                if (widget.titleIcon != null)
                  Padding(
                    padding:
                        const EdgeInsets.only(right: KPadding.kPaddingSize16),
                    child: widget.titleIcon,
                  ),
              ],
            )
          : null,
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
                  top: widget.isDesk
                      ? KPadding.kPaddingSize8
                      : KPadding.kPaddingSize16,
                  bottom: widget.isDesk
                      ? KPadding.kPaddingSize32
                      : KPadding.kPaddingSize16,
                ),
                child: buildTitle(isDesk: widget.isDesk),
              ),
              CardTextDetailWidget(
                text: widget.text,
                maxLines: KDimensions.storyCardMaxLines,
                buttonText: widget.buttonText,
                buttonStyle: widget.buttonStyle,
                isDesk: widget.isDesk,
              ),
              KSizedBox.kHeightSizedBox24,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () => setState(() {
                          if (evaluation != EvaluationEnum.like) {
                            evaluation = EvaluationEnum.like;
                          } else {
                            evaluation = EvaluationEnum.none;
                          }
                        }),
                        borderRadius: BorderRadius.circular(KSize.kRadius32),
                        child: Padding(
                          padding: const EdgeInsets.all(KPadding.kPaddingSize4),
                          child: evaluation == EvaluationEnum.like
                              ? KIcon.activeLike.setIconKey(
                                  KWidgetkeys.widget.cardTextDetailEvaluate
                                      .iconActiveLike,
                                )
                              : KIcon.like.setIconKey(
                                  KWidgetkeys
                                      .widget.cardTextDetailEvaluate.iconLike,
                                ),
                        ),
                      ),
                      KSizedBox.kWidthSizedBox8,
                      InkWell(
                        onTap: () => setState(() {
                          if (evaluation != EvaluationEnum.smile) {
                            evaluation = EvaluationEnum.smile;
                          } else {
                            evaluation = EvaluationEnum.none;
                          }
                        }),
                        borderRadius: BorderRadius.circular(KSize.kRadius32),
                        child: Padding(
                          padding: const EdgeInsets.all(KPadding.kPaddingSize4),
                          child: evaluation == EvaluationEnum.smile
                              ? KIcon.activeSmile.setIconKey(
                                  KWidgetkeys.widget.cardTextDetailEvaluate
                                      .iconActiveSmile,
                                  // changeColor: AppColors.grey,
                                )
                              : KIcon.smile.setIconKey(
                                  KWidgetkeys
                                      .widget.cardTextDetailEvaluate.iconSmile,
                                ),
                        ),
                      ),
                      KSizedBox.kWidthSizedBox8,
                      InkWell(
                        onTap: () => setState(() {
                          if (evaluation != EvaluationEnum.dislike) {
                            evaluation = EvaluationEnum.dislike;
                          } else {
                            evaluation = EvaluationEnum.none;
                          }
                        }),
                        borderRadius: BorderRadius.circular(KSize.kRadius32),
                        child: Padding(
                          padding: const EdgeInsets.all(KPadding.kPaddingSize4),
                          child: evaluation == EvaluationEnum.dislike
                              ? KIcon.activeDislike.setIconKey(
                                  KWidgetkeys.widget.cardTextDetailEvaluate
                                      .iconActiveDislike,
                                )
                              : KIcon.dislike.setIconKey(
                                  KWidgetkeys.widget.cardTextDetailEvaluate
                                      .iconDislike,
                                ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      if (widget.titleIcon != null && widget.isDesk)
                        widget.titleIcon!,
                      KSizedBox.kWidthSizedBox16,
                      KIcon.share.setIconKey(
                        KWidgetkeys.widget.cardTextDetailEvaluate.iconShare,
                      ),
                    ],
                  ),
                ],
              ),
              if (widget.bottom != null) widget.bottom!,
            ],
          ),
        ),
      ),
      isDesk: widget.isDesk,
    );
  }

  Widget buildTitle({required bool isDesk}) {
    if (widget.titleDate != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (widget.isDesk || !widget.titleTopMob) widget.titleWidget,
          widget.titleDate!,
        ],
      );
    } else {
      return widget.titleWidget;
    }
  }
}
