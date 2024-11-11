import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/home/home.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class BoxWidgetList extends StatelessWidget {
  const BoxWidgetList({
    required this.isDesk,
    required this.isTablet,
    required this.aboutProjectKey,
    super.key,
  });
  final bool isDesk;
  final bool isTablet;
  final GlobalKey aboutProjectKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isDesk)
          KSizedBox.kHeightSizedBox36
        else
          KSizedBox.kHeightSizedBox16,
        if (isTablet)
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  flex: isDesk ? 3 : 2,
                  child: HomeBoxWidget(
                    aboutProjectKey: aboutProjectKey,
                    isDesk: isDesk,
                    isTablet: true,
                  ),
                ),
                KSizedBox.kWidthSizedBox24,
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: DiscountBoxwWidget(
                          key: KWidgetkeys.screen.home.discountsBox,
                          isTablet: true,
                        ),
                      ),
                      KSizedBox.kHeightSizedBox16,
                      Expanded(
                        flex: 2,
                        child: DoubleBox(
                          context: context,
                          textIconPaddingWidget: const Spacer(),
                          isTablet: isTablet,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        else ...[
          HomeBoxWidget(
            aboutProjectKey: aboutProjectKey,
            isDesk: false,
            isTablet: false,
          ),
          KSizedBox.kHeightSizedBox16,
          DiscountBoxwWidget(
            key: KWidgetkeys.screen.home.discountsBox,
            isTablet: false,
          ),
          KSizedBox.kHeightSizedBox16,
          DoubleBox(
            context: context,
            isTablet: isTablet,
          ),
        ],
        KSizedBox.kHeightSizedBox16,
        if (Config.isDevelopment)
          if (isTablet)
            Row(
              children: [
                Expanded(
                  child: BoxWidget(
                    key: KWidgetkeys.screen.home.informationBox,
                    text: context.l10n.information,
                    onTap: () => context.goNamed(KRoute.information.name),
                    isDesk: true,
                    icon: KIcon.globe,
                  ),
                ),
                KSizedBox.kWidthSizedBox24,
                Expanded(
                  child: BoxWidget(
                    key: KWidgetkeys.screen.home.storyBox,
                    text: context.l10n.stories,
                    onTap: () => context.goNamed(KRoute.stories.name),
                    isDesk: true,
                    icon: KIcon.messageSquare,
                  ),
                ),
                KSizedBox.kWidthSizedBox24,
                Expanded(
                  child: BoxWidget(
                    key: KWidgetkeys.screen.home.workBox,
                    text: context.l10n.work,
                    onTap: () => context.goNamed(KRoute.work.name),
                    isDesk: true,
                    icon: KIcon.briefcase,
                  ),
                ),
              ],
            )
          else ...[
            BoxWidget(
              key: KWidgetkeys.screen.home.informationBox,
              text: context.l10n.information,
              onTap: () => context.goNamed(KRoute.information.name),
              isDesk: false,
              icon: KIcon.globe,
            ),
            KSizedBox.kHeightSizedBox16,
            BoxWidget(
              key: KWidgetkeys.screen.home.storyBox,
              text: context.l10n.stories,
              onTap: () => context.goNamed(KRoute.stories.name),
              isDesk: false,
              icon: KIcon.messageSquare,
            ),
            KSizedBox.kHeightSizedBox16,
            BoxWidget(
              key: KWidgetkeys.screen.home.workBox,
              text: context.l10n.work,
              onTap: () => context.goNamed(KRoute.work.name),
              isDesk: false,
              icon: KIcon.briefcase,
            ),
          ],
      ],
    );
  }
}

class DoubleBox extends StatelessWidget {
  const DoubleBox({
    required this.context,
    required this.isTablet,
    super.key,
    this.textIconPaddingWidget,
  });
  final BuildContext context;
  final bool isTablet;
  final Widget? textIconPaddingWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: isTablet ? 5 : 4,
          child: BoxWidget(
            key: KWidgetkeys.screen.home.investorsBox,
            text: context.l10n.investors,
            onTap: () => context.goNamed(KRoute.support.name),
            isDesk: true,
            iconHasBackground: false,
            textIconPaddingWidget: textIconPaddingWidget,
            background: AppColors.materialThemeKeyColorsNeutralVariant,
            iconText: context.l10n.supportVeterans,
            textStyle: isTablet
                ? AppTextStyle.materialThemeHeadlineSmall
                : AppTextStyle.materialThemeTitleLarge,
            padding: isTablet
                ? null
                : const EdgeInsets.only(
                    top: KPadding.kPaddingSize16,
                    right: KPadding.kPaddingSize16,
                    bottom: KPadding.kPaddingSize8,
                    left: KPadding.kPaddingSize16,
                  ),
          ),
        ),
        KSizedBox.kWidthSizedBox16,
        Expanded(
          flex: 4,
          child: BoxWidget(
            key: KWidgetkeys.screen.home.feedbackBox,
            text: context.l10n.contacts,
            onTap: () => context.goNamed(KRoute.feedback.name),
            isDesk: true,
            icon: KIcon.fileText,
            iconHasBackground: false,
            textIconPaddingWidget: textIconPaddingWidget,
            iconText: context.l10n.haveQuestions,
            textStyle: isTablet
                ? AppTextStyle.materialThemeHeadlineSmall
                : AppTextStyle.materialThemeTitleLarge,
            padding: isTablet
                ? null
                : const EdgeInsets.only(
                    top: KPadding.kPaddingSize16,
                    right: KPadding.kPaddingSize16,
                    bottom: KPadding.kPaddingSize8,
                    left: KPadding.kPaddingSize16,
                  ),
          ),
        ),
      ],
    );
  }
}
