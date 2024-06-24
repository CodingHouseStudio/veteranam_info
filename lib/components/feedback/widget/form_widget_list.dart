part of 'body/feedback_body_widget.dart';

List<Widget> _formWidgegList({
  required bool isDesk,
  required BuildContext context,
  required TextEditingController nameController,
  required TextEditingController emailController,
  required TextEditingController messageController,
}) =>
    isDesk
        ? [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        context.l10n.feedbackSubtitle,
                        key: KWidgetkeys.screen.feedback.subtitle,
                        style: AppTextStyle.materialThemeBodyLarge,
                      ),
                      KSizedBox.kHeightSizedBox32,
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            context.l10n.preferEmail,
                            key: KWidgetkeys.screen.feedback.emailText,
                            style: AppTextStyle
                                .materialThemeBodyLargeNeutralVariant60,
                          ),
                          emailButton(isDesk: isDesk),
                        ],
                      ),
                      KSizedBox.kHeightSizedBox32,
                      Text(
                        context.l10n.ourSocialNetworks,
                        key: KWidgetkeys.screen.feedback.socialText,
                        style: AppTextStyle.materialThemeTitleMedium,
                      ),
                      KSizedBox.kHeightSizedBox8,
                      Wrap(
                        children: FooterWidget.socialMediaLinks(
                          isDesk: isDesk,
                          context: context,
                          padding: KSizedBox.kWidthSizedBox24,
                          instagramKey: KWidgetkeys.screen.feedback.instagram,
                          linkedInKey: KWidgetkeys.screen.feedback.linkedIn,
                          facebookKey: KWidgetkeys.screen.feedback.facebook,
                        ),
                      ),
                    ],
                  ),
                ),
                KSizedBox.kWidthSizedBox45,
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: _fieldWidgetList(
                      isDesk: isDesk,
                      context: context,
                      nameController: nameController,
                      emailController: emailController,
                      messageController: messageController,
                    ),
                  ),
                ),
              ],
            ),
            KSizedBox.kHeightSizedBox100,
          ]
        : [
            Text(
              context.l10n.feedbackSubtitle,
              key: KWidgetkeys.screen.feedback.subtitle,
              style: AppTextStyle.materialThemeBodyMedium,
            ),
            KSizedBox.kHeightSizedBox32,
            ..._fieldWidgetList(
              isDesk: isDesk,
              context: context,
              nameController: nameController,
              emailController: emailController,
              messageController: messageController,
            ),
            KSizedBox.kHeightSizedBox32,
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  context.l10n.preferEmail,
                  key: KWidgetkeys.screen.feedback.emailText,
                  style: AppTextStyle.materialThemeBodyMediumNeutralVariant35,
                ),
                emailButton(isDesk: isDesk),
              ],
            ),
            KSizedBox.kHeightSizedBox32,
            Text(
              context.l10n.ourSocialNetworks,
              key: KWidgetkeys.screen.feedback.socialText,
              style: AppTextStyle.materialThemeTitleMedium,
            ),
            KSizedBox.kHeightSizedBox8,
            Wrap(
              children: FooterWidget.socialMediaLinks(
                isDesk: isDesk,
                context: context,
                padding: KSizedBox.kWidthSizedBox24,
                instagramKey: KWidgetkeys.screen.feedback.instagram,
                linkedInKey: KWidgetkeys.screen.feedback.linkedIn,
                facebookKey: KWidgetkeys.screen.feedback.facebook,
              ),
            ),
            KSizedBox.kHeightSizedBox32,
          ];

Widget emailButton({
  required bool isDesk,
}) =>
    Markdown(
      key: KWidgetkeys.screen.feedback.emailButton,
      data: KAppText.email,
      styleSheet: MarkdownStyleSheet(
        a: isDesk
            ? AppTextStyle.materialThemeBodyLarge.copyWith(
                color: AppColors.materialThemeKeyColorsSecondary,
              )
            : AppTextStyle.materialThemeBodyMedium.copyWith(
                color: AppColors.materialThemeKeyColorsSecondary,
              ),
      ),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      onTapLink: (text, href, title) async {
        final emailUri = Uri(
          scheme: 'mailto',
          path: KAppText.email,
        );

        if (await canLaunchUrl(emailUri)) {
          await launchUrl(emailUri);
        }
      },
    );
