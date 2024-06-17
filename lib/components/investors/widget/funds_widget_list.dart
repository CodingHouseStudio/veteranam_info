part of 'body/investors_body_widget.dart';

List<Widget> _fundsWidgetList({
  required BuildContext context,
  required bool isDesk,
}) {
  final isLoading = context.read<InvestorsWatcherBloc>().state.loadingStatus !=
      LoadingStatus.loaded;
  final fundItems = isLoading
      ? List<FundModel>.generate(
          KDimensions.shimmerFundsItems,
          (index) => KMockText.fundModel.copyWith(
            id: index.toString(),
          ),
        )
      : context.read<InvestorsWatcherBloc>().state.loadingFundItems;
  return List.generate(
    context.read<InvestorsWatcherBloc>().state.failure == null
        ? (isDesk
            ? (fundItems.length / KDimensions.donateCardsLine).ceil()
            : fundItems.length)
        : 0,
    (index) {
      return Padding(
        padding: index != 0
            ? const EdgeInsets.only(
                top: KPadding.kPaddingSize24,
              )
            : EdgeInsets.zero,
        child: isDesk
            ? DonatesCardsWidget(
                key: KWidgetkeys.screen.investors.cards,
                fundItems: fundItems.sublist(
                  index * 3,
                  (fundItems.length > (index + 1) * KDimensions.donateCardsLine)
                      ? index * 3 + 3
                      : fundItems.length,
                ),
              )
            : SkeletonizerWidget(
                isLoading: isLoading,
                child: DonateCardWidget(
                  key: index != fundItems.length - 1
                      ? KWidgetkeys.screen.investors.card
                      : KWidgetkeys.screen.investors.cardLast,
                  fundModel: fundItems.elementAt(index),
                  isDesk: false,
                  hasSubtitle: true,
                ),
              ),
      );
    },
  );
}
