import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.navigationShell,
    // required this.goRouterState,
    super.key,
  });
  final Widget navigationShell;
  // final GoRouterState goRouterState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NawbarWidget(),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final isMobile =
              constraints.maxWidth < KPlatformConstants.minWidthThresholdMobile;
          final isTablet = constraints.maxWidth >=
                  KPlatformConstants.minWidthThresholdMobile &&
              constraints.maxWidth <
                  KPlatformConstants.minWidthThresholdDesktop;
          final isDesk = constraints.maxWidth >
              KPlatformConstants.minWidthThresholdDesktop;

          return ListView(
            padding: EdgeInsets.only(
              top: KPadding.kPaddingSize10,
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
            ),
            children: [
              navigationShell,
              FooterWidget(
                isDesktop: isDesk,
              ),
            ],
          );
        },
      ),
    );
  }
}
