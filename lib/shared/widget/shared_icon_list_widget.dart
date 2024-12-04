import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class SharedIconListWidget extends StatelessWidget {
  const SharedIconListWidget({
    required this.isDesk,
    required this.cardEnum,
    required this.cardId,
    required this.shareKey,
    required this.complaintKey,
    required this.share,
    super.key,
    this.link,
    this.webSiteKey,
    this.useSiteUrl,
    this.showComplaint = true,
    this.showShare = true,
    this.background = AppColors.materialThemeWhite,
    this.discountItem,
    this.likeKey,
  });
  final bool isDesk;
  final String? link;
  final CardEnum cardEnum;
  final String cardId;
  final Key? webSiteKey;
  final Key shareKey;
  final Key? likeKey;
  final Key complaintKey;
  final String? share;
  final bool showComplaint;
  final bool showShare;
  final Color background;
  final bool? useSiteUrl;
  final DiscountModel? discountItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CardLikeIconWidget(
          label: context.l10n.favorite,
          icon: KIcon.favorite,
          countLike: discountItem?.likes ?? 0,
          background: background,
          key: likeKey,
        ),
        if (isDesk) KSizedBox.kWidthSizedBox16 else KSizedBox.kWidthSizedBox8,
        // if (link != null && link!.isUrlValid) ...[
        //   _CardIconWidget(
        //     label: context.l10n.webSite,
        //     onPressed: () => context..read<UrlCubit>().launchUrl(url: link),
        //     icon: KIcon.captivePortal,
        //     background: background,
        //     key: webSiteKey,
        //   ),
        //   if (isDesk) KSizedBox.kWidthSizedBox12
        //else KSizedBox.kWidthSizedBox4,
        // ],
        if (showShare)
          _CardIconWidget(
            label: context.l10n.share,
            onPressed: share != null
                ? () => context.read<UrlCubit>().share(
                      share,
                      useSiteUrl: useSiteUrl,
                    )
                : null,
            icon: KIcon.share,
            background: background,
            key: shareKey,
          ),
        if (isDesk) KSizedBox.kWidthSizedBox16 else KSizedBox.kWidthSizedBox8,
        Column(
          children: [
            DropDownButton(
              isDesk: isDesk,
              style: KButtonStyles.borderWhiteButtonStyle,
              discountButtons: true,
              items: [
                if (link != null && link!.isUrlValid)
                  DropDownItem(
                    text: context.l10n.webSite,
                    icon: IconWidget(
                      background: background,
                      icon: KIcon.captivePortal,
                      padding: KPadding.kPaddingSize12,
                    ),
                    action: () =>
                        context..read<UrlCubit>().launchUrl(url: link),
                    key: webSiteKey!,
                  ),
                DropDownItem(
                  text: context.l10n.complaint,
                  icon: IconWidget(
                    background: background,
                    icon: KIcon.brightnessAlert,
                    padding: KPadding.kPaddingSize12,
                  ),
                  action: () => context.dialog.showReportDialog(
                    isDesk: isDesk,
                    cardEnum: cardEnum,
                    // afterEvent: afterEvent,
                    cardId: cardId,
                  ),
                  key: complaintKey,
                ),
              ],
              offset: KDimensions.discountOffset,
            ),
            KSizedBox.kHeightSizedBox6,
            Text(
              context.l10n.more,
              style: AppTextStyle.materialThemeLabelSmallBlack,
            ),
          ],
        ),
        // if (widget.showComplaint) ...[
        //   if (widget.isDesk)
        //     KSizedBox.kWidthSizedBox16
        //   else
        //     KSizedBox.kWidthSizedBox8,
        //   ComplaintWidget(
        //     key: widget.complaintKey,
        //     isDesk: widget.isDesk,
        //     cardEnum: widget.cardEnum,
        //     // afterEvent: afterEvent,
        //     cardId: widget.cardId,
        //     background: widget.background,
        //   ),
        //],
      ],
    );
  }
}

class _CardIconWidget extends StatelessWidget {
  const _CardIconWidget({
    required this.icon,
    required this.label,
    required this.background,
    super.key,
    this.onPressed,
  });
  final VoidCallback? onPressed;
  final Icon icon;
  final String label;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: key,
      onTap: onPressed,
      child: Column(
        children: [
          IconWidget(
            background: background,
            icon: icon,
            padding: KPadding.kPaddingSize12,
          ),
          KSizedBox.kHeightSizedBox6,
          Text(
            label,
            style: AppTextStyle.materialThemeLabelSmallBlack,
          ),
        ],
      ),
    );
  }
}

class _CardLikeIconWidget extends StatelessWidget {
  const _CardLikeIconWidget({
    required this.icon,
    required this.label,
    required this.background,
    required this.countLike,
    // this.onPressed,
    super.key,
  });
  // final VoidCallback? onPressed;
  final Icon icon;
  final String label;
  final Color background;
  final int countLike;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: key,
      // onTap: onPressed,
      child: Column(
        children: [
          Stack(
            children: [
              IconWidget(
                background: background,
                icon: icon,
                padding: KPadding.kPaddingSize12,
              ),
              Padding(
                padding: const EdgeInsets.only(left: KPadding.kPaddingSize36),
                child: DecoratedBox(
                  decoration: KWidgetTheme.boxDecorationDiscount,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: KPadding.kPaddingSize8,
                      vertical: KPadding.kPaddingSize4,
                    ),
                    child: Text(
                      countLike.toString(),
                      style: AppTextStyle.materialThemeLabelSmall,
                    ),
                  ),
                ),
              ),
            ],
          ),
          KSizedBox.kHeightSizedBox6,
          Text(
            label,
            style: AppTextStyle.materialThemeLabelSmallBlack,
          ),
        ],
      ),
    );
  }
}
