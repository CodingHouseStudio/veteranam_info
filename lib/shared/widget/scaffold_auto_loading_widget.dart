import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:veteranam/shared/shared_flutter.dart';

class ScaffoldAutoLoadingWidget extends StatefulWidget {
  const ScaffoldAutoLoadingWidget({
    required this.mainChildWidgetsFunction,
    required this.loadFunction,
    required this.loadingButtonText,
    required this.loadingStatus,
    required this.isListLoadedFull,
    this.loadDataAgain,
    this.cardListIsEmpty,
    this.titleChildWidgetsFunction,
    this.mainDeskPadding,
    // this.mainRightChildWidget,
    super.key,
    // this.resetFilter,
    this.pageName,
    this.emptyWidget,
    this.showLoadingWidget = true,
    // this.showMobileNawbar,
  });

  final List<Widget> Function({required bool isDesk})?
      titleChildWidgetsFunction;
  final List<Widget> Function({required bool isDesk}) mainChildWidgetsFunction;
  final EdgeInsetsGeometry Function({required double maxWidth})?
      mainDeskPadding;
  final void Function() loadFunction;
  // final Widget? mainRightChildWidget;
  final String loadingButtonText;
  final bool? cardListIsEmpty;
  final LoadingStatus loadingStatus;
  // final void Function()? resetFilter;
  final void Function()? loadDataAgain;
  final String? pageName;
  // final bool? showMobileNawbar;
  final Widget Function({required bool isDesk})? emptyWidget;
  final bool showLoadingWidget;
  final bool isListLoadedFull;

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
    if (!PlatformEnumFlutter.isWebDesktop) {
      _scrollController.addListener(_onScroll);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkCubit, NetworkStatus>(
      // listener: (context, state) {
      //   if (state == NetworkStatus.network) {
      //     widget.loadDataAgain?.call();
      //   }
      // },
      builder: (context, state) => LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final isDesk =
              constraints.maxWidth > KPlatformConstants.minWidthThresholdDesk;
          // final isTablet =
          //     constraints.maxWidth > KPlatformConstants.
          // minWidthThresholdTablet;

          final titleChildWidget =
              widget.titleChildWidgetsFunction?.call(isDesk: isDesk);
          final mainChildWidget = widget.mainChildWidgetsFunction(
            isDesk: isDesk,
          )..addAll(
              widget.showLoadingWidget
                  ? [
                      if ((widget.cardListIsEmpty ?? false) &&
                          widget.loadingStatus != LoadingStatus.loading &&
                          widget.emptyWidget != null)
                        widget.emptyWidget!.call(isDesk: isDesk)
                      else ...[
                        if (!widget.isListLoadedFull &&
                            PlatformEnumFlutter.isWebDesktop &&
                            !(widget.cardListIsEmpty ?? false) &&
                            widget.loadingStatus != LoadingStatus.loading)
                          LoadingButtonWidget(
                            isDesk: isDesk,
                            onPressed: widget.loadFunction,
                            text: widget.loadingButtonText,
                            widgetKey: ScaffoldKeys.loadingButton,
                          ),

                        //     ...[
                        //   KSizedBox.kHeightSizedBox100,
                        //   // const Center(child: KImage.emptyList),
                        //   Center(
                        //     child: Text(
                        //       context.l10n.cardListEmptyText,
                        //       key: ScaffoldKeys.emptyListText,
                        //       style:
                        //           AppTextStyle.
                        // materialThemeTitleMediumNeutralVariant70
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
                        if (widget.isListLoadedFull &&
                            !(widget.cardListIsEmpty ?? false) &&
                            widget.showLoadingWidget)
                          ListScrollUpWidget(
                            scrollController: _scrollController,
                          ),
                      ],
                      KSizedBox.kHeightSizedBox40,
                    ]
                  : const [],
            );

          final padding = EdgeInsets.symmetric(
            horizontal: (isDesk
                ? KPadding.kPaddingSize90 +
                    ((constraints.maxWidth >
                            KPlatformConstants.maxWidthThresholdDesk)
                        ? (constraints.maxWidth -
                                KPlatformConstants.maxWidthThresholdDesk) /
                            2
                        : 0)
                : KPadding.kPaddingSize16),
          );
          final scaffold = FocusTraversalGroup(
            child: Semantics(
              child: Stack(
                children: [
                  Scaffold(
                    resizeToAvoidBottomInset: true,
                    bottomNavigationBar: Config.isWeb
                        ? null
                        : MobNavigationWidget(
                            index: context.l10n.discounts == widget.pageName
                                ? 0
                                : 1,
                          ),
                    appBar: appBar,
                    body: KeyboardScrollView(
                      widgetKey: ScaffoldKeys.scroll,
                      // physics: KTest.scroll,
                      slivers: [
                        const NetworkBanner(),
                        if (Config.isWeb || widget.pageName != null)
                          NavigationBarWidget(
                            pageName: widget.pageName,
                            // showMobileNawbar: widget.showMobileNawbar,
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
                          sliver:
                              // widget.mainRightChildWidget != null && isDesk
                              //     ? RowSliver(
                              //         right: mainBody(mainChildWidget),
                              //         left: SliverPersistentHeader(
                              //           pinned: true,
                              //           delegate: SliverHeaderWidget(
                              //             // isDesk: isDesk,
                              //             childWidget: ({
                              //               required overlapsContent,
                              //               required shrinkOffset,
                              //             }) =>
                              //                 widget.mainRightChildWidget!,
                              //            maxMinHeight: constraints.maxHeight,
                              //             // isTablet: isTablet,
                              //           ),
                              //         ),
                              //         leftWidthPercent: 0.3,
                              //       )
                              //     :
                              mainBody(mainChildWidget),
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
          return Config.isWeb
              ? scaffold
              : ColoredBox(
                  color: AppColors.materialThemeWhite,
                  child: SafeArea(child: scaffold),
                );
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
        !widget.isListLoadedFull &&
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

  @override
  void dispose() {
    if (PlatformEnumFlutter.isWebDesktop) {
      _scrollController.dispose();
    } else {
      _scrollController
        ..removeListener(_onScroll)
        ..dispose();
    }
    super.dispose();
  }
}
