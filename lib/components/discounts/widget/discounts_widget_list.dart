part of 'body/discounts_body_widget.dart';

List<Widget> discountsWidgetList({
  required BuildContext context,
  required bool isDesk,
}) {
  final isLoading = context.read<DiscountWatcherBloc>().state.loadingStatus !=
      LoadingStatus.loaded;
  final discountsWidgetList = [
    if (context.read<DiscountWatcherBloc>().state.failure == null) ...[
      ...context.read<DiscountWatcherBloc>().state.filteredDiscountModelItems,
      if (isLoading)
        ...List.generate(
          KDimensions.shimmerDiscountsItems,
          (index) => KMockText.discountModel.copyWith(
            id: index.toString(),
            userId: index.toString(),
          ),
        ),
    ],
  ];
  return List.generate(discountsWidgetList.length, (index) {
    return Padding(
      padding: EdgeInsets.only(
        top: index != 0 ? KPadding.kPaddingSize40 : 0,
      ),
      child: SkeletonizerWidget(
        isLoading: discountsWidgetList.length - index <=
                KDimensions.shimmerDiscountsItems &&
            isLoading,
        child: DiscountsCardWidget(
          key: index != discountsWidgetList.length - 1
              ? KWidgetkeys.screen.discounts.card
              : KWidgetkeys.screen.discounts.cardLast,
          discountItem: discountsWidgetList.elementAt(index),
          isDesk: isDesk,
        ),
      ),
    );
  });
}
