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
        BlocBuilder<InvestorsWatcherBloc, InvestorsWatcherState>(
          builder: (context, _) {
            switch (_.loadingStatus) {
              case LoadingStatusInvestors.loaded:
                if (isDesk) {
                  return FundsDeskList(
                    state: _,
                  );
                } else {
                  return FundsMobList(state: _);
                }
              case LoadingStatusInvestors.loading:
              case LoadingStatusInvestors.error:
              case LoadingStatusInvestors.initial:
                return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}

class FundsDeskList extends StatefulWidget {
  const FundsDeskList({
    required this.state,
    super.key,
  });
  final InvestorsWatcherState state;

  @override
  State<FundsDeskList> createState() => _FundsDeskListState();
}

class _FundsDeskListState extends State<FundsDeskList> {
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      controller: _scrollController,
      itemCount: widget.state.loadingDeskFundItems.length + 1,
      itemBuilder: (context, index) {
        if (widget.state.loadingDeskFundItems.length > index) {
          return Padding(
            padding: const EdgeInsets.only(
              top: KPadding.kPaddingSize48,
            ),
            child: DonatesCardsWidget(
              fundItems: widget.state.loadingDeskFundItems.elementAt(index),
            ),
          );
        } else {
          if (widget.state.loadedFull) {
            return ListScrollUpWidget(scrollController: _scrollController);
          } else {
            return Padding(
              padding: const EdgeInsets.only(top: KPadding.kPaddingSize40),
              child: LoadingButtonWidget(
                widgetKey: KWidgetkeys.screen.investors.loadingButton,
                isDesk: true,
                onPressed: () => context
                    .read<InvestorsWatcherBloc>()
                    .add(const InvestorsWatcherEvent.loadNextItems()),
                text: context.l10n.moreFunds,
              ),
            );
          }
        }
      },
    );
  }

  void scrollUp() {
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: (_scrollController.offset / 10).toInt()),
      curve: Curves.linear,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }
}

class FundsMobList extends StatefulWidget {
  const FundsMobList({
    required this.state,
    super.key,
  });
  final InvestorsWatcherState state;

  @override
  State<FundsMobList> createState() => _FundsMobListState();
}

class _FundsMobListState extends State<FundsMobList> {
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      controller: _scrollController,
      itemCount:
          widget.state.fundItems.length + (widget.state.loadedFull ? 1 : 0),
      itemBuilder: (context, index) {
        if (widget.state.fundItems.length > index) {
          return Padding(
            padding: const EdgeInsets.only(
              top: KPadding.kPaddingSize48,
            ),
            child: DonateCardWidget(
              hasSubtitle: true,
              fundModel: widget.state.fundItems.elementAt(index),
              isDesk: false,
            ),
          );
        } else {
          return ListScrollUpWidget(scrollController: _scrollController);
        }
      },
    );
  }

  void _onScroll() {
    if (_isBottom && !widget.state.loadedFull) {
      context
          .read<InvestorsWatcherBloc>()
          .add(const InvestorsWatcherEvent.loadNextItems());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void scrollUp() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();

    super.dispose();
  }
}
