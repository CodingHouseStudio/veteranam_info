import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class ScaffoldDecorationWidget extends StatelessWidget {
  const ScaffoldDecorationWidget({
    required this.mainChildWidgetsFunction,
    super.key,
    this.mainDecoration,
    this.titleChildWidgetsFunction,
    this.mainPadding,
    this.mainDecorationPadding,
    this.titlePadding,
    // this.loadDataAgain,
  });
  final List<Widget> Function({required bool isDesk})?
      titleChildWidgetsFunction;
  final List<Widget> Function({required bool isDesk}) mainChildWidgetsFunction;
  final EdgeInsetsGeometry Function({
    required bool isDesk,
    required double maxWidth,
  })? mainPadding;
  final EdgeInsetsGeometry Function({
    required bool isDesk,
    required double maxWidth,
  })? titlePadding;
  final EdgeInsetsGeometry Function({required bool isDesk})?
      mainDecorationPadding;
  final BoxDecoration? mainDecoration;
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
        return FocusTraversalGroup(
          child: Semantics(
            child: Scaffold(
              resizeToAvoidBottomInset: !Config.isWeb,
              appBar: AppBar(
                backgroundColor: AppColors.materialThemeWhite,
                toolbarHeight: KSize.kAppBarHeight,
              ),
              body: KeyboardScrollView(
                widgetKey: KWidgetkeys.widget.scaffold.scroll,
                slivers: [
                  SliverPersistentHeader(
                    delegate: NawbarWidget.getSliverHeader(
                      isDesk: isDesk,
                      isTablet: isTablet,
                    ),
                  ),
                  if (titleChildWidgetsFunction != null)
                    SliverPadding(
                      padding: titlePadding != null
                          ? titlePadding!(
                              isDesk: isDesk,
                              maxWidth: constraints.maxWidth,
                            ) //.add(padding)
                          : padding,
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
