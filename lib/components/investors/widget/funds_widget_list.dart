part of 'body/investors_body_widget.dart';

class FundsWidgetList extends StatelessWidget {
  const FundsWidgetList({required this.isDesk, Key? key}) : super(key: key);
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Center(
        child: Text(
          context.l10n.provenFunds,
          key: KWidgetkeys.screen.investors.fundsTitle,
          style: AppTextStyle.materialThemeDisplayMedium,
        ),
      ),
      if (isDesk) KSizedBox.kHeightSizedBox32 else KSizedBox.kHeightSizedBox24,
      FundsList(isDesk: isDesk),
    ]);
  }
}

class FundsList extends StatelessWidget {
  const FundsList({
    super.key,
    required this.isDesk,
  });

  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvestorsWatcherBloc, InvestorsWatcherState>(
      builder: (context, _) {
        switch (_.loadingStatus) {
          case LoadingStatusInvestors.loaded:
            if (_.mobFundItems.isEmpty) {
              return MockButtonWidget(
                key: KWidgetkeys.screen.investors.buttonMock,
                onPressed: () {
                  GetIt.I.get<IInvestorsRepository>().addMockFunds();
                  context
                      .read<InvestorsWatcherBloc>()
                      .add(const InvestorsWatcherEvent.started());
                },
              );
            } else {
              return ListView.builder(
                shrinkWrap: true,
                itemCount:
                    isDesk ? _.deskFundItems.length : _.mobFundItems.length,
                itemBuilder: (context, index) {
                  if (isDesk)
                    return DonatesCardsWidget(
                      key: KWidgetkeys.screen.investors.cards,
                      fundItems: _.deskFundItems.elementAt(index),
                    );
                  else
                    return DonateCardWidget(
                      hasSubtitle: true,
                      fundModel: _.mobFundItems.elementAt(index),
                      isDesk: false,
                    );
                },
              );
            }
          case LoadingStatusInvestors.loading:
          case LoadingStatusInvestors.error:
          case LoadingStatusInvestors.initial:
            return const SizedBox.shrink();
        }
      },
    );
  }

  // UnmodifiableListView<Widget> _fundsWidgetList({
  //   required List<FundModel> funds,
  //   required bool isDesk,
  // }) {
  // final fundsModel = context.read<InvestorsWatcherBloc>().state.fundItems;
  // final fundsModelItems = <List<FundModel>>[];

  // for (var i = 0; i < fundsModel.length; i += KDimensions.donateCardsLine) {
  //   if (i + KDimensions.donateCardsLine <= fundsModel.length) {
  //     fundsModelItems
  //         .add(fundsModel.sublist(i, i + KDimensions.donateCardsLine));
  //   } else {
  //     fundsModelItems.add(fundsModel.sublist(i));
  //   }
  // }

  // DonatesCardsWidget(
  //   key: KWidgetkeys.screen.investors.cards,
  //   fundItems: fundsModel.elementAt(index),
  // );
  // } else {
  //   return UnmodifiableListView(cardWidgetList<FundModel>(
  //     loadingStatus: LoadingStatus.loaded,
  //     modelItems: fundsModel,
  //     cardWidget: ({required modelItem, required isLoading}) =>
  //         DonateCardWidget(
  //       key: KWidgetkeys.screen.investors.card,
  //       fundModel: modelItem,
  //       isDesk: isDesk,
  //       hasSubtitle: true,
  //       // reportEvent: null,
  //       // () => context
  //       //     .read<InvestorsWatcherBloc>()
  //       //     .add(const InvestorsWatcherEvent.getReport()),
  //     ),
  //     isDesk: isDesk,
  //     shimmerItemsNumber: KDimensions.shimmerFundsMobItems,
  //     isNotFailure: isNotFailure,
  //     shimmerItem: KMockText.fundModel,
  //   ));
  // }
  // }
}
