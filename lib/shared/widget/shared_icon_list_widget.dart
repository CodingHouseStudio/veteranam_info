import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:veteranam/shared/shared.dart';

class SharedIconListWidget extends StatelessWidget {
  const SharedIconListWidget({
    required this.text,
    required this.isDesk,
    required this.link,
    required this.cardEnum,
    required this.afterEvent,
    required this.cardId,
    super.key,
  });
  final String text;
  final bool isDesk;
  final String link;
  final CardEnum cardEnum;
  final void Function()? afterEvent;
  final String cardId;
  @override
  Widget build(BuildContext context) {
    return CardTextDetailWidget(
      text: text,
      maxLines: 3,
      icon: [
        _cardIconWidget(
          label: context.l10n.webSite,
          context,
          onPressed: null,
          icon: KIcon.captivePortal,
        ),
        if (isDesk) KSizedBox.kWidthSizedBox24,
        _cardIconWidget(
          label: context.l10n.share,
          context,
          onPressed: () async => Share.share(
            link,
          ),
          icon: KIcon.share,
        ),
        if (isDesk) KSizedBox.kWidthSizedBox24 else KSizedBox.kWidthSizedBox8,
        ComplaintWidget(
          isDesk: isDesk,
          cardEnum: cardEnum,
          afterEvent: afterEvent,
          cardId: cardId,
        ),
      ],
      isDesk: isDesk,
    );
  }
}

Widget _cardIconWidget(
  BuildContext context, {
  required VoidCallback? onPressed,
  required Icon icon,
  required String label,
}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(KPadding.kPaddingSize12),
        child: IconButton(
          key: KWidgetkeys.widget.discountCard.buttons,
          style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              AppColors.materialThemeWhite,
            ),
          ),
          onPressed: onPressed,
          icon: icon,
        ),
      ),
      Text(
        key: KWidgetkeys.widget.discountCard.description,
        label,
        style: AppTextStyle.materialThemeLabelSmall.copyWith(
          color: AppColors.materialThemeBlack,
        ),
      ),
    ],
  );
}
