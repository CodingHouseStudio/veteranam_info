import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

/// COMMENT: Сlass adds common elements to all screens
class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.childWidgetsFunction,
    super.key,
    this.hasMic = true,
  });
  final List<Widget> Function({required bool isDesk}) childWidgetsFunction;
  final bool hasMic;

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
        final childWidgets = childWidgetsFunction(isDesk: isDesk)
          ..add(
            FooterWidget(
              isDesk: isDesk,
            ),
          );
        return Scaffold(
          // extendBodyBehindAppBar: true,
          appBar: NawbarWidget(
            isDesk: isDesk,
            hasMicrophone: hasMic,
          ),
          body: ListView.builder(
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
            itemCount: childWidgets.length,
            itemBuilder: (context, index) => childWidgets.elementAt(index),
          ),
        );
      },
    );
  }
}
