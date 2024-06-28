part of 'body/investors_body_widget.dart';

List<Widget> _fundsWidgetList({
  required BuildContext context,
  required bool isDesk,
}) {
  final isLoading = context.read<InvestorsWatcherBloc>().state.loadingStatus !=
      LoadingStatus.loaded;
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
      isLoading: isLoading,
      modelItems: fundsModelItems,
      cardWidget: ({required modelItem, required key}) => DonatesCardsWidget(
        key: KWidgetkeys.screen.investors.cards,
        fundItems: modelItem,
        isLoading: isLoading,
      ),
      isDesk: isDesk,
      shimmerItemsNumber: KDimensions.shimmerFundsItems,
      cardKey: KWidgetkeys.screen.investors.card,
      cardLastKey: KWidgetkeys.screen.investors.cardLast,
      isNotFailure: isNotFailure,
      shimmerItem: List.generate(
        KDimensions.donateCardsLine,
        (index) => KMockText.fundModel,
      ),
    );
  } else {
    return cardWidgetList<FundModel>(
      isLoading: isLoading,
      modelItems: fundsModel,
      cardWidget: ({required modelItem, required key}) => DonateCardWidget(
        key: key,
        fundModel: modelItem,
        isDesk: isDesk,
        hasSubtitle: true,
      ),
      isDesk: isDesk,
      shimmerItemsNumber: KDimensions.shimmerFundsItems,
      cardKey: KWidgetkeys.screen.investors.card,
      cardLastKey: KWidgetkeys.screen.investors.cardLast,
      isNotFailure: isNotFailure,
      shimmerItem: KMockText.fundModel,
    );
  }
}
