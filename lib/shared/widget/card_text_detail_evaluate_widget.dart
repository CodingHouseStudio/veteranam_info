import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/components/components.dart';
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
    this.onLikeChange,
  });
  final String text;
  final List<String>? buttonText;
  final ButtonStyle? buttonStyle;
  final Widget titleWidget;
  final bool titleTopMob;
  final ImageModel? image;
  final Widget? bottom;
  final Widget? titleDate;
  final bool isDesk;
  final Widget? titleIcon;
  final void Function({required bool like})? onLikeChange;

  @override
  State<CardTextDetailEvaluateWidget> createState() =>
      _CardTextDetailEvaluateWidgetState();
}

class _CardTextDetailEvaluateWidgetState
    extends State<CardTextDetailEvaluateWidget> {
  late bool like;
  late int? maxLines;

  @override
  void initState() {
    super.initState();
    like = false;
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
                        onTap: () {
                          setState(() {
                            like = !like;
                            // if (evaluation != EvaluationEnum.like) {
                            //   evaluation = EvaluationEnum.like;
                            // context.read<InformationWatcherBloc>().add(
                            //       InformationWatcherEvent.like(
                            //         widget.storyId,
                            //         true,
                            //       ),
                            //     );
                            // } else {
                            //   evaluation = EvaluationEnum.none;
                            // context.read<InformationWatcherBloc>().add(
                            //       InformationWatcherEvent.like(
                            //         widget.i,
                            //         false,
                            //       ),
                            //     );
                            // }
                          });
                          widget.onLikeChange?.call(like: like);
                        },
                        borderRadius: BorderRadius.circular(KSize.kRadius32),
                        child: Padding(
                          padding: const EdgeInsets.all(KPadding.kPaddingSize4),
                          child: like //== EvaluationEnum.like
                              ? KIcon.activeLike.copyWith(
                                  key: KWidgetkeys.widget.cardTextDetailEvaluate
                                      .iconActiveLike,
                                )
                              : KIcon.like.copyWith(
                                  key: KWidgetkeys
                                      .widget.cardTextDetailEvaluate.iconLike,
                                ),
                        ),
                      ),
                      KSizedBox.kWidthSizedBox8,
                      // InkWell(
                      //   onTap: () => setState(() {
                      //     if (like != EvaluationEnum.smile) {
                      //       like = EvaluationEnum.smile;
                      //     } else {
                      //       like = EvaluationEnum.none;
                      //     }
                      //   }),
                      //   borderRadius: BorderRadius.circular(KSize.kRadius32),
                      //   child:
                      Padding(
                        padding: const EdgeInsets.all(KPadding.kPaddingSize4),
                        child: like //== EvaluationEnum.smile
                            ? KIcon.activeSmile.copyWith(
                                key: KWidgetkeys.widget.cardTextDetailEvaluate
                                    .iconActiveSmile,
                                // changeColor: AppColors.grey,
                              )
                            : KIcon.smile.copyWith(
                                key: KWidgetkeys
                                    .widget.cardTextDetailEvaluate.iconSmile,
                              ),
                        // ),
                      ),
                      KSizedBox.kWidthSizedBox8,
                      // InkWell(
                      //   onTap: () => setState(() {
                      //     if (like != EvaluationEnum.dislike) {
                      //       like = EvaluationEnum.dislike;
                      //     } else {
                      //       like = EvaluationEnum.none;
                      //     }
                      //   }),
                      //   borderRadius: BorderRadius.circular(KSize.kRadius32),
                      //   child:
                      Padding(
                        padding: const EdgeInsets.all(KPadding.kPaddingSize4),
                        child: like //== EvaluationEnum.dislike
                            ? KIcon.activeDislike.copyWith(
                                key: KWidgetkeys.widget.cardTextDetailEvaluate
                                    .iconActiveDislike,
                              )
                            : KIcon.dislike.copyWith(
                                key: KWidgetkeys
                                    .widget.cardTextDetailEvaluate.iconDislike,
                              ),
                        //),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      if (widget.titleIcon != null && widget.isDesk)
                        widget.titleIcon!,
                      KSizedBox.kWidthSizedBox16,
                      KIcon.share.copyWith(
                        key:
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
