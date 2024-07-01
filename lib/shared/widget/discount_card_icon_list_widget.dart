import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class DiscountCardIconListWidget extends StatelessWidget {
  const DiscountCardIconListWidget({
    required this.text,
    required this.isDesk,
    super.key,
    this.onPressed,
  });
  final String text;
  final bool isDesk;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return CardTextDetailWidget(
      text: text,
      maxLines: 1,
      icon: [
        _cardIconWidget(
          label: context.l10n.webSite,
          context,
          onPressed: null,
          icon: KIcon.captivePortal,
        ),
        if (isDesk) KSizedBox.kWidthSizedBox24 else KSizedBox.kWidthSizedBox8,
        _cardIconWidget(
          label: context.l10n.share,
          context,
          onPressed: onPressed,
          icon: KIcon.share,
        ),
        if (isDesk) KSizedBox.kWidthSizedBox24 else KSizedBox.kWidthSizedBox8,
        _cardIconWidget(
          label: context.l10n.report,
          context,
          onPressed: null,
          icon: KIcon.report.copyWith(
            color: AppColors.materialThemeRefErrorError60,
          ),
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
