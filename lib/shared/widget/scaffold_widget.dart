import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/shared/shared.dart';

class ScaffoldWidget extends StatefulWidget {
  const ScaffoldWidget({
    required this.mainChildWidgetsFunction,
    super.key,
    this.titleChildWidgetsFunction,
    this.mainDeskPadding,
    this.hasFooter = false,
    this.pageName,
    // this.showMobileNawbar,
    this.showMobBottomNavigation,
    this.loadDataAgain,
    this.showMobNawbarBackButton,
  });
  final List<Widget> Function({required bool isDesk})?
      titleChildWidgetsFunction;
  final List<Widget> Function({required bool isDesk, required bool isTablet})
      mainChildWidgetsFunction;
  final EdgeInsetsGeometry? mainDeskPadding;
  final bool hasFooter;
  final String? pageName;
  // final bool? showMobileNawbar;
  final bool? showMobBottomNavigation;
  final void Function()? loadDataAgain;
  final bool? showMobNawbarBackButton;

  @override
  State<ScaffoldWidget> createState() => _ScaffoldWidgetState();
}

class _ScaffoldWidgetState extends State<ScaffoldWidget> {
  bool offline = false;
  bool slow = false;

  @override
  void initState() {
    super.initState();
    final initialState = context.read<NetworkCubit>().state;
    _updateNetworkStatus(initialState);
  }

  void _updateNetworkStatus(NetworkStatus state) {
    setState(() {
      if (state == NetworkStatus.offline) {
        offline = true;
        slow = false;
      } else if (state == NetworkStatus.slow) {
        offline = false;
        slow = true;
      } else {
        offline = false;
        slow = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NetworkCubit, NetworkStatus>(
      listener: (context, state) {
        _updateNetworkStatus(state);
        if (state == NetworkStatus.network && widget.loadDataAgain != null) {
          widget.loadDataAgain!();
        }
      },
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final isDesk =
              constraints.maxWidth > KPlatformConstants.minWidthThresholdDesk;
          final isTablet =
              constraints.maxWidth > KPlatformConstants.minWidthThresholdTablet;
          final mainChildWidget = widget.mainChildWidgetsFunction(
            isDesk: isDesk,
            isTablet: isTablet,
          );
          final padding = EdgeInsets.symmetric(
            horizontal: (isDesk
                ? KPadding.kPaddingSize90 +
                    ((constraints.maxWidth >
                            KPlatformConstants.maxWidthThresholdTablet)
                        ? (constraints.maxWidth -
                                KPlatformConstants.maxWidthThresholdTablet) /
                            2
                        : 0)
                : isTablet
                    ? KPadding.kPaddingSize32
                    : KPadding.kPaddingSize16),
          );
          final footerWidget = <Widget>[];
          if (widget.hasFooter) {
            footerWidget.addAll(
              FooterWidget.get(
                context: context,
                isTablet: isTablet,
                isDesk: isDesk,
              ),
            );
          }
          final scaffold = FocusTraversalGroup(
            // policy: WidgetOrderTraversalPolicy(),
            child: Semantics(
              child: Scaffold(
                bottomNavigationBar:
                    KTest.testIsWeb || !(widget.showMobBottomNavigation ?? true)
                        ? null
                        : const MobNavigationWidget(
                            index: 2,
                          ),
                appBar: !KTest.testIsWeb && (offline || slow)
                    ? PreferredSize(
                        preferredSize: const Size.fromHeight(KSize.kFont48),
                        child: Column(
                          children: [
                            NetworkStatusBanner(
                              offline: offline,
                              slow: slow,
                            ),
                            AppBar(
                              backgroundColor: AppColors.materialThemeWhite,
                              toolbarHeight: KSize.kAppBarHeight,
                            ),
                          ],
                        ),
                      )
                    : AppBar(
                        backgroundColor: AppColors.materialThemeWhite,
                        toolbarHeight: KSize.kAppBarHeight,
                      ),
                body: KeyboardScrollView(
                  widgetKey: KWidgetkeys.widget.scaffold.scroll,
                  //physics: KTest.scroll,
                  slivers: [
                    SliverPersistentHeader(
                      delegate: NawbarWidget(
                        isDesk: isDesk,
                        isTablet: isTablet,
                        pageName: widget.pageName,
                        showMobBackButton: widget.showMobNawbarBackButton,
                        // showMobileNawbar: showMobileNawbar,
                      ),
                    ),
                    if (widget.titleChildWidgetsFunction != null)
                      SliverPadding(
                        padding: padding,
                        sliver: SliverList.builder(
                          addAutomaticKeepAlives: false,
                          addRepaintBoundaries: false,
                          itemBuilder: (context, index) {
                            return widget.titleChildWidgetsFunction!
                                    (isDesk: isDesk)
                                .elementAt(index);
                          },
                          itemCount: widget
                              .titleChildWidgetsFunction!(isDesk: isDesk)
                              .length,
                        ),
                      ),
                    SliverPadding(
                      padding: isDesk && widget.mainDeskPadding != null
                          ? padding.add(widget.mainDeskPadding!)
                          : padding,
                      sliver: SliverList.builder(
                        addAutomaticKeepAlives: false,
                        addRepaintBoundaries: false,
                        itemBuilder: (context, index) {
                          return mainChildWidget.elementAt(index);
                        },
                        itemCount: mainChildWidget.length,
                      ),
                    ),
                    if (widget.hasFooter)
                      SliverPadding(
                        padding: padding.copyWith(
                          bottom: KPadding.kPaddingSize40,
                        ),
                        sliver: DecoratedSliver(
                          decoration: KWidgetTheme.boxDecorationFooter,
                          sliver: SliverPadding(
                            padding: isDesk
                                ? const EdgeInsets.all(
                                    KPadding.kPaddingSize32,
                                  ).copyWith(left: KPadding.kPaddingSize46)
                                : isTablet
                                    ? const EdgeInsets.all(
                                        KPadding.kPaddingSize46,
                                      )
                                    : const EdgeInsets.symmetric(
                                        vertical: KPadding.kPaddingSize32,
                                        horizontal: KPadding.kPaddingSize16,
                                      ),
                            sliver: SliverList.builder(
                              key: KWidgetkeys.widget.footer.widget,
                              addAutomaticKeepAlives: false,
                              addRepaintBoundaries: false,
                              itemBuilder: (context, index) =>
                                  footerWidget.elementAt(index),
                              itemCount: footerWidget.length,
                            ),
                          ),
                        ),
                      ),
                  ],
                  semanticChildCount: mainChildWidget.length +
                      (widget.hasFooter ? (footerWidget.length + 1) : 1),
                  maxHeight: constraints.maxHeight,
                ),
              ),
            ),
          );
          return KTest.testIsWeb ? scaffold : SafeArea(child: scaffold);
        },
      ),
    );
  }
}
