import 'package:flutter/material.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile =
            constraints.maxWidth < KPlatformConstants.minWidthThresholdMobile;
        final isTablet = constraints.maxWidth >=
                KPlatformConstants.minWidthThresholdMobile &&
            constraints.maxWidth < KPlatformConstants.minWidthThresholdDesktop;
        final isDesk =
            KPlatformConstants.changeToDescWidget(constraints.maxWidth);
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: NawbarWidget(
            isDesk: isDesk,
            hasMicrophone: false,
          ),
          body: HomeBlocprovider(
            key: KWidgetkeys.screen.home.screen,
            childWidget: Padding(
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
              ),
              child: HomeBodyWidget(
                isDesk: isDesk,
              ),
            ),
          ),
        );
      },
    );
  }
}
