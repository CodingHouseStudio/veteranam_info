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
    super.key,
    this.link,
    this.webSiteKey,
    this.share,
    this.useSiteUrl,
    this.showComplaint = true,
    this.showShare = true,
    this.background = AppColors.materialThemeWhite,
  });
  final bool isDesk;
  final String? link;
  final CardEnum cardEnum;
  final String cardId;
  final Key? webSiteKey;
  final Key shareKey;
  final Key complaintKey;
  final String? share;
  final bool showComplaint;
  final bool showShare;
  final Color background;
  final bool? useSiteUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (link != null && link!.isUrlValid) ...[
          _CardIconWidget(
            label: context.l10n.webSite,
            onPressed: () => context..read<UrlCubit>().launchUrl(url: link),
            icon: KIcon.captivePortal,
            background: background,
            key: webSiteKey,
          ),
          if (isDesk) KSizedBox.kWidthSizedBox12 else KSizedBox.kWidthSizedBox4,
        ],
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
        if (showComplaint) ...[
          if (isDesk) KSizedBox.kWidthSizedBox12 else KSizedBox.kWidthSizedBox8,
          ComplaintWidget(
            key: complaintKey,
            isDesk: isDesk,
            cardEnum: cardEnum,
            // afterEvent: afterEvent,
            cardId: cardId,
            background: background,
          ),
        ],
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
