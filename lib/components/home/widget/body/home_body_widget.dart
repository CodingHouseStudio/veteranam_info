import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({super.key});

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

        return Padding(
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
          child: ListView(
            children: [
              MessageFieldWidget(changeMessage: (_) {}),
              KSizedBox.kHeightSizedBoxM,
              const FilterBoxWidget(
                filters: KMockText.filter,
              ),
              KSizedBox.kHeightSizedBoxM,
              DropListFieldWidget(
                onChanged: (_) {},
                hintText: '',
                dropDownList: KMockText.dropDownList,
              ),
              KSizedBox.kHeightSizedBoxM,
              const QuestionWidget(
                title: KAppText.questionTitle,
                subtitle: KAppText.questionSubtitle,
              ),
              KSizedBox.kHeightSizedBoxM,
              const BoxWidget(
                text: KAppText.footerDiscountsCoupons,
              ),
              KSizedBox.kHeightSizedBoxM,
              FooterDescWidget(
                isDesktop: isDesktop,
              ),
            ],
          ),
          KSizedBox.kHeightSizedBoxM,
          const FooterDescWidget(),
          KSizedBox.kHeightSizedBoxM,
          const ProfileCardWidget(),
        ],
      ),
    );
  }
}
