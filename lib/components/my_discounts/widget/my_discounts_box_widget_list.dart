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
      if (isDesk) {
        return Padding(
          padding: index != 0
              ? const EdgeInsets.only(
                  top: KPadding.kPaddingSize24,
                )
              : EdgeInsets.zero,
          child: IntrinsicHeight(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          DiscountsCardWidget(
                            key: KWidgetkeys.screen.myDiscounts.card,
                            discountItem: discounts.elementAt(index),
                            isDesk: isDesk,
                          ),
                          StatisticBoxWidget(
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
                        const Row(
                          children: [
                            IconWidget(
                              padding: KPadding.kPaddingSize12,
                              icon: KIcon.trash,
                              background: AppColors
                                  .materialThemeKeyColorsNeutralVariant,
                            ),
                            KSizedBox.kWidthSizedBox8,
                            IconWidget(
                              padding: KPadding.kPaddingSize12,
                              icon: KIcon.edit,
                              background: AppColors
                                  .materialThemeKeyColorsNeutralVariant,
                            ),
                            KSizedBox.kWidthSizedBox8,
                            IconWidget(
                              padding: KPadding.kPaddingSize12,
                              icon: KIcon.share,
                              background: AppColors
                                  .materialThemeKeyColorsNeutralVariant,
                            ),
                          ],
                        ),
                        KSizedBox.kHeightSizedBox16,
                        TextButton.icon(
                          onPressed: null,
                          style: KButtonStyles.borderButtonStyle,
                          icon: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: KPadding.kPaddingSize12,
                            ).copyWith(
                              left: KPadding.kPaddingSize22,
                            ),
                            child: KIcon.close,
                          ),
                          label: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: KPadding.kPaddingSize16,
                              ),
                              child: Text(
                                key: KWidgetkeys.screen.employeeRespond.upload,
                                context.l10n.deactivate,
                                style: AppTextStyle.text24,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      } else {
        return Padding(
          padding: index != 0
              ? const EdgeInsets.only(
                  top: KPadding.kPaddingSize32,
                )
              : EdgeInsets.zero,
          child: Stack(
            key: KWidgetkeys.screen.home.box,
            alignment: Alignment.bottomRight,
            children: [
              Column(
                children: [
                  DiscountsCardWidget(
                    key: KWidgetkeys.screen.myDiscounts.card,
                    discountItem: discounts.elementAt(index),
                    isDesk: isDesk,
                  ),
                  KSizedBox.kHeightSizedBox16,
                  StatisticBoxWidget(
                    title: context.l10n.statistics,
                    subtitle: context.l10n.saved,
                    isDesk: isDesk,
                    onTap: null,
                  ),
                  KSizedBox.kHeightSizedBox16,
                  Row(
                    children: [
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
                              key: KWidgetkeys.screen.employeeRespond.upload,
                              context.l10n.deactivate,
                              style: AppTextStyle.text16,
                            ),
                          ),
                        ),
                      ),
                      KSizedBox.kWidthSizedBox40,
                      const IconWidget(
                        padding: KPadding.kPaddingSize12,
                        icon: KIcon.trash,
                        background:
                            AppColors.materialThemeKeyColorsNeutralVariant,
                      ),
                      KSizedBox.kWidthSizedBox10,
                      const IconWidget(
                        padding: KPadding.kPaddingSize12,
                        icon: KIcon.share,
                        background:
                            AppColors.materialThemeKeyColorsNeutralVariant,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      }
    });
  } else {
    return [Container()]; // Return an empty container if not in success state
  }
}
