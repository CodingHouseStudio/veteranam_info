import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class MobSettingsBodyWidget extends StatelessWidget {
  const MobSettingsBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      pageName: context.l10n.settings,
      mainChildWidgetsFunction: ({required isDesk, required isTablet}) => [
        KSizedBox.kHeightSizedBox16,
        Text(
          key: KWidgetkeys.screen.mobSettings.title,
          context.l10n.general,
          style: AppTextStyle.materialThemeTitleMediumNeutralVariant50,
        ),
        BoxWidget(
          key: KWidgetkeys.screen.mobSettings.faq,
          isDesk: false,
          onTap: () => context.goNamed(KRoute.mobFAQ.name),
          text: context.l10n.faq,
          textStyle: AppTextStyle.materialThemeTitleMediumBlack,
          icon: KIcon.arrowUpRight,
          padding: const EdgeInsets.only(
            left: KPadding.kPaddingSize8,
          ),
          background: AppColors.materialThemeWhite,
        ),
        KSizedBox.kHeightSizedBox8,
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: KPadding.kPaddingSize16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.language,
                style: AppTextStyle.materialThemeTitleMedium,
              ),
              LanguagesSwitcherWidget(
                key: KWidgetkeys.screen.mobSettings.languagesSwitcher,
                decoration: KWidgetTheme.boxDecorationNawbar,
                unactiveIconColor: AppColors.materialThemeWhite,
              ),
            ],
          ),
        ),
        KSizedBox.kHeightSizedBox8,
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: KPadding.kPaddingSize16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TooltipWidget(
                key: KWidgetkeys.screen.mobSettings.offlinesTitle,
                description: context.l10n.mobOfflineHint,
                text: context.l10n.offline,
                duration: const Duration(seconds: 8),
                verticalOffset: KSize.kPixel20,
              ),
              BlocBuilder<MobOfflineModeCubit, MobMode>(
                builder: (context, _) => SwitchOfflineWidget(
                  key: KWidgetkeys.screen.mobSettings.offlinesSwitcher,
                  isSelected: _.isOffline,
                  onChanged: null,
                  //  () =>
                  //     context.read<MobOfflineModeCubit>().switchMode(),
                ),
              ),
            ],
          ),
        ),
        KSizedBox.kHeightSizedBox24,
        Text(
          key: KWidgetkeys.screen.mobSettings.subtitle,
          context.l10n.contacts,
          style: AppTextStyle.materialThemeTitleMediumNeutralVariant50,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: KPadding.kPaddingSize8,
          ),
          child: TextButton(
            onPressed: context.copyEmail,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  key: KWidgetkeys.screen.mobSettings.email,
                  KAppText.email,
                  style: AppTextStyle.materialThemeTitleMedium,
                ),
                KIcon.copy,
              ],
            ),
          ),
        ),
        KSizedBox.kHeightSizedBox4,
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: KPadding.kPaddingSize16,
          ),
          child: DoubleButtonWidget(
            widgetKey: KWidgetkeys.screen.mobSettings.feedbackButton,
            text: context.l10n.contact,
            onPressed: () => context.goNamed(KRoute.feedback.name),
            darkMode: true,
            mobVerticalTextPadding: KPadding.kPaddingSize12,
            mobIconPadding: KPadding.kPaddingSize12,
            mobHorizontalTextPadding: KPadding.kPaddingSize64,
            isDesk: false,
          ),
        ),
        KSizedBox.kHeightSizedBox16,
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: KPadding.kPaddingSize16,
          ),
          child: SocialMediaLinks(
            isDesk: false,
            padding: KSizedBox.kWidthSizedBox24,
            instagramKey: KWidgetkeys.screen.mobSettings.instagramIcon,
            linkedInKey: KWidgetkeys.screen.mobSettings.linkedInIcon,
            facebookKey: KWidgetkeys.screen.mobSettings.facebookIcon,
          ),
        ),
        KSizedBox.kHeightSizedBox8,
        BoxWidget(
          key: KWidgetkeys.screen.mobSettings.bugButton,
          isDesk: false,
          onTap: () async => context.dialog.showMobFeedback(),
          text: context.l10n.reportBugs,
          textStyle: AppTextStyle.materialThemeTitleMediumBlack,
          icon: KIcon.arrowUpRight,
          padding: const EdgeInsets.only(
            left: KPadding.kPaddingSize8,
          ),
          background: AppColors.materialThemeWhite,
        ),
        KSizedBox.kHeightSizedBox8,
        const Divider(
          color: AppColors.materialThemeKeyColorsNeutral,
          height: KSize.kPixel1,
          thickness: KSize.kPixel1,
        ),
        KSizedBox.kHeightSizedBox8,
        TextButton(
          key: KWidgetkeys.screen.mobSettings.privacyPolicy,
          onPressed: () => context.goNamed(KRoute.privacyPolicy.name),
          style: KButtonStyles.withoutStyle
              .copyWith(alignment: Alignment.bottomLeft),
          child: Text(
            context.l10n.privacyPolicy,
            style: AppTextStyle.materialThemeTitleMediumNeutralVariant50,
          ),
        ),
        KSizedBox.kHeightSizedBox16,
        const InfoVersionWidget(isDesk: true),
        KSizedBox.kHeightSizedBox16,
      ],
    );

    //     appBar: AppBar(
    //       title: Container(
    //         decoration: KWidgetTheme.boxDecorationNawbar,
    //         margin: const EdgeInsets.only(
    //           top: KPadding.kPaddingSize24,
    //           left: KPadding.kPaddingSize16,
    //           right: KPadding.kPaddingSize16,
    //         ),
    //         padding: const EdgeInsets.only(
    //           left: KPadding.kPaddingSize16,
    //           right: KPadding.kPaddingSize8,
    //           top: KPadding.kPaddingSize8,
    //           bottom: KPadding.kPaddingSize8,
    //         ),
    //         child: Text(
    //           context.l10n.settings,
    //           style: AppTextStyle.materialThemeTitleMedium,
    //           textAlign: TextAlign.center,
    //         ),
    //       ),
    //     ),
  }
}
