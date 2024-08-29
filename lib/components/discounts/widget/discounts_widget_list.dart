part of 'body/discounts_body_widget.dart';

List<Widget> discountsWidgetList({
  required BuildContext context,
  required bool isDesk,
}) {
  final items = cardWidgetList<DiscountModel>(
    loadingStatus: context.read<DiscountWatcherBloc>().state.loadingStatus,
    modelItems:
        context.read<DiscountWatcherBloc>().state.filteredDiscountModelItems,
    cardWidget: ({required modelItem, required isLoading}) =>
        DiscountCardWidget(
      key: KWidgetkeys.screen.discounts.card,
      discountItem: modelItem,
      isDesk: isDesk,
      // reportEvent: null,
      share: '${KRoute.home.path}${KRoute.discounts.path}/${modelItem.id}',
      isLoading: isLoading,
      // () => context
      //     .read<DiscountWatcherBloc>()
      //     .add(const DiscountWatcherEvent.getReport()),
    ),
    isDesk: isDesk,
    shimmerItemsNumber: context.read<DiscountConfigCubit>().state.loadingItems,
    isNotFailure: context.read<DiscountWatcherBloc>().state.failure == null,
    shimmerItem: KMockText.discountModel,
  );

  final finalList = <Widget>[];
  for (var i = 0; i < items.length; i++) {
    finalList.add(items[i]);
    if ((i + 1) %
                (KDimensions.loadItems *
                    (context.read<DiscountConfigCubit>().state.linkScrollCount +
                        1)) ==
            0 &&
        context.read<DiscountWatcherBloc>().state.loadingStatus !=
            LoadingStatus.listLoadedFull) {
      finalList.add(
        DiscountNotificationWidget(key: ValueKey(i), isDesk: isDesk),
      );
    }
  }
  return finalList;
}
