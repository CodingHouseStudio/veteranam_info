import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class ScaffoldDecorationWidget extends StatelessWidget {
  const ScaffoldDecorationWidget({
    required this.mainChildWidgetsFunction,
    this.mainDecoration,
    this.titleChildWidgetsFunction,
    super.key,
    this.mainPadding,
    this.mainDecorationPadding,
  });
  final List<Widget> Function({required bool isDesk})?
      titleChildWidgetsFunction;
  final List<Widget> Function({required bool isDesk}) mainChildWidgetsFunction;
  final EdgeInsetsGeometry Function({
    required bool isDesk,
    required double maxWidth,
  })? mainPadding;
  final EdgeInsetsGeometry Function({required bool isDesk})?
      mainDecorationPadding;
  final BoxDecoration? mainDecoration;
  @override
  Widget build(BuildContext context) {
    return _ScaffoldDecorationWidget(
      mainChildWidgetsFunction: mainChildWidgetsFunction,
      mainDecoration: mainDecoration,
      mainDecorationPadding: mainDecorationPadding,
      mainPadding: mainPadding,
      titleChildWidgetsFunction: titleChildWidgetsFunction,
    );
  }
}

class ScaffoldDecorationNetworkWidget extends StatefulWidget {
  const ScaffoldDecorationNetworkWidget({
    required this.mainChildWidgetsFunction,
    required this.loadDataAgain,
    this.mainDecoration,
    this.titleChildWidgetsFunction,
    super.key,
    this.mainPadding,
    this.mainDecorationPadding,
  });
  final List<Widget> Function({required bool isDesk})?
      titleChildWidgetsFunction;
  final List<Widget> Function({required bool isDesk}) mainChildWidgetsFunction;
  final EdgeInsetsGeometry Function({
    required bool isDesk,
    required double maxWidth,
  })? mainPadding;
  final EdgeInsetsGeometry Function({required bool isDesk})?
      mainDecorationPadding;
  final BoxDecoration? mainDecoration;
  final void Function() loadDataAgain;

  @override
  State<ScaffoldDecorationNetworkWidget> createState() =>
      _ScaffoldDecorationNetworkWidgetState();
}

class _ScaffoldDecorationNetworkWidgetState
    extends State<ScaffoldDecorationNetworkWidget> {
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
    return _ScaffoldDecorationWidget(
      mainChildWidgetsFunction: widget.mainChildWidgetsFunction,
      mainDecoration: widget.mainDecoration,
      mainDecorationPadding: widget.mainDecorationPadding,
      mainPadding: widget.mainPadding,
      titleChildWidgetsFunction: widget.titleChildWidgetsFunction,
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

class _ScaffoldDecorationWidget extends StatelessWidget {
  const _ScaffoldDecorationWidget({
    required this.mainChildWidgetsFunction,
    this.mainDecoration,
    this.titleChildWidgetsFunction,
    this.mainPadding,
    this.mainDecorationPadding,
  });
  final List<Widget> Function({required bool isDesk})?
      titleChildWidgetsFunction;
  final List<Widget> Function({required bool isDesk}) mainChildWidgetsFunction;
  final EdgeInsetsGeometry Function({
    required bool isDesk,
    required double maxWidth,
  })? mainPadding;
  final EdgeInsetsGeometry Function({required bool isDesk})?
      mainDecorationPadding;
  final BoxDecoration? mainDecoration;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final isDesk =
            constraints.maxWidth > KPlatformConstants.minWidthThresholdDesk;
        final isTablet =
            constraints.maxWidth > KPlatformConstants.minWidthThresholdTablet;
        final mainChildWidget = mainChildWidgetsFunction(
          isDesk: isDesk,
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
                  isTablet: isTablet,
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
                padding: mainPadding != null
                    ? mainPadding!(
                        isDesk: isDesk,
                        maxWidth: constraints.maxWidth,
                      ).add(padding)
                    : padding,
                sliver: DecoratedSliver(
                  decoration: mainDecoration ?? const BoxDecoration(),
                  sliver: SliverPadding(
                    padding: mainDecorationPadding != null
                        ? mainDecorationPadding!(isDesk: isDesk)
                        : EdgeInsets.zero,
                    sliver: SliverList.builder(
                      addAutomaticKeepAlives: false,
                      addRepaintBoundaries: false,
                      itemBuilder: (context, index) {
                        return mainChildWidget.elementAt(index);
                      },
                      itemCount: mainChildWidget.length,
                    ),
                  ),
                ),
              ),
              // SliverPadding(
              //   padding: padding.copyWith(
              //     bottom: KPadding.kPaddingSize40,
              //   ),
              //   sliver: DecoratedSliver(
              //     decoration: KWidgetTheme.boxDecorationFooter,
              //     sliver: SliverPadding(
              //       padding: isDesk
              //           ? const EdgeInsets.all(KPadding.kPaddingSize48)
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
              //             footerList.elementAt(index),
              //         itemCount: footerList.length,
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
}
