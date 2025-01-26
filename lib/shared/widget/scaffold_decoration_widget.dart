import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class ScaffoldDecorationWidget extends StatelessWidget {
  const ScaffoldDecorationWidget({
    required this.mainChildWidgetsFunction,
    super.key,
    this.mainDecoration,
    this.titleChildWidgetsFunction,
    this.mainPadding,
    this.mainDecorationPadding,
    this.backButtonPathName,
    // this.loadDataAgain,
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
  final String? backButtonPathName;
  // final void Function()? loadDataAgain;

  @override
  Widget build(BuildContext context) {
    return
        // BlocListener<NetworkCubit, NetworkStatus>(
        //   listener: (context, state) {
        //     if (state == NetworkStatus.network && loadDataAgain != null) {
        //       loadDataAgain!();
        //     }
        //   },
        //   child:
        LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final isDesk =
            constraints.maxWidth > KPlatformConstants.minWidthThresholdDesk;
        // final isTablet =
        //     constraints.maxWidth >
        // KPlatformConstants.minWidthThresholdTablet;
        final mainChildWidget = mainChildWidgetsFunction(
          isDesk: isDesk,
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
        // final footerList = FooterWidget.get(
        //   context: context,
        //   isDesk: isDesk,
        // );
        return FocusTraversalGroup(
          child: Semantics(
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: appBar,
              body: KeyboardScrollView(
                widgetKey: ScaffoldKeys.scroll,
                slivers: [
                  NavigationBarWidget(
                    backButtonPathName: backButtonPathName,
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
                          ) //.add(padding)
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
                  //           ?
                  //const EdgeInsets.all(KPadding.kPaddingSize48)
                  //               .copyWith(left: KPadding.kPaddingSize46)
                  //           : const EdgeInsets.symmetric(
                  //               vertical: KPadding.kPaddingSize32,
                  //               horizontal: KPadding.kPaddingSize16,
                  //             ),
                  //       sliver: SliverList.builder(
                  //         key: FooterKeys.widget,
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
                maxHeight: constraints.maxHeight,
              ),
            ),
          ),
        );
      },
      // ),
    );
  }
}
