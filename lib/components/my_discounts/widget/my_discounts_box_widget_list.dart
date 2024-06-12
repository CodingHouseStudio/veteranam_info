part of 'body/my_discounts_body_widget.dart';

List<Widget> _discountsboxWidgetList({
  required BuildContext context,
  required bool isDesk,
}) {
  final isLoading =
      context.read<MyDiscountsWatcherBloc>().state.loadingStatus !=
          LoadingStatus.loaded;
  final discountsWidgetList = isLoading
      ? List.generate(
          KDimensions.shimmerDiscountsItems,
          (index) => KMockText.discountModel.copyWith(
            id: index.toString(),
            userId: index.toString(),
          ),
        )
      : context.read<MyDiscountsWatcherBloc>().state.discountsModelItems;

  return List.generate(discountsWidgetList.length, (index) {
    return Padding(
      padding: index != 0
          ? const EdgeInsets.only(
              top: KPadding.kPaddingSize24,
            )
          : EdgeInsets.zero,
      child: Skeletonizer(
        enabled: isLoading,
        child: isDesk
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        ..._boxesWidget(
                          context,
                          isDesk,
                          discountsWidgetList,
                          index,
                        ),
                      ],
                    ),
                  ),
                  KSizedBox.kWidthSizedBox24,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButtonWidget(
                            onPressed: () {
                              context.read<MyDiscountsWatcherBloc>().add(
                                    MyDiscountsWatcherEvent.deleteDiscount(
                                      discountsWidgetList.elementAt(index).id,
                                    ),
                                  );
                            },
                            key: KWidgetkeys.screen.myDiscounts.iconTrash,
                            padding: KPadding.kPaddingSize12,
                            icon: KIcon.trash,
                            background:
                                AppColors.materialThemeKeyColorsNeutralVariant,
                          ),
                          KSizedBox.kWidthSizedBox8,
                          IconWidget(
                            key: KWidgetkeys.screen.myDiscounts.iconEdit,
                            padding: KPadding.kPaddingSize12,
                            icon: KIcon.edit,
                            background:
                                AppColors.materialThemeKeyColorsNeutralVariant,
                          ),
                          KSizedBox.kWidthSizedBox8,
                          IconWidget(
                            key: KWidgetkeys.screen.myDiscounts.iconShare,
                            padding: KPadding.kPaddingSize12,
                            icon: KIcon.share,
                            background:
                                AppColors.materialThemeKeyColorsNeutralVariant,
                          ),
                        ],
                      ),
                      KSizedBox.kHeightSizedBox16,
                      ..._buildDiactivateButtons(context, isDesk),
                    ],
                  ),
                ],
              )
            : Column(
                children: [
                  ..._boxesWidget(
                    context,
                    isDesk,
                    discountsWidgetList,
                    index,
                  ),
                  KSizedBox.kHeightSizedBox16,
                  Row(
                    children: [
                      ..._buildDiactivateButtons(context, isDesk),
                      KSizedBox.kWidthSizedBox40,
                      IconButtonWidget(
                        onPressed: () {
                          context.read<MyDiscountsWatcherBloc>().add(
                                MyDiscountsWatcherEvent.deleteDiscount(
                                  discountsWidgetList.elementAt(index).id,
                                ),
                              );
                        },
                        key: KWidgetkeys.screen.myDiscounts.iconTrash,
                        padding: KPadding.kPaddingSize12,
                        icon: KIcon.trash,
                        background:
                            AppColors.materialThemeKeyColorsNeutralVariant,
                      ),
                      KSizedBox.kWidthSizedBox10,
                      IconWidget(
                        key: KWidgetkeys.screen.myDiscounts.iconShare,
                        padding: KPadding.kPaddingSize12,
                        icon: KIcon.share,
                        background:
                            AppColors.materialThemeKeyColorsNeutralVariant,
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  });
}

List<Widget> _buildDiactivateButtons(BuildContext context, bool isDesk) {
  if (isDesk) {
    return [
      TextButton.icon(
        onPressed: null,
        style: KButtonStyles.borderButtonStyle.copyWith(
          padding: const MaterialStatePropertyAll(
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
          padding: const MaterialStatePropertyAll(
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
    DiscountsCardWidget(
      key: KWidgetkeys.screen.myDiscounts.card,
      discountItem: discountsWidgetList.elementAt(index),
      isDesk: isDesk,
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
