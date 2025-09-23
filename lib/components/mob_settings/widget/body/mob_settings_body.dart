import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class MobSettingsBodyWidget extends StatelessWidget {
  const MobSettingsBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BadgerControllerWidget(),
        Expanded(
          child: ScaffoldWidget(
            pageName: context.l10n.settings,
            mainChildWidgetsFunction: ({required isDesk, required isTablet}) =>
                [
              KSizedBox.kHeightSizedBox16,
              Text(
                key: MobSettingsKeys.title,
                context.l10n.general,
                style: AppTextStyle.materialThemeTitleMediumNeutralVariant50,
              ),
              BoxWidget(
                key: MobSettingsKeys.faq,
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
                    const LanguagesSwitcherWidget(
                      key: MobSettingsKeys.languagesSwitcher,
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
                      key: MobSettingsKeys.offlinesTitle,
                      description: context.l10n.mobOfflineHint,
                      text: context.l10n.offline,
                      duration: const Duration(seconds: 8),
                      verticalOffset: KSize.kPixel20,
                    ),
                    BlocBuilder<MobOfflineModeCubit, MobMode>(
                      builder: (context, _) => SwitchOfflineWidget(
                        key: MobSettingsKeys.offlinesSwitcher,
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
                key: MobSettingsKeys.subtitle,
                context.l10n.contacts,
                style: AppTextStyle.materialThemeTitleMediumNeutralVariant50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: KPadding.kPaddingSize8,
                ),
                child: TextButton(
                  onPressed: context.copyEmail,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        key: MobSettingsKeys.email,
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
                  widgetKey: MobSettingsKeys.feedbackButton,
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
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: KPadding.kPaddingSize16,
                ),
                child: SocialMediaLinks(
                  isDesk: false,
                  instagramKey: MobSettingsKeys.instagramIcon,
                  linkedInKey: MobSettingsKeys.linkedInIcon,
                  facebookKey: MobSettingsKeys.facebookIcon,
                ),
              ),
              KSizedBox.kHeightSizedBox8,
              BoxWidget(
                key: MobSettingsKeys.bugButton,
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
                color: AppColors.materialThemeRefNeutralNeutral90,
                height: KSize.kPixel1,
                thickness: KSize.kPixel1,
              ),
              KSizedBox.kHeightSizedBox8,
              TextButton(
                key: MobSettingsKeys.privacyPolicy,
                onPressed: () => context.goNamed(KRoute.privacyPolicy.name),
                style: KButtonStyles.withoutStyleAligmentBottomLeft,
                child: Text(
                  context.l10n.privacyPolicy,
                  style: AppTextStyle.materialThemeTitleMediumNeutralVariant50,
                ),
              ),
              KSizedBox.kHeightSizedBox16,
              const InfoVersionWidget(isDesk: true),
              KSizedBox.kHeightSizedBox16,
            ],
            bottomBarIndex: 2,
          ),
        ),
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
