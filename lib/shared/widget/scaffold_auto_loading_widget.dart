import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class ScaffoldAutoLoadingWidget extends StatelessWidget {
  const ScaffoldAutoLoadingWidget({
    required this.mainChildWidgetsFunction,
    required this.scrollFunction,
    required this.loadingButtonText,
    super.key,
    this.titleChildWidgetsFunction,
    this.mainDeskPadding,
    this.mainRightChildWidget,
  });
  final List<Widget> Function({required bool isDesk})?
      titleChildWidgetsFunction;
  final List<Widget> Function({required bool isDesk}) mainChildWidgetsFunction;
  final EdgeInsetsGeometry? mainDeskPadding;
  final void Function() scrollFunction;
  final Widget? mainRightChildWidget;
  final String loadingButtonText;

  @override
  Widget build(BuildContext context) {
    if (KPlatformConstants.isWebDesktop) {
      return _ScaffoldAutoLoadingWidgetDesk(
        mainChildWidgetsFunction: mainChildWidgetsFunction,
        loadFunction: scrollFunction,
        mainDeskPadding: mainDeskPadding,
        mainRightChildWidget: mainRightChildWidget,
        titleChildWidgetsFunction: titleChildWidgetsFunction,
        loadingButtonText: loadingButtonText,
      );
    } else {
      return _ScaffoldAutoLoadingWidgetMobile(
        mainChildWidgetsFunction: mainChildWidgetsFunction,
        scrollFunction: scrollFunction,
        mainDeskPadding: mainDeskPadding,
        mainRightChildWidget: mainRightChildWidget,
        titleChildWidgetsFunction: titleChildWidgetsFunction,
      );
    }
  }
}

class _ScaffoldAutoLoadingWidgetMobile extends StatefulWidget {
  const _ScaffoldAutoLoadingWidgetMobile({
    required this.mainChildWidgetsFunction,
    required this.scrollFunction,
    this.titleChildWidgetsFunction,
    this.mainDeskPadding,
    this.mainRightChildWidget,
  });
  final List<Widget> Function({required bool isDesk})?
      titleChildWidgetsFunction;
  final List<Widget> Function({required bool isDesk}) mainChildWidgetsFunction;
  final EdgeInsetsGeometry? mainDeskPadding;
  final void Function() scrollFunction;
  final Widget? mainRightChildWidget;

  @override
  State<_ScaffoldAutoLoadingWidgetMobile> createState() =>
      _ScaffoldAutoLoadingWidgetMobileState();
}

class _ScaffoldAutoLoadingWidgetMobileState
    extends State<_ScaffoldAutoLoadingWidgetMobile> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final isDesk =
            constraints.maxWidth > KPlatformConstants.minWidthThresholdDesk;
        final mainChildWidget = widget.mainChildWidgetsFunction(isDesk: isDesk);
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
        // final footerList = FooterWidget.get(
        //   context: context,
        //   isDesk: isDesk,
        // );
        return Scaffold(
          body: CustomScrollView(
            key: KWidgetkeys.widget.scaffold.scroll,
            slivers: [
              SliverPersistentHeader(
                delegate: NawbarWidget(
                  isDesk: isDesk,
                ),
              ),
              if (widget.titleChildWidgetsFunction != null)
                SliverPadding(
                  padding: padding,
                  sliver: SliverList.builder(
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
                    itemBuilder: (context, index) {
                      return widget.titleChildWidgetsFunction!(isDesk: isDesk)
                          .elementAt(index);
                    },
                    itemCount: widget
                        .titleChildWidgetsFunction!(isDesk: isDesk).length,
                  ),
                ),

              SliverPadding(
                padding: isDesk && widget.mainDeskPadding != null
                    ? padding.add(widget.mainDeskPadding!)
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
                          ),
                        ),
                        leftWidthPercent: 0.3,
                      )
                    : mainBody(mainChildWidget),
              ),
              // SliverPadding(
              //   padding: padding.copyWith(
              //     bottom: KPadding.kPaddingSize40,
              //   ),
              //   sliver: DecoratedSliver(
              //     decoration: KWidgetTheme.boxDecorationFooter,
              //     sliver: SliverPadding(
              //       padding: isDesk
              //           ? const EdgeInsets.all(KPadding.kPaddingSize32)
              //               .copyWith(left: KPadding.kPaddingSize46)
              //           : const EdgeInsets.symmetric(
              //               vertical: KPadding.kPaddingSize32,
              //               horizontal: KPadding.kPaddingSize16,
              //             ),
              //       sliver: SliverList.builder(
              //         key: KWidgetkeys.widget.footer.widget,
              //         addAutomaticKeepAlives: false,
              //         addRepaintBoundaries: false,
              //         itemBuilder: (context, index) =>
              //             footerWidget.elementAt(index),
              //         itemCount: footerWidget.length,
              //       ),
              //     ),
              //   ),
              // ),
            ],
            semanticChildCount: mainChildWidget.length + 1,
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

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) widget.scrollFunction();
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}

class _ScaffoldAutoLoadingWidgetDesk extends StatelessWidget {
  const _ScaffoldAutoLoadingWidgetDesk({
    required this.mainChildWidgetsFunction,
    required this.loadFunction,
    required this.loadingButtonText,
    this.titleChildWidgetsFunction,
    this.mainDeskPadding,
    this.mainRightChildWidget,
  });
  final List<Widget> Function({required bool isDesk})?
      titleChildWidgetsFunction;
  final List<Widget> Function({required bool isDesk}) mainChildWidgetsFunction;
  final EdgeInsetsGeometry? mainDeskPadding;
  final void Function() loadFunction;
  final Widget? mainRightChildWidget;
  final String loadingButtonText;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final isDesk =
            constraints.maxWidth > KPlatformConstants.minWidthThresholdTablet;
        final mainChildWidget = mainChildWidgetsFunction(isDesk: isDesk)
          ..addAll([
            LoadingButton(
              isDesk: isDesk,
              onPressed: loadFunction,
              text: loadingButtonText,
              widgetKey: KWidgetkeys.widget.scaffold.loadingButton,
            ),
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
        // final footerList = FooterWidget.get(
        //   context: context,
        //   isDesk: isDesk,
        // );
        return Scaffold(
          body: CustomScrollView(
            key: KWidgetkeys.widget.scaffold.scroll,
            slivers: [
              SliverPersistentHeader(
                delegate: NawbarWidget(
                  isDesk: isDesk,
                ),
              ),
              if (titleChildWidgetsFunction != null)
                SliverPadding(
                  padding: padding,
                  sliver: SliverList.builder(
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
                    itemBuilder: (context, index) {
                      return titleChildWidgetsFunction!(isDesk: isDesk)
                          .elementAt(index);
                    },
                    itemCount:
                        titleChildWidgetsFunction!(isDesk: isDesk).length,
                  ),
                ),

              SliverPadding(
                padding: isDesk && mainDeskPadding != null
                    ? padding.add(mainDeskPadding!)
                    : padding,
                sliver: mainRightChildWidget != null && isDesk
                    ? RowSliver(
                        right: mainBody(mainChildWidget),
                        left: SliverPersistentHeader(
                          pinned: true,
                          delegate: NawbarWidget(
                            isDesk: isDesk,
                            childWidget: mainRightChildWidget,
                            maxMinHeight: constraints.maxHeight,
                          ),
                        ),
                        leftWidthPercent: 0.3,
                      )
                    : mainBody(mainChildWidget),
              ),
              // SliverPadding(
              //   padding: padding.copyWith(
              //     bottom: KPadding.kPaddingSize40,
              //   ),
              //   sliver: DecoratedSliver(
              //     decoration: KWidgetTheme.boxDecorationFooter,
              //     sliver: SliverPadding(
              //       padding: isDesk
              //           ? const EdgeInsets.all(KPadding.kPaddingSize32)
              //               .copyWith(left: KPadding.kPaddingSize46)
              //           : const EdgeInsets.symmetric(
              //               vertical: KPadding.kPaddingSize32,
              //               horizontal: KPadding.kPaddingSize16,
              //             ),
              //       sliver: SliverList.builder(
              //         key: KWidgetkeys.widget.footer.widget,
              //         addAutomaticKeepAlives: false,
              //         addRepaintBoundaries: false,
              //         itemBuilder: (context, index) =>
              //             footerWidget.elementAt(index),
              //         itemCount: footerWidget.length,
              //       ),
              //     ),
              //   ),
              // ),
            ],
            semanticChildCount: mainChildWidget.length + 1,
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
}
