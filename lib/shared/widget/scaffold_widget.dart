import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared.dart';

class ScaffoldWidget extends StatelessWidget {
  const ScaffoldWidget({
    required this.mainChildWidgetsFunction,
    this.titleChildWidgetsFunction,
    super.key,
    this.mainDeskPadding,
    this.hasFooter = false,
    this.showMobBottomNavigation,
    this.pageName,
  });
  final List<Widget> Function({required bool isDesk})?
      titleChildWidgetsFunction;
  final List<Widget> Function({required bool isDesk, required bool isTablet})
      mainChildWidgetsFunction;
  final EdgeInsetsGeometry? mainDeskPadding;
  final bool hasFooter;
  final bool? showMobBottomNavigation;
  final String? pageName;

  @override
  Widget build(BuildContext context) {
    return _ScaffoldWidget(
      mainChildWidgetsFunction: mainChildWidgetsFunction,
      hasFooter: hasFooter,
      mainDeskPadding: mainDeskPadding,
      titleChildWidgetsFunction: titleChildWidgetsFunction,
      showMobBottomNavigation: showMobBottomNavigation,
      pageName: pageName,
    );
  }
}

class ScaffoldNetworkWidget extends StatefulWidget {
  const ScaffoldNetworkWidget({
    required this.mainChildWidgetsFunction,
    required this.loadDataAgain,
    this.showMobileNawbar,
    this.titleChildWidgetsFunction,
    super.key,
    this.mainDeskPadding,
    this.hasFooter = false,
    this.pageName,
  });
  final List<Widget> Function({required bool isDesk})?
      titleChildWidgetsFunction;
  final List<Widget> Function({required bool isDesk, required bool isTablet})
      mainChildWidgetsFunction;
  final EdgeInsetsGeometry? mainDeskPadding;
  final bool hasFooter;
  final void Function() loadDataAgain;
  final String? pageName;
  final bool? showMobileNawbar;

  @override
  State<ScaffoldNetworkWidget> createState() => _ScaffoldNetworkWidgetState();
}

class _ScaffoldNetworkWidgetState extends State<ScaffoldNetworkWidget> {
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  late Connectivity _connectivity;

  @override
  void initState() {
    super.initState();
    _connectivity = Connectivity();
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  Widget build(BuildContext context) {
    return _ScaffoldWidget(
      mainChildWidgetsFunction: widget.mainChildWidgetsFunction,
      hasFooter: widget.hasFooter,
      mainDeskPadding: widget.mainDeskPadding,
      titleChildWidgetsFunction: widget.titleChildWidgetsFunction,
      pageName: widget.pageName,
      showMobileNawbar: widget.showMobileNawbar,
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
    _connectivitySubscription.cancel();
    super.dispose();
  }
}

class _ScaffoldWidget extends StatelessWidget {
  const _ScaffoldWidget({
    required this.mainChildWidgetsFunction,
    this.titleChildWidgetsFunction,
    this.mainDeskPadding,
    this.hasFooter = false,
    this.pageName,
    this.showMobileNawbar,
    this.showMobBottomNavigation,
  });
  final List<Widget> Function({required bool isDesk})?
      titleChildWidgetsFunction;
  final List<Widget> Function({required bool isDesk, required bool isTablet})
      mainChildWidgetsFunction;
  final EdgeInsetsGeometry? mainDeskPadding;
  final bool hasFooter;
  final String? pageName;
  final bool? showMobileNawbar;
  final bool? showMobBottomNavigation;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final isDesk =
            constraints.maxWidth > KPlatformConstants.minWidthThresholdDesk;
        final isTablet =
            constraints.maxWidth > KPlatformConstants.minWidthThresholdTablet;
        final mainChildWidget =
            mainChildWidgetsFunction(isDesk: isDesk, isTablet: isTablet);
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
        if (hasFooter) {
          footerWidget.addAll(
            FooterWidget.get(
              context: context,
              isTablet: isTablet,
              isDesk: isDesk,
            ),
          );
        }
        final route = [
          KRoute.discounts.name,
          KRoute.investors.name,
          KRoute.home.name,
        ];
        final scaffold = Scaffold(
          bottomNavigationBar:
              KTest.testIsWeb || !(showMobBottomNavigation ?? true)
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
                      currentIndex: 2,
                      onTap: (i) => context.goNamed(route.elementAt(i)),
                    ),
          body: CustomScrollView(
            key: KWidgetkeys.widget.scaffold.scroll,
            // dragStartBehavior: DragStartBehavior.down,
            physics: KTest.scroll,
            slivers: [
              SliverPersistentHeader(
                delegate: NawbarWidget(
                  isDesk: isDesk,
                  isTablet: isTablet,
                  pageName: pageName,
                  showMobileNawbar: showMobileNawbar,
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
                sliver: SliverList.builder(
                  addAutomaticKeepAlives: false,
                  addRepaintBoundaries: false,
                  itemBuilder: (context, index) {
                    return mainChildWidget.elementAt(index);
                  },
                  itemCount: mainChildWidget.length,
                ),
              ),
              if (hasFooter)
                SliverPadding(
                  padding: padding.copyWith(
                    bottom: KPadding.kPaddingSize40,
                  ),
                  sliver: DecoratedSliver(
                    decoration: KWidgetTheme.boxDecorationFooter,
                    sliver: SliverPadding(
                      padding: isDesk
                          ? const EdgeInsets.all(KPadding.kPaddingSize32)
                              .copyWith(left: KPadding.kPaddingSize46)
                          : isTablet
                              ? const EdgeInsets.all(KPadding.kPaddingSize46)
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
                (hasFooter ? (footerWidget.length + 1) : 1),
          ),
        );
        return KTest.testIsWeb ? scaffold : SafeArea(child: scaffold);
      },
    );
  }
}
