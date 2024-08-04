part of 'body/my_discounts_body_widget.dart';

List<Widget> _buildDiactivateButtons(BuildContext context, bool isDesk) {
  if (isDesk) {
    return [
      TextButton.icon(
        onPressed: null,
        style: KButtonStyles.borderButtonStyle.copyWith(
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(
              vertical: KPadding.kPaddingSize12,
              horizontal: KPadding.kPaddingSize16,
            ),
          ),
          alignment: Alignment.centerLeft,
        ),
        icon: KIcon.close,
        label: Text(
          key: KWidgetkeys.screen.myDiscounts.diactivate,
          context.l10n.deactivate,
          style: AppTextStyle.text24,
        ),
      ),
    ];
  } else {
    return [
      TextButton.icon(
        onPressed: null,
        style: KButtonStyles.borderButtonStyle.copyWith(
          padding: const WidgetStatePropertyAll(
            EdgeInsets.only(
              top: KPadding.kPaddingSize12,
              bottom: KPadding.kPaddingSize12,
              right: KPadding.kPaddingSize24,
              left: KPadding.kPaddingSize16,
            ),
          ),
          alignment: Alignment.centerLeft,
        ),
        icon: KIcon.close,
        label: Text(
          key: KWidgetkeys.screen.myDiscounts.diactivate,
          context.l10n.deactivate,
          style: AppTextStyle.text16,
        ),
      ),
    ];
  }
}

List<Widget> _boxesWidget(
  BuildContext context,
  bool isDesk,
  List<DiscountModel> discountsWidgetList,
  int index,
) {
  return [
    DiscountCardWidget(
      key: KWidgetkeys.screen.myDiscounts.card,
      discountItem: discountsWidgetList.elementAt(index),
      isDesk: isDesk,
      // reportEvent: null,
      share: null,
      isLoading: true,
    ),
    if (!isDesk) KSizedBox.kHeightSizedBox16,
    StatisticBoxWidget(
      key: KWidgetkeys.screen.myDiscounts.box,
      title: context.l10n.statistics,
      subtitle: context.l10n.saved,
      isDesk: isDesk,
      onTap: null,
    ),
  ];
}
