import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:veteranam/shared/shared.dart';

class MobSettingsBodyWidget extends StatelessWidget {
  const MobSettingsBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      pageName: context.l10n.settings,
      mainChildWidgetsFunction: ({required isDesk, required isTablet}) => [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              key: KWidgetkeys.screen.mobSettings.title1,
              context.l10n.general,
              style: AppTextStyle.materialThemeTitleMediumNeutralVariant50,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: KPadding.kPaddingSize8,
              ),
              child: BoxWidget(
                key: KWidgetkeys.screen.mobSettings.faq,
                isDesk: false,
                onTap: null,
                text: context.l10n.faq,
                textStyle: AppTextStyle.materialThemeTitleMediumBlack,
                icon: KIcon.arrowUpRight,
                padding: EdgeInsets.zero,
                background: AppColors.materialThemeWhite,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: KPadding.kPaddingSize16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KSizedBox.kHeightSizedBox8,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.l10n.language,
                        style: AppTextStyle.materialThemeTitleMedium,
                      ),
                      LanguagesSwitcherWidget(
                        key: KWidgetkeys.screen.mobSettings.languagesSwitcher,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            KSizedBox.kHeightSizedBox24,
            Text(
              key: KWidgetkeys.screen.mobSettings.title2,
              context.l10n.contacts,
              style: AppTextStyle.materialThemeTitleMediumNeutralVariant50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: KPadding.kPaddingSize16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KSizedBox.kHeightSizedBox8,
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(
                        const ClipboardData(text: KAppText.email),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(context.l10n.copyEmail),
                        ),
                      );
                    },
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
                  KSizedBox.kHeightSizedBox16,
                  DoubleButtonWidget(
                    widgetKey: KWidgetkeys.screen.mobSettings.button,
                    text: context.l10n.contact,
                    onPressed: () => context.goNamed(KRoute.feedback.name),
                    color: AppColors.materialThemeBlack,
                    textColor: AppColors.materialThemeWhite,
                    mobTextWidth: KSize.kPixel200,
                    mobVerticalTextPadding: KPadding.kPaddingSize12,
                    isDesk: false,
                  ),
                  KSizedBox.kHeightSizedBox16,
                  Row(
                    children: [
                      IconButtonWidget(
                        key: KWidgetkeys.screen.mobSettings.likedInIcon,
                        onPressed: () => context.read<UrlCubit>().launchUrl(
                              url: KAppText.linkedIn,
                              mode: LaunchMode.externalApplication,
                            ),
                        icon: KImage.linkedIn(),
                        background: AppColors.materialThemeSourceSeed,
                      ),
                      KSizedBox.kWidthSizedBox16,
                      IconButtonWidget(
                        key: KWidgetkeys.screen.mobSettings.instagramIcon,
                        onPressed: () => context.read<UrlCubit>().launchUrl(
                              url: KAppText.instagram,
                              mode: LaunchMode.externalApplication,
                            ),
                        icon: KImage.instagram(),
                        background: AppColors.materialThemeSourceSeed,
                      ),
                      KSizedBox.kWidthSizedBox16,
                      IconButtonWidget(
                        key: KWidgetkeys.screen.mobSettings.facebookIcon,
                        onPressed: () => context.read<UrlCubit>().launchUrl(
                              url: KAppText.facebook,
                              mode: LaunchMode.externalApplication,
                            ),
                        icon: KImage.facebook(),
                        background: AppColors.materialThemeSourceSeed,
                      ),
                    ],
                  ),
                ],
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
      ],
    );
  }
}
