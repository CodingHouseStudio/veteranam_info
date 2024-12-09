import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/components/discounts/discounts.dart';
import 'package:veteranam/shared/constants/failure_enum.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountsBodyWidget extends StatelessWidget {
  const DiscountsBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    if (PlatformEnumFlutter.isWebDesktop) {
      return const _DiscountsBodyWidget(
        scrollController: null,
      );
    }
    return const _DiscountMobBodyWidget();
  }
}

class _DiscountsBodyWidget extends StatelessWidget {
  const _DiscountsBodyWidget({required this.scrollController});
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocListener<NetworkCubit, NetworkStatus>(
      listener: (context, state) {
        if (state == NetworkStatus.network) {
          context.read<DiscountWatcherBloc>().add(
                const DiscountWatcherEvent.started(),
              );
        }
      },
      child: BlocListener<DiscountWatcherBloc, DiscountWatcherState>(
        listener: (context, state) {
          if (state.failure != null) {
            context.dialog.showGetErrorDialog(
              error: state.failure!.value(context),
              onPressed: state.failure == DiscountFailure.filter ? null : () {},
              // I think this event is not necessary for Stream, but
              // I think it's better to give
              // the user imaginary control over it

              // () => context
              //     .read<DiscountWatcherBloc>()
              //     .add(const DiscountWatcherEvent.started()),
            );
          }

          if (state.filterDiscountModelList.length ==
              (context.read<DiscountConfigCubit>().state.loadingItems *
                  (context.read<DiscountConfigCubit>().state.emailScrollCount +
                      1))) {
            if (Config.isWeb) {
              if (context.read<UserEmailFormBloc>().state.emailEnum.show) {
                if ((context.read<UserWatcherBloc>().state.user.email ?? '')
                    .isEmpty) {
                  context.dialog.showUserEmailDialog(
                    context.read<DiscountConfigCubit>().state.emailCloseDelay,
                  );
                }
              }
            } else {
              context.read<MobileRatingCubit>().showDialog();
            }
          }
        },
        listenWhen: (previous, current) =>
            current.failure != null ||
            previous.filterDiscountModelList.length !=
                current.filterDiscountModelList.length,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final isDesk =
                constraints.maxWidth > KPlatformConstants.minWidthThresholdDesk;
            final isTablet = constraints.maxWidth >
                KPlatformConstants.minWidthThresholdTablet;

            final padding = EdgeInsets.symmetric(
              horizontal: (isDesk
                  ? KPadding.kPaddingSize90 +
                      ((constraints.maxWidth >
                              KPlatformConstants.maxWidthThresholdTablet)
                          ? (constraints.maxWidth -
                                  KPlatformConstants.maxWidthThresholdTablet) /
                              2
                          : 0)
                  : KPadding.kPaddingSize16),
            );
            return FocusTraversalGroup(
              child: Semantics(
                child: CustomScrollView(
                  key: KWidgetkeys.widget.scaffold.scroll,
                  cacheExtent: KDimensions.listCacheExtent,
                  slivers: [
                    NetworkBanner(isDesk: isDesk, isTablet: isTablet),
                    NavigationBarWidget(
                      isDesk: isDesk,
                      isTablet: isTablet,
                      pageName: context.l10n.discounts,
                    ),
                    SliverPadding(
                      padding: padding,
                      sliver: DiscountTitleWidget(
                        isDesk: isDesk,
                      ),
                    ),
                    if (!isDesk)
                      SliverPadding(
                        padding: padding,
                        sliver: SliverToBoxAdapter(
                          child: AdvancedFilterMob(
                            key: KWidgetkeys.screen.discounts.advancedFilterMob,
                          ),
                        ),
                      ),
                    if (isDesk)
                      SliverPadding(
                        padding: padding,
                        sliver: DiscountsDeskWidgetList(
                          maxHeight: constraints.maxHeight,
                        ),
                      )
                    else
                      DiscountsMobWidgetList(
                        padding: padding,
                      ),
                  ],
                  controller: scrollController,
                  // semanticChildCount: null,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _DiscountMobBodyWidget extends StatefulWidget {
  const _DiscountMobBodyWidget();

  @override
  State<_DiscountMobBodyWidget> createState() => _DiscountMobBodyWidgetState();
}

class _DiscountMobBodyWidgetState extends State<_DiscountMobBodyWidget> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    if (!PlatformEnumFlutter.isWebDesktop) {
      _scrollController.addListener(_onScroll);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _DiscountsBodyWidget(scrollController: _scrollController);
  }

  void _onScroll() {
    if (_isBottom &&
        context.read<DiscountWatcherBloc>().state.loadingStatus ==
            LoadingStatus.loaded) {
      context.read<DiscountWatcherBloc>().add(
            const DiscountWatcherEvent.loadNextItems(),
          );
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= maxScroll * 0.9;
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }
}
