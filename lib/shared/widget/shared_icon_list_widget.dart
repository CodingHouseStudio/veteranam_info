import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/shared/shared.dart';

abstract class SharedIconListWidget {
  static List<Widget> get({
    required BuildContext context,
    required bool isDesk,
    required String? link,
    required CardEnum cardEnum,
    // required void Function()? afterEvent,
    required String cardId,
    required Key? webSiteKey,
    required Key shareKey,
    required Key complaintKey,
    required String? share,
    bool showComplaint = true,
    bool showShare = true,
    Color background = AppColors.materialThemeWhite,
    bool? useSiteUrl,
  }) {
    return [
      if (link != null) ...[
        _cardIconWidget(
          label: context.l10n.webSite,
          context,
          onPressed: () => context..read<UrlCubit>().launchUrl(url: link),
          icon: KIcon.captivePortal,
          background: background,
          key: webSiteKey,
        ),
        if (isDesk) KSizedBox.kWidthSizedBox12 else KSizedBox.kWidthSizedBox4,
      ],
      if (showShare)
        _cardIconWidget(
          label: context.l10n.share,
          context,
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
    ];
  }

  static Widget _cardIconWidget(
    BuildContext context, {
    required VoidCallback? onPressed,
    required Icon icon,
    required String label,
    required Color background,
    required Key? key,
  }) {
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
            style: AppTextStyle.materialThemeLabelSmall.copyWith(
              color: AppColors.materialThemeBlack,
            ),
          ),
        ],
      ),
    );
  }
}
