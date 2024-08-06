part of 'body/home_body_widget.dart';

List<Widget> _settingsList({
  required BuildContext context,
  required GlobalKey aboutProjectKey,
}) =>
    [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.general,
            style: AppTextStyle.materialThemeTitleMediumNeutralVariant50,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: KPadding.kPaddingSize8,
            ),
            child: BoxWidget(
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
                    const LanguagesSwitcherWidget(),
                  ],
                ),
              ],
            ),
          ),
          KSizedBox.kHeightSizedBox24,
          Text(
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
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        KAppText.email,
                        style: AppTextStyle.materialThemeTitleMedium,
                      ),
                      KIcon.copy,
                    ],
                  ),
                ),
                KSizedBox.kHeightSizedBox16,
                DoubleButtonWidget(
                  widgetKey: KWidgetkeys.screen.home.boxButton,
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
                      key: KWidgetkeys.widget.footer.likedInIcon,
                      onPressed: () => context.read<UrlCubit>().launchUrl(
                            url: KAppText.linkedIn,
                            mode: LaunchMode.externalApplication,
                          ),
                      icon: KImage.linkedIn(),
                      background: AppColors.materialThemeSourceSeed,
                    ),
                    KSizedBox.kWidthSizedBox16,
                    IconButtonWidget(
                      key: KWidgetkeys.widget.footer.instagramIcon,
                      onPressed: () => context.read<UrlCubit>().launchUrl(
                            url: KAppText.instagram,
                            mode: LaunchMode.externalApplication,
                          ),
                      icon: KImage.instagram(),
                      background: AppColors.materialThemeSourceSeed,
                    ),
                    KSizedBox.kWidthSizedBox16,
                    IconButtonWidget(
                      key: KWidgetkeys.widget.footer.facebookIcon,
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
            key: KWidgetkeys.widget.footer.privacyPolicy,
            onPressed: () => context.goNamed(KRoute.privacyPolicy.name),
            style: KButtonStyles.withoutStyle
                .copyWith(alignment: Alignment.bottomLeft),
            child: Text(
              context.l10n.privacyPolicy,
              style: AppTextStyle.materialThemeBodyLargeNeutralVariant35,
            ),
          ),
          KSizedBox.kHeightSizedBox16,
          const FooterInfoVersionWidget(isDesk: true),
        ],
      ),
    ];
