part of 'body/discounts_body_widget.dart';

List<Widget> discountsWidgetList({
  required BuildContext context,
  required bool isDesk,
}) =>

    ///TODO: fix
    cardWidgetList<DiscountModel>(
      loadingStatus: context.read<DiscountWatcherBloc>().state.loadingStatus,
      modelItems: context.read<DiscountWatcherBloc>().state.discountModelItems,
      cardWidget: ({required modelItem, required isLoading}) =>
          DiscountsCardWidget(
        key: KWidgetkeys.screen.discounts.card,
        discountItem: modelItem,
        isDesk: isDesk,
      ),
      isDesk: isDesk,
      shimmerItemsNumber: KDimensions.shimmerDiscountsItems,
      isNotFailure: context.read<DiscountWatcherBloc>().state.failure == null,
      shimmerItem: KMockText.discountModel,
    );
