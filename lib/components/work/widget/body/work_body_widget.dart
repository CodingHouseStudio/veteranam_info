import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class WorkBodyWidget extends StatelessWidget {
  const WorkBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final isMobile =
            constraints.maxWidth < KPlatformConstants.minWidthThresholdMobile;
        final isTablet = constraints.maxWidth >=
                KPlatformConstants.minWidthThresholdMobile &&
            constraints.maxWidth < KPlatformConstants.minWidthThresholdDesktop;
        final isDesktop =
            constraints.maxWidth > KPlatformConstants.minWidthThresholdDesktop;

        return ListView(
           padding: EdgeInsets.only(
          top: KPadding.kPaddingSizeS,
          left: KPadding.kPaddingSizeXXL *
              (isMobile
                  ? KPlatformConstants.mobilePaddingKoefficient
                  : (isTablet
                      ? KPlatformConstants.tabletPaddingKoefficient
                      : KPlatformConstants.desktopPaddingKoefficient)),
          right: KPadding.kPaddingSizeXXL *
              (isMobile
                  ? KPlatformConstants.mobilePaddingKoefficient
                  : (isTablet
                      ? KPlatformConstants.tabletPaddingKoefficient
                      : KPlatformConstants.desktopPaddingKoefficient)),
        ),
          children: [
            const WorkCardWidget(
              title: KMockText.workTitle,
              city: KMockText.workCity,
              price: KMockText.workPrice,
              description: KMockText.workDescription,
              employer: KMockText.workEmployer,
            ),
            FooterDescWidget(
              isDesktop: isDesktop,
            ),
          ],
        );
      },
    );
  }
}
