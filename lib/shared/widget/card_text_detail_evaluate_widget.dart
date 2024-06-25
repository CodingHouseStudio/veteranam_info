import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';
import 'package:share_plus/share_plus.dart';

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
    this.directLink,
    this.link,
  });

  final String? directLink;
  final String? link;
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
      filters: widget.bottom,
      image: widget.image?.downloadURL,
      childWidget: Center(
        key: KWidgetkeys.widget.cardTextDetailEvaluate.widget,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: KMinMaxSize.maxWidth640,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (widget.bottom != null && widget.image == null) widget.bottom!,
              buildTitle(isDesk: widget.isDesk),
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
                  Column(
                    children: [
                      IconButtonWidget(
                        onPressed: () => setState(() {
                          if (evaluation != EvaluationEnum.like) {
                            evaluation = EvaluationEnum.like;
                          } else {
                            evaluation = EvaluationEnum.none;
                          }
                        }),
                        background: evaluation != EvaluationEnum.like
                            ? AppColors.materialThemeKeyColorsNeutral
                            : AppColors.materialThemeBlack,
                        padding: KPadding.kPaddingSize12,
                        icon: evaluation == EvaluationEnum.like
                            ? KIcon.activeLike.copyWith(
                                color: AppColors.materialThemeKeyColorsPrimary,
                                key: KWidgetkeys.widget.cardTextDetailEvaluate
                                    .iconActiveLike,
                              )
                            : KIcon.like.copyWith(
                                key: KWidgetkeys
                                    .widget.cardTextDetailEvaluate.iconLike,
                              ),
                      ),
                      KSizedBox.kHeightSizedBox3,
                      Text(
                        context.l10n.useful,
                        style: AppTextStyle.materialThemeLabelSmall,
                      ),
                    ],
                  ),
                  KSizedBox.kWidthSizedBox8,
                  Row(
                    children: [
                      Column(
                        children: [
                          IconButtonWidget(
                            onPressed: null,
                            background: AppColors.materialThemeKeyColorsNeutral,
                            padding: KPadding.kPaddingSize12,
                            icon: KIcon.website.copyWith(
                              key: KWidgetkeys
                                  .widget.cardTextDetailEvaluate.iconWebsite,
                            ),
                          ),
                          KSizedBox.kHeightSizedBox3,
                          Text(
                            context.l10n.website,
                            style: AppTextStyle.materialThemeLabelSmall,
                          ),
                        ],
                      ),
                      if (widget.isDesk)
                        KSizedBox.kWidthSizedBox24
                      else
                        KSizedBox.kWidthSizedBox8,
                      Column(
                        children: [
                          IconButtonWidget(
                            padding: KPadding.kPaddingSize12,
                            icon: KIcon.share,
                            background: AppColors.materialThemeKeyColorsNeutral,
                            key: KWidgetkeys
                                .widget.cardTextDetailEvaluate.iconShare,
                            onPressed: _informationShareLink,
                          ),
                          KSizedBox.kHeightSizedBox3,
                          Text(
                            context.l10n.share,
                            style: AppTextStyle.materialThemeLabelSmall,
                          ),
                        ],
                      ),
                      if (widget.isDesk)
                        KSizedBox.kWidthSizedBox24
                      else
                        KSizedBox.kWidthSizedBox8,
                      Column(
                        children: [
                          IconButtonWidget(
                            padding: KPadding.kPaddingSize12,
                            icon: KIcon.safe.copyWith(
                              key: KWidgetkeys
                                  .widget.cardTextDetailEvaluate.iconSave,
                            ),
                            background: AppColors.materialThemeKeyColorsNeutral,
                            onPressed: null,
                          ),
                          KSizedBox.kHeightSizedBox3,
                          Text(
                            context.l10n.save,
                            style: AppTextStyle.materialThemeLabelSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              if (widget.isDesk)
                KSizedBox.kHeightSizedBox32
              else
                KSizedBox.kHeightSizedBox16,
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

  Future<void> _informationShareLink() async {
    await Share.share(
      widget.directLink ?? widget.link!,
    );
  }
}
