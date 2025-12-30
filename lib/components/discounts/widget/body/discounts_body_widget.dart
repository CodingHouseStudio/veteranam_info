import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/components/discounts/discounts.dart';
import 'package:veteranam/shared/shared_flutter.dart';

// import 'package:veteranam/shared/constants/failure_enum.dart';

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
    return DiscountsBlocListener(
      childWidget: CustomScrollView(
        key: ScaffoldKeys.scroll,
        cacheExtent: KDimensions.listCacheExtent,
        slivers: [
          const NetworkBanner(),
          if (Config.isWeb) const NavigationBarWidget(),
          BlocBuilder<AppLayoutBloc, AppLayoutState>(
            buildWhen: (previous, current) =>
                previous.appVersionEnum.isDesk != current.appVersionEnum.isDesk,
            builder: (context, state) => SliverCenterWidget(
              appVersionEnum: state.appVersionEnum,
              sliver: SliverMainAxisGroup(
                slivers: [
                  DiscountTitleWidget(
                    isDesk: state.appVersionEnum.isDesk,
                  ),
                  if (state.appVersionEnum.isDesk)
                    KSizedBox.kHeightSizedBox40.toSliver
                  else
                    KSizedBox.kHeightSizedBox24.toSliver,
                  if (state.appVersionEnum.isDesk)
                    const DiscountsDeskWidgetList()
                  else
                    DiscountWidgetList(
                      isDesk: state.appVersionEnum.isTablet,
                    ),
                ],
              ),
            ),
          ),
        ],
        controller: scrollController,
        // semanticChildCount: null,
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
        context.read<DiscountsWatcherBloc>().state.loadingStatus ==
            LoadingStatus.loaded) {
      context.read<DiscountsWatcherBloc>().add(
            const DiscountsWatcherEvent.loadNextItems(),
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
