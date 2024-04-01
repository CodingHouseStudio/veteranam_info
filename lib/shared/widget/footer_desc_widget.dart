import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/shared/shared.dart';

class FooterDescWidget extends StatelessWidget {
  const FooterDescWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: KBorderRadius.kBorderRadiusM,
        color: AppColors.widgetBackground,
      ),
      child: Padding(
        padding: const EdgeInsets.all(KPadding.kPaddingSizeXL),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextButton(
                    key: KWidgetkeys.footerKeys.aboutUsButton,
                    style: KButtonStyles.transparentButtonStyle,
                    onPressed: () {},
                    child: const Text(
                      KAppText.footerAboutUs,
                      style: AppTextStyle.lableMediumLarge,
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    key: KWidgetkeys.footerKeys.storyButton,
                    style: KButtonStyles.transparentButtonStyle,
                    onPressed: () {
                      context.go('${KRoute.home.path}${KRoute.story.path}');
                    },
                    child: const Text(
                      KAppText.footerStories,
                      style: AppTextStyle.lableMediumLarge,
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    key: KWidgetkeys.footerKeys.workButton,
                    style: KButtonStyles.transparentButtonStyle,
                    onPressed: () {
                      context.go('${KRoute.home.path}${KRoute.work.path}');
                    },
                    child: const Text(
                      KAppText.footerWork,
                      style: AppTextStyle.lableMediumLarge,
                    ),
                  ),
                ),
              ],
            ),
            KSizedBox.kHeightSizedBoxM,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextButton(
                    key: KWidgetkeys.footerKeys.contactButton,
                    style: KButtonStyles.transparentButtonStyle,
                    onPressed: () {},
                    child: const Text(
                      KAppText.footerContact,
                      style: AppTextStyle.lableMediumLarge,
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    key: KWidgetkeys.footerKeys.discountsButton,
                    style: KButtonStyles.transparentButtonStyle,
                    onPressed: () {
                      context.go('${KRoute.home.path}${KRoute.discounts.path}');
                    },
                    child: const Text(
                      KAppText.footerDiscountsCoupons,
                      style: AppTextStyle.lableMediumLarge,
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    key: KWidgetkeys.footerKeys.informationButton,
                    style: KButtonStyles.transparentButtonStyle,
                    onPressed: () {
                      context
                          .go('${KRoute.home.path}${KRoute.information.path}');
                    },
                    child: const Text(
                      KAppText.footerInformation,
                      style: AppTextStyle.lableMediumLarge,
                    ),
                  ),
                ),
              ],
            ),
            KSizedBox.kHeightSizedBoxM,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextButton(
                    key: KWidgetkeys.footerKeys.consultationOnlineButton,
                    style: KButtonStyles.transparentButtonStyle,
                    onPressed: () {},
                    child: const Text(
                      KAppText.footerConsultationOnline,
                      style: AppTextStyle.lableMediumLarge,
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    key: KWidgetkeys.footerKeys.profileButton,
                    style: KButtonStyles.transparentButtonStyle,
                    onPressed: () {
                      context.go('${KRoute.home.path}${KRoute.profile.path}');
                    },
                    child: const Text(
                      KAppText.footerMyProfiel,
                      style: AppTextStyle.lableMediumLarge,
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    key: KWidgetkeys.footerKeys.investorsButton,
                    style: KButtonStyles.transparentButtonStyle,
                    onPressed: () {
                      context.go('${KRoute.home.path}${KRoute.investors.path}');
                    },
                    child: const Text(
                      KAppText.footerForInvestors,
                      style: AppTextStyle.lableMediumLarge,
                    ),
                  ),
                ),
              ],
            ),
            KSizedBox.kHeightSizedBoxML,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconWidget(
                  key: KWidgetkeys.footerKeys.likedInIcon,
                  icon: KIcon.linkedIn,
                ),
                KSizedBox.kWidthSizedBoxSM,
                IconWidget(
                  key: KWidgetkeys.footerKeys.instagramIcon,
                  icon: KIcon.instagram,
                ),
                KSizedBox.kWidthSizedBoxSM,
                IconWidget(
                  key: KWidgetkeys.footerKeys.facebookIcon,
                  icon: KIcon.facebook,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
