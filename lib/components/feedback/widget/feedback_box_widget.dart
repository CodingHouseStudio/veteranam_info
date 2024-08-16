part of 'body/feedback_body_widget.dart';

// @override
// void initState() {
//   if (context.read<FeedbackBloc>().state.formState ==
//       FeedbackEnum.sendingMessage) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Scrollable.ensureVisible(
//         screen.feedbackKboxey.currentContext!,
//       );
//     });
//   }
//   super.initState();
// }
List<Widget> _feedbackBoxWidgetList({
  required bool isDesk,
  required void Function() sendAgain,
  required BuildContext context,
}) =>
    isDesk
        ? [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      key: KWidgetkeys.screen.feedback.boxSocialMedia,
                      context.l10n.ourSocialNetworks,
                      style: AppTextStyle.materialThemeTitleMedium,
                    ),
                    Wrap(
                      children: FooterWidget.socialMediaLinks(
                        isTablet: false,
                        context: context,
                        padding: KSizedBox.kWidthSizedBox24,
                        instagramKey:
                            KWidgetkeys.screen.mobSettings.instagramIcon,
                        linkedInKey: KWidgetkeys.screen.mobSettings.likedInIcon,
                        facebookKey:
                            KWidgetkeys.screen.mobSettings.facebookIcon,
                      ),
                    ),
                  ],
                ),
                KSizedBox.kWidthSizedBox100,
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        context.l10n.feedbackSent,
                        key: KWidgetkeys.screen.feedback.boxText,
                        style: AppTextStyle.materialThemeDisplaySmall,
                      ),
                      KSizedBox.kHeightSizedBox24,
                      Row(
                        children: [
                          DoubleButtonWidget(
                            widgetKey:
                                KWidgetkeys.screen.feedback.boxBackButton,
                            text: context.l10n.toTheMainPage,
                            isDesk: true,
                            onPressed: () => _navMain(context),
                            color: AppColors.materialThemeBlack,
                            textColor: AppColors.materialThemeWhite,
                            align: Alignment.center,
                          ),
                          KSizedBox.kWidthSizedBox24,
                          TextButton(
                            key: KWidgetkeys.screen.feedback.boxButton,
                            onPressed: sendAgain,
                            //() =>
                            //context.goNamed(KRoute.feedback.name),
                            style: KButtonStyles.borderBlackButtonStyle,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: KPadding.kPaddingSize12,
                                horizontal: KPadding.kPaddingSize30,
                              ),
                              child: Text(
                                context.l10n.writeMore,
                                style: AppTextStyle.materialThemeTitleMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ]
        : [
            Text(
              context.l10n.feedbackSent,
              key: KWidgetkeys.screen.feedback.boxText,
              style: AppTextStyle.materialThemeHeadlineSmall,
            ),
            KSizedBox.kHeightSizedBox24,
            DoubleButtonWidget(
              widgetKey: KWidgetkeys.screen.feedback.boxBackButton,
              text: context.l10n.toTheMainPage,
              isDesk: false,
              onPressed: () => _navMain(context),
              color: AppColors.materialThemeBlack,
              textColor: AppColors.materialThemeWhite,
              mobTextWidth: double.infinity,
              mobVerticalTextPadding: KPadding.kPaddingSize16,
              mobIconPadding: KPadding.kPaddingSize16,
            ),
            KSizedBox.kHeightSizedBox16,
            TextButton(
              key: KWidgetkeys.screen.feedback.boxButton,
              onPressed:
                  sendAgain, //() => context.goNamed(KRoute.feedback.name),
              style: KButtonStyles.borderBlackButtonStyle,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: KPadding.kPaddingSize16,
                ),
                child: Text(
                  context.l10n.writeMore,
                  style: AppTextStyle.materialThemeTitleMedium,
                ),
              ),
            ),
            KSizedBox.kHeightSizedBox32,
            Text(
              context.l10n.ourSocialNetworks,
              key: KWidgetkeys.screen.feedback.boxSocialMedia,
              style: AppTextStyle.materialThemeTitleMedium,
            ),
            KSizedBox.kHeightSizedBox8,
            Wrap(
              children: FooterWidget.socialMediaLinks(
                isTablet: false,
                context: context,
                padding: KSizedBox.kWidthSizedBox24,
                instagramKey: KWidgetkeys.screen.mobSettings.instagramIcon,
                linkedInKey: KWidgetkeys.screen.mobSettings.likedInIcon,
                facebookKey: KWidgetkeys.screen.mobSettings.facebookIcon,
              ),
            ),
          ];

void _navMain(BuildContext context) => context.goNamed(
      KTest.testIsWeb ? KRoute.home.name : KRoute.discounts.name,
    );
