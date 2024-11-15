import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/investors/bloc/investors_watcher_bloc.dart';
import 'package:veteranam/components/investors/investors.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class FundsWidgetList extends StatelessWidget {
  const FundsWidgetList({required this.isDesk, super.key});
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            context.l10n.provenFunds,
            key: KWidgetkeys.screen.investors.fundsTitle,
            style: AppTextStyle.materialThemeDisplayMedium,
          ),
        ),
        FundsList(
          isDesk: isDesk,
        ),
      ],
    );
  }
}

class FundsList extends StatelessWidget {
  const FundsList({
    required this.isDesk,
    super.key,
  });
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvestorsWatcherBloc, InvestorsWatcherState>(
      builder: (context, _) {
        switch (_.loadingStatus) {
          case LoadingStatusInvestors.loaded:
            final listLength =
                isDesk ? _.deskFundItems.length : _.mobFundItems.length;
            return ListView.builder(
              shrinkWrap: true,
              primary: false,
              addAutomaticKeepAlives: false,
              addRepaintBoundaries: false,
              itemCount: listLength + 1,
              itemBuilder: (context, index) {
                if (index < listLength) {
                  return Padding(
                    key: isDesk
                        ? ValueKey(_.deskFundItems.elementAt(index).first.id)
                        : ValueKey(_.mobFundItems.elementAt(index).id),
                    padding: const EdgeInsets.only(
                      top: KPadding.kPaddingSize48,
                    ),
                    child: isDesk
                        ? DonatesCardsWidget(
                            key: KWidgetkeys.screen.investors.cards,
                            fundItems: _.deskFundItems.elementAt(index),
                          )
                        : DonateCardWidget(
                            key: KWidgetkeys.screen.investors.card,
                            hasSubtitle: true,
                            fundModel: _.mobFundItems.elementAt(index),
                            isDesk: false,
                          ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: KPadding.kPaddingSize48,
                    ),
                    child: Center(
                      child: Text(
                        context.l10n.thatEndOfList,
                        key: KWidgetkeys.screen.investors.endListText,
                        style: AppTextStyle
                            .materialThemeTitleMediumNeutralVariant70,
                      ),
                    ),
                  );
                }
              },
            );
          case LoadingStatusInvestors.loading:
          case LoadingStatusInvestors.error:
          case LoadingStatusInvestors.initial:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
