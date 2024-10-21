part of 'body/my_discounts_body_widget.dart';

List<Widget> _myDiscountsCardWidgetList({
  required BuildContext context,
  required bool isDesk,
}) =>
    cardWidgetList<DiscountModel>(
      loadingStatus: context.read<MyDiscountsWatcherBloc>().state.loadingStatus,
      modelItems: context
          .read<MyDiscountsWatcherBloc>()
          .state
          .loadedDiscountsModelItems,
      cardWidget: ({required modelItem, required isLoading}) => MyDiscountsCard(
        key: KWidgetkeys.screen.myDiscounts.card,
        discountModel: modelItem,
        isDesk: isDesk,
        isLoading: isLoading,
        onDeactivate: ({required deactivate}) =>
            context.read<MyDiscountsWatcherBloc>().add(
                  MyDiscountsWatcherEvent.changeDeactivate(
                    modelItem,
                  ),
                ),
        // reportEvent: null,
        // () => context
        //     .read<DiscountWatcherBloc>()
        //     .add(const DiscountWatcherEvent.getReport()),
      ),
      isDesk: isDesk,
      shimmerItemsNumber: KDimensions.loadItems,
      isNotFailure:
          context.read<MyDiscountsWatcherBloc>().state.failure == null,
      shimmerItem: KMockText.discountModel,
    );
