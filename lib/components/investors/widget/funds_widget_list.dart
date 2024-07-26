part of 'body/investors_body_widget.dart';

List<Widget> _fundsWidgetList({
  required BuildContext context,
  required bool isDesk,
}) {
  final fundsModel =
      context.read<InvestorsWatcherBloc>().state.loadingFundItems;
  final fundsModelItems = <List<FundModel>>[];

  for (var i = 0; i < fundsModel.length; i += KDimensions.donateCardsLine) {
    if (i + KDimensions.donateCardsLine <= fundsModel.length) {
      fundsModelItems
          .add(fundsModel.sublist(i, i + KDimensions.donateCardsLine));
    } else {
      fundsModelItems.add(fundsModel.sublist(i));
    }
  }
  final isNotFailure =
      context.read<InvestorsWatcherBloc>().state.failure == null;
  if (isDesk) {
    return cardWidgetList<List<FundModel>>(
      loadingStatus: context.read<InvestorsWatcherBloc>().state.loadingStatus,
      modelItems: fundsModelItems,
      cardWidget: ({required modelItem, required isLoading}) =>
          DonatesCardsWidget(
        key: KWidgetkeys.screen.investors.cards,
        fundItems: modelItem,
        isLoading: isLoading,
      ),
      isDesk: isDesk,
      shimmerItemsNumber: KDimensions.shimmerFundsDeskItems,
      isNotFailure: isNotFailure,
      shimmerItem: List.generate(
        KDimensions.donateCardsLine,
        (index) => KMockText.fundModel,
      ),
    );
  } else {
    return cardWidgetList<FundModel>(
      loadingStatus: context.read<InvestorsWatcherBloc>().state.loadingStatus,
      modelItems: fundsModel,
      cardWidget: ({required modelItem, required isLoading}) =>
          DonateCardWidget(
        key: KWidgetkeys.screen.investors.card,
        fundModel: modelItem,
        isDesk: isDesk,
        hasSubtitle: true,
        reportEvent: null,
        // () => context
        //     .read<InvestorsWatcherBloc>()
        //     .add(const InvestorsWatcherEvent.getReport()),
      ),
      isDesk: isDesk,
      shimmerItemsNumber: KDimensions.shimmerFundsMobItems,
      isNotFailure: isNotFailure,
      shimmerItem: KMockText.fundModel,
    );
  }
}
