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

  return List.generate(
      context.read<MyDiscountsWatcherBloc>().state.failure == null
          ? discountsWidgetList.length
          : 0, (index) {
    return Padding(
      padding: index != 0
          ? const EdgeInsets.only(
              top: KPadding.kPaddingSize24,
            )
          : EdgeInsets.zero,
      child: SkeletonizerWidget(
        isLoading: isLoading,
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
                        key: KWidgetkeys.screen.myDiscounts.iconTrash,
                        onPressed: () {
                          context.read<MyDiscountsWatcherBloc>().add(
                                MyDiscountsWatcherEvent.deleteDiscount(
                                  discountsWidgetList.elementAt(index).id,
                                ),
                              );
                        },
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
