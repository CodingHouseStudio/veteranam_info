part of 'body/my_discounts_body_widget.dart';

List<Widget> _discountsboxWidgetList({
  required BuildContext context,
  required bool isDesk,
}) {
  final bloc = context.read<MyDiscountsWatcherBloc>();
  final state = bloc.state;

  if (state is MyDiscountsWatcherStateSuccess) {
    final discounts = state.discountsModelItems;

    return List.generate(discounts.length, (index) {
      final discount = discounts[index];

      return Padding(
        padding: index != 0
            ? const EdgeInsets.only(
                top: KPadding.kPaddingSize24,
              )
            : EdgeInsets.zero,
        child: isDesk
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        DiscountsCardWidget(
                          key: KWidgetkeys.screen.myDiscounts.card,
                          discountItem: discount,
                          isDesk: isDesk,
                        ),
                        StatisticBoxWidget(
                          key: KWidgetkeys.screen.myDiscounts.box,
                          title: context.l10n.statistics,
                          subtitle: context.l10n.saved,
                          isDesk: isDesk,
                          onTap: null,
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
                              bloc.add(
                                MyDiscountsWatcherEvent.deleteDiscount(
                                  discount.id,
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
                    ],
                  ),
                ],
              )
            : Column(
                children: [
                  DiscountsCardWidget(
                    key: KWidgetkeys.screen.myDiscounts.card,
                    discountItem: discount,
                    isDesk: isDesk,
                  ),
                  KSizedBox.kHeightSizedBox16,
                  StatisticBoxWidget(
                    key: KWidgetkeys.screen.myDiscounts.box,
                    title: context.l10n.statistics,
                    subtitle: context.l10n.saved,
                    isDesk: isDesk,
                    onTap: null,
                  ),
                  KSizedBox.kHeightSizedBox16,
                  Row(
                    children: [
                      //приватний метод
                      TextButton.icon(
                        onPressed: null,
                        style: KButtonStyles.borderButtonStyle,
                        icon: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: KPadding.kPaddingSize12,
                          ).copyWith(
                            left: KPadding.kPaddingSize16,
                          ),
                          child: KIcon.close,
                        ),
                        label: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: KPadding.kPaddingSize24,
                            ),
                            child: Text(
                              key: KWidgetkeys.screen.myDiscounts.diactivate,
                              context.l10n.deactivate,
                              style: AppTextStyle.text16,
                            ),
                          ),
                        ),
                      ),
                      KSizedBox.kWidthSizedBox40,
                      GestureDetector(
                        onTap: () {
                          bloc.add(
                            MyDiscountsWatcherEvent.deleteDiscount(
                              discount.id,
                            ),
                          );
                        },
                        child: IconWidget(
                          key: KWidgetkeys.screen.myDiscounts.iconTrash,
                          padding: KPadding.kPaddingSize12,
                          icon: KIcon.trash,
                          background:
                              AppColors.materialThemeKeyColorsNeutralVariant,
                        ),
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
      );
    });
  } else {
    return [Container()]; // Return an empty container if not in success state
  }
}
