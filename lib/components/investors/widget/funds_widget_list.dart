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
        return SliverList.builder(
          addAutomaticKeepAlives: false,
          addRepaintBoundaries: false,
          itemCount: listLength == 0
              ? isDesk
                  ? KDimensions.shimmerFundsDeskItems
                  : KDimensions.shimmerFundsMobItems
              : listLength + 1,
          itemBuilder: (context, index) => _FundsItemWidget(
            isDesk: isDesk,
            index: index,
            state: _,
            listLength: listLength,
          ),
        );
      },
    );
  }
}

class _FundsItemWidget extends StatelessWidget {
  const _FundsItemWidget({
    required this.isDesk,
    required this.index,
    required this.state,
    required this.listLength,
  });
  final bool isDesk;
  final int index;
  final InvestorsWatcherState state;
  final int listLength;
  @override
  Widget build(BuildContext context) {
    if (state.loadingStatus != LoadingStatusInvestors.loaded) {
      return SkeletonizerWidget(
        isLoading: true,
        child: _FundWidget(
          isDesk: isDesk,
          fundMob: KMockText.fundModel,
          fundDesk: KMockText.fundDesk,
        ),
      );
    }
    if (index < listLength) {
      return _FundWidget(
        isDesk: isDesk,
        fundMob: state.mobFundItems.elementAt(index),
        fundDesk: isDesk ? state.deskFundItems.elementAt(index) : const [],
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
            style: AppTextStyle.materialThemeTitleMediumNeutralVariant70,
          ),
        ),
      );
    }
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
    return Padding(
      key: isDesk ? ValueKey(fundDesk.first.id) : ValueKey(fundMob.id),
      padding: const EdgeInsets.only(
        top: KPadding.kPaddingSize48,
      ),
      child: isDesk
          ? DonatesCardsWidget(
              key: KWidgetkeys.screen.investors.cards,
              fundItems: fundDesk,
            )
          : DonateCardWidget(
              key: KWidgetkeys.screen.investors.card,
              hasSubtitle: true,
              fundModel: fundMob,
              isDesk: false,
            ),
    );
  }
}
