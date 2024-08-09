import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared.dart';

class MobSettingsBodyWidget extends StatelessWidget {
  const MobSettingsBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      pageName: context.l10n.settings,
      mainChildWidgetsFunction: ({required isDesk, required isTablet}) => [
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
            onPressed: () {
              Clipboard.setData(
                const ClipboardData(text: KAppText.email),
              );
              context.dialog.showCopyEmailDialog();
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
              instagramKey: KWidgetkeys.screen.feedback.instagram,
              linkedInKey: KWidgetkeys.screen.feedback.linkedIn,
              facebookKey: KWidgetkeys.screen.feedback.facebook,
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
    );
  }
}
