part of 'body/discounts_body_widget.dart';

List<Widget> discountsWidgetList({
  required BuildContext context,
  required bool isDesk,
}) {
  final discountsWidgetList =
      context.read<DiscountWatcherBloc>().state.discountModelItems.isNotEmpty
          ? context.read<DiscountWatcherBloc>().state.filteredDiscountModelItems
          : List.generate(
              KDimensions.shimmerDiscountsItems,
              (index) => DiscountModel(
                id: index.toString(),
                userId: index.toString(),
                service: KMockText.serviceDiscount,
                percent: KMockText.discount,
                city: KMockText.cityDiscount,
                comment: KMockText.preInstructionDiscount,
                date: ExtendedDateTime.current,
                instruction: KMockText.instructionDiscount,
                tags: KMockText.tag,
              ),
            );
  return List.generate(discountsWidgetList.length, (index) {
    return Padding(
      padding: EdgeInsets.only(
        top: index != 0 ? KPadding.kPaddingSize40 : 0,
      ),
      child: Skeletonizer(
        enabled: context.read<DiscountWatcherBloc>().state.loadingStatus !=
            LoadingStatus.loaded,
        child: DiscountsCardWidget(
          key: KWidgetkeys.screen.discounts.card,
          discountItem: discountsWidgetList.elementAt(index),
          isDesk: isDesk,
        ),
      ),
    );
  });
}
