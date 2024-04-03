import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class StoryBodyWidget extends StatelessWidget {
  const StoryBodyWidget({super.key});

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
            StoryCardWidget(
              storyDate: KMockText.date,
              userName: KMockText.userName,
              story: KMockText.cardData,
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
