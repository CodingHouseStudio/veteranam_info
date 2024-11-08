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
        const FundsList(),
      ],
    );
  }
}

class FundsList extends StatelessWidget {
  const FundsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvestorsWatcherBloc, InvestorsWatcherState>(
      builder: (context, _) {
        switch (_.loadingStatus) {
          case LoadingStatusInvestors.loaded:
            return ListView.builder(
              shrinkWrap: true,
              itemCount: _.deskFundItems.length + 1,
              itemBuilder: (context, index) {
                if (_.deskFundItems.length > index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: KPadding.kPaddingSize48,
                    ),
                    child: DonatesCardsWidget(
                      fundItems: _.deskFundItems.elementAt(index),
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      context.l10n.thatEndOfList,
                      key: KWidgetkeys.widget.scaffold.endListText,
                      style:
                          AppTextStyle.materialThemeTitleMediumNeutralVariant70,
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
