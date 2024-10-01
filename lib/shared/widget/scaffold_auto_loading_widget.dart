import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/shared/shared.dart';

class ScaffoldAutoLoadingWidget extends StatefulWidget {
  const ScaffoldAutoLoadingWidget({
    required this.mainChildWidgetsFunction,
    required this.loadFunction,
    required this.loadingButtonText,
    required this.loadingStatus,
    this.loadDataAgain,
    this.cardListIsEmpty,
    this.titleChildWidgetsFunction,
    this.mainDeskPadding,
    this.mainRightChildWidget,
    super.key,
    // this.resetFilter,
    this.pageName,
    this.emptyWidget,
    // this.showMobileNawbar,
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
  // final void Function()? resetFilter;
  final void Function()? loadDataAgain;
  final String? pageName;
  // final bool? showMobileNawbar;
  final Widget Function({required bool isDesk})? emptyWidget;

  @override
  State<ScaffoldAutoLoadingWidget> createState() =>
      _ScaffoldAutoLoadingWidgetState();
}

class _ScaffoldAutoLoadingWidgetState extends State<ScaffoldAutoLoadingWidget> {
  late ScrollController _scrollController;
  bool offline = false;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    if (!KPlatformConstants.isWebDesktop) {
      _scrollController.addListener(_onScroll);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NetworkCubit, NetworkStatus>(
      listener: (context, state) {
        if (state == NetworkStatus.network) {
          widget.loadDataAgain?.call();
        }
      },
      builder: (context, state) => LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final isDesk =
              constraints.maxWidth > KPlatformConstants.minWidthThresholdDesk;
          final isTablet =
              constraints.maxWidth > KPlatformConstants.minWidthThresholdTablet;

          final titleChildWidget =
              widget.titleChildWidgetsFunction?.call(isDesk: isDesk);
          final mainChildWidget = widget.mainChildWidgetsFunction(
            isDesk: isDesk,
          )..addAll([
              if ((widget.cardListIsEmpty ?? false) &&
                  widget.loadingStatus != LoadingStatus.loading &&
                  widget.emptyWidget != null)
                widget.emptyWidget!.call(isDesk: isDesk)
              else ...[
                if (widget.loadingStatus != LoadingStatus.listLoadedFull &&
                    KPlatformConstants.isWebDesktop &&
                    !(widget.cardListIsEmpty ?? false) &&
                    widget.loadingStatus != LoadingStatus.loading)
                  LoadingButtonWidget(
                    isDesk: isDesk,
                    onPressed: widget.loadFunction,
                    text: widget.loadingButtonText,
                    widgetKey: KWidgetkeys.widget.scaffold.loadingButton,
                  ),
                //     ...[
                //   KSizedBox.kHeightSizedBox100,
                //   // const Center(child: KImage.emptyList),
                //   Center(
                //     child: Text(
                //       context.l10n.cardListEmptyText,
                //       key: KWidgetkeys.widget.scaffold.emptyListText,
                //       style:
                //           AppTextStyle.materialThemeTitleMediumNeutralVariant70
                // ,
                //     ),
                //   ),
                //   KSizedBox.kHeightSizedBox36,
                //   Center(
                //     child: TextButton(
                //       onPressed: widget.resetFilter,
                //       child: Text(
                //         context.l10n.resetAll,
                //         style: AppTextStyle.materialThemeTitleLarge,
                //       ),
                //     ),
                //   ),
                // ],
                if (widget.loadingStatus == LoadingStatus.listLoadedFull &&
                    !(widget.cardListIsEmpty ?? false)) ...[
                  Center(
                    child: Text(
                      context.l10n.thatEndOfList,
                      key: KWidgetkeys.widget.scaffold.endListText,
                      style:
                          AppTextStyle.materialThemeTitleMediumNeutralVariant70,
                    ),
                  ),
                  KSizedBox.kHeightSizedBox24,
                  Center(
                    child: TextButton(
                      key: KWidgetkeys.widget.scaffold.endListButton,
                      style: KButtonStyles.endListButtonStyle,
                      onPressed: scrollUp,
                      child: Text(
                        context.l10n.returnToTop,
                        style: AppTextStyle.materialThemeTitleMedium,
                      ),
                    ),
                  ),
                ],
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
          final scaffold = FocusTraversalGroup(
            child: Semantics(
              child: Stack(
                children: [
                  Scaffold(
                    resizeToAvoidBottomInset: !Config.isWeb,
                    bottomNavigationBar: Config.isWeb
                        ? null
                        : MobNavigationWidget(
                            index: context.l10n.discounts == widget.pageName
                                ? 0
                                : 1,
                          ),
                    appBar: AppBar(
                      backgroundColor: AppColors.materialThemeWhite,
                      toolbarHeight: KSize.kAppBarHeight,
                    ),
                    body: KeyboardScrollView(
                      widgetKey: KWidgetkeys.widget.scaffold.scroll,
                      // physics: KTest.scroll,
                      slivers: [
                        if (!Config.isWeb && state.isOffline)
                          SliverPersistentHeader(
                            pinned: true,
                            delegate: NetworkStatusBanner.getSliverHeader(
                              isDesk: isDesk,
                              isTablet: isTablet,
                              networkStatus: state,
                            ),
                          ),
                        if (Config.isWeb || widget.pageName != null)
                          SliverPersistentHeader(
                            delegate: NawbarWidget.getSliverHeader(
                              isDesk: isDesk,
                              isTablet: isTablet,
                              pageName: widget.pageName,
                              // showMobileNawbar: widget.showMobileNawbar,
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
                                  widget.mainDeskPadding!(
                                    maxWidth: constraints.maxWidth,
                                  ),
                                )
                              : padding,
                          sliver: widget.mainRightChildWidget != null && isDesk
                              ? RowSliver(
                                  right: mainBody(mainChildWidget),
                                  left: SliverPersistentHeader(
                                    pinned: true,
                                    delegate: SliverHeaderWidget(
                                      // isDesk: isDesk,
                                      childWidget: ({
                                        required overlapsContent,
                                        required shrinkOffset,
                                      }) =>
                                          widget.mainRightChildWidget!,
                                      maxMinHeight: constraints.maxHeight,
                                      // isTablet: isTablet,
                                    ),
                                  ),
                                  leftWidthPercent: 0.3,
                                )
                              : mainBody(mainChildWidget),
                        ),
                      ],
                      semanticChildCount: mainChildWidget.length +
                          (titleChildWidget?.length ?? 0) +
                          1,
                      scrollController: _scrollController,
                      maxHeight: constraints.maxHeight,
                    ),
                  ),
                  // if (_isScrolled)
                  //   const Padding(
                  //     padding: EdgeInsets.only(
                  //       top: KPadding.kPaddingSize10,
                  //       right: KPadding.kPaddingSize10,
                  //     ),
                  //     child: Align(
                  //       alignment: Alignment.topRight,
                  //       child: KIcon.noInternet,
                  //     ),
                  //   ),
                ],
              ),
            ),
          );
          return Config.isWeb ? scaffold : SafeArea(child: scaffold);
        },
      ),
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
      duration: Duration(milliseconds: (_scrollController.offset / 10).toInt()),
      curve: Curves.linear,
    );
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
    super.dispose();
  }
}
