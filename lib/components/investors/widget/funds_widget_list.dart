import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/investors/bloc/investors_watcher_bloc.dart';
import 'package:veteranam/components/investors/investors.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class FundsWidgetList extends StatelessWidget {
  const FundsWidgetList({
    required this.isDesk,
    super.key,
  });
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvestorsWatcherBloc, InvestorsWatcherState>(
      builder: (context, _) {
        final listLength =
            isDesk ? _.deskFundItems.length : _.mobFundItems.length;
        if (listLength != 0) {
          return SliverMainAxisGroup(
            slivers: [
              SliverList.builder(
                addAutomaticKeepAlives: false,
                addRepaintBoundaries: false,
                itemCount: listLength * 2,
                itemBuilder: (context, index) {
                  if (index.isEven) {
                    final indexValue = (index / 2).toInt();
                    final keyValue = isDesk
                        ? '${_.deskFundItems.elementAt(indexValue).first.id}'
                            '_desk'
                        : _.mobFundItems.elementAt(indexValue).id;
                    return _FundWidget(
                      key: ValueKey(
                        keyValue,
                      ),
                      isDesk: isDesk,
                      fundDesk: isDesk
                          ? _.deskFundItems.elementAt(indexValue)
                          : const [],
                      fundMob: _.mobFundItems.elementAt(indexValue),
                    );
                  } else {
                    return KSizedBox.kHeightSizedBox48;
                  }
                },
              ),
              SliverPadding(
                padding: const EdgeInsets.only(
                  top: KPadding.kPaddingSize48,
                ),
                sliver: SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      context.l10n.thatEndOfList,
                      key: InvestorsKeys.endListText,
                      style:
                          AppTextStyle.materialThemeTitleMediumNeutralVariant70,
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return SliverList.builder(
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: false,
            itemCount: (isDesk
                    ? KDimensions.shimmerFundsDeskItems
                    : KDimensions.shimmerFundsMobItems) *
                2,
            itemBuilder: (context, index) {
              if (index.isEven) {
                return SkeletonizerWidget(
                  isLoading: true,
                  child: _FundWidget(
                    isDesk: isDesk,
                    fundMob: KMockText.fundModel,
                    fundDesk: KMockText.fundDesk,
                  ),
                );
              } else {
                return KSizedBox.kHeightSizedBox48;
              }
            },
          );
        }
      },
    );
  }
}

class _FundWidget extends StatelessWidget {
  const _FundWidget({
    required this.isDesk,
    required this.fundMob,
    required this.fundDesk,
    super.key,
  });

  final bool isDesk;
  final FundModel fundMob;
  final List<FundModel> fundDesk;

  @override
  Widget build(BuildContext context) {
    if (isDesk) {
      return DonatesCardsWidget(
        key: InvestorsKeys.cards,
        fundItems: fundDesk,
      );
    } else {
      return DonateCardWidget(
        key: InvestorsKeys.card,
        hasSubtitle: true,
        fundModel: fundMob,
        isDesk: false,
      );
    }
  }
}
