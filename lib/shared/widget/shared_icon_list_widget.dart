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
    required this.webSiteKey,
    super.key,
    this.link,
    this.useSiteUrl,
    this.showComplaint = true,
    this.showShare = true,
    this.iconBackground = AppColors.materialThemeWhite,
    this.numberLikes,
    this.likeKey,
    this.isSeparatePage = false,
    this.iconBorder,
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
  final Color iconBackground;
  final bool? useSiteUrl;
  final int? numberLikes;
  final bool isSeparatePage;
  final BoxBorder? iconBorder;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: (isDesk ? KPadding.kPaddingSize16 : KPadding.kPaddingSize8) +
          (isSeparatePage ? KPadding.kPaddingSize8 : 0),
      runSpacing: KPadding.kPaddingSize16,
      children: [
        // _CardLikeIconWidget(
        //   label: context.l10n.favorite,
        //   icon: KIcon.favorite,
        //   countLike: numberLikes ?? 0,
        //   background: isSeparatePage
        //       ? AppColors.materialThemeKeyColorsNeutral
        //       : iconBackground,
        //   key: likeKey,
        // ),
        // if (link != null && link!.isUrlValid) ...[
        //   _CardIconWidget(
        //     label: context.l10n.webSite,
        //     onPressed: () => context..read<UrlCubit>()
        //.launchUrl(url: link),
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
            background: iconBackground,
            key: shareKey,
            border: iconBorder ??
                (isSeparatePage
                    ? Border.all(
                        color: AppColors.materialThemeKeyColorsNeutral,
                      )
                    : null),
          ),
        if (isSeparatePage) ...[
          if (link != null && link!.isUrlValid)
            _CardIconWidget(
              key: webSiteKey,
              background: iconBackground,
              icon: KIcon.captivePortal,
              onPressed: () =>
                  context.openLinkWithAgreeDialog(isDesk: isDesk, link: link!),
              label: context.l10n.webSite,
              border: iconBorder ??
                  (isSeparatePage
                      ? Border.all(
                          color: AppColors.materialThemeKeyColorsNeutral,
                        )
                      : null),
            ),
          complaintButton(context),
        ] else if (link != null && link!.isUrlValid)
          PopupMenuButtonWidget<int>(
            buttonText: context.l10n.login,
            shape: const OutlineInputBorder(
              borderSide:
                  BorderSide(color: AppColors.materialThemeKeyColorsNeutral),
              borderRadius: KBorderRadius.kBorderRadius16,
            ),
            buttonChild: Column(
              children: [
                const IconWidget(
                  decoration: KWidgetTheme.boxDecorationPopupMenuBorder,
                  icon: KIcon.moreVert,
                  padding: KPadding.kPaddingSize12,
                ),
                KSizedBox.kHeightSizedBox6,
                Text(
                  context.l10n.more,
                  style: AppTextStyle.materialThemeLabelSmallBlack,
                ),
              ],
            ),
            showIndicatorIcon: false,
            buttonStyle: KButtonStyles.noBackgroundOnHoverButtonStyle,
            menuItemsPadding: const EdgeInsets.only(
              top: KPadding.kPaddingSize16,
              bottom: KPadding.kPaddingSize16,
              left: KPadding.kPaddingSize8,
              right: KPadding.kPaddingSize8,
            ),
            items: [
              DropDownItem(
                key: webSiteKey,
                value: 1,
                text: context.l10n.webSite,
                icon: IconWidget(
                  background: iconBackground,
                  icon: KIcon.captivePortal,
                  padding: KPadding.kPaddingSize12,
                ),
                event: () => context.openLinkWithAgreeDialog(
                  isDesk: isDesk,
                  link: link!,
                ),
                // padding: const EdgeInsets.only(
                //   top: KPadding.kPaddingSize16,
                //   bottom: KPadding.kPaddingSize8,
                //   left: KPadding.kPaddingSize16,
                //   right: KPadding.kPaddingSize16,
                // ),
              ),
              DropDownItem(
                key: complaintKey,
                value: 2,
                text: context.l10n.complaint,
                icon: IconWidget(
                  background: iconBackground,
                  icon: KIcon.brightnessAlert,
                  padding: KPadding.kPaddingSize12,
                ),
                event: () => context.dialog.showReportDialog(
                  isDesk: isDesk,
                  cardEnum: cardEnum,
                  cardId: cardId,
                ),
                // padding: const EdgeInsets.only(
                //   bottom: KPadding.kPaddingSize16,
                //   left: KPadding.kPaddingSize16,
                //   right: KPadding.kPaddingSize16,
                // ),
              ),
            ],
            position: PopupMenuButtonPosition.bottomLeft,
          )
        else
          complaintButton(context),
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

  Widget complaintButton(BuildContext context) {
    return _CardIconWidget(
      key: complaintKey,
      background: iconBackground,
      icon: KIcon.brightnessAlert,
      onPressed: () => context.dialog.showReportDialog(
        isDesk: isDesk,
        cardEnum: cardEnum,
        cardId: cardId,
      ),
      label: context.l10n.complaint,
      border: iconBorder ??
          (isSeparatePage
              ? Border.all(
                  color: AppColors.materialThemeKeyColorsNeutral,
                )
              : null),
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
    this.border,
    // ignore: unused_element
    this.iconWidget,
  });
  final VoidCallback? onPressed;
  final Icon icon;
  final String label;
  final Color background;
  final BoxBorder? border;
  final Widget? iconWidget;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      child: Column(
        children: [
          iconWidget ??
              IconWidget(
                background: background,
                icon: icon,
                padding: KPadding.kPaddingSize12,
                border: border,
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

// class _CardLikeIconWidget extends StatelessWidget {
//   const _CardLikeIconWidget({
//     required this.icon,
//     required this.label,
//     required this.background,
//     required this.countLike,
//   });
//   // final VoidCallback? onPressed;
//   final Icon icon;
//   final String label;
//   final Color background;
//   final int countLike;

//   @override
//   Widget build(BuildContext context) {
//     return _CardIconWidget(
//       background: background,
//       icon: icon,
//       label: label,
//       iconWidget: countLike > 0
//           ? Stack(
//               children: [
//                 IconWidget(
//                   background: background,
//                   icon: icon,
//                   padding: KPadding.kPaddingSize12,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left:
// KPadding.kPaddingSize36),
//                   child: DecoratedBox(
//                     decoration: KWidgetTheme.boxDecorationDiscount,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: KPadding.kPaddingSize8,
//                         vertical: KPadding.kPaddingSize4,
//                       ),
//                       child: Text(
//                         countLike.toString(),
//                         style: AppTextStyle.materialThemeLabelSmall,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           : null,
//       // child: Column(
//       //   children: [
//       //     if (countLike > 0)
//       //       Stack(
//       //         children: [
//       //           IconWidget(
//       //             background: background,
//       //             icon: icon,
//       //             padding: KPadding.kPaddingSize12,
//       //           ),
//       //           Padding(
//       //             padding: const EdgeInsets.only(left: KPadding.
//       // kPaddingSize36),
//       //             child: DecoratedBox(
//       //               decoration: KWidgetTheme.boxDecorationDiscount,
//       //               child: Padding(
//       //                 padding: const EdgeInsets.symmetric(
//       //                   horizontal: KPadding.kPaddingSize8,
//       //                   vertical: KPadding.kPaddingSize4,
//       //                 ),
//       //                 child: Text(
//       //                   countLike.toString(),
//       //                   style: AppTextStyle.materialThemeLabelSmall,
//       //                 ),
//       //               ),
//       //             ),
//       //           ),
//       //         ],
//       //       )
//       //     else
//       //       IconWidget(
//       //         background: background,
//       //         icon: icon,
//       //         padding: KPadding.kPaddingSize12,
//       //       ),
//       //     KSizedBox.kHeightSizedBox6,
//       //     Text(
//       //       label,
//       //       style: AppTextStyle.materialThemeLabelSmallBlack,
//       //     ),
//       //   ],
//       // ),
//     );
//   }
// }
