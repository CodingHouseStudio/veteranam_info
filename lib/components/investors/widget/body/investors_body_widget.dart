import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

class InvestorsBodyWidget extends StatelessWidget {
  const InvestorsBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvestorsWatcherBloc, InvestorsWatcherState>(
      builder: (context, _) {
        switch (_) {
          case InvestorsWatcherStateIntital():
            return const CircularProgressIndicator.adaptive();
          case InvestorsWatcherStateLoading():
            return const CircularProgressIndicator.adaptive();
          case InvestorsWatcherStateSuccess():
            return ScaffoldWithNavBar(
              childWidgetsFunction: ({required isDesk}) => [
                FeedbackWidget(isDesk: isDesk),
                Text(
                  context.l10n.funds,
                  style: isDesk ? AppTextStyle.text96 : AppTextStyle.text32,
                ),
                KSizedBox.kHeightSizedBox8,
                Text(
                  context.l10n.fundsSubtitle,
                  style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
                ),
                KSizedBox.kHeightSizedBox56,
                if (_.fundItems.isNotEmpty)
                  if (isDesk)
                    ...List.generate(
                      (_.fundItems.length / 3).ceil(),
                      (index) => Padding(
                        padding: EdgeInsets.only(
                          top: index == 0 ? 0 : KPadding.kPaddingSize24,
                        ),
                        child: DonatesCardsWidget(
                          key: KWidgetkeys.screen.investors.donateCards,
                          fundItems: _.fundItems.sublist(
                            index * 3,
                            (_.fundItems.length > index * 3 + 3)
                                ? index * 3 + 3
                                : _.fundItems.length,
                          ),
                        ),
                      ),
                    )
                  else
                    ...List.generate(
                      _.fundItems.length,
                      (index) => Padding(
                        padding: EdgeInsets.only(
                          top: index == 0 ? 0 : KPadding.kPaddingSize24,
                        ),
                        child: DonateCardWidget(
                          key: KWidgetkeys.screen.investors.donateCards,
                          fundModel: _.fundItems.elementAt(index),
                          isDesk: false,
                          hasSubtitle: true,
                        ),
                      ),
                    )
                else
                  TextButton(
                    key: KWidgetkeys.screen.home.buttonMock,
                    onPressed: () {
                      GetIt.I.get<IInvestorsRepository>().addMockFunds();
                      context
                          .read<InvestorsWatcherBloc>()
                          .add(const InvestorsWatcherEvent.started());
                    },
                    child: Text(
                      context.l10n.getMockData,
                      style: AppTextStyle.text32,
                    ),
                  ),
                if (isDesk)
                  KSizedBox.kHeightSizedBox56
                else
                  KSizedBox.kHeightSizedBox40,
              ],
            );
          case InvestorsWatcherStateFailure():
          default:
            return const CircularProgressIndicator.adaptive();
        }
      },
    );
  }
}
