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
            IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.only(top: KPadding.kPaddingSize32),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: KWidgetTheme.boxDecorationWidget,
                        padding: const EdgeInsets.symmetric(
                          horizontal: KPadding.kPaddingSize32,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.l10n.thankYou,
                              key: KWidgetkeys.screen.feedback.boxTitle,
                              style: AppTextStyle.text96,
                            ),
                            KSizedBox.kHeightSizedBox32,
                            Text(
                              context.l10n.feedbackBoxSubtitle,
                              key: KWidgetkeys.screen.feedback.boxSubtitle,
                              style: AppTextStyle.text40,
                            ),
                            KSizedBox.kHeightSizedBox48,
                            ButtonWidget(
                              key: KWidgetkeys.screen.feedback.boxButton,
                              text: context.l10n.sendMore,
                              onPressed: sendAgain,
                              isDesk: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    KSizedBox.kWidthSizedBox24,
                    Expanded(
                      child: Column(
                        children: [
                          BoxWidget(
                            key: KWidgetkeys.screen.feedback.boxInformationBox,
                            text: context.l10n.information,
                            onTap: () => context.goNamed(
                              KRoute.information.name,
                            ),
                            isDesk: true,
                          ),
                          KSizedBox.kHeightSizedBox24,
                          BoxWidget(
                            key: KWidgetkeys.screen.feedback.boxInvestorsBox,
                            text: context.l10n.investors,
                            onTap: () => context.goNamed(KRoute.investors.name),
                            isDesk: true,
                          ),
                          KSizedBox.kHeightSizedBox24,
                          BoxWidget(
                            key: KWidgetkeys.screen.feedback.boxStoryBox,
                            text: context.l10n.stories,
                            onTap: () => context.goNamed(KRoute.stories.name),
                            isDesk: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]
        : [
            Text(
              context.l10n.thankYou,
              key: KWidgetkeys.screen.feedback.boxTitle,
              style: AppTextStyle.text48,
            ),
            KSizedBox.kHeightSizedBox16,
            Text(
              context.l10n.feedbackBoxSubtitle,
              key: KWidgetkeys.screen.feedback.boxSubtitle,
              style: AppTextStyle.text24,
            ),
            KSizedBox.kHeightSizedBox24,
            ButtonWidget(
              key: KWidgetkeys.screen.feedback.boxButton,
              text: context.l10n.sendMore,
              onPressed: sendAgain,
              isDesk: false,
            ),
            KSizedBox.kHeightSizedBox24,
            BoxWidget(
              key: KWidgetkeys.screen.feedback.boxInformationBox,
              text: context.l10n.information,
              onTap: () => context.goNamed(KRoute.information.name),
              isDesk: false,
            ),
            KSizedBox.kHeightSizedBox24,
            BoxWidget(
              key: KWidgetkeys.screen.feedback.boxInvestorsBox,
              text: context.l10n.investors,
              onTap: () => context.goNamed(KRoute.investors.name),
              isDesk: false,
            ),
            KSizedBox.kHeightSizedBox24,
            BoxWidget(
              key: KWidgetkeys.screen.feedback.boxStoryBox,
              text: context.l10n.stories,
              onTap: () => context.goNamed(KRoute.stories.name),
              isDesk: false,
            ),
          ];
