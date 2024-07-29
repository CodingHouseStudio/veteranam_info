import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared.dart';

class ScaffoldAutoLoadingWidget extends StatefulWidget {
  const ScaffoldAutoLoadingWidget({
    required this.mainChildWidgetsFunction,
    required this.loadFunction,
    required this.loadingButtonText,
    required this.loadDataAgain,
    required this.loadingStatus,
    this.cardListIsEmpty,
    this.titleChildWidgetsFunction,
    this.mainDeskPadding,
    this.mainRightChildWidget,
    super.key,
    this.resetFilter,
    this.pageName,
    this.showMobileNawbar,
  });

  final List<Widget> Function({required bool isDesk})?
      titleChildWidgetsFunction;
  final List<Widget> Function({required bool isDesk}) mainChildWidgetsFunction;
  final EdgeInsetsGeometry Function({required double maxWidth})?
      mainDeskPadding;
  final void Function() loadFunction;
  final Widget? mainRightChildWidget;
  final String loadingButtonText;
  final bool? cardListIsEmpty;
  final LoadingStatus loadingStatus;
  final void Function()? resetFilter;
  final void Function() loadDataAgain;
  final String? pageName;
  final bool? showMobileNawbar;

  @override
  State<ScaffoldAutoLoadingWidget> createState() =>
      _ScaffoldAutoLoadingWidgetState();
}

class _ScaffoldAutoLoadingWidgetState extends State<ScaffoldAutoLoadingWidget> {
  late ScrollController _scrollController;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  late Connectivity _connectivity;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _connectivity = Connectivity();
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
    if (!KPlatformConstants.isWebDesktop) {
      _scrollController.addListener(_onScroll);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final isDesk =
            constraints.maxWidth > KPlatformConstants.minWidthThresholdDesk;
        final isTablet =
            constraints.maxWidth > KPlatformConstants.minWidthThresholdTablet;

        final titleChildWidget =
            widget.titleChildWidgetsFunction?.call(isDesk: isDesk);
        final mainChildWidget = widget.mainChildWidgetsFunction(isDesk: isDesk)
          ..addAll([
            if (widget.loadingStatus != LoadingStatus.listLoadedFull &&
                KPlatformConstants.isWebDesktop &&
                !(widget.cardListIsEmpty ?? false) &&
                widget.loadingStatus != LoadingStatus.loading)
              LoadingButton(
                isDesk: isDesk,
                onPressed: widget.loadFunction,
                text: widget.loadingButtonText,
                widgetKey: KWidgetkeys.widget.scaffold.loadingButton,
              ),
            if ((widget.cardListIsEmpty ?? false) &&
                widget.loadingStatus != LoadingStatus.loading) ...[
              KSizedBox.kHeightSizedBox100,
              // const Center(child: KImage.emptyList),
              Center(
                child: Text(
                  context.l10n.cardListEmptyText,
                  key: KWidgetkeys.widget.scaffold.endListText,
                  style: AppTextStyle.materialThemeTitleMediumNeutralVariant70,
                ),
              ),
              KSizedBox.kHeightSizedBox36,
              Center(
                child: TextButton(
                  onPressed: widget.resetFilter,
                  child: Text(
                    context.l10n.resetAll,
                    style: AppTextStyle.materialThemeTitleLarge,
                  ),
                ),
              ),
            ],
            if (widget.loadingStatus == LoadingStatus.listLoadedFull &&
                !(widget.cardListIsEmpty ?? false)) ...[
              Center(
                child: Text(
                  context.l10n.thatEndOfList,
                  key: KWidgetkeys.widget.scaffold.emptyListText,
                  style: AppTextStyle.materialThemeTitleMediumNeutralVariant70,
                ),
              ),
              KSizedBox.kHeightSizedBox24,
              Center(
                child: TextButton(
                  style: KButtonStyles.endListButtonStyle,
                  onPressed: scrollUp,
                  child: Text(
                    context.l10n.returnToTop,
                    style: AppTextStyle.materialThemeTitleMedium,
                  ),
                ),
              ),
            ],
            KSizedBox.kHeightSizedBox40,
          ]);

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
        final route = [
          KRoute.discounts.name,
          KRoute.investors.name,
          KRoute.home.name,
        ];
        return Scaffold(
          bottomNavigationBar: KTest.testIsWeb
              ? null
              : BottomNavigationBar(
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: KIcon.tag.copyWith(fill: 1),
                      label: context.l10n.discounts,
                    ),
                    BottomNavigationBarItem(
                      icon: KIcon.investors.copyWith(fill: 1),
                      label: context.l10n.investors,
                    ),
                    BottomNavigationBarItem(
                      icon: KIcon.settings.copyWith(fill: 1),
                      label: context.l10n.settings,
                    ),
                  ],
                  currentIndex:
                      context.l10n.discounts == widget.pageName ? 0 : 1,
                  onTap: (i) => context.goNamed(route.elementAt(i)),
                ),
          body: CustomScrollView(
            key: KWidgetkeys.widget.scaffold.scroll,
            physics: KTest.scroll,
            slivers: [
              SliverPersistentHeader(
                delegate: NawbarWidget(
                  isDesk: isDesk,
                  isTablet: isTablet,
                  pageName: widget.pageName,
                  showMobileNawbar: widget.showMobileNawbar,
                ),
              ),
              if (titleChildWidget != null)
                SliverPadding(
                  padding: padding,
                  sliver: SliverList.builder(
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
                    itemBuilder: (context, index) {
                      return titleChildWidget.elementAt(index);
                    },
                    itemCount: titleChildWidget.length,
                  ),
                ),
              SliverPadding(
                padding: isDesk && widget.mainDeskPadding != null
                    ? padding.add(
                        widget.mainDeskPadding!(maxWidth: constraints.maxWidth),
                      )
                    : padding,
                sliver: widget.mainRightChildWidget != null && isDesk
                    ? RowSliver(
                        right: mainBody(mainChildWidget),
                        left: SliverPersistentHeader(
                          pinned: true,
                          delegate: NawbarWidget(
                            isDesk: isDesk,
                            childWidget: widget.mainRightChildWidget,
                            maxMinHeight: constraints.maxHeight,
                            isTablet: isTablet,
                          ),
                        ),
                        leftWidthPercent: 0.3,
                      )
                    : mainBody(mainChildWidget),
              ),
            ],
            semanticChildCount:
                mainChildWidget.length + (titleChildWidget?.length ?? 0) + 1,
            controller: _scrollController,
          ),
        );
      },
    );
  }

  Widget mainBody(List<Widget> mainChildWidget) => SliverList.builder(
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: false,
        itemBuilder: (context, index) {
          return mainChildWidget.elementAt(index);
        },
        itemCount: mainChildWidget.length,
      );

  void _onScroll() {
    if (_isBottom &&
        widget.loadingStatus != LoadingStatus.listLoadedFull &&
        !(widget.cardListIsEmpty ?? false)) {
      widget.loadFunction();
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
      curve: Curves.easeInOut,
    );
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } catch (e) {
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return;
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    if (result.any((element) => element != ConnectivityResult.none)) {
      widget.loadDataAgain();
    }
  }

  @override
  void dispose() {
    if (KPlatformConstants.isWebDesktop) {
      _scrollController.dispose();
    } else {
      _scrollController
        ..removeListener(_onScroll)
        ..dispose();
    }
    _connectivitySubscription.cancel();
    super.dispose();
  }
}
