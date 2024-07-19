part of 'body/discounts_body_widget.dart';

List<Widget> discountsWidgetList({
  required BuildContext context,
  required bool isDesk,
}) =>
    cardWidgetList<DiscountModel>(
      loadingStatus: context.read<DiscountWatcherBloc>().state.loadingStatus,
      modelItems:
          context.read<DiscountWatcherBloc>().state.filteredDiscountModelItems,
      cardWidget: ({required modelItem, required isLoading}) =>
          DiscountCardWidget(
        key: KWidgetkeys.screen.discounts.card,
        discountItem: modelItem,
        isDesk: isDesk,
        reportEvent: () => context
            .read<DiscountWatcherBloc>()
            .add(const DiscountWatcherEvent.getReport()),
      ),
      isDesk: isDesk,
      shimmerItemsNumber: KDimensions.shimmerDiscountsItems,
      isNotFailure: context.read<DiscountWatcherBloc>().state.failure == null,
      shimmerItem: KMockText.discountModel,
    )..add(
        NotificationLinkWidget(
          onChanged: (p0) {},
          isDesk: isDesk,
          title: context.l10n.discountLinkTitle,
          sendOnPressed: () {},
        ),
      );
