import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/investors/bloc/investors_watcher_bloc.dart';
import 'package:veteranam/components/investors/investors.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class FundsWidgetList extends SingleChildRenderObjectWidget {
  FundsWidgetList({
    required this.isDesk,
    required this.padding,
    super.key,
  }) : super(
          child: _FundsWidgetList(
            isDesk: isDesk,
          ),
        );
  final bool isDesk;
  final EdgeInsets padding;

  @override
  RenderSliverPadding createRenderObject(BuildContext context) {
    return RenderSliverPadding(
      padding: padding,
      textDirection: Directionality.of(context),
    );
  }
}

class _FundsWidgetList extends StatelessWidget {
  const _FundsWidgetList({
    required this.isDesk,
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
                itemCount: listLength,
                itemBuilder: (context, index) => Padding(
                  key: ValueKey(
                    isDesk
                        ? '${_.deskFundItems.elementAt(index).first.id}_desk'
                        : _.mobFundItems.elementAt(index).id,
                  ),
                  padding: const EdgeInsets.only(
                    top: KPadding.kPaddingSize48,
                  ),
                  child: _FundWidget(
                    isDesk: isDesk,
                    fundDesk:
                        isDesk ? _.deskFundItems.elementAt(index) : const [],
                    fundMob: _.mobFundItems.elementAt(index),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(
                  top: KPadding.kPaddingSize48,
                ),
                sliver: SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      context.l10n.thatEndOfList,
                      key: KWidgetkeys.screen.investors.endListText,
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
            itemCount: isDesk
                ? KDimensions.shimmerFundsDeskItems
                : KDimensions.shimmerFundsMobItems,
            itemBuilder: (context, index) => SkeletonizerWidget(
              isLoading: true,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: KPadding.kPaddingSize48,
                ),
                child: _FundWidget(
                  isDesk: isDesk,
                  fundMob: KMockText.fundModel,
                  fundDesk: KMockText.fundDesk,
                ),
              ),
            ),
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
  });

  final bool isDesk;
  final FundModel fundMob;
  final List<FundModel> fundDesk;

  @override
  Widget build(BuildContext context) {
    if (isDesk) {
      return DonatesCardsWidget(
        key: KWidgetkeys.screen.investors.cards,
        fundItems: fundDesk,
      );
    } else {
      return DonateCardWidget(
        key: KWidgetkeys.screen.investors.card,
        hasSubtitle: true,
        fundModel: fundMob,
        isDesk: false,
      );
    }
  }
}
