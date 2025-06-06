import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class ScaffoldWidget extends StatelessWidget {
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
    this.titleDeskPadding,
    this.isForm = false,
    this.bottomBarIndex,
    this.backButtonPathName,
    this.showAppBar = true,
  });
  final List<Widget> Function({required bool isDesk})?
      titleChildWidgetsFunction;
  final List<Widget> Function({required bool isDesk, required bool isTablet})
      mainChildWidgetsFunction;
  final EdgeInsetsGeometry Function({
    required double maxWidth,
  })? mainDeskPadding;
  final EdgeInsetsGeometry Function({
    required double maxWidth,
  })? titleDeskPadding;
  final bool hasFooter;
  final String? pageName;
  // final bool? showMobileNawbar;
  final bool? showMobBottomNavigation;
  final void Function()? loadDataAgain;
  final bool? showMobNawbarBackButton;
  final bool isForm;
  final int? bottomBarIndex;
  final String? backButtonPathName;
  final bool showAppBar;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkCubit, NetworkStatus>(
      // listener: (context, state) {
      //   if (state == NetworkStatus.network && loadDataAgain != null) {
      //     loadDataAgain!();
      //   }
      // },
      builder: (context, state) => LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final isDesk =
              constraints.maxWidth > KPlatformConstants.minWidthThresholdDesk;
          final isTablet =
              constraints.maxWidth > KPlatformConstants.minWidthThresholdTablet;
          final mainChildWidget = mainChildWidgetsFunction(
            isDesk: isDesk,
            isTablet: isTablet,
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
                : isTablet
                    ? KPadding.kPaddingSize32
                    : KPadding.kPaddingSize16),
          );
          //final footerWidget = <Widget>[];
          //if (hasFooter) {
          // footerWidget.addAll(
          //   FooterWidget.get(
          //     context: context,
          //     isTablet: isTablet,
          //     isDesk: isDesk,
          //   ),
          // );
          //}

          final scaffold = FocusTraversalGroup(
            // policy: WidgetOrderTraversalPolicy(),
            child: Semantics(
              child: Scaffold(
                resizeToAvoidBottomInset: true,
                bottomNavigationBar:
                    Config.isWeb || !(showMobBottomNavigation ?? true)
                        ? null
                        : MobNavigationWidget(
                            index: bottomBarIndex ?? 2,
                          ),
                appBar: appBar,
                body: KeyboardScrollView(
                  widgetKey: ScaffoldKeys.scroll,
                  //physics: KTest.scroll,
                  slivers: [
                    const NetworkBanner(),
                    if (showAppBar)
                      NavigationBarWidget(
                        pageName: pageName,
                        showMobBackButton: showMobNawbarBackButton,
                        backButtonPathName: backButtonPathName,
                        // showMobileNawbar: showMobileNawbar,
                      ),

                    if (titleChildWidgetsFunction != null)
                      SliverPadding(
                        padding: isTablet && titleDeskPadding != null
                            ? titleDeskPadding!(
                                maxWidth: constraints.maxWidth,
                              )
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
                      padding: (isForm ? isDesk : isTablet) &&
                              mainDeskPadding != null
                          ? mainDeskPadding!(
                              maxWidth: constraints.maxWidth,
                            )
                          : isForm &&
                                  !isDesk &&
                                  KMinMaxSize.formMobileMaxWidth <
                                      constraints.maxWidth
                              ? EdgeInsets.symmetric(
                                  horizontal: (constraints.maxWidth -
                                          KMinMaxSize.formMobileMaxWidth) /
                                      2,
                                )
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
                    // if (hasFooter)
                    //   SliverPadding(
                    //     padding: padding.copyWith(
                    //       bottom: KPadding.kPaddingSize40,
                    //     ),
                    //     sliver: DecoratedSliver(
                    //       decoration: KWidgetTheme.boxDecorationFooter,
                    //       sliver: SliverPadding(
                    //         padding: isDesk
                    //             ? const EdgeInsets.all(
                    //                 KPadding.kPaddingSize32,
                    //               ).copyWith(left: KPadding.kPaddingSize46)
                    //             : isTablet
                    //                 ? const EdgeInsets.all(
                    //                     KPadding.kPaddingSize46,
                    //                   )
                    //                 : const EdgeInsets.symmetric(
                    //                     vertical: KPadding.kPaddingSize32,
                    //                     horizontal: KPadding.kPaddingSize16,
                    //                   ),
                    //         sliver: SliverList.builder(
                    //           key: FooterKeys.widget,
                    //           addAutomaticKeepAlives: false,
                    //           addRepaintBoundaries: false,
                    //           itemBuilder: (context, index) =>
                    //               footerWidget.elementAt(index),
                    //           itemCount: footerWidget.length,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                  ],
                  semanticChildCount: mainChildWidget.length + 1,
                  // (hasFooter ? (footerWidget.length + 1) : 1),
                  maxHeight: constraints.maxHeight,
                ),
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
}
