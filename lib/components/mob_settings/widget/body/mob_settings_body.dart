import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared.dart';

class MobSettingsBodyWidget extends StatelessWidget {
  const MobSettingsBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(KSize.kPixel80),
          child: Container(
            decoration: KWidgetTheme.boxDecorationNawbar,
            margin: const EdgeInsets.only(
              top: KPadding.kPaddingSize24,
              left: KPadding.kPaddingSize16,
              right: KPadding.kPaddingSize16,
            ),
            padding: const EdgeInsets.only(
              left: KPadding.kPaddingSize16,
              right: KPadding.kPaddingSize8,
              top: KPadding.kPaddingSize8,
              bottom: KPadding.kPaddingSize8,
            ),
            child: Text(
              context.l10n.settings,
              style: AppTextStyle.materialThemeTitleMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        bottomNavigationBar: const MobNavigationWidget(index: 2),
        body: BlocListener<UrlCubit, UrlEnum?>(
          listener: (context, state) {
            context.dialog.showCopyEmailDialog(state?.value(context));
            if (state == UrlEnum.copySucceed) {
              context.read<UrlCubit>().reset();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(KPadding.kPaddingSize16),
            child: ListView(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  key: KWidgetkeys.screen.mobSettings.title,
                  context.l10n.general,
                  style: AppTextStyle.materialThemeTitleMediumNeutralVariant50,
                ),
                BoxWidget(
                  key: KWidgetkeys.screen.mobSettings.faq,
                  isDesk: false,
                  onTap: null,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.l10n.language,
                        style: AppTextStyle.materialThemeTitleMedium,
                      ),
                      LanguagesSwitcherWidget(
                        key: KWidgetkeys.screen.mobSettings.languagesSwitcher,
                        decoration: KWidgetTheme.boxDecorationNawbar,
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
                    horizontal: KPadding.kPaddingSize10,
                  ),
                  child: TextButton(
                    onPressed: () =>
                        context.read<UrlCubit>().copy(KAppText.email),
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
                    widgetKey: KWidgetkeys.screen.mobSettings.button,
                    text: context.l10n.contact,
                    onPressed: () => context.goNamed(KRoute.feedback.name),
                    color: AppColors.materialThemeBlack,
                    textColor: AppColors.materialThemeWhite,
                    mobVerticalTextPadding: KPadding.kPaddingSize12,
                    isDesk: false,
                  ),
                ),
                KSizedBox.kHeightSizedBox16,
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: KPadding.kPaddingSize16,
                  ),
                  child: Wrap(
                    children: FooterWidget.socialMediaLinks(
                      isTablet: false,
                      context: context,
                      padding: KSizedBox.kWidthSizedBox16,
                      instagramKey:
                          KWidgetkeys.screen.mobSettings.instagramIcon,
                      linkedInKey: KWidgetkeys.screen.mobSettings.likedInIcon,
                      facebookKey: KWidgetkeys.screen.mobSettings.facebookIcon,
                    ),
                  ),
                ),
                KSizedBox.kHeightSizedBox24,
                const Divider(
                  color: AppColors.materialThemeKeyColorsNeutral,
                  height: KSize.kPixel1,
                  thickness: KSize.kPixel1,
                ),
                TextButton(
                  key: KWidgetkeys.screen.mobSettings.privacyPolicy,
                  onPressed: () => context.goNamed(KRoute.privacyPolicy.name),
                  style: KButtonStyles.withoutStyle
                      .copyWith(alignment: Alignment.bottomLeft),
                  child: Text(
                    context.l10n.privacyPolicy,
                    style: AppTextStyle.materialThemeBodyLargeNeutralVariant35,
                  ),
                ),
                KSizedBox.kHeightSizedBox16,
                const InfoVersionWidget(isDesk: true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
