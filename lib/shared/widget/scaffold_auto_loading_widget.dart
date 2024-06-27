import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class ScaffoldAutoLoadingWidget extends StatefulWidget {
  const ScaffoldAutoLoadingWidget({
    required this.mainChildWidgetsFunction,
    required this.scrollFunction,
    this.titleChildWidgetsFunction,
    super.key,
    this.mainDeskPadding,
    this.mainRightChildWidget,
  });
  final List<Widget> Function({required bool isDesk})?
      titleChildWidgetsFunction;
  final List<Widget> Function({required bool isDesk}) mainChildWidgetsFunction;
  final EdgeInsetsGeometry Function({required double maxWidth})?
      mainDeskPadding;
  final void Function() scrollFunction;
  final Widget? mainRightChildWidget;

  @override
  State<ScaffoldAutoLoadingWidget> createState() =>
      _ScaffoldAutoLoadingWidgetState();
}

class _ScaffoldAutoLoadingWidgetState extends State<ScaffoldAutoLoadingWidget> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final isDesk =
            constraints.maxWidth > KPlatformConstants.minWidthThresholdTablet;
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
