import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/shared/shared.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.navigationShell,
    required this.goRouterState,
    super.key,
  });
  final Widget navigationShell;
  final GoRouterState goRouterState;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final isMobile =
            constraints.maxWidth < KPlatformConstants.minWidthThresholdMobile;
        final isTablet = constraints.maxWidth >=
                KPlatformConstants.minWidthThresholdMobile &&
            constraints.maxWidth < KPlatformConstants.minWidthThresholdDesktop;
        final isDesk =
            constraints.maxWidth > KPlatformConstants.minWidthThresholdDesktop;
        return Scaffold(
          appBar: NawbarWidget(
            isDesk: isDesk,
            padding: padding,
            hasMicrophone: goRouterState.fullPath != KRoute.home.path,
          ),
          body: ListView(
            key: KWidgetkeys.widget.shellRoute.scroll,
            padding: EdgeInsets.only(
              left: KPadding.kPaddingSize75 *
                  (isMobile
                      ? KPlatformConstants.mobilePaddingKoefficient
                      : (isTablet
                          ? KPlatformConstants.tabletPaddingKoefficient
                          : KPlatformConstants.desktopPaddingKoefficient)),
              right: KPadding.kPaddingSize75 *
                  (isMobile
                      ? KPlatformConstants.mobilePaddingKoefficient
                      : (isTablet
                          ? KPlatformConstants.tabletPaddingKoefficient
                          : KPlatformConstants.desktopPaddingKoefficient)),
              top: KPadding.kPaddingSize10,
            ),
            children: [
              navigationShell,
              FooterWidget(
                isDesktop: isDesk,
              ),
            ],
          ),
        );
      },
    );
  }
}
