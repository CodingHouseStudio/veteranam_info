part of 'body/investors_body_widget.dart';

List<Widget> _fundsWidgetList({
  required BuildContext context,
  required bool isDesk,
}) {
  final isLoading = context.read<InvestorsWatcherBloc>().state.loadingStatus !=
      LoadingStatus.loaded;
  final fundItems = [
    if (context.read<InvestorsWatcherBloc>().state.failure == null) ...[
      ...context.read<InvestorsWatcherBloc>().state.loadingFundItems,
      if (isLoading)
        ...List<FundModel>.generate(
          KDimensions.shimmerFundsItems,
          (index) => KMockText.fundModel.copyWith(
            id: index.toString(),
          ),
        ),
    ],
  ];
  return List.generate(
    (isDesk
        ? (fundItems.length / KDimensions.donateCardsLine).ceil()
        : fundItems.length),
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
                isLoading: fundItems.length - index * 3 <=
                        KDimensions.shimmerFundsItems &&
                    isLoading,
              )
            : SkeletonizerWidget(
                isLoading:
                    fundItems.length - index <= KDimensions.shimmerFundsItems &&
                        isLoading,
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
