part of 'body/discounts_body_widget.dart';

List<Widget> discountsWidgetList({
  required BuildContext context,
  required bool isDesk,
}) =>
    cardWidgetList<DiscountModel>(
      isLoading: context.read<DiscountWatcherBloc>().state.loadingStatus !=
          LoadingStatus.loaded,
      modelItems:
          context.read<DiscountWatcherBloc>().state.filteredDiscountModelItems,
      cardWidget: ({required modelItem, required key}) => DiscountsCardWidget(
        key: key,
        discountItem: modelItem,
        isDesk: isDesk,
      ),
      isDesk: isDesk,
      shimmerItemsNumber: KDimensions.shimmerDiscountsItems,
      cardKey: KWidgetkeys.screen.discounts.card,
      cardLastKey: KWidgetkeys.screen.discounts.cardLast,
      isNotFailure: context.read<DiscountWatcherBloc>().state.failure == null,
      shimmerItem: KMockText.discountModel,
    );
