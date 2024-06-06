part of 'body/investors_body_widget.dart';

List<Widget> _fundsWidgetList({
  required BuildContext context,
  required bool isDesk,
}) {
  final fundItems =
      context.read<InvestorsWatcherBloc>().state.fundItems.isNotEmpty
          ? context.read<InvestorsWatcherBloc>().state.fundItems
          : List<FundModel>.generate(
              KDimensions.shimmerFundsItems,
              (index) => FundModel(
                id: index.toString(),
                title: KMockText.donateCardTitle,
                subtitle: KMockText.donateCardSubtitle,
                link: '',
              ),
            );
  return List.generate(
    isDesk
        ? (fundItems.length / KDimensions.donateCardsLine).ceil()
        : fundItems.length,
    (index) {
      return Padding(
        padding: index != 0
            ? const EdgeInsets.only(
                top: KPadding.kPaddingSize24,
              )
            : EdgeInsets.zero,
        child: isDesk
            ? DonatesCardsWidget(
                key: KWidgetkeys.screen.investors.donateCards,
                fundItems: fundItems.sublist(
                  index * 3,
                  (fundItems.length > (index + 1) * KDimensions.donateCardsLine)
                      ? index * 3 + 3
                      : fundItems.length,
                ),
              )
            : Skeletonizer(
                enabled:
                    context.read<InvestorsWatcherBloc>().state.loadingStatus !=
                        LoadingStatus.loaded,
                child: DonateCardWidget(
                  key: KWidgetkeys.screen.investors.donateCard,
                  fundModel: fundItems.elementAt(index),
                  isDesk: false,
                  hasSubtitle: true,
                ),
              ),
      );
    },
  );
}
