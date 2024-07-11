import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

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
    this.onLikeChange,
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
      filters: widget.bottom,
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
              if (widget.bottom != null && widget.image == null)
                Padding(
                  padding: widget.isDesk
                      ? const EdgeInsets.only(
                          left: KPadding.kPaddingSize32,
                          right: KPadding.kPaddingSize16,
                        )
                      : const EdgeInsets.only(
                          left: KPadding.kPaddingSize16,
                          right: KPadding.kPaddingSize16,
                        ),
                  child: widget.bottom,
                ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.isDesk
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
              if (widget.isDesk)
                KSizedBox.kHeightSizedBox24
              else
                KSizedBox.kHeightSizedBox16,
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.isDesk
                      ? KPadding.kPaddingSize32
                      : KPadding.kPaddingSize16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Column(
                          children: [
                            IconButtonWidget(
                              onPressed: () {
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
                              background: !like
                                  ? AppColors.materialThemeKeyColorsNeutral
                                  : AppColors.materialThemeBlack,
                              padding: KPadding.kPaddingSize12,
                              icon: like //evaluation == EvaluationEnum.like
                                  ? KIcon.activeLike.copyWith(
                                      key: KWidgetkeys
                                          .widget
                                          .cardTextDetailEvaluate
                                          .iconActiveLike,
                                    )
                                  : KIcon.like.copyWith(
                                      key: KWidgetkeys.widget
                                          .cardTextDetailEvaluate.iconLike,
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
                      ],
                    ),
                    Row(
                      children: [
                        buildIcon(
                          icon: KIcon.website.copyWith(
                            key: KWidgetkeys
                                .widget.cardTextDetailEvaluate.iconWebsite,
                          ),
                          text: context.l10n.webSite,
                          onPressed: null,
                        ),
                        if (widget.isDesk)
                          KSizedBox.kWidthSizedBox24
                        else
                          KSizedBox.kWidthSizedBox8,
                        buildIcon(
                          icon: KIcon.brightnessAlert.copyWith(
                            key: KWidgetkeys
                                .widget.cardTextDetailEvaluate.iconComplaint,
                          ),
                          text: context.l10n.complaint,
                          onPressed: null,
                        ),
                        if (widget.isDesk)
                          KSizedBox.kWidthSizedBox24
                        else
                          KSizedBox.kWidthSizedBox8,
                        buildIcon(
                          icon: KIcon.more.copyWith(
                            key: KWidgetkeys
                                .widget.cardTextDetailEvaluate.iconSave,
                          ),
                          text: context.l10n.more,
                          onPressed: null,
                        ),
                        if (widget.isDesk)
                          KSizedBox.kWidthSizedBox24
                        else
                          KSizedBox.kWidthSizedBox8,
                      ],
                    ),
                  ],
                ),
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
          if (widget.isDesk)
            KSizedBox.kHeightSizedBox8
          else
            KSizedBox.kHeightSizedBox4,
          widget.titleDate!,
        ],
      );
    } else {
      return widget.titleWidget;
    }
  }

  Widget buildIcon({
    required Icon icon,
    required String text,
    required VoidCallback? onPressed,
  }) {
    return Column(
      children: [
        IconButtonWidget(
          onPressed: onPressed,
          background: AppColors.materialThemeKeyColorsNeutral,
          icon: icon,
          padding: KPadding.kPaddingSize12,
        ),
        KSizedBox.kHeightSizedBox3,
        Text(
          text,
          style: AppTextStyle.materialThemeLabelSmall,
        ),
      ],
    );
  }
}
